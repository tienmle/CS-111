
obj/mpos-kern:     file format elf32-i386


Disassembly of section .text:

00100000 <multiboot>:
  100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
  100006:	00 00                	add    %al,(%eax)
  100008:	fe 4f 52             	decb   0x52(%edi)
  10000b:	e4 bc                	in     $0xbc,%al

0010000c <multiboot_start>:
# The multiboot_start routine sets the stack pointer to the top of the
# MiniprocOS's kernel stack, then jumps to the 'start' routine in mpos-kern.c.

.globl multiboot_start
multiboot_start:
	movl $0x200000, %esp
  10000c:	bc 00 00 20 00       	mov    $0x200000,%esp
	pushl $0
  100011:	6a 00                	push   $0x0
	popfl
  100013:	9d                   	popf   
	call start
  100014:	e8 60 02 00 00       	call   100279 <start>
  100019:	90                   	nop

0010001a <sys_int48_handler>:

# Interrupt handlers
.align 2

sys_int48_handler:
	pushl $0
  10001a:	6a 00                	push   $0x0
	pushl $48
  10001c:	6a 30                	push   $0x30
	jmp _generic_int_handler
  10001e:	eb 3a                	jmp    10005a <_generic_int_handler>

00100020 <sys_int49_handler>:

sys_int49_handler:
	pushl $0
  100020:	6a 00                	push   $0x0
	pushl $49
  100022:	6a 31                	push   $0x31
	jmp _generic_int_handler
  100024:	eb 34                	jmp    10005a <_generic_int_handler>

00100026 <sys_int50_handler>:

sys_int50_handler:
	pushl $0
  100026:	6a 00                	push   $0x0
	pushl $50
  100028:	6a 32                	push   $0x32
	jmp _generic_int_handler
  10002a:	eb 2e                	jmp    10005a <_generic_int_handler>

0010002c <sys_int51_handler>:

sys_int51_handler:
	pushl $0
  10002c:	6a 00                	push   $0x0
	pushl $51
  10002e:	6a 33                	push   $0x33
	jmp _generic_int_handler
  100030:	eb 28                	jmp    10005a <_generic_int_handler>

00100032 <sys_int52_handler>:

sys_int52_handler:
	pushl $0
  100032:	6a 00                	push   $0x0
	pushl $52
  100034:	6a 34                	push   $0x34
	jmp _generic_int_handler
  100036:	eb 22                	jmp    10005a <_generic_int_handler>

00100038 <sys_int53_handler>:

sys_int53_handler:
	pushl $0
  100038:	6a 00                	push   $0x0
	pushl $53
  10003a:	6a 35                	push   $0x35
	jmp _generic_int_handler
  10003c:	eb 1c                	jmp    10005a <_generic_int_handler>

0010003e <sys_int54_handler>:

sys_int54_handler:
	pushl $0
  10003e:	6a 00                	push   $0x0
	pushl $54
  100040:	6a 36                	push   $0x36
	jmp _generic_int_handler
  100042:	eb 16                	jmp    10005a <_generic_int_handler>

00100044 <sys_int55_handler>:

sys_int55_handler:
	pushl $0
  100044:	6a 00                	push   $0x0
	pushl $55
  100046:	6a 37                	push   $0x37
	jmp _generic_int_handler
  100048:	eb 10                	jmp    10005a <_generic_int_handler>

0010004a <sys_int56_handler>:

sys_int56_handler:
	pushl $0
  10004a:	6a 00                	push   $0x0
	pushl $56
  10004c:	6a 38                	push   $0x38
	jmp _generic_int_handler
  10004e:	eb 0a                	jmp    10005a <_generic_int_handler>

00100050 <sys_int57_handler>:

sys_int57_handler:
	pushl $0
  100050:	6a 00                	push   $0x0
	pushl $57
  100052:	6a 39                	push   $0x39
	jmp _generic_int_handler
  100054:	eb 04                	jmp    10005a <_generic_int_handler>

00100056 <default_int_handler>:

	.globl default_int_handler
default_int_handler:
	pushl $0
  100056:	6a 00                	push   $0x0
	jmp _generic_int_handler
  100058:	eb 00                	jmp    10005a <_generic_int_handler>

0010005a <_generic_int_handler>:
	# When we get here, the processor's interrupt mechanism has
	# pushed the old task status and stack registers onto the kernel stack.
	# Then one of the specific handlers pushed the interrupt number.
	# Now, we complete the 'registers_t' structure by pushing the extra
	# segment definitions and the general CPU registers.
	pushl %ds
  10005a:	1e                   	push   %ds
	pushl %es
  10005b:	06                   	push   %es
	pushal
  10005c:	60                   	pusha  

	# Call the kernel's 'interrupt' function.
	pushl %esp
  10005d:	54                   	push   %esp
	call interrupt
  10005e:	e8 58 00 00 00       	call   1000bb <interrupt>

00100063 <sys_int_handlers>:
  100063:	1a 00                	sbb    (%eax),%al
  100065:	10 00                	adc    %al,(%eax)
  100067:	20 00                	and    %al,(%eax)
  100069:	10 00                	adc    %al,(%eax)
  10006b:	26 00 10             	add    %dl,%es:(%eax)
  10006e:	00 2c 00             	add    %ch,(%eax,%eax,1)
  100071:	10 00                	adc    %al,(%eax)
  100073:	32 00                	xor    (%eax),%al
  100075:	10 00                	adc    %al,(%eax)
  100077:	38 00                	cmp    %al,(%eax)
  100079:	10 00                	adc    %al,(%eax)
  10007b:	3e 00 10             	add    %dl,%ds:(%eax)
  10007e:	00 44 00 10          	add    %al,0x10(%eax,%eax,1)
  100082:	00 4a 00             	add    %cl,0x0(%edx)
  100085:	10 00                	adc    %al,(%eax)
  100087:	50                   	push   %eax
  100088:	00 10                	add    %dl,(%eax)
  10008a:	00 90 83 ec 0c a1    	add    %dl,-0x5ef3137d(%eax)

0010008c <schedule>:
 *
 *****************************************************************************/

void
schedule(void)
{
  10008c:	83 ec 0c             	sub    $0xc,%esp
	pid_t pid = current->p_pid;
  10008f:	a1 a4 9e 10 00       	mov    0x109ea4,%eax
	while (1) {
		pid = (pid + 1) % NPROCS;
  100094:	b9 10 00 00 00       	mov    $0x10,%ecx
 *****************************************************************************/

void
schedule(void)
{
	pid_t pid = current->p_pid;
  100099:	8b 10                	mov    (%eax),%edx
	while (1) {
		pid = (pid + 1) % NPROCS;
  10009b:	8d 42 01             	lea    0x1(%edx),%eax
  10009e:	99                   	cltd   
  10009f:	f7 f9                	idiv   %ecx
		if (proc_array[pid].p_state == P_RUNNABLE)
  1000a1:	6b c2 54             	imul   $0x54,%edx,%eax
  1000a4:	83 b8 44 91 10 00 01 	cmpl   $0x1,0x109144(%eax)
  1000ab:	75 ee                	jne    10009b <schedule+0xf>
			run(&proc_array[pid]);
  1000ad:	83 ec 0c             	sub    $0xc,%esp
  1000b0:	05 fc 90 10 00       	add    $0x1090fc,%eax
  1000b5:	50                   	push   %eax
  1000b6:	e8 e1 03 00 00       	call   10049c <run>

001000bb <interrupt>:

static pid_t do_fork(process_t *parent);
static pid_t do_newthread (process_t* process, int startFunction);
void
interrupt(registers_t *reg)
{
  1000bb:	55                   	push   %ebp
	// the application's state on the kernel's stack, then jumping to
	// kernel assembly code (in mpos-int.S, for your information).
	// That code saves more registers on the kernel's stack, then calls
	// interrupt().  The first thing we must do, then, is copy the saved
	// registers into the 'current' process descriptor.
	current->p_registers = *reg;
  1000bc:	b9 11 00 00 00       	mov    $0x11,%ecx

static pid_t do_fork(process_t *parent);
static pid_t do_newthread (process_t* process, int startFunction);
void
interrupt(registers_t *reg)
{
  1000c1:	57                   	push   %edi
  1000c2:	56                   	push   %esi
  1000c3:	53                   	push   %ebx
  1000c4:	83 ec 1c             	sub    $0x1c,%esp
	// the application's state on the kernel's stack, then jumping to
	// kernel assembly code (in mpos-int.S, for your information).
	// That code saves more registers on the kernel's stack, then calls
	// interrupt().  The first thing we must do, then, is copy the saved
	// registers into the 'current' process descriptor.
	current->p_registers = *reg;
  1000c7:	8b 1d a4 9e 10 00    	mov    0x109ea4,%ebx

static pid_t do_fork(process_t *parent);
static pid_t do_newthread (process_t* process, int startFunction);
void
interrupt(registers_t *reg)
{
  1000cd:	8b 44 24 30          	mov    0x30(%esp),%eax
	// the application's state on the kernel's stack, then jumping to
	// kernel assembly code (in mpos-int.S, for your information).
	// That code saves more registers on the kernel's stack, then calls
	// interrupt().  The first thing we must do, then, is copy the saved
	// registers into the 'current' process descriptor.
	current->p_registers = *reg;
  1000d1:	8d 7b 04             	lea    0x4(%ebx),%edi
  1000d4:	89 c6                	mov    %eax,%esi
  1000d6:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  1000d8:	8b 40 28             	mov    0x28(%eax),%eax
  1000db:	83 e8 30             	sub    $0x30,%eax
  1000de:	83 f8 05             	cmp    $0x5,%eax
  1000e1:	0f 87 90 01 00 00    	ja     100277 <interrupt+0x1bc>
  1000e7:	ff 24 85 58 0a 10 00 	jmp    *0x100a58(,%eax,4)
		// The 'sys_getpid' system call returns the current
		// process's process ID.  System calls return results to user
		// code by putting those results in a register.  Like Linux,
		// we use %eax for system call return values.  The code is
		// surprisingly simple:
		current->p_registers.reg_eax = current->p_pid;
  1000ee:	8b 03                	mov    (%ebx),%eax
		run(current);
  1000f0:	83 ec 0c             	sub    $0xc,%esp
		// The 'sys_getpid' system call returns the current
		// process's process ID.  System calls return results to user
		// code by putting those results in a register.  Like Linux,
		// we use %eax for system call return values.  The code is
		// surprisingly simple:
		current->p_registers.reg_eax = current->p_pid;
  1000f3:	89 43 20             	mov    %eax,0x20(%ebx)
		run(current);
  1000f6:	53                   	push   %ebx
  1000f7:	e9 9a 00 00 00       	jmp    100196 <interrupt+0xdb>
  1000fc:	b8 98 91 10 00       	mov    $0x109198,%eax
  100101:	ba 01 00 00 00       	mov    $0x1,%edx
	//                What should sys_fork() return to the child process?)
	// You need to set one other process descriptor field as well.
	// Finally, return the child's process ID to the parent.
	pid_t id;
	for( id = 1; id < NPROCS; id++){
		if(proc_array[id].p_state == P_EMPTY)
  100106:	83 38 00             	cmpl   $0x0,(%eax)
  100109:	74 0e                	je     100119 <interrupt+0x5e>
	//   * ???????    There is one other difference.  What is it?  (Hint:
	//                What should sys_fork() return to the child process?)
	// You need to set one other process descriptor field as well.
	// Finally, return the child's process ID to the parent.
	pid_t id;
	for( id = 1; id < NPROCS; id++){
  10010b:	42                   	inc    %edx
  10010c:	83 c0 54             	add    $0x54,%eax
  10010f:	83 fa 10             	cmp    $0x10,%edx
  100112:	75 f2                	jne    100106 <interrupt+0x4b>
  100114:	83 ca ff             	or     $0xffffffff,%edx
  100117:	eb 71                	jmp    10018a <interrupt+0xcf>
		if(proc_array[id].p_state == P_EMPTY)
			break;
	}
	if(id >= NPROCS)
		return -1;
	proc_array[id].p_registers = parent->p_registers;
  100119:	6b ea 54             	imul   $0x54,%edx,%ebp
  10011c:	b9 11 00 00 00       	mov    $0x11,%ecx
  100121:	8d 73 04             	lea    0x4(%ebx),%esi
  100124:	8d 85 fc 90 10 00    	lea    0x1090fc(%ebp),%eax
  10012a:	89 c7                	mov    %eax,%edi
  10012c:	83 c7 04             	add    $0x4,%edi
  10012f:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
	// and then how to actually copy the stack.  (Hint: use memcpy.)
	// We have done one for you.

	// YOUR CODE HERE!

	src_stack_top = PROC1_STACK_ADDR + src->p_pid * PROC_STACK_SIZE;
  100131:	8b 33                	mov    (%ebx),%esi
	src_stack_bottom = src->p_registers.reg_esp;
	dest_stack_top = PROC1_STACK_ADDR + dest->p_pid * PROC_STACK_SIZE;
  100133:	8b bd fc 90 10 00    	mov    0x1090fc(%ebp),%edi
		if(proc_array[id].p_state == P_EMPTY)
			break;
	}
	if(id >= NPROCS)
		return -1;
	proc_array[id].p_registers = parent->p_registers;
  100139:	89 44 24 0c          	mov    %eax,0xc(%esp)
	// We have done one for you.

	// YOUR CODE HERE!

	src_stack_top = PROC1_STACK_ADDR + src->p_pid * PROC_STACK_SIZE;
	src_stack_bottom = src->p_registers.reg_esp;
  10013d:	8b 4b 40             	mov    0x40(%ebx),%ecx
	// and then how to actually copy the stack.  (Hint: use memcpy.)
	// We have done one for you.

	// YOUR CODE HERE!

	src_stack_top = PROC1_STACK_ADDR + src->p_pid * PROC_STACK_SIZE;
  100140:	83 c6 0a             	add    $0xa,%esi
  100143:	c1 e6 12             	shl    $0x12,%esi
	src_stack_bottom = src->p_registers.reg_esp;
	dest_stack_top = PROC1_STACK_ADDR + dest->p_pid * PROC_STACK_SIZE;
  100146:	83 c7 0a             	add    $0xa,%edi
	dest_stack_bottom = dest_stack_top - (src_stack_top - src_stack_bottom);
	// YOUR CODE HERE: memcpy the stack and set dest->p_registers.reg_esp
	memcpy((void*) dest_stack_top, (void*) src_stack_top, (src_stack_top
  100149:	50                   	push   %eax
  10014a:	89 f0                	mov    %esi,%eax
  10014c:	29 c8                	sub    %ecx,%eax
  10014e:	50                   	push   %eax
  10014f:	56                   	push   %esi

	// YOUR CODE HERE!

	src_stack_top = PROC1_STACK_ADDR + src->p_pid * PROC_STACK_SIZE;
	src_stack_bottom = src->p_registers.reg_esp;
	dest_stack_top = PROC1_STACK_ADDR + dest->p_pid * PROC_STACK_SIZE;
  100150:	c1 e7 12             	shl    $0x12,%edi
	dest_stack_bottom = dest_stack_top - (src_stack_top - src_stack_bottom);
	// YOUR CODE HERE: memcpy the stack and set dest->p_registers.reg_esp
	memcpy((void*) dest_stack_top, (void*) src_stack_top, (src_stack_top
  100153:	57                   	push   %edi
  100154:	89 54 24 18          	mov    %edx,0x18(%esp)
  100158:	89 4c 24 14          	mov    %ecx,0x14(%esp)
  10015c:	e8 13 04 00 00       	call   100574 <memcpy>
 - src_stack_bottom));
	dest->p_registers.reg_esp = dest_stack_bottom;
  100161:	8b 4c 24 14          	mov    0x14(%esp),%ecx
  100165:	8b 44 24 1c          	mov    0x1c(%esp),%eax
	if(id >= NPROCS)
		return -1;
	proc_array[id].p_registers = parent->p_registers;
	copy_stack(proc_array+id, parent);
	proc_array[id].p_registers.reg_eax = 0;
	proc_array[id].p_state = parent->p_state;
  100169:	83 c4 10             	add    $0x10,%esp
  10016c:	8b 54 24 08          	mov    0x8(%esp),%edx
	}
	if(id >= NPROCS)
		return -1;
	proc_array[id].p_registers = parent->p_registers;
	copy_stack(proc_array+id, parent);
	proc_array[id].p_registers.reg_eax = 0;
  100170:	c7 85 1c 91 10 00 00 	movl   $0x0,0x10911c(%ebp)
  100177:	00 00 00 
	dest_stack_top = PROC1_STACK_ADDR + dest->p_pid * PROC_STACK_SIZE;
	dest_stack_bottom = dest_stack_top - (src_stack_top - src_stack_bottom);
	// YOUR CODE HERE: memcpy the stack and set dest->p_registers.reg_esp
	memcpy((void*) dest_stack_top, (void*) src_stack_top, (src_stack_top
 - src_stack_bottom));
	dest->p_registers.reg_esp = dest_stack_bottom;
  10017a:	01 cf                	add    %ecx,%edi
  10017c:	29 f7                	sub    %esi,%edi
  10017e:	89 78 40             	mov    %edi,0x40(%eax)
	if(id >= NPROCS)
		return -1;
	proc_array[id].p_registers = parent->p_registers;
	copy_stack(proc_array+id, parent);
	proc_array[id].p_registers.reg_eax = 0;
	proc_array[id].p_state = parent->p_state;
  100181:	8b 43 48             	mov    0x48(%ebx),%eax
  100184:	89 85 44 91 10 00    	mov    %eax,0x109144(%ebp)
		run(current);

	case INT_SYS_FORK:
		// The 'sys_fork' system call should create a new process.
		// You will have to complete the do_fork() function!
		current->p_registers.reg_eax = do_fork(current);
  10018a:	89 53 20             	mov    %edx,0x20(%ebx)
		run(current);
  10018d:	83 ec 0c             	sub    $0xc,%esp
  100190:	ff 35 a4 9e 10 00    	pushl  0x109ea4
  100196:	e8 01 03 00 00       	call   10049c <run>
	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule a
		// different process.  (MiniprocOS is cooperatively
		// scheduled, so we need a special system call to do this.)
		// The schedule() function picks another process and runs it.
		schedule();
  10019b:	e8 ec fe ff ff       	call   10008c <schedule>
		// non-runnable.
		// The process stored its exit status in the %eax register
		// before calling the system call.  The %eax REGISTER has
		// changed by now, but we can read the APPLICATION's setting
		// for this register out of 'current->p_registers'.
		current->p_state = P_EMPTY;
  1001a0:	a1 a4 9e 10 00       	mov    0x109ea4,%eax
		current->p_exit_status = current->p_registers.reg_eax;

		if(current->p_blockedProc != 0){
  1001a5:	8b 50 50             	mov    0x50(%eax),%edx
		// The process stored its exit status in the %eax register
		// before calling the system call.  The %eax REGISTER has
		// changed by now, but we can read the APPLICATION's setting
		// for this register out of 'current->p_registers'.
		current->p_state = P_EMPTY;
		current->p_exit_status = current->p_registers.reg_eax;
  1001a8:	8b 48 20             	mov    0x20(%eax),%ecx
		// non-runnable.
		// The process stored its exit status in the %eax register
		// before calling the system call.  The %eax REGISTER has
		// changed by now, but we can read the APPLICATION's setting
		// for this register out of 'current->p_registers'.
		current->p_state = P_EMPTY;
  1001ab:	c7 40 48 00 00 00 00 	movl   $0x0,0x48(%eax)
		current->p_exit_status = current->p_registers.reg_eax;

		if(current->p_blockedProc != 0){
  1001b2:	85 d2                	test   %edx,%edx
		// The process stored its exit status in the %eax register
		// before calling the system call.  The %eax REGISTER has
		// changed by now, but we can read the APPLICATION's setting
		// for this register out of 'current->p_registers'.
		current->p_state = P_EMPTY;
		current->p_exit_status = current->p_registers.reg_eax;
  1001b4:	89 48 4c             	mov    %ecx,0x4c(%eax)

		if(current->p_blockedProc != 0){
  1001b7:	74 1a                	je     1001d3 <interrupt+0x118>
			proc_array[current->p_blockedProc].p_registers.reg_eax = current->p_exit_status;
  1001b9:	6b d2 54             	imul   $0x54,%edx,%edx
			proc_array[current->p_blockedProc].p_state = P_RUNNABLE;
			current->p_blockedProc = 0;
  1001bc:	c7 40 50 00 00 00 00 	movl   $0x0,0x50(%eax)
		// for this register out of 'current->p_registers'.
		current->p_state = P_EMPTY;
		current->p_exit_status = current->p_registers.reg_eax;

		if(current->p_blockedProc != 0){
			proc_array[current->p_blockedProc].p_registers.reg_eax = current->p_exit_status;
  1001c3:	89 8a 1c 91 10 00    	mov    %ecx,0x10911c(%edx)
			proc_array[current->p_blockedProc].p_state = P_RUNNABLE;
  1001c9:	c7 82 44 91 10 00 01 	movl   $0x1,0x109144(%edx)
  1001d0:	00 00 00 
			current->p_blockedProc = 0;
		}
		schedule();
  1001d3:	e8 b4 fe ff ff       	call   10008c <schedule>
		// * A process that doesn't exist (p_state == P_EMPTY).
		// (In the Unix operating system, only process P's parent
		// can call sys_wait(P).  In MiniprocOS, we allow ANY
		// process to call sys_wait(P).)

		pid_t p = current->p_registers.reg_eax;
  1001d8:	a1 a4 9e 10 00       	mov    0x109ea4,%eax
  1001dd:	8b 50 20             	mov    0x20(%eax),%edx
		if (p <= 0 || p >= NPROCS || p == current->p_pid
  1001e0:	8d 4a ff             	lea    -0x1(%edx),%ecx
  1001e3:	83 f9 0e             	cmp    $0xe,%ecx
  1001e6:	77 11                	ja     1001f9 <interrupt+0x13e>
  1001e8:	3b 10                	cmp    (%eax),%edx
  1001ea:	74 0d                	je     1001f9 <interrupt+0x13e>
		    || proc_array[p].p_state == P_EMPTY)
  1001ec:	6b d2 54             	imul   $0x54,%edx,%edx
  1001ef:	8b 8a 44 91 10 00    	mov    0x109144(%edx),%ecx
		// (In the Unix operating system, only process P's parent
		// can call sys_wait(P).  In MiniprocOS, we allow ANY
		// process to call sys_wait(P).)

		pid_t p = current->p_registers.reg_eax;
		if (p <= 0 || p >= NPROCS || p == current->p_pid
  1001f5:	85 c9                	test   %ecx,%ecx
  1001f7:	75 09                	jne    100202 <interrupt+0x147>
		    || proc_array[p].p_state == P_EMPTY)
			current->p_registers.reg_eax = -1;
  1001f9:	c7 40 20 ff ff ff ff 	movl   $0xffffffff,0x20(%eax)
		// (In the Unix operating system, only process P's parent
		// can call sys_wait(P).  In MiniprocOS, we allow ANY
		// process to call sys_wait(P).)

		pid_t p = current->p_registers.reg_eax;
		if (p <= 0 || p >= NPROCS || p == current->p_pid
  100200:	eb 26                	jmp    100228 <interrupt+0x16d>
		    || proc_array[p].p_state == P_EMPTY)
			current->p_registers.reg_eax = -1;
		else if (proc_array[p].p_state == P_ZOMBIE){
  100202:	83 f9 03             	cmp    $0x3,%ecx
  100205:	75 0b                	jne    100212 <interrupt+0x157>
			current->p_registers.reg_eax = proc_array[p].p_exit_status;
  100207:	8b 92 48 91 10 00    	mov    0x109148(%edx),%edx
  10020d:	89 50 20             	mov    %edx,0x20(%eax)
  100210:	eb 16                	jmp    100228 <interrupt+0x16d>
		}else{
			current->p_registers.reg_eax = WAIT_TRYAGAIN;
  100212:	c7 40 20 fe ff ff ff 	movl   $0xfffffffe,0x20(%eax)
			current->p_state = P_BLOCKED;
  100219:	c7 40 48 02 00 00 00 	movl   $0x2,0x48(%eax)
			proc_array[p].p_blockedProc = current->p_pid;
  100220:	8b 00                	mov    (%eax),%eax
  100222:	89 82 4c 91 10 00    	mov    %eax,0x10914c(%edx)
		}	
		schedule();
  100228:	e8 5f fe ff ff       	call   10008c <schedule>
	}

	case INT_SYS_NEWTHREAD:
		current->p_registers.reg_eax = do_newthread(current, current->p_registers.reg_ebx);
  10022d:	8b 15 a4 9e 10 00    	mov    0x109ea4,%edx
  100233:	b8 50 91 10 00       	mov    $0x109150,%eax
  100238:	bb 01 00 00 00       	mov    $0x1,%ebx
  10023d:	8b 6a 14             	mov    0x14(%edx),%ebp
	pid_t pid = 1;
	process_t* proc;
	while(pid < NPROCS){
		proc = &proc_array[pid];
		
		if(proc->p_state == P_EMPTY){
  100240:	83 78 48 00          	cmpl   $0x0,0x48(%eax)
  100244:	75 19                	jne    10025f <interrupt+0x1a4>
		
		proc->p_registers = parentProcess->p_registers;
  100246:	8d 78 04             	lea    0x4(%eax),%edi
  100249:	b9 11 00 00 00       	mov    $0x11,%ecx
  10024e:	8d 72 04             	lea    0x4(%edx),%esi
  100251:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
		proc->p_registers.reg_eip = startFunction;
  100253:	89 68 34             	mov    %ebp,0x34(%eax)

		proc->p_state == P_RUNNABLE;
		proc->p_registers.reg_eax = 0;
  100256:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)
  10025d:	eb 0c                	jmp    10026b <interrupt+0x1b0>
		
		return pid;
		}

		pid++;
  10025f:	43                   	inc    %ebx
  100260:	83 c0 54             	add    $0x54,%eax

pid_t
do_newthread(process_t* parentProcess, int startFunction){
	pid_t pid = 1;
	process_t* proc;
	while(pid < NPROCS){
  100263:	83 fb 10             	cmp    $0x10,%ebx
  100266:	75 d8                	jne    100240 <interrupt+0x185>
  100268:	83 cb ff             	or     $0xffffffff,%ebx
		schedule();
	}

	case INT_SYS_NEWTHREAD:
		current->p_registers.reg_eax = do_newthread(current, current->p_registers.reg_ebx);
		run(current);
  10026b:	83 ec 0c             	sub    $0xc,%esp
		}	
		schedule();
	}

	case INT_SYS_NEWTHREAD:
		current->p_registers.reg_eax = do_newthread(current, current->p_registers.reg_ebx);
  10026e:	89 5a 20             	mov    %ebx,0x20(%edx)
		run(current);
  100271:	52                   	push   %edx
  100272:	e9 1f ff ff ff       	jmp    100196 <interrupt+0xdb>
  100277:	eb fe                	jmp    100277 <interrupt+0x1bc>

00100279 <start>:
 *
 *****************************************************************************/

void
start(void)
{
  100279:	53                   	push   %ebx
  10027a:	83 ec 0c             	sub    $0xc,%esp
	const char *s;
	int whichprocess;
	pid_t i;

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  10027d:	68 40 05 00 00       	push   $0x540
  100282:	6a 00                	push   $0x0
  100284:	68 fc 90 10 00       	push   $0x1090fc
  100289:	e8 4a 03 00 00       	call   1005d8 <memset>
  10028e:	b8 fc 90 10 00       	mov    $0x1090fc,%eax
  100293:	31 d2                	xor    %edx,%edx
  100295:	83 c4 10             	add    $0x10,%esp
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100298:	89 10                	mov    %edx,(%eax)
	int whichprocess;
	pid_t i;

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
  10029a:	42                   	inc    %edx
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  10029b:	c7 40 48 00 00 00 00 	movl   $0x0,0x48(%eax)
		proc_array[i].p_blockedProc = 0;
  1002a2:	c7 40 50 00 00 00 00 	movl   $0x0,0x50(%eax)
	int whichprocess;
	pid_t i;

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
  1002a9:	83 c0 54             	add    $0x54,%eax
  1002ac:	83 fa 10             	cmp    $0x10,%edx
  1002af:	75 e7                	jne    100298 <start+0x1f>
		proc_array[i].p_state = P_EMPTY;
		proc_array[i].p_blockedProc = 0;
	}

	// The first process has process ID 1.
	current = &proc_array[1];
  1002b1:	c7 05 a4 9e 10 00 50 	movl   $0x109150,0x109ea4
  1002b8:	91 10 00 

	// Set up x86 hardware, and initialize the first process's
	// special registers.  This only needs to be done once, at boot time.
	// All other processes' special registers can be copied from the
	// first process.
	segments_init();
  1002bb:	e8 74 00 00 00       	call   100334 <segments_init>
	special_registers_init(current);
  1002c0:	83 ec 0c             	sub    $0xc,%esp
  1002c3:	ff 35 a4 9e 10 00    	pushl  0x109ea4
  1002c9:	e8 e5 01 00 00       	call   1004b3 <special_registers_init>

	// Erase the console, and initialize the cursor-position shared
	// variable to point to its upper left.
	console_clear();
  1002ce:	e8 30 01 00 00       	call   100403 <console_clear>

	// Figure out which program to run.
	cursorpos = console_printf(cursorpos, 0x0700, "Type '1' to run mpos-app, or '2' to run mpos-app2.");
  1002d3:	83 c4 0c             	add    $0xc,%esp
  1002d6:	68 70 0a 10 00       	push   $0x100a70
  1002db:	68 00 07 00 00       	push   $0x700
  1002e0:	ff 35 00 00 06 00    	pushl  0x60000
  1002e6:	e8 52 07 00 00       	call   100a3d <console_printf>
  1002eb:	83 c4 10             	add    $0x10,%esp
  1002ee:	a3 00 00 06 00       	mov    %eax,0x60000
	do {
		whichprocess = console_read_digit();
  1002f3:	e8 4e 01 00 00       	call   100446 <console_read_digit>
	} while (whichprocess != 1 && whichprocess != 2);
  1002f8:	8d 58 ff             	lea    -0x1(%eax),%ebx
  1002fb:	83 fb 01             	cmp    $0x1,%ebx
  1002fe:	77 f3                	ja     1002f3 <start+0x7a>
	console_clear();
  100300:	e8 fe 00 00 00       	call   100403 <console_clear>

	// Load the process application code and data into memory.
	// Store its entry point into the first process's EIP
	// (instruction pointer).
	program_loader(whichprocess - 1, &current->p_registers.reg_eip);
  100305:	a1 a4 9e 10 00       	mov    0x109ea4,%eax
  10030a:	83 c0 34             	add    $0x34,%eax
  10030d:	52                   	push   %edx
  10030e:	52                   	push   %edx
  10030f:	50                   	push   %eax
  100310:	53                   	push   %ebx
  100311:	e8 d2 01 00 00       	call   1004e8 <program_loader>

	// Set the main process's stack pointer, ESP.
	current->p_registers.reg_esp = PROC1_STACK_ADDR + PROC_STACK_SIZE;
  100316:	a1 a4 9e 10 00       	mov    0x109ea4,%eax
  10031b:	c7 40 40 00 00 2c 00 	movl   $0x2c0000,0x40(%eax)

	// Mark the process as runnable!
	current->p_state = P_RUNNABLE;
  100322:	c7 40 48 01 00 00 00 	movl   $0x1,0x48(%eax)

	// Switch to the main process using run().
	run(current);
  100329:	89 04 24             	mov    %eax,(%esp)
  10032c:	e8 6b 01 00 00       	call   10049c <run>
  100331:	90                   	nop
  100332:	90                   	nop
  100333:	90                   	nop

00100334 <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100334:	b8 3c 96 10 00       	mov    $0x10963c,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100339:	b9 56 00 10 00       	mov    $0x100056,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10033e:	89 c2                	mov    %eax,%edx
  100340:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  100343:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100344:	bb 56 00 10 00       	mov    $0x100056,%ebx
  100349:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10034c:	66 a3 0e 1b 10 00    	mov    %ax,0x101b0e
  100352:	c1 e8 18             	shr    $0x18,%eax
  100355:	88 15 10 1b 10 00    	mov    %dl,0x101b10
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10035b:	ba a4 96 10 00       	mov    $0x1096a4,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100360:	a2 13 1b 10 00       	mov    %al,0x101b13
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100365:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100367:	66 c7 05 0c 1b 10 00 	movw   $0x68,0x101b0c
  10036e:	68 00 
  100370:	c6 05 12 1b 10 00 40 	movb   $0x40,0x101b12
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  100377:	c6 05 11 1b 10 00 89 	movb   $0x89,0x101b11

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  10037e:	c7 05 40 96 10 00 00 	movl   $0x80000,0x109640
  100385:	00 08 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  100388:	66 c7 05 44 96 10 00 	movw   $0x10,0x109644
  10038f:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100391:	66 89 0c c5 a4 96 10 	mov    %cx,0x1096a4(,%eax,8)
  100398:	00 
  100399:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  1003a0:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  1003a5:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  1003aa:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  1003af:	40                   	inc    %eax
  1003b0:	3d 00 01 00 00       	cmp    $0x100,%eax
  1003b5:	75 da                	jne    100391 <segments_init+0x5d>
  1003b7:	66 b8 30 00          	mov    $0x30,%ax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_GETPID; i < INT_SYS_GETPID + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003bb:	ba a4 96 10 00       	mov    $0x1096a4,%edx
  1003c0:	8b 0c 85 a3 ff 0f 00 	mov    0xfffa3(,%eax,4),%ecx
  1003c7:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  1003ce:	66 89 0c c5 a4 96 10 	mov    %cx,0x1096a4(,%eax,8)
  1003d5:	00 
  1003d6:	c1 e9 10             	shr    $0x10,%ecx
  1003d9:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  1003de:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  1003e3:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_GETPID; i < INT_SYS_GETPID + 10; i++)
  1003e8:	40                   	inc    %eax
  1003e9:	83 f8 3a             	cmp    $0x3a,%eax
  1003ec:	75 d2                	jne    1003c0 <segments_init+0x8c>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_GETPID], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  1003ee:	b0 28                	mov    $0x28,%al
  1003f0:	0f 01 15 d4 1a 10 00 	lgdtl  0x101ad4
  1003f7:	0f 00 d8             	ltr    %ax
  1003fa:	0f 01 1d dc 1a 10 00 	lidtl  0x101adc
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  100401:	5b                   	pop    %ebx
  100402:	c3                   	ret    

00100403 <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  100403:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100404:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  100406:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100407:	c7 05 00 00 06 00 00 	movl   $0xb8000,0x60000
  10040e:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  100411:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%eax,%eax,1)
  100418:	00 20 07 
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  10041b:	40                   	inc    %eax
  10041c:	3d d0 07 00 00       	cmp    $0x7d0,%eax
  100421:	75 ee                	jne    100411 <console_clear+0xe>
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  100423:	be d4 03 00 00       	mov    $0x3d4,%esi
  100428:	b0 0e                	mov    $0xe,%al
  10042a:	89 f2                	mov    %esi,%edx
  10042c:	ee                   	out    %al,(%dx)
  10042d:	31 c9                	xor    %ecx,%ecx
  10042f:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  100434:	88 c8                	mov    %cl,%al
  100436:	89 da                	mov    %ebx,%edx
  100438:	ee                   	out    %al,(%dx)
  100439:	b0 0f                	mov    $0xf,%al
  10043b:	89 f2                	mov    %esi,%edx
  10043d:	ee                   	out    %al,(%dx)
  10043e:	88 c8                	mov    %cl,%al
  100440:	89 da                	mov    %ebx,%edx
  100442:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  100443:	5b                   	pop    %ebx
  100444:	5e                   	pop    %esi
  100445:	c3                   	ret    

00100446 <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  100446:	ba 64 00 00 00       	mov    $0x64,%edx
  10044b:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  10044c:	a8 01                	test   $0x1,%al
  10044e:	74 45                	je     100495 <console_read_digit+0x4f>
  100450:	b2 60                	mov    $0x60,%dl
  100452:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  100453:	8d 50 fe             	lea    -0x2(%eax),%edx
  100456:	80 fa 08             	cmp    $0x8,%dl
  100459:	77 05                	ja     100460 <console_read_digit+0x1a>
		return data - 0x02 + 1;
  10045b:	0f b6 c0             	movzbl %al,%eax
  10045e:	48                   	dec    %eax
  10045f:	c3                   	ret    
	else if (data == 0x0B)
  100460:	3c 0b                	cmp    $0xb,%al
  100462:	74 35                	je     100499 <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  100464:	8d 50 b9             	lea    -0x47(%eax),%edx
  100467:	80 fa 02             	cmp    $0x2,%dl
  10046a:	77 07                	ja     100473 <console_read_digit+0x2d>
		return data - 0x47 + 7;
  10046c:	0f b6 c0             	movzbl %al,%eax
  10046f:	83 e8 40             	sub    $0x40,%eax
  100472:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  100473:	8d 50 b5             	lea    -0x4b(%eax),%edx
  100476:	80 fa 02             	cmp    $0x2,%dl
  100479:	77 07                	ja     100482 <console_read_digit+0x3c>
		return data - 0x4B + 4;
  10047b:	0f b6 c0             	movzbl %al,%eax
  10047e:	83 e8 47             	sub    $0x47,%eax
  100481:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  100482:	8d 50 b1             	lea    -0x4f(%eax),%edx
  100485:	80 fa 02             	cmp    $0x2,%dl
  100488:	77 07                	ja     100491 <console_read_digit+0x4b>
		return data - 0x4F + 1;
  10048a:	0f b6 c0             	movzbl %al,%eax
  10048d:	83 e8 4e             	sub    $0x4e,%eax
  100490:	c3                   	ret    
	else if (data == 0x53)
  100491:	3c 53                	cmp    $0x53,%al
  100493:	74 04                	je     100499 <console_read_digit+0x53>
  100495:	83 c8 ff             	or     $0xffffffff,%eax
  100498:	c3                   	ret    
  100499:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  10049b:	c3                   	ret    

0010049c <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  10049c:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  1004a0:	a3 a4 9e 10 00       	mov    %eax,0x109ea4

	asm volatile("movl %0,%%esp\n\t"
  1004a5:	83 c0 04             	add    $0x4,%eax
  1004a8:	89 c4                	mov    %eax,%esp
  1004aa:	61                   	popa   
  1004ab:	07                   	pop    %es
  1004ac:	1f                   	pop    %ds
  1004ad:	83 c4 08             	add    $0x8,%esp
  1004b0:	cf                   	iret   
  1004b1:	eb fe                	jmp    1004b1 <run+0x15>

001004b3 <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  1004b3:	53                   	push   %ebx
  1004b4:	83 ec 0c             	sub    $0xc,%esp
  1004b7:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  1004bb:	6a 44                	push   $0x44
  1004bd:	6a 00                	push   $0x0
  1004bf:	8d 43 04             	lea    0x4(%ebx),%eax
  1004c2:	50                   	push   %eax
  1004c3:	e8 10 01 00 00       	call   1005d8 <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  1004c8:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  1004ce:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  1004d4:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  1004da:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
}
  1004e0:	83 c4 18             	add    $0x18,%esp
  1004e3:	5b                   	pop    %ebx
  1004e4:	c3                   	ret    
  1004e5:	90                   	nop
  1004e6:	90                   	nop
  1004e7:	90                   	nop

001004e8 <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  1004e8:	55                   	push   %ebp
  1004e9:	57                   	push   %edi
  1004ea:	56                   	push   %esi
  1004eb:	53                   	push   %ebx
  1004ec:	83 ec 1c             	sub    $0x1c,%esp
  1004ef:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  1004f3:	83 f8 01             	cmp    $0x1,%eax
  1004f6:	7f 04                	jg     1004fc <program_loader+0x14>
  1004f8:	85 c0                	test   %eax,%eax
  1004fa:	79 02                	jns    1004fe <program_loader+0x16>
  1004fc:	eb fe                	jmp    1004fc <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  1004fe:	8b 34 c5 14 1b 10 00 	mov    0x101b14(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  100505:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  10050b:	74 02                	je     10050f <program_loader+0x27>
  10050d:	eb fe                	jmp    10050d <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  10050f:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  100512:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  100516:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  100518:	c1 e5 05             	shl    $0x5,%ebp
  10051b:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  10051e:	eb 3f                	jmp    10055f <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  100520:	83 3b 01             	cmpl   $0x1,(%ebx)
  100523:	75 37                	jne    10055c <program_loader+0x74>
			copyseg((void *) ph->p_va,
  100525:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  100528:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  10052b:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  10052e:	01 c7                	add    %eax,%edi
	memsz += va;
  100530:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  100532:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  100537:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  10053b:	52                   	push   %edx
  10053c:	89 fa                	mov    %edi,%edx
  10053e:	29 c2                	sub    %eax,%edx
  100540:	52                   	push   %edx
  100541:	8b 53 04             	mov    0x4(%ebx),%edx
  100544:	01 f2                	add    %esi,%edx
  100546:	52                   	push   %edx
  100547:	50                   	push   %eax
  100548:	e8 27 00 00 00       	call   100574 <memcpy>
  10054d:	83 c4 10             	add    $0x10,%esp
  100550:	eb 04                	jmp    100556 <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  100552:	c6 07 00             	movb   $0x0,(%edi)
  100555:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  100556:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  10055a:	72 f6                	jb     100552 <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  10055c:	83 c3 20             	add    $0x20,%ebx
  10055f:	39 eb                	cmp    %ebp,%ebx
  100561:	72 bd                	jb     100520 <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  100563:	8b 56 18             	mov    0x18(%esi),%edx
  100566:	8b 44 24 34          	mov    0x34(%esp),%eax
  10056a:	89 10                	mov    %edx,(%eax)
}
  10056c:	83 c4 1c             	add    $0x1c,%esp
  10056f:	5b                   	pop    %ebx
  100570:	5e                   	pop    %esi
  100571:	5f                   	pop    %edi
  100572:	5d                   	pop    %ebp
  100573:	c3                   	ret    

00100574 <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  100574:	56                   	push   %esi
  100575:	31 d2                	xor    %edx,%edx
  100577:	53                   	push   %ebx
  100578:	8b 44 24 0c          	mov    0xc(%esp),%eax
  10057c:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  100580:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100584:	eb 08                	jmp    10058e <memcpy+0x1a>
		*d++ = *s++;
  100586:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  100589:	4e                   	dec    %esi
  10058a:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  10058d:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  10058e:	85 f6                	test   %esi,%esi
  100590:	75 f4                	jne    100586 <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  100592:	5b                   	pop    %ebx
  100593:	5e                   	pop    %esi
  100594:	c3                   	ret    

00100595 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  100595:	57                   	push   %edi
  100596:	56                   	push   %esi
  100597:	53                   	push   %ebx
  100598:	8b 44 24 10          	mov    0x10(%esp),%eax
  10059c:	8b 7c 24 14          	mov    0x14(%esp),%edi
  1005a0:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  1005a4:	39 c7                	cmp    %eax,%edi
  1005a6:	73 26                	jae    1005ce <memmove+0x39>
  1005a8:	8d 34 17             	lea    (%edi,%edx,1),%esi
  1005ab:	39 c6                	cmp    %eax,%esi
  1005ad:	76 1f                	jbe    1005ce <memmove+0x39>
		s += n, d += n;
  1005af:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  1005b2:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  1005b4:	eb 07                	jmp    1005bd <memmove+0x28>
			*--d = *--s;
  1005b6:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  1005b9:	4a                   	dec    %edx
  1005ba:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  1005bd:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  1005be:	85 d2                	test   %edx,%edx
  1005c0:	75 f4                	jne    1005b6 <memmove+0x21>
  1005c2:	eb 10                	jmp    1005d4 <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  1005c4:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  1005c7:	4a                   	dec    %edx
  1005c8:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  1005cb:	41                   	inc    %ecx
  1005cc:	eb 02                	jmp    1005d0 <memmove+0x3b>
  1005ce:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  1005d0:	85 d2                	test   %edx,%edx
  1005d2:	75 f0                	jne    1005c4 <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  1005d4:	5b                   	pop    %ebx
  1005d5:	5e                   	pop    %esi
  1005d6:	5f                   	pop    %edi
  1005d7:	c3                   	ret    

001005d8 <memset>:

void *
memset(void *v, int c, size_t n)
{
  1005d8:	53                   	push   %ebx
  1005d9:	8b 44 24 08          	mov    0x8(%esp),%eax
  1005dd:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  1005e1:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  1005e5:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  1005e7:	eb 04                	jmp    1005ed <memset+0x15>
		*p++ = c;
  1005e9:	88 1a                	mov    %bl,(%edx)
  1005eb:	49                   	dec    %ecx
  1005ec:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  1005ed:	85 c9                	test   %ecx,%ecx
  1005ef:	75 f8                	jne    1005e9 <memset+0x11>
		*p++ = c;
	return v;
}
  1005f1:	5b                   	pop    %ebx
  1005f2:	c3                   	ret    

001005f3 <strlen>:

size_t
strlen(const char *s)
{
  1005f3:	8b 54 24 04          	mov    0x4(%esp),%edx
  1005f7:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1005f9:	eb 01                	jmp    1005fc <strlen+0x9>
		++n;
  1005fb:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1005fc:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  100600:	75 f9                	jne    1005fb <strlen+0x8>
		++n;
	return n;
}
  100602:	c3                   	ret    

00100603 <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  100603:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  100607:	31 c0                	xor    %eax,%eax
  100609:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  10060d:	eb 01                	jmp    100610 <strnlen+0xd>
		++n;
  10060f:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100610:	39 d0                	cmp    %edx,%eax
  100612:	74 06                	je     10061a <strnlen+0x17>
  100614:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  100618:	75 f5                	jne    10060f <strnlen+0xc>
		++n;
	return n;
}
  10061a:	c3                   	ret    

0010061b <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  10061b:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  10061c:	3d a0 8f 0b 00       	cmp    $0xb8fa0,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100621:	53                   	push   %ebx
  100622:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  100624:	b8 00 80 0b 00       	mov    $0xb8000,%eax
  100629:	0f 43 d8             	cmovae %eax,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  10062c:	80 fa 0a             	cmp    $0xa,%dl
  10062f:	75 2c                	jne    10065d <console_putc+0x42>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100631:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  100637:	be 50 00 00 00       	mov    $0x50,%esi
  10063c:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  10063e:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100641:	99                   	cltd   
  100642:	f7 fe                	idiv   %esi
  100644:	89 de                	mov    %ebx,%esi
  100646:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  100648:	eb 07                	jmp    100651 <console_putc+0x36>
			*cursor++ = ' ' | color;
  10064a:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  10064d:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  10064e:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100651:	83 f8 50             	cmp    $0x50,%eax
  100654:	75 f4                	jne    10064a <console_putc+0x2f>
  100656:	29 d0                	sub    %edx,%eax
  100658:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  10065b:	eb 0b                	jmp    100668 <console_putc+0x4d>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  10065d:	0f b6 d2             	movzbl %dl,%edx
  100660:	09 ca                	or     %ecx,%edx
  100662:	66 89 13             	mov    %dx,(%ebx)
  100665:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  100668:	5b                   	pop    %ebx
  100669:	5e                   	pop    %esi
  10066a:	c3                   	ret    

0010066b <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  10066b:	56                   	push   %esi
  10066c:	53                   	push   %ebx
  10066d:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  100671:	8d 58 ff             	lea    -0x1(%eax),%ebx
  100674:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  100678:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  10067d:	75 04                	jne    100683 <fill_numbuf+0x18>
  10067f:	85 d2                	test   %edx,%edx
  100681:	74 10                	je     100693 <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  100683:	89 d0                	mov    %edx,%eax
  100685:	31 d2                	xor    %edx,%edx
  100687:	f7 f1                	div    %ecx
  100689:	4b                   	dec    %ebx
  10068a:	8a 14 16             	mov    (%esi,%edx,1),%dl
  10068d:	88 13                	mov    %dl,(%ebx)
			val /= base;
  10068f:	89 c2                	mov    %eax,%edx
  100691:	eb ec                	jmp    10067f <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  100693:	89 d8                	mov    %ebx,%eax
  100695:	5b                   	pop    %ebx
  100696:	5e                   	pop    %esi
  100697:	c3                   	ret    

00100698 <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  100698:	55                   	push   %ebp
  100699:	57                   	push   %edi
  10069a:	56                   	push   %esi
  10069b:	53                   	push   %ebx
  10069c:	83 ec 38             	sub    $0x38,%esp
  10069f:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  1006a3:	8b 7c 24 54          	mov    0x54(%esp),%edi
  1006a7:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  1006ab:	e9 62 03 00 00       	jmp    100a12 <console_vprintf+0x37a>
		if (*format != '%') {
  1006b0:	80 fa 25             	cmp    $0x25,%dl
  1006b3:	74 13                	je     1006c8 <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  1006b5:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1006b9:	0f b6 d2             	movzbl %dl,%edx
  1006bc:	89 f0                	mov    %esi,%eax
  1006be:	e8 58 ff ff ff       	call   10061b <console_putc>
  1006c3:	e9 47 03 00 00       	jmp    100a0f <console_vprintf+0x377>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1006c8:	47                   	inc    %edi
  1006c9:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  1006d0:	00 
  1006d1:	eb 12                	jmp    1006e5 <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  1006d3:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  1006d4:	8a 11                	mov    (%ecx),%dl
  1006d6:	84 d2                	test   %dl,%dl
  1006d8:	74 1a                	je     1006f4 <console_vprintf+0x5c>
  1006da:	89 e8                	mov    %ebp,%eax
  1006dc:	38 c2                	cmp    %al,%dl
  1006de:	75 f3                	jne    1006d3 <console_vprintf+0x3b>
  1006e0:	e9 41 03 00 00       	jmp    100a26 <console_vprintf+0x38e>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1006e5:	8a 17                	mov    (%edi),%dl
  1006e7:	84 d2                	test   %dl,%dl
  1006e9:	74 0b                	je     1006f6 <console_vprintf+0x5e>
  1006eb:	b9 a4 0a 10 00       	mov    $0x100aa4,%ecx
  1006f0:	89 d5                	mov    %edx,%ebp
  1006f2:	eb e0                	jmp    1006d4 <console_vprintf+0x3c>
  1006f4:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  1006f6:	8d 42 cf             	lea    -0x31(%edx),%eax
  1006f9:	3c 08                	cmp    $0x8,%al
  1006fb:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  100702:	00 
  100703:	76 13                	jbe    100718 <console_vprintf+0x80>
  100705:	eb 1d                	jmp    100724 <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  100707:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  10070c:	0f be c0             	movsbl %al,%eax
  10070f:	47                   	inc    %edi
  100710:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  100714:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  100718:	8a 07                	mov    (%edi),%al
  10071a:	8d 50 d0             	lea    -0x30(%eax),%edx
  10071d:	80 fa 09             	cmp    $0x9,%dl
  100720:	76 e5                	jbe    100707 <console_vprintf+0x6f>
  100722:	eb 18                	jmp    10073c <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  100724:	80 fa 2a             	cmp    $0x2a,%dl
  100727:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  10072e:	ff 
  10072f:	75 0b                	jne    10073c <console_vprintf+0xa4>
			width = va_arg(val, int);
  100731:	83 c3 04             	add    $0x4,%ebx
			++format;
  100734:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  100735:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100738:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  10073c:	83 cd ff             	or     $0xffffffff,%ebp
  10073f:	80 3f 2e             	cmpb   $0x2e,(%edi)
  100742:	75 37                	jne    10077b <console_vprintf+0xe3>
			++format;
  100744:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  100745:	31 ed                	xor    %ebp,%ebp
  100747:	8a 07                	mov    (%edi),%al
  100749:	8d 50 d0             	lea    -0x30(%eax),%edx
  10074c:	80 fa 09             	cmp    $0x9,%dl
  10074f:	76 0d                	jbe    10075e <console_vprintf+0xc6>
  100751:	eb 17                	jmp    10076a <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  100753:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  100756:	0f be c0             	movsbl %al,%eax
  100759:	47                   	inc    %edi
  10075a:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  10075e:	8a 07                	mov    (%edi),%al
  100760:	8d 50 d0             	lea    -0x30(%eax),%edx
  100763:	80 fa 09             	cmp    $0x9,%dl
  100766:	76 eb                	jbe    100753 <console_vprintf+0xbb>
  100768:	eb 11                	jmp    10077b <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  10076a:	3c 2a                	cmp    $0x2a,%al
  10076c:	75 0b                	jne    100779 <console_vprintf+0xe1>
				precision = va_arg(val, int);
  10076e:	83 c3 04             	add    $0x4,%ebx
				++format;
  100771:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  100772:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  100775:	85 ed                	test   %ebp,%ebp
  100777:	79 02                	jns    10077b <console_vprintf+0xe3>
  100779:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  10077b:	8a 07                	mov    (%edi),%al
  10077d:	3c 64                	cmp    $0x64,%al
  10077f:	74 34                	je     1007b5 <console_vprintf+0x11d>
  100781:	7f 1d                	jg     1007a0 <console_vprintf+0x108>
  100783:	3c 58                	cmp    $0x58,%al
  100785:	0f 84 a2 00 00 00    	je     10082d <console_vprintf+0x195>
  10078b:	3c 63                	cmp    $0x63,%al
  10078d:	0f 84 bf 00 00 00    	je     100852 <console_vprintf+0x1ba>
  100793:	3c 43                	cmp    $0x43,%al
  100795:	0f 85 d0 00 00 00    	jne    10086b <console_vprintf+0x1d3>
  10079b:	e9 a3 00 00 00       	jmp    100843 <console_vprintf+0x1ab>
  1007a0:	3c 75                	cmp    $0x75,%al
  1007a2:	74 4d                	je     1007f1 <console_vprintf+0x159>
  1007a4:	3c 78                	cmp    $0x78,%al
  1007a6:	74 5c                	je     100804 <console_vprintf+0x16c>
  1007a8:	3c 73                	cmp    $0x73,%al
  1007aa:	0f 85 bb 00 00 00    	jne    10086b <console_vprintf+0x1d3>
  1007b0:	e9 86 00 00 00       	jmp    10083b <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  1007b5:	83 c3 04             	add    $0x4,%ebx
  1007b8:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  1007bb:	89 d1                	mov    %edx,%ecx
  1007bd:	c1 f9 1f             	sar    $0x1f,%ecx
  1007c0:	89 0c 24             	mov    %ecx,(%esp)
  1007c3:	31 ca                	xor    %ecx,%edx
  1007c5:	55                   	push   %ebp
  1007c6:	29 ca                	sub    %ecx,%edx
  1007c8:	68 ac 0a 10 00       	push   $0x100aac
  1007cd:	b9 0a 00 00 00       	mov    $0xa,%ecx
  1007d2:	8d 44 24 40          	lea    0x40(%esp),%eax
  1007d6:	e8 90 fe ff ff       	call   10066b <fill_numbuf>
  1007db:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  1007df:	58                   	pop    %eax
  1007e0:	5a                   	pop    %edx
  1007e1:	ba 01 00 00 00       	mov    $0x1,%edx
  1007e6:	8b 04 24             	mov    (%esp),%eax
  1007e9:	83 e0 01             	and    $0x1,%eax
  1007ec:	e9 a6 00 00 00       	jmp    100897 <console_vprintf+0x1ff>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  1007f1:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  1007f4:	b9 0a 00 00 00       	mov    $0xa,%ecx
  1007f9:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1007fc:	55                   	push   %ebp
  1007fd:	68 ac 0a 10 00       	push   $0x100aac
  100802:	eb 11                	jmp    100815 <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  100804:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  100807:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10080a:	55                   	push   %ebp
  10080b:	68 c0 0a 10 00       	push   $0x100ac0
  100810:	b9 10 00 00 00       	mov    $0x10,%ecx
  100815:	8d 44 24 40          	lea    0x40(%esp),%eax
  100819:	e8 4d fe ff ff       	call   10066b <fill_numbuf>
  10081e:	ba 01 00 00 00       	mov    $0x1,%edx
  100823:	89 44 24 0c          	mov    %eax,0xc(%esp)
  100827:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  100829:	59                   	pop    %ecx
  10082a:	59                   	pop    %ecx
  10082b:	eb 6a                	jmp    100897 <console_vprintf+0x1ff>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  10082d:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  100830:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100833:	55                   	push   %ebp
  100834:	68 ac 0a 10 00       	push   $0x100aac
  100839:	eb d5                	jmp    100810 <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  10083b:	83 c3 04             	add    $0x4,%ebx
  10083e:	8b 43 fc             	mov    -0x4(%ebx),%eax
  100841:	eb 41                	jmp    100884 <console_vprintf+0x1ec>
			break;
		case 'C':
			color = va_arg(val, int);
  100843:	83 c3 04             	add    $0x4,%ebx
  100846:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100849:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  10084d:	e9 bf 01 00 00       	jmp    100a11 <console_vprintf+0x379>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100852:	83 c3 04             	add    $0x4,%ebx
  100855:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  100858:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  10085c:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  100861:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100865:	88 44 24 24          	mov    %al,0x24(%esp)
  100869:	eb 28                	jmp    100893 <console_vprintf+0x1fb>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  10086b:	84 c0                	test   %al,%al
  10086d:	b2 25                	mov    $0x25,%dl
  10086f:	0f 44 c2             	cmove  %edx,%eax
  100872:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  100876:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  10087b:	80 3f 00             	cmpb   $0x0,(%edi)
  10087e:	74 0a                	je     10088a <console_vprintf+0x1f2>
  100880:	8d 44 24 24          	lea    0x24(%esp),%eax
  100884:	89 44 24 04          	mov    %eax,0x4(%esp)
  100888:	eb 09                	jmp    100893 <console_vprintf+0x1fb>
				format--;
  10088a:	8d 54 24 24          	lea    0x24(%esp),%edx
  10088e:	4f                   	dec    %edi
  10088f:	89 54 24 04          	mov    %edx,0x4(%esp)
  100893:	31 d2                	xor    %edx,%edx
  100895:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100897:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  100899:	83 fd ff             	cmp    $0xffffffff,%ebp
  10089c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1008a3:	74 1f                	je     1008c4 <console_vprintf+0x22c>
  1008a5:	89 04 24             	mov    %eax,(%esp)
  1008a8:	eb 01                	jmp    1008ab <console_vprintf+0x213>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  1008aa:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1008ab:	39 e9                	cmp    %ebp,%ecx
  1008ad:	74 0a                	je     1008b9 <console_vprintf+0x221>
  1008af:	8b 44 24 04          	mov    0x4(%esp),%eax
  1008b3:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  1008b7:	75 f1                	jne    1008aa <console_vprintf+0x212>
  1008b9:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  1008bc:	89 0c 24             	mov    %ecx,(%esp)
  1008bf:	eb 1f                	jmp    1008e0 <console_vprintf+0x248>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  1008c1:	42                   	inc    %edx
  1008c2:	eb 09                	jmp    1008cd <console_vprintf+0x235>
  1008c4:	89 d1                	mov    %edx,%ecx
  1008c6:	8b 14 24             	mov    (%esp),%edx
  1008c9:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1008cd:	8b 44 24 04          	mov    0x4(%esp),%eax
  1008d1:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  1008d5:	75 ea                	jne    1008c1 <console_vprintf+0x229>
  1008d7:	8b 44 24 08          	mov    0x8(%esp),%eax
  1008db:	89 14 24             	mov    %edx,(%esp)
  1008de:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  1008e0:	85 c0                	test   %eax,%eax
  1008e2:	74 0c                	je     1008f0 <console_vprintf+0x258>
  1008e4:	84 d2                	test   %dl,%dl
  1008e6:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  1008ed:	00 
  1008ee:	75 24                	jne    100914 <console_vprintf+0x27c>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  1008f0:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  1008f5:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  1008fc:	00 
  1008fd:	75 15                	jne    100914 <console_vprintf+0x27c>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  1008ff:	8b 44 24 14          	mov    0x14(%esp),%eax
  100903:	83 e0 08             	and    $0x8,%eax
  100906:	83 f8 01             	cmp    $0x1,%eax
  100909:	19 c9                	sbb    %ecx,%ecx
  10090b:	f7 d1                	not    %ecx
  10090d:	83 e1 20             	and    $0x20,%ecx
  100910:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  100914:	3b 2c 24             	cmp    (%esp),%ebp
  100917:	7e 0d                	jle    100926 <console_vprintf+0x28e>
  100919:	84 d2                	test   %dl,%dl
  10091b:	74 41                	je     10095e <console_vprintf+0x2c6>
			zeros = precision - len;
  10091d:	2b 2c 24             	sub    (%esp),%ebp
  100920:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  100924:	eb 40                	jmp    100966 <console_vprintf+0x2ce>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100926:	84 d2                	test   %dl,%dl
  100928:	74 34                	je     10095e <console_vprintf+0x2c6>
  10092a:	8b 44 24 14          	mov    0x14(%esp),%eax
  10092e:	83 e0 06             	and    $0x6,%eax
  100931:	83 f8 02             	cmp    $0x2,%eax
  100934:	75 28                	jne    10095e <console_vprintf+0x2c6>
  100936:	45                   	inc    %ebp
  100937:	75 25                	jne    10095e <console_vprintf+0x2c6>
			 && numeric && precision < 0
			 && len + !!negative < width)
  100939:	31 c0                	xor    %eax,%eax
  10093b:	8b 14 24             	mov    (%esp),%edx
  10093e:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100943:	0f 95 c0             	setne  %al
  100946:	8d 14 10             	lea    (%eax,%edx,1),%edx
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100949:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  10094d:	7d 0f                	jge    10095e <console_vprintf+0x2c6>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  10094f:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100953:	2b 14 24             	sub    (%esp),%edx
  100956:	29 c2                	sub    %eax,%edx
  100958:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  10095c:	eb 08                	jmp    100966 <console_vprintf+0x2ce>
  10095e:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  100965:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100966:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  10096a:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  10096c:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100970:	2b 2c 24             	sub    (%esp),%ebp
  100973:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100978:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  10097b:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  10097e:	29 c5                	sub    %eax,%ebp
  100980:	89 f0                	mov    %esi,%eax
  100982:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100986:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  10098a:	eb 0f                	jmp    10099b <console_vprintf+0x303>
			cursor = console_putc(cursor, ' ', color);
  10098c:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100990:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100995:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100996:	e8 80 fc ff ff       	call   10061b <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  10099b:	85 ed                	test   %ebp,%ebp
  10099d:	7e 07                	jle    1009a6 <console_vprintf+0x30e>
  10099f:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  1009a4:	74 e6                	je     10098c <console_vprintf+0x2f4>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  1009a6:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  1009ab:	89 c6                	mov    %eax,%esi
  1009ad:	74 23                	je     1009d2 <console_vprintf+0x33a>
			cursor = console_putc(cursor, negative, color);
  1009af:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  1009b4:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1009b8:	e8 5e fc ff ff       	call   10061b <console_putc>
  1009bd:	89 c6                	mov    %eax,%esi
  1009bf:	eb 11                	jmp    1009d2 <console_vprintf+0x33a>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  1009c1:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1009c5:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  1009ca:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  1009cb:	e8 4b fc ff ff       	call   10061b <console_putc>
  1009d0:	eb 06                	jmp    1009d8 <console_vprintf+0x340>
  1009d2:	89 f0                	mov    %esi,%eax
  1009d4:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  1009d8:	85 f6                	test   %esi,%esi
  1009da:	7f e5                	jg     1009c1 <console_vprintf+0x329>
  1009dc:	8b 34 24             	mov    (%esp),%esi
  1009df:	eb 15                	jmp    1009f6 <console_vprintf+0x35e>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  1009e1:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  1009e5:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  1009e6:	0f b6 11             	movzbl (%ecx),%edx
  1009e9:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1009ed:	e8 29 fc ff ff       	call   10061b <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  1009f2:	ff 44 24 04          	incl   0x4(%esp)
  1009f6:	85 f6                	test   %esi,%esi
  1009f8:	7f e7                	jg     1009e1 <console_vprintf+0x349>
  1009fa:	eb 0f                	jmp    100a0b <console_vprintf+0x373>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  1009fc:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a00:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100a05:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100a06:	e8 10 fc ff ff       	call   10061b <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100a0b:	85 ed                	test   %ebp,%ebp
  100a0d:	7f ed                	jg     1009fc <console_vprintf+0x364>
  100a0f:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100a11:	47                   	inc    %edi
  100a12:	8a 17                	mov    (%edi),%dl
  100a14:	84 d2                	test   %dl,%dl
  100a16:	0f 85 94 fc ff ff    	jne    1006b0 <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100a1c:	83 c4 38             	add    $0x38,%esp
  100a1f:	89 f0                	mov    %esi,%eax
  100a21:	5b                   	pop    %ebx
  100a22:	5e                   	pop    %esi
  100a23:	5f                   	pop    %edi
  100a24:	5d                   	pop    %ebp
  100a25:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100a26:	81 e9 a4 0a 10 00    	sub    $0x100aa4,%ecx
  100a2c:	b8 01 00 00 00       	mov    $0x1,%eax
  100a31:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100a33:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100a34:	09 44 24 14          	or     %eax,0x14(%esp)
  100a38:	e9 a8 fc ff ff       	jmp    1006e5 <console_vprintf+0x4d>

00100a3d <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100a3d:	8d 44 24 10          	lea    0x10(%esp),%eax
  100a41:	50                   	push   %eax
  100a42:	ff 74 24 10          	pushl  0x10(%esp)
  100a46:	ff 74 24 10          	pushl  0x10(%esp)
  100a4a:	ff 74 24 10          	pushl  0x10(%esp)
  100a4e:	e8 45 fc ff ff       	call   100698 <console_vprintf>
  100a53:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100a56:	c3                   	ret    
