#include <linux/version.h>
#include <linux/autoconf.h>
#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/init.h>

#include <linux/crypto.h>
#include <linux/scatterlist.h>
#include <linux/err.h>

#include <linux/sched.h>
#include <linux/kernel.h>  /* printk() */
#include <linux/errno.h>   /* error codes */
#include <linux/types.h>   /* size_t */
#include <linux/vmalloc.h>
#include <linux/genhd.h>
#include <linux/blkdev.h>
#include <linux/wait.h>
#include <linux/file.h>

#include "spinlock.h"
#include "osprd.h"

/* The size of an OSPRD sector. */
#define SECTOR_SIZE	512

/* This flag is added to an OSPRD file's f_flags to indicate that the file
* is locked. */
#define F_OSPRD_LOCKED	0x80000

/* eprintk() prints messages to the console.
* (If working on a real Linux machine, change KERN_NOTICE to KERN_ALERT or
* KERN_EMERG so that you are sure to see the messages.  By default, the
* kernel does not print all messages to the console.  Levels like KERN_ALERT
* and KERN_EMERG will make sure that you will see messages.) */
#define eprintk(format, ...) printk(KERN_NOTICE format, ## __VA_ARGS__)

MODULE_LICENSE("Dual BSD/GPL");
MODULE_DESCRIPTION("CS 111 RAM Disk");
// EXERCISE: Pass your names into the kernel as the module's authors.
MODULE_AUTHOR("Tien Le and David Nguyen");

#define OSPRD_MAJOR	222

/* This module parameter controls how big the disk will be.
* You can specify module parameters when you load the module,
* as an argument to insmod: "insmod osprd.ko nsectors=4096" */
static int nsectors = 32;
module_param(nsectors, int, 0);

#define SHA1_LENGTH		20
/* ENCRYPTION CODE */
//Referenced the documentation/crypto/api-intro.txt file for this implementation
// input is the plaintext we want to create a hash of
// inputlen is the length of this, usually MAX_PASSWORD_LENGTH
// output is the returned hash
int sha1_hash(char* input, unsigned inputlen, char** output){
	struct scatterlist sg;
	struct crypto_tfm *tfm;
	
	//Zero out the output, just in case
	memset(*output, 0x00, SHA1_LENGTH);

	//Initialize tfm
	tfm = crypto_alloc_tfm("sha1", 0);
	if(tfm == NULL){
		eprintk("Failed to load transform for SHA1\n");
		return -EINVAL;
	}
	sg_init_one(&sg, (u8 *)input, inputlen);
	//Configure hashing engine by description in hash_desc
	crypto_digest_init(tfm);
	//Perform the hashing method
	crypto_digest_update(tfm, &sg, 1);
	//Copy the hash to the array

	crypto_digest_final(tfm, *output);

	//Cleanup
	crypto_free_tfm(tfm);
	return 0;
}

static void encrypt(char *buf, char *key, unsigned size)  
{   
	//Length of buf must equal length of key
	//Temporarily use XOR to make sure everything works
	//TODO: Implement a more sophisticated algorithm or use linux/crypto
	int i;
	for(i = 0; i < size; i++)
	{
		buf[i] ^= key[i];
	}
}

void decrypt(char *buf, char *key, unsigned size){
	int i;
	for(i = 0; i < size; i++)
	{
		buf[i] ^= key[i];
	}
}

/* New struct declarations to help track processes */
// TICKET LINKED LIST
// Data structure to keep track of tickets
typedef struct ticketQueue{
	unsigned ticket;
	struct ticketQueue* next;
}ticketQueue;

typedef struct pidList{
        pid_t pid;
            struct pidList* next;
}pidList;

void insertpidList(pidList** list, pid_t pid);
void removepidList(pidList** list, pid_t pid);
int existsinPidList(pidList* list, pid_t target);

void insertTicket(ticketQueue** list, unsigned newticket);
void removeTicket(ticketQueue** list, unsigned ticket);
static int queueIsEmpty(struct ticketQueue* list);

/* The internal representation of our device. */
typedef struct osprd_info {
	uint8_t *data;                  // The data array. Its size is
	// (nsectors * SECTOR_SIZE) bytes.

	osp_spinlock_t mutex;           // Mutex for synchronizing access to
	// this block device

	unsigned ticket_head;		// Currently running ticket for
	// the device lock

	unsigned ticket_tail;		// Next available ticket for
	// the device lock

	wait_queue_head_t blockq;       // Wait queue for tasks blocked on
	// the device lock

	/* HINT: You may want to add additional fields to help
	in detecting deadlock. */

	unsigned count_rlocks;	// Count of the number of active read locks
	unsigned count_wlocks;	// Count of the number of active write locks

	struct ticketQueue* ticketQueue; // List of current number of waiting tickets
    pidList* pid_waiting_for_rlocks;
    pidList* pid_waiting_for_wlocks;

	//Structures for encrypting
	//TODO: Figure out what we need for this
	unsigned char passwordhash[SHA1_LENGTH];
	// The following elements are used internally; you don't need
	// to understand them.
	struct request_queue *queue;    // The device request queue.
	spinlock_t qlock;		// Used internally for mutual
	//   exclusion in the 'queue'.
	struct gendisk *gd;             // The generic disk.
} osprd_info_t;

#define NOSPRD 4
static osprd_info_t osprds[NOSPRD];

//Inserts a ticket into the very end of the list. Initializes list of none currently exists
void insertTicket(struct ticketQueue** list, unsigned newticket)
{
	ticketQueue *to_insert = kzalloc(sizeof(ticketQueue), GFP_ATOMIC);
	to_insert->ticket = newticket;
	to_insert->next = NULL;

	if (*list == NULL)
		*list = to_insert;
	else
	{
		ticketQueue* walk = *list;
		ticketQueue* prev = NULL;
		while (walk)
		{
			prev = walk;
			walk = walk->next;
		}
		prev->next = to_insert;
	}
	return;
}

//Removes a ticket from the list
//If there is only one ticket in the list, we will deallocate the list and point to NULL
void removeTicket(struct ticketQueue** list, unsigned ticket)
{
	ticketQueue* cur;

	if(*list == NULL){
		return;
	}
	//If the first node in the list is the desired ticket, deallocate
	cur = *list;
	if(cur->ticket == ticket){
		*list = (*list)->next;
		kfree(cur);
		return;
	}

	while( cur->next != NULL){
		if(cur->next->ticket == ticket){
			cur->next = cur->next->next;
			kfree(cur->next);
			return;
		}
		cur = cur->next;
	}
	return; // Did not find ticket, returning
}


static int queueIsEmpty(struct ticketQueue* list){
	if(list == NULL)
		return 1;
	return 0;
}


void insertpidList(pidList** list, pid_t pid)
{
    pidList* to_insert = kzalloc(sizeof(pidList), GFP_ATOMIC);
    to_insert->pid = pid;
    to_insert->next = *list;
    *list = to_insert;
    return;
}

//Remove all instance of pid 
void removepidList(pidList** list, pid_t pid)
{
    pidList* walk = *list;
	pidList* prev = NULL;
    while (walk != NULL && walk->pid == pid)
    {
        *list = walk->next;  
        kfree(walk);               
        walk = *list;         
    } 
    while (walk != NULL)
    {
        while (walk != NULL && walk->pid != pid)
        {
            prev = walk;
            walk = walk->next;
        }
        if (walk == NULL) 
			return;
        prev->next = walk->next;
        kfree(walk); 
        walk = prev->next;
    }
}

//If the target exists return 1, else 0
int existsinPidList(pidList* list, pid_t target)
{
	int ret_val = 0;
	pidList* walk = list;
	while (walk != NULL)
	{
		if (walk->pid == target)
		{
			ret_val = 1;
			break;
		}
		walk = walk->next;
	}
	return ret_val;
}


// Declare useful helper functions

/*
* file2osprd(filp)
*   Given an open file, check whether that file corresponds to an OSP ramdisk.
*   If so, return a pointer to the ramdisk's osprd_info_t.
*   If not, return NULL.
*/
static osprd_info_t *file2osprd(struct file *filp);

/*
* for_each_open_file(task, callback, user_data)
*   Given a task, call the function 'callback' once for each of 'task's open
*   files.  'callback' is called as 'callback(filp, user_data)'; 'filp' is
*   the open file, and 'user_data' is copied from for_each_open_file's third
*   argument.
*/
static void for_each_open_file(struct task_struct *task,
							   void (*callback)(struct file *filp,
							   osprd_info_t *user_data),
							   osprd_info_t *user_data);


/*
* osprd_process_request(d, req)
*   Called when the user reads or writes a sector.
*   Should perform the read or write, as appropriate.
*/
static void osprd_process_request(osprd_info_t *d, struct request *req)
{
	unsigned sec;
	unsigned size;

	if(!blk_fs_request(req)) {
		end_request(req, 0);
		return;
	}
	// EXERCISE: Perform the read or write request by copying data between
	// our data array and the request's buffer.
	// Hint: The 'struct request' argument tells you what kind of request
	// this is, and which sectors are being read or written.
	// Read about 'struct request' in <linux/blkdev.h>.
	// Consider the 'req->sector', 'req->current_nr_sectors', and
	// 'req->buffer' members, and the rq_data_dir() function.

	// Your code here.
	// 
	// rq_data_dir
	// #define rq_data_dir(rq)         ((rq)->flags & 1)
	sec = req->sector * SECTOR_SIZE;
	size = req->current_nr_sectors * SECTOR_SIZE;	

	osp_spin_lock(&d->mutex);
	if(rq_data_dir(req) == READ){
		memcpy(req->buffer, d->data + sec, size);
	} else if(rq_data_dir(req) == WRITE){
		memcpy(d->data + sec, req->buffer, size);
	}
	osp_spin_unlock(&d->mutex);

	end_request(req, 1);
}


// This function is called when a /dev/osprdX file is opened.
// You aren't likely to need to change this.
static int osprd_open(struct inode *inode, struct file *filp)
{
	// Always set the O_SYNC flag. That way, we will get writes immediately
	// instead of waiting for them to get through write-back caches.
	filp->f_flags |= O_SYNC;
	return 0;
}


// This function is called when a /dev/osprdX file is finally closed.
// (If the file descriptor was dup2ed, this function is called only when the
// last copy is closed.)
static int osprd_close_last(struct inode *inode, struct file *filp)
{
	if (filp) {
		osprd_info_t *d = file2osprd(filp);
		int filp_writable = filp->f_mode & FMODE_WRITE;

		// EXERCISE: If the user closes a ramdisk file that holds
		// a lock, release the lock.  Also wake up blocked processes
		// as appropriate.

		// Your code here.

		if (d == NULL || (filp->f_flags & F_OSPRD_LOCKED) == 0 ) //If the file is not an OSP ramdisk or if there are no locks for the disk
			return -1;
		osp_spin_lock(&(d->mutex));
		filp->f_flags = filp->f_flags & ~(F_OSPRD_LOCKED);
		if(filp_writable)
        {
			d->count_wlocks--;
            removepidList(&(d->pid_waiting_for_wlocks), current->pid);
        }
		else
        {
			d->count_rlocks--;
            removepidList(&(d->pid_waiting_for_rlocks), current->pid);
        }
		osp_spin_unlock(&(d->mutex));
		wake_up_all(&(d->blockq));
		return 0;
	}

	return -1;
}


/*
* osprd_lock
*/

/*
* New code here
*/

//Give the ticket to the next ticket in the queue
//If the queue is empty, then we assume nobody is waiting so reset ticket_tail and head to 0
//USE THIS FUNCTION WITH A LOCK
void passTicketTail(osprd_info_t* d){
	if(queueIsEmpty(d->ticketQueue)){
		d->ticket_head = 0;
		d->ticket_tail = 0;
	}
	else
		d->ticket_tail = d->ticketQueue->ticket;
}

//Attempts to acquire a lock
//	Function will return 0, -1, -EDEADLK, or -EBUSY depending on conditions
static int acquire_lock(struct file* filp){
	osprd_info_t *d = file2osprd(filp); // Device info
	if(d == NULL)
		return -1;
	int filp_writable;
	filp_writable = (filp->f_mode & FMODE_WRITE);

	//Basic check if file already has a lock
	if(filp->f_flags & F_OSPRD_LOCKED)
		return -EDEADLK;

	//Check for two conditions
	// 1) There are any write locks
	// 2) We are attempting to acquire a write lock and there are read locks
	osp_spin_lock(&d->mutex);
	if(d->count_wlocks > 0 || (filp_writable && d->count_rlocks > 0))
	{
		osp_spin_unlock(&d->mutex);
		return -EBUSY; // Try again later
	}

	// Acquire the lock
	if(filp_writable)
    {
		d->count_wlocks++;
        insertpidList(&(d->pid_waiting_for_wlocks), current->pid);
    }
	else //We are reading
    {
		d->count_rlocks++;
        insertpidList(&(d->pid_waiting_for_rlocks), current->pid);
    }
	//TODO: Implement a list of lock holding processes to detect deadlock
	filp->f_flags |= F_OSPRD_LOCKED;
	osp_spin_unlock(&d->mutex);
	return 0;
}

/*
* End new code
*/


/*
* osprd_ioctl(inode, filp, cmd, arg)
*   Called to perform an ioctl on the named file.
*/
int osprd_ioctl(struct inode *inode, struct file *filp,
				unsigned int cmd, unsigned long arg)
{
	osprd_info_t *d = file2osprd(filp);	// device info
	int r = 0;			// return value: initially 0

	// is file open for writing?
	int filp_writable = (filp->f_mode & FMODE_WRITE);

	// This line avoids compiler warnings; you may remove it.
	(void) filp_writable, (void) d;

	// Set 'r' to the ioctl's return value: 0 on success, negative on error

	if (cmd == OSPRDIOCACQUIRE) {

		// EXERCISE 4: Lock the ramdisk.
		//
		// If *filp is open for writing (filp_writable), then attempt
		// to write-lock the ramdisk; otherwise attempt to read-lock
		// the ramdisk.
		//
		// This lock request must block using 'd->blockq' until:
		// 1) no other process holds a write lock;
		// 2) either the request is for a read lock, or no other process
		//    holds a read lock; and
		// 3) lock requests should be serviced in order, so no process
		//    that blocked earlier is still blocked waiting for the
		//    lock.
		//
		// If a process acquires a lock, mark this fact by setting
		// 'filp->f_flags |= F_OSPRD_LOCKED'.  You also need to
		// keep track of how many read and write locks are held:
		// change the 'osprd_info_t' structure to do this.
		//
		// Also wake up processes waiting on 'd->blockq' as needed.
		//
		// If the lock request would cause a deadlock, return -EDEADLK.
		// If the lock request blocks and is awoken by a signal, then
		// return -ERESTARTSYS.
		// Otherwise, if we can grant the lock request, return 0.

		// 'd->ticket_head' and 'd->ticket_tail' should help you
		// service lock requests in order.  These implement a ticket
		// order: 'ticket_tail' is the next ticket, and 'ticket_head'
		// is the ticket currently being served.  You should set a local
		// variable to 'd->ticket_head' and increment 'd->ticket_head'.
		// Then, block at least until 'd->ticket_tail == local_ticket'.
		// (Some of these operations are in a critical section and must
		// be protected by a spinlock; which ones?)

		// Your code here (instead of the next two lines).

		unsigned currentTicket;
/*
                       char* buffer = (char*) kmalloc(MAX_PASSWORD_LENGTH,GFP_ATOMIC);
		       int p;
			for(p = 0; p < MAX_PASSWORD_LENGTH; p++)
				buffer[p] = 'a';
			buffer[MAX_PASSWORD_LENGTH-1] = '\0';
                        char* outputhash = (char*) kmalloc(SHA1_LENGTH, GFP_ATOMIC);
                        sha1_hash(buffer, MAX_PASSWORD_LENGTH, &outputhash);
        int i;
                        osp_spin_lock(&d->mutex);
                        memcpy(d->passwordhash, outputhash, SHA1_LENGTH);
                        osp_spin_unlock(&d->mutex);
	eprintk("Starting\n");
        for(i = 0; i < SHA1_LENGTH; i++){
                eprintk("%d\n",d->passwordhash[i]);
        }
	eprintk("Ending\n");
*/

		//TODO: Deadlock function implementation here

		//Give process a ticket
		osp_spin_lock(&d->mutex);
		currentTicket = d->ticket_head;
		d->ticket_head++;
		insertTicket(&(d->ticketQueue), currentTicket);
		
        //if the process is already waiting for a lock and requests another one
        //of the same ramdisk module, its deadlocking
        if (existsinPidList(d->pid_waiting_for_rlocks, current->pid) || 
			existsinPidList(d->pid_waiting_for_wlocks, current->pid))
		{
			osp_spin_unlock(&d->mutex);
			return -EDEADLK;
		}                
		osp_spin_unlock(&d->mutex);
		wait_event_interruptible(d->blockq, d->ticket_tail == currentTicket &&
			((filp_writable && d->count_rlocks == 0 && d->count_wlocks == 0) ||
			(!filp_writable && d->count_wlocks == 0))
			);
		if(signal_pending(current)){
			osp_spin_lock(&d->mutex);
			//Remove ticket from list of waiting tickets, since this process is going to restart	
			removeTicket(&(d->ticketQueue), currentTicket);
			if(d->ticket_tail == currentTicket)
				passTicketTail(d);
			osp_spin_unlock(&d->mutex);
			return -ERESTARTSYS;
		}
		r = acquire_lock(filp);
		if(r != 0)
			eprintk("Error: Did not acquire file lock even when we should have been able to");
		
		//Succesfully acquired lock, cleanup
		osp_spin_lock(&d->mutex);
		removeTicket(&(d->ticketQueue), currentTicket);
		passTicketTail(d);
		osp_spin_unlock(&d->mutex);

		//Wake everyone up so they can check if they have the ticket
		wake_up_all(&(d->blockq));
		r = 0;
	} else if (cmd == OSPRDIOCTRYACQUIRE) {

		// EXERCISE: ATTEMPT to lock the ramdisk.
		//
		// This is just like OSPRDIOCACQUIRE, except it should never
		// block.  If OSPRDIOCACQUIRE would block or return deadlock,
		// OSPRDIOCTRYACQUIRE should return -EBUSY.
		// Otherwise, if we can grant the lock request, return 0.

		// Your code here (instead of the next two lines).
		r = acquire_lock(filp); 
		if(r != 0)
			r = -EBUSY;

	} else if (cmd == OSPRDIOCRELEASE) {

		// EXERCISE: Unlock the ramdisk.
		//
		// If the file hasn't locked the ramdisk, return -EINVAL.
		// Otherwise, clear the lock from filp->f_flags, wake up
		// the wait queue, perform any additional accounting steps
		// you need, and return 0.

		// Your code here (instead of the next line).
		osprd_info_t *d = file2osprd(filp); // Device info
		if(d == NULL){
			return -1;
		}

		int filp_writable = filp->f_mode & FMODE_WRITE;
		int filp_locked   = filp->f_mode & F_OSPRD_LOCKED;

		if(filp_locked == 0){
			return -EINVAL;
		}

		osp_spin_lock(&d->mutex);
		if(filp_writable)
        {
			d->count_wlocks--;
            removepidList(&(d->pid_waiting_for_wlocks), current->pid);
        }
		else
        {
			d->count_rlocks--;
            removepidList(&(d->pid_waiting_for_rlocks), current->pid);
        }
		//passTicketTail(d);
		filp->f_flags = filp->f_flags & ~(F_OSPRD_LOCKED);
		osp_spin_unlock(&d->mutex);

		wake_up_all(&d->blockq);
		r = 0;

	} else if(cmd == OSPRDENTERPASSWORD){
		if(arg == 0){
			//d->password = '\0';
			r = 0;
		}
		else
		{
			char* outputhash = (char*) kmalloc(SHA1_LENGTH, GFP_ATOMIC);		
			char* buffer = (char*) kmalloc(MAX_PASSWORD_LENGTH,GFP_ATOMIC);
			r = copy_from_user(buffer, (const char __user*) arg, MAX_PASSWORD_LENGTH);
			if(r != 0){
				kfree(buffer);
				return -1;	
			}
			sha1_hash(buffer, MAX_PASSWORD_LENGTH, &outputhash);
			osp_spin_lock(&d->mutex);
			memcpy(d->passwordhash, outputhash, SHA1_LENGTH);
			osp_spin_unlock(&d->mutex);
		
			kfree(buffer);
			/*
			int k;
			for(k = 0; k < SHA1_LENGTH; k++)
				eprintk("%d - %d\n", k, d->passwordhash[k]);
				*/
		}
			
	}
	
	else
		r = -ENOTTY; /* unknown command */
	return r;
}


// Initialize internal fields for an osprd_info_t.

static void osprd_setup(osprd_info_t *d)
{
	/* Initialize the wait queue. */
	init_waitqueue_head(&d->blockq);
	osp_spin_lock_init(&d->mutex);
	d->ticket_head = d->ticket_tail = 0;
	/* Add code here if you add fields to osprd_info_t. */
	d->count_rlocks = 0;
	d->count_wlocks = 0;
    d->pid_waiting_for_rlocks = NULL;
    d->pid_waiting_for_wlocks = NULL;
	d->ticketQueue = NULL;
	d->passwordhash[0] = 0;
}


/*****************************************************************************/
/*         THERE IS NO NEED TO UNDERSTAND ANY CODE BELOW THIS LINE!          */
/*                                                                           */
/*****************************************************************************/

// Process a list of requests for a osprd_info_t.
// Calls osprd_process_request for each element of the queue.

static void osprd_process_request_queue(request_queue_t *q)
{
	osprd_info_t *d = (osprd_info_t *) q->queuedata;
	struct request *req;

	while ((req = elv_next_request(q)) != NULL)
		osprd_process_request(d, req);
}


// Some particularly horrible stuff to get around some Linux issues:
// the Linux block device interface doesn't let a block device find out
// which file has been closed.  We need this information.

static struct file_operations osprd_blk_fops;
static int (*blkdev_release)(struct inode *, struct file *);
//New code for design project
ssize_t (*blkdev_read) (struct file *, char *, size_t, loff_t *);
ssize_t (*blkdev_write) (struct file *, const char *, size_t, loff_t *);


static int _osprd_release(struct inode *inode, struct file *filp)
{
	if (file2osprd(filp))
		osprd_close_last(inode, filp);
	return (*blkdev_release)(inode, filp);
}


//osprd_encrypted_read takes the password, hashes it
ssize_t _osprd_encrypted_read (struct file * filp, char * user, size_t size, loff_t * loff){
	//ssize_t ret = (*blkdev_read)(filp, user, size, loff);

	char* buf;
	int copystatus;
	osprd_info_t *d = file2osprd(filp);
	if(!d)
		return (*blkdev_read)(filp, user, size, loff);
	
	//If no password was given, we just use the regular read as normal
	if(d->passwordhash[0] == '\0')
		return (*blkdev_read)(filp, user, size, loff);

	//eprintk("Password given, trying to unencrypt..\n");
	ssize_t status;
	if(!d)
		return (*blkdev_read)(filp, user, size, loff);
	buf = (char*) kmalloc(size, GFP_KERNEL);
	if(buf == NULL)
		return -ENOMEM;
	status = (*blkdev_read)(filp,user,size,loff);
	copystatus = copy_from_user(buf,user,size);
	if( copystatus < 0)
	{
		eprintk("Copy from user failed in osprd_encrypted_read!\n");
		kfree(buf);
		return copystatus;
	}
	//eprintk("Calling encrypted read\n");
	
	
	//Decryption code

	long currentsize;
	unsigned long offset;
	long initialoffset;
	long towrite;
	loff_t fileoffset = *loff;
	currentsize = size;
	towrite = SHA1_LENGTH;
	offset = (int) fileoffset % towrite;
	initialoffset = towrite - offset;

	if( offset > 0)
	{
		decrypt(buf, d->passwordhash, initialoffset);
		currentsize -= initialoffset;
	}
	while(currentsize > 0)
	{
		decrypt(buf + (size - currentsize), d->passwordhash, towrite);
		currentsize -= towrite;
	}
	
	copystatus = copy_to_user(user, buf, size);
	kfree(buf);
	if(copystatus){
		return -1;
	}
	//Zero out the password
	int p;
	for(p = 0; p < SHA1_LENGTH; p++)
		d->passwordhash[p] = 0;
	return status;
}

// osprd_encrypted_write takes the password, will hash it, and then call
// an encrypting helper function to transform the data. We will then
// return the data and write the block to memory.
ssize_t _osprd_encrypted_write (struct file * filp, const char * user, size_t size, loff_t * loff){
	//ssize_t ret = (*blkdev_write)(filp, user, size, loff);
	char* buf;
	int copystatus;
	osprd_info_t *d = file2osprd(filp);
	if(!d)
		return (*blkdev_write)(filp, user, size, loff);
	
	//If no password was given, we just use the regular write as normal
	if(d->passwordhash[0] == '\0')
		return (*blkdev_write)(filp, user, size, loff);

	//Acquire data from buffer that we are going to write
	buf = (char*) kmalloc(size, GFP_KERNEL);
	if(buf == NULL)
		return -ENOMEM;
	copystatus = copy_from_user(buf,user,size);
	if( copystatus < 0)
	{
		eprintk("Copy from user failed!\n");
		kfree(buf);
		return copystatus;
	}

	//Encryption code

	long currentsize;
	unsigned long offset;
	long initialoffset;
	long towrite;
	loff_t fileoffset = *loff;
	currentsize = size;
	towrite = SHA1_LENGTH;
	offset = (int) fileoffset % towrite;
	initialoffset = towrite - offset;

	if( offset > 0)
	{
		encrypt(buf, d->passwordhash, initialoffset);
		currentsize -= initialoffset;
	}
	while(currentsize > 0)
	{
		encrypt(buf + (size - currentsize), d->passwordhash, towrite);
		currentsize -= towrite;
	}

	copystatus = copy_to_user(user, buf, size);
	kfree(buf);
	if(copystatus){
		return -1;
	}
	//Write the data and zero out the password
	int p = 0;
	for(p = 0; p < SHA1_LENGTH; p++)
		d->passwordhash[p] = 0;
	return (*blkdev_write)(filp,user,size,loff);
}


static int _osprd_open(struct inode *inode, struct file *filp)
{
	if (!osprd_blk_fops.open) {
		memcpy(&osprd_blk_fops, filp->f_op, sizeof(osprd_blk_fops));
		blkdev_release = osprd_blk_fops.release;
		osprd_blk_fops.release = _osprd_release;
		//Set functions to point .read and .write to internally written functions
		//blkdev_read and blkdev_write preserve the original read and write functions
		//so we don't need to reinvent the wheel here, we read and write from the disk
		//using the same interface, but we're going to modify the character strings
		//to encrypt/decrypt.
		blkdev_read = osprd_blk_fops.read;
		blkdev_write = osprd_blk_fops.write;
		osprd_blk_fops.read		= _osprd_encrypted_read;
		osprd_blk_fops.write	= _osprd_encrypted_write;
	}
	filp->f_op = &osprd_blk_fops;
	return osprd_open(inode, filp);
}


// The device operations structure.

static struct block_device_operations osprd_ops = {
	.owner = THIS_MODULE,
	.open = _osprd_open,
	// .release = osprd_release, // we must call our own release
	.ioctl = osprd_ioctl
};


// Given an open file, check whether that file corresponds to an OSP ramdisk.
// If so, return a pointer to the ramdisk's osprd_info_t.
// If not, return NULL.

static osprd_info_t *file2osprd(struct file *filp)
{
	if (filp) {
		struct inode *ino = filp->f_dentry->d_inode;
		if (ino->i_bdev
			&& ino->i_bdev->bd_disk
			&& ino->i_bdev->bd_disk->major == OSPRD_MAJOR
			&& ino->i_bdev->bd_disk->fops == &osprd_ops)
			return (osprd_info_t *) ino->i_bdev->bd_disk->private_data;
	}
	return NULL;
}


// Call the function 'callback' with data 'user_data' for each of 'task's
// open files.

static void for_each_open_file(struct task_struct *task,
							   void (*callback)(struct file *filp, osprd_info_t *user_data),
							   osprd_info_t *user_data)
{
	int fd;
	task_lock(task);
	spin_lock(&task->files->file_lock);
	{
#if LINUX_VERSION_CODE <= KERNEL_VERSION(2, 6, 13)
		struct files_struct *f = task->files;
#else
		struct fdtable *f = task->files->fdt;
#endif
		for (fd = 0; fd < f->max_fds; fd++)
			if (f->fd[fd])
				(*callback)(f->fd[fd], user_data);
	}
	spin_unlock(&task->files->file_lock);
	task_unlock(task);
}


// Destroy a osprd_info_t.

static void cleanup_device(osprd_info_t *d)
{
	wake_up_all(&d->blockq);
	if (d->gd) {
		del_gendisk(d->gd);
		put_disk(d->gd);
	}
	if (d->queue)
		blk_cleanup_queue(d->queue);
	if (d->data)
		vfree(d->data);
}


// Initialize a osprd_info_t.

static int setup_device(osprd_info_t *d, int which)
{
	memset(d, 0, sizeof(osprd_info_t));

	/* Get memory to store the actual block data. */
	if (!(d->data = vmalloc(nsectors * SECTOR_SIZE)))
		return -1;
	memset(d->data, 0, nsectors * SECTOR_SIZE);

	/* Set up the I/O queue. */
	spin_lock_init(&d->qlock);
	if (!(d->queue = blk_init_queue(osprd_process_request_queue, &d->qlock)))
		return -1;
	blk_queue_hardsect_size(d->queue, SECTOR_SIZE);
	d->queue->queuedata = d;

	/* The gendisk structure. */
	if (!(d->gd = alloc_disk(1)))
		return -1;
	d->gd->major = OSPRD_MAJOR;
	d->gd->first_minor = which;
	d->gd->fops = &osprd_ops;
	d->gd->queue = d->queue;
	d->gd->private_data = d;
	snprintf(d->gd->disk_name, 32, "osprd%c", which + 'a');
	set_capacity(d->gd, nsectors);
	add_disk(d->gd);

	/* Call the setup function. */
	osprd_setup(d);

	return 0;
}

static void osprd_exit(void);


// The kernel calls this function when the module is loaded.
// It initializes the 4 osprd block devices.

static int __init osprd_init(void)
{
	int i, r;

	// shut up the compiler
	(void) for_each_open_file;
#ifndef osp_spin_lock
	(void) osp_spin_lock;
	(void) osp_spin_unlock;
#endif

	/* Register the block device name. */
	if (register_blkdev(OSPRD_MAJOR, "osprd") < 0) {
		printk(KERN_WARNING "osprd: unable to get major number\n");
		return -EBUSY;
	}

	/* Initialize the device structures. */
	for (i = r = 0; i < NOSPRD; i++)
		if (setup_device(&osprds[i], i) < 0)
			r = -EINVAL;

	if (r < 0) {
		printk(KERN_EMERG "osprd: can't set up device structures\n");
		osprd_exit();
		return -EBUSY;
	} else
		return 0;
}


// The kernel calls this function to unload the osprd module.
// It destroys the osprd devices.

static void osprd_exit(void)
{
	int i;
	for (i = 0; i < NOSPRD; i++)
		cleanup_device(&osprds[i]);
	unregister_blkdev(OSPRD_MAJOR, "osprd");
}


// Tell Linux to call those functions at init and exit time.
module_init(osprd_init);
module_exit(osprd_exit);
