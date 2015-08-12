#include "schedos-kern.h"
#include "x86.h"
#include "lib.h"


/*****************************************************************************
 * schedos-kern
 *
 *   This is the schedos's kernel.
 *   It sets up process descriptors for the 4 applications, then runs
 *   them in some schedule.
 *
 *****************************************************************************/

// The program loader loads 4 processes, starting at PROC1_START, allocating
// 1 MB to each process.
// Each process's stack grows down from the top of its memory space.
// (But note that SchedOS processes, like MiniprocOS processes, are not fully
// isolated: any process could modify any part of memory.)

#define NPROCS		5
#define PROC1_START	0x200000
#define PROC_SIZE	0x100000

// +---------+-----------------------+--------+---------------------+---------/
// | Base    | Kernel         Kernel | Shared | App 0         App 0 | App 1
// | Memory  | Code + Data     Stack | Data   | Code + Data   Stack | Code ...
// +---------+-----------------------+--------+---------------------+---------/
// 0x0    0x100000               0x198000 0x200000              0x300000
//
// The program loader puts each application's starting instruction pointer
// at the very top of its stack.
//
// System-wide global variables shared among the kernel and the four
// applications are stored in memory from 0x198000 to 0x200000.  Currently
// there is just one variable there, 'cursorpos', which occupies the four
// bytes of memory 0x198000-0x198003.  You can add more variables by defining
// their addresses in schedos-symbols.ld; make sure they do not overlap!


// A process descriptor for each process.
// Note that proc_array[0] is never used.
// The first application process descriptor is proc_array[1].
static process_t proc_array[NPROCS];

// A pointer to the currently running process.
// This is kept up to date by the run() function, in mpos-x86.c.
process_t *current;

// The preferred scheduling algorithm.
int scheduling_algorithm;

// UNCOMMENT THESE LINES IF YOU DO EXERCISE 4.A
// Use these #defines to initialize your implementation.
// Changing one of these lines should change the initialization.
 #define __PRIORITY_1__ 1
 #define __PRIORITY_2__ 2
 #define __PRIORITY_3__ 3
 #define __PRIORITY_4__ 4

// UNCOMMENT THESE LINES IF YOU DO EXERCISE 4.B
// Use these #defines to initialize your implementation.
// Changing one of these lines should change the initialization.
 #define __SHARE_1__ 1
 #define __SHARE_2__ 2
 #define __SHARE_3__ 3
 #define __SHARE_4__ 4

// USE THESE VALUES FOR SETTING THE scheduling_algorithm VARIABLE.
#define __EXERCISE_1__   0  // the initial algorithm
#define __EXERCISE_2__   2  // strict priority scheduling (exercise 2)
#define __EXERCISE_4A__ 41  // p_priority algorithm (exercise 4.a)
#define __EXERCISE_4B__ 42  // p_share algorithm (exercise 4.b)
#define __EXERCISE_7__   7  // any algorithm for exercise 7

// Use for exercise 7

//TESTING FOR EXERCISE 7
//Lottery parameters must be <= MAX_TICKET_COUNT
//max_ticket_count is adjustable
#define MAX_TICKET_COUNT 100
#define LOTTERY_1__ 40
#define LOTTERY_2__ 35
#define LOTTERY_3__ 20
#define LOTTERY_4__ 5

/*
 * Auxiliary functions to implement lottery system
 */

#define MAX_TICKET_COUNT 100
int ticketcount;

pid_t tickets[MAX_TICKET_COUNT];

void
addTicket(pid_t pid)
{
	if(ticketcount < MAX_TICKET_COUNT){
		tickets[ticketcount] = pid;
		ticketcount++;
    }

}

void
deleteTicket(pid_t pid)
{
                int j; //Delete from array, can be slow
                for(j = ticketcount - 1; j>=0; j--){
                        if(tickets[j] == pid){
                                int k;
                                for(k = j; k<ticketcount-1; k++)
                                        tickets[k] = tickets[k+1];
                                break;
                        }
                }
                ticketcount--;
}

//Linear feedback shift register
//Simulates a random number generator so we can test lottery scheduler
unsigned t1 = 0, t2 = 0;

unsigned random()
{
    unsigned b;

    b = t1 ^ (t1 >> 2) ^ (t1 >> 6) ^ (t1 >> 7);
    t1 = (t1 >> 1) | (~b << 31);

    b = (t2 << 1) ^ (t2 << 2) ^ (t1 << 3) ^ (t2 << 4);
    t2 = (t2 << 1) | (~b >> 31);

    return t1 ^ t2;
}


/*****************************************************************************
 * start
 *
 *   Initialize the hardware and process descriptors, then run
 *   the first process.
 *
 *****************************************************************************/

void
start(void)
{
	int i;

	// Set up hardware (schedos-x86.c)
	segments_init();
	interrupt_controller_init(1);
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}
	//Initialize share and priority parameters
	//Note: sys_share and sys_priority are still implemented
	//declaring every line manually was done in order to support
	//definitions at the top for testing
	proc_array[1].p_share	 = __SHARE_1__;
	proc_array[1].p_runcount = __SHARE_1__;
	proc_array[1].p_priority = __PRIORITY_1__;
	proc_array[1].p_lottery  = LOTTERY_1__;

	proc_array[2].p_share    = __SHARE_2__;
        proc_array[2].p_runcount = __SHARE_2__;
        proc_array[2].p_priority = __PRIORITY_2__;
	proc_array[2].p_lottery  = LOTTERY_2__;

        proc_array[3].p_share    = __SHARE_3__;
        proc_array[3].p_runcount = __SHARE_3__;
        proc_array[3].p_priority = __PRIORITY_3__;
	proc_array[3].p_lottery  = LOTTERY_3__;

        proc_array[4].p_share    = __SHARE_4__;
        proc_array[4].p_runcount = __SHARE_4__;
        proc_array[4].p_priority = __PRIORITY_4__;
	proc_array[4].p_lottery  = LOTTERY_4__;

	ticketcount = 0;

	for (i = 1; i < NPROCS; i++) {
		process_t *proc = &proc_array[i];
		uint32_t stack_ptr = PROC1_START + i * PROC_SIZE;

		// Initialize the process descriptor
		special_registers_init(proc);

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
		
		// Exercise 8: Load tickets
		int j = 0;
		while(j < proc_array[i].p_lottery){
			addTicket(proc_array[i].p_pid);
			j++;
			}
		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
	}
		
	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;

	// Initialize the scheduling algorithm.
	// USE THE FOLLOWING VALUES:
	//    0 = the initial algorithm
	//    2 = strict priority scheduling (exercise 2)
	//   41 = p_priority algorithm (exercise 4.a)
	//   42 = p_share algorithm (exercise 4.b)
	//    7 = any algorithm that you may implement for exercise 7
	scheduling_algorithm = __EXERCISE_1__;

	// Switch to the first process.
	run(&proc_array[1]);

	// Should never get here!
	while (1)
		/* do nothing */;
}



/*****************************************************************************
 * interrupt
 *
 *   This is the weensy interrupt and system call handler.
 *   The current handler handles 4 different system calls (two of which
 *   do nothing), plus the clock interrupt.
 *
 *   Note that we will never receive clock interrupts while in the kernel.
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;

	switch (reg->reg_intno) {

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();

	case INT_SYS_EXIT:
		// 'sys_exit' exits the current process: it is marked as
		// non-runnable.
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
		current->p_exit_status = reg->reg_eax;
		schedule();

	//Used for exercise 4A: priority scheduler
	case INT_SYS_SETPRIORITY:
		current->p_priority = reg->reg_eax;
		run(current);

	//Used for proportional share scheduler
	case INT_SYS_SHARE:
		current->p_share     	 = reg->reg_eax;
		current->p_runcount	 = reg->reg_eax;
		run(current);
	
	case INT_SYS_PRINT: //Exercise 6: Used a system call to print characters
		*cursorpos++ = reg->reg_eax;
		run(current);
	
	//INT_SYS_ADDTICKET and INT_SYS_DELETETICKET are for exercise 7
	case INT_SYS_ADDTICKET: //Does not work if we have too many tickets
		addTicket(reg->reg_eax);
		run(current);

	case INT_SYS_DELETETICKET:	
		deleteTicket(reg->reg_eax);
		run(current);

	case INT_CLOCK:
		// A clock interrupt occurred (so an application exhausted its
		// time quantum).
		// Switch to the next runnable process.
		schedule();

	default:
		while (1)
			/* do nothing */;

	}
}



/*****************************************************************************
 * schedule
 *
 *   This is the weensy process scheduler.
 *   It picks a runnable process, then context-switches to that process.
 *   If there are no runnable processes, it spins forever.
 *
 *   This function implements multiple scheduling algorithms, depending on
 *   the value of 'scheduling_algorithm'.  We've provided one; in the problem
 *   set you will provide at least one more.
 *
 *****************************************************************************/

void
schedule(void)
{
	pid_t pid = current->p_pid;
	pid_t j;
	int lowest_priority = 99999; //Set to some high value
	switch(scheduling_algorithm){
	case __EXERCISE_1__:
		while (1) {
			pid = (pid + 1) % NPROCS;

			// Run the selected process, but skip
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
				run(&proc_array[pid]);
		}
		break;
	case __EXERCISE_2__: //EXERCISE 2: priority based on pid
		while(1){
			for(pid = 0; pid < NPROCS; pid++)
				if(proc_array[pid].p_state == P_RUNNABLE)
					run(&proc_array[pid]);
		}
		break;
	case __EXERCISE_4A__: //EXERCISE 4A:priority levels are defined by p_priority field
		while(1){
			for(j = 0; j < NPROCS; j++){
				if(proc_array[j].p_state == P_RUNNABLE &&
					proc_array[j].p_priority < lowest_priority){
					lowest_priority = proc_array[j].p_priority;
				}
			}
			pid = (pid + 1) % NPROCS; //Alternate between equal priority
			if(proc_array[pid].p_state == P_RUNNABLE && 
				proc_array[pid].p_priority <= lowest_priority){
				run(&proc_array[pid]);
			}
		}
		break;
	case __EXERCISE_4B__: //EXERCISE 4B: Proportional-share scheduling
		while(1){
			if(proc_array[pid].p_state == P_RUNNABLE){
				if(proc_array[pid].p_runcount == 0)
					proc_array[pid].p_runcount = proc_array[pid].p_share;
				else{
					proc_array[pid].p_runcount--;
					run(&proc_array[pid]);
				}
			}
		// If we can't run this process any more, move to the next one
		pid = (pid+1) % NPROCS;
		}
		break;
	case __EXERCISE_7__: //EXERCISE 7: Extra credit lottery algorithm
		while(1){ //So compiler doesn't complain
			unsigned i, winner;
			i = random(); //This is pseudorandom
			winner = i % ticketcount; 
			run(&proc_array[tickets[winner]]);
		}
		break;
	default:
		break;
	}
	// If we get here, we are running an unknown scheduling algorithm.
	cursorpos = console_printf(cursorpos, 0x100, "\nUnknown scheduling algorithm %d\n", scheduling_algorithm);
	while (1)
		/* do nothing */;
}
