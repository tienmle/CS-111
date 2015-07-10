
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
  100014:	e8 16 02 00 00       	call   10022f <start>
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
  10008f:	a1 54 9e 10 00       	mov    0x109e54,%eax
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
  1000a4:	83 b8 f4 90 10 00 01 	cmpl   $0x1,0x1090f4(%eax)
  1000ab:	75 ee                	jne    10009b <schedule+0xf>
			run(&proc_array[pid]);
  1000ad:	83 ec 0c             	sub    $0xc,%esp
  1000b0:	05 ac 90 10 00       	add    $0x1090ac,%eax
  1000b5:	50                   	push   %eax
  1000b6:	e8 95 03 00 00       	call   100450 <run>

001000bb <interrupt>:

static pid_t do_fork(process_t *parent);

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
  1000c7:	8b 1d 54 9e 10 00    	mov    0x109e54,%ebx

static pid_t do_fork(process_t *parent);

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
  1000de:	83 f8 04             	cmp    $0x4,%eax
  1000e1:	0f 87 46 01 00 00    	ja     10022d <interrupt+0x172>
  1000e7:	ff 24 85 0c 0a 10 00 	jmp    *0x100a0c(,%eax,4)
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
  1000fc:	b8 48 91 10 00       	mov    $0x109148,%eax
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
  100124:	8d 85 ac 90 10 00    	lea    0x1090ac(%ebp),%eax
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
  100133:	8b bd ac 90 10 00    	mov    0x1090ac(%ebp),%edi
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
  10015c:	e8 c7 03 00 00       	call   100528 <memcpy>
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
  100170:	c7 85 cc 90 10 00 00 	movl   $0x0,0x1090cc(%ebp)
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
  100184:	89 85 f4 90 10 00    	mov    %eax,0x1090f4(%ebp)
		run(current);

	case INT_SYS_FORK:
		// The 'sys_fork' system call should create a new process.
		// You will have to complete the do_fork() function!
		current->p_registers.reg_eax = do_fork(current);
  10018a:	89 53 20             	mov    %edx,0x20(%ebx)
		run(current);
  10018d:	83 ec 0c             	sub    $0xc,%esp
  100190:	ff 35 54 9e 10 00    	pushl  0x109e54
  100196:	e8 b5 02 00 00       	call   100450 <run>
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
  1001a0:	a1 54 9e 10 00       	mov    0x109e54,%eax
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
  1001c3:	89 8a cc 90 10 00    	mov    %ecx,0x1090cc(%edx)
			proc_array[current->p_blockedProc].p_state = P_RUNNABLE;
  1001c9:	c7 82 f4 90 10 00 01 	movl   $0x1,0x1090f4(%edx)
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
  1001d8:	a1 54 9e 10 00       	mov    0x109e54,%eax
  1001dd:	8b 50 20             	mov    0x20(%eax),%edx
		if (p <= 0 || p >= NPROCS || p == current->p_pid
  1001e0:	8d 4a ff             	lea    -0x1(%edx),%ecx
  1001e3:	83 f9 0e             	cmp    $0xe,%ecx
  1001e6:	77 11                	ja     1001f9 <interrupt+0x13e>
  1001e8:	3b 10                	cmp    (%eax),%edx
  1001ea:	74 0d                	je     1001f9 <interrupt+0x13e>
		    || proc_array[p].p_state == P_EMPTY)
  1001ec:	6b d2 54             	imul   $0x54,%edx,%edx
  1001ef:	8b 8a f4 90 10 00    	mov    0x1090f4(%edx),%ecx
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
  100207:	8b 92 f8 90 10 00    	mov    0x1090f8(%edx),%edx
  10020d:	89 50 20             	mov    %edx,0x20(%eax)
  100210:	eb 16                	jmp    100228 <interrupt+0x16d>
		}else{
			current->p_registers.reg_eax = WAIT_TRYAGAIN;
  100212:	c7 40 20 fe ff ff ff 	movl   $0xfffffffe,0x20(%eax)
			current->p_state = P_BLOCKED;
  100219:	c7 40 48 02 00 00 00 	movl   $0x2,0x48(%eax)
			proc_array[p].p_blockedProc = current->p_pid;
  100220:	8b 00                	mov    (%eax),%eax
  100222:	89 82 fc 90 10 00    	mov    %eax,0x1090fc(%edx)
		}	
		schedule();
  100228:	e8 5f fe ff ff       	call   10008c <schedule>
  10022d:	eb fe                	jmp    10022d <interrupt+0x172>

0010022f <start>:
 *
 *****************************************************************************/

void
start(void)
{
  10022f:	53                   	push   %ebx
  100230:	83 ec 0c             	sub    $0xc,%esp
	const char *s;
	int whichprocess;
	pid_t i;

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  100233:	68 40 05 00 00       	push   $0x540
  100238:	6a 00                	push   $0x0
  10023a:	68 ac 90 10 00       	push   $0x1090ac
  10023f:	e8 48 03 00 00       	call   10058c <memset>
  100244:	b8 ac 90 10 00       	mov    $0x1090ac,%eax
  100249:	31 d2                	xor    %edx,%edx
  10024b:	83 c4 10             	add    $0x10,%esp
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10024e:	89 10                	mov    %edx,(%eax)
	int whichprocess;
	pid_t i;

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
  100250:	42                   	inc    %edx
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100251:	c7 40 48 00 00 00 00 	movl   $0x0,0x48(%eax)
		proc_array[i].p_blockedProc = 0;
  100258:	c7 40 50 00 00 00 00 	movl   $0x0,0x50(%eax)
	int whichprocess;
	pid_t i;

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
  10025f:	83 c0 54             	add    $0x54,%eax
  100262:	83 fa 10             	cmp    $0x10,%edx
  100265:	75 e7                	jne    10024e <start+0x1f>
		proc_array[i].p_state = P_EMPTY;
		proc_array[i].p_blockedProc = 0;
	}

	// The first process has process ID 1.
	current = &proc_array[1];
  100267:	c7 05 54 9e 10 00 00 	movl   $0x109100,0x109e54
  10026e:	91 10 00 

	// Set up x86 hardware, and initialize the first process's
	// special registers.  This only needs to be done once, at boot time.
	// All other processes' special registers can be copied from the
	// first process.
	segments_init();
  100271:	e8 72 00 00 00       	call   1002e8 <segments_init>
	special_registers_init(current);
  100276:	83 ec 0c             	sub    $0xc,%esp
  100279:	ff 35 54 9e 10 00    	pushl  0x109e54
  10027f:	e8 e3 01 00 00       	call   100467 <special_registers_init>

	// Erase the console, and initialize the cursor-position shared
	// variable to point to its upper left.
	console_clear();
  100284:	e8 2e 01 00 00       	call   1003b7 <console_clear>

	// Figure out which program to run.
	cursorpos = console_printf(cursorpos, 0x0700, "Type '1' to run mpos-app, or '2' to run mpos-app2.");
  100289:	83 c4 0c             	add    $0xc,%esp
  10028c:	68 20 0a 10 00       	push   $0x100a20
  100291:	68 00 07 00 00       	push   $0x700
  100296:	ff 35 00 00 06 00    	pushl  0x60000
  10029c:	e8 50 07 00 00       	call   1009f1 <console_printf>
  1002a1:	83 c4 10             	add    $0x10,%esp
  1002a4:	a3 00 00 06 00       	mov    %eax,0x60000
	do {
		whichprocess = console_read_digit();
  1002a9:	e8 4c 01 00 00       	call   1003fa <console_read_digit>
	} while (whichprocess != 1 && whichprocess != 2);
  1002ae:	8d 58 ff             	lea    -0x1(%eax),%ebx
  1002b1:	83 fb 01             	cmp    $0x1,%ebx
  1002b4:	77 f3                	ja     1002a9 <start+0x7a>
	console_clear();
  1002b6:	e8 fc 00 00 00       	call   1003b7 <console_clear>

	// Load the process application code and data into memory.
	// Store its entry point into the first process's EIP
	// (instruction pointer).
	program_loader(whichprocess - 1, &current->p_registers.reg_eip);
  1002bb:	a1 54 9e 10 00       	mov    0x109e54,%eax
  1002c0:	83 c0 34             	add    $0x34,%eax
  1002c3:	52                   	push   %edx
  1002c4:	52                   	push   %edx
  1002c5:	50                   	push   %eax
  1002c6:	53                   	push   %ebx
  1002c7:	e8 d0 01 00 00       	call   10049c <program_loader>

	// Set the main process's stack pointer, ESP.
	current->p_registers.reg_esp = PROC1_STACK_ADDR + PROC_STACK_SIZE;
  1002cc:	a1 54 9e 10 00       	mov    0x109e54,%eax
  1002d1:	c7 40 40 00 00 2c 00 	movl   $0x2c0000,0x40(%eax)

	// Mark the process as runnable!
	current->p_state = P_RUNNABLE;
  1002d8:	c7 40 48 01 00 00 00 	movl   $0x1,0x48(%eax)

	// Switch to the main process using run().
	run(current);
  1002df:	89 04 24             	mov    %eax,(%esp)
  1002e2:	e8 69 01 00 00       	call   100450 <run>
  1002e7:	90                   	nop

001002e8 <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002e8:	b8 ec 95 10 00       	mov    $0x1095ec,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002ed:	b9 56 00 10 00       	mov    $0x100056,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002f2:	89 c2                	mov    %eax,%edx
  1002f4:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  1002f7:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002f8:	bb 56 00 10 00       	mov    $0x100056,%ebx
  1002fd:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100300:	66 a3 be 1a 10 00    	mov    %ax,0x101abe
  100306:	c1 e8 18             	shr    $0x18,%eax
  100309:	88 15 c0 1a 10 00    	mov    %dl,0x101ac0
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10030f:	ba 54 96 10 00       	mov    $0x109654,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100314:	a2 c3 1a 10 00       	mov    %al,0x101ac3
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100319:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10031b:	66 c7 05 bc 1a 10 00 	movw   $0x68,0x101abc
  100322:	68 00 
  100324:	c6 05 c2 1a 10 00 40 	movb   $0x40,0x101ac2
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  10032b:	c6 05 c1 1a 10 00 89 	movb   $0x89,0x101ac1

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  100332:	c7 05 f0 95 10 00 00 	movl   $0x80000,0x1095f0
  100339:	00 08 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  10033c:	66 c7 05 f4 95 10 00 	movw   $0x10,0x1095f4
  100343:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100345:	66 89 0c c5 54 96 10 	mov    %cx,0x109654(,%eax,8)
  10034c:	00 
  10034d:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100354:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  100359:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  10035e:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  100363:	40                   	inc    %eax
  100364:	3d 00 01 00 00       	cmp    $0x100,%eax
  100369:	75 da                	jne    100345 <segments_init+0x5d>
  10036b:	66 b8 30 00          	mov    $0x30,%ax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_GETPID; i < INT_SYS_GETPID + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  10036f:	ba 54 96 10 00       	mov    $0x109654,%edx
  100374:	8b 0c 85 a3 ff 0f 00 	mov    0xfffa3(,%eax,4),%ecx
  10037b:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100382:	66 89 0c c5 54 96 10 	mov    %cx,0x109654(,%eax,8)
  100389:	00 
  10038a:	c1 e9 10             	shr    $0x10,%ecx
  10038d:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  100392:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  100397:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_GETPID; i < INT_SYS_GETPID + 10; i++)
  10039c:	40                   	inc    %eax
  10039d:	83 f8 3a             	cmp    $0x3a,%eax
  1003a0:	75 d2                	jne    100374 <segments_init+0x8c>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_GETPID], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  1003a2:	b0 28                	mov    $0x28,%al
  1003a4:	0f 01 15 84 1a 10 00 	lgdtl  0x101a84
  1003ab:	0f 00 d8             	ltr    %ax
  1003ae:	0f 01 1d 8c 1a 10 00 	lidtl  0x101a8c
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  1003b5:	5b                   	pop    %ebx
  1003b6:	c3                   	ret    

001003b7 <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  1003b7:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  1003b8:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  1003ba:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  1003bb:	c7 05 00 00 06 00 00 	movl   $0xb8000,0x60000
  1003c2:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  1003c5:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%eax,%eax,1)
  1003cc:	00 20 07 
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  1003cf:	40                   	inc    %eax
  1003d0:	3d d0 07 00 00       	cmp    $0x7d0,%eax
  1003d5:	75 ee                	jne    1003c5 <console_clear+0xe>
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  1003d7:	be d4 03 00 00       	mov    $0x3d4,%esi
  1003dc:	b0 0e                	mov    $0xe,%al
  1003de:	89 f2                	mov    %esi,%edx
  1003e0:	ee                   	out    %al,(%dx)
  1003e1:	31 c9                	xor    %ecx,%ecx
  1003e3:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  1003e8:	88 c8                	mov    %cl,%al
  1003ea:	89 da                	mov    %ebx,%edx
  1003ec:	ee                   	out    %al,(%dx)
  1003ed:	b0 0f                	mov    $0xf,%al
  1003ef:	89 f2                	mov    %esi,%edx
  1003f1:	ee                   	out    %al,(%dx)
  1003f2:	88 c8                	mov    %cl,%al
  1003f4:	89 da                	mov    %ebx,%edx
  1003f6:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  1003f7:	5b                   	pop    %ebx
  1003f8:	5e                   	pop    %esi
  1003f9:	c3                   	ret    

001003fa <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  1003fa:	ba 64 00 00 00       	mov    $0x64,%edx
  1003ff:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  100400:	a8 01                	test   $0x1,%al
  100402:	74 45                	je     100449 <console_read_digit+0x4f>
  100404:	b2 60                	mov    $0x60,%dl
  100406:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  100407:	8d 50 fe             	lea    -0x2(%eax),%edx
  10040a:	80 fa 08             	cmp    $0x8,%dl
  10040d:	77 05                	ja     100414 <console_read_digit+0x1a>
		return data - 0x02 + 1;
  10040f:	0f b6 c0             	movzbl %al,%eax
  100412:	48                   	dec    %eax
  100413:	c3                   	ret    
	else if (data == 0x0B)
  100414:	3c 0b                	cmp    $0xb,%al
  100416:	74 35                	je     10044d <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  100418:	8d 50 b9             	lea    -0x47(%eax),%edx
  10041b:	80 fa 02             	cmp    $0x2,%dl
  10041e:	77 07                	ja     100427 <console_read_digit+0x2d>
		return data - 0x47 + 7;
  100420:	0f b6 c0             	movzbl %al,%eax
  100423:	83 e8 40             	sub    $0x40,%eax
  100426:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  100427:	8d 50 b5             	lea    -0x4b(%eax),%edx
  10042a:	80 fa 02             	cmp    $0x2,%dl
  10042d:	77 07                	ja     100436 <console_read_digit+0x3c>
		return data - 0x4B + 4;
  10042f:	0f b6 c0             	movzbl %al,%eax
  100432:	83 e8 47             	sub    $0x47,%eax
  100435:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  100436:	8d 50 b1             	lea    -0x4f(%eax),%edx
  100439:	80 fa 02             	cmp    $0x2,%dl
  10043c:	77 07                	ja     100445 <console_read_digit+0x4b>
		return data - 0x4F + 1;
  10043e:	0f b6 c0             	movzbl %al,%eax
  100441:	83 e8 4e             	sub    $0x4e,%eax
  100444:	c3                   	ret    
	else if (data == 0x53)
  100445:	3c 53                	cmp    $0x53,%al
  100447:	74 04                	je     10044d <console_read_digit+0x53>
  100449:	83 c8 ff             	or     $0xffffffff,%eax
  10044c:	c3                   	ret    
  10044d:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  10044f:	c3                   	ret    

00100450 <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  100450:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  100454:	a3 54 9e 10 00       	mov    %eax,0x109e54

	asm volatile("movl %0,%%esp\n\t"
  100459:	83 c0 04             	add    $0x4,%eax
  10045c:	89 c4                	mov    %eax,%esp
  10045e:	61                   	popa   
  10045f:	07                   	pop    %es
  100460:	1f                   	pop    %ds
  100461:	83 c4 08             	add    $0x8,%esp
  100464:	cf                   	iret   
  100465:	eb fe                	jmp    100465 <run+0x15>

00100467 <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  100467:	53                   	push   %ebx
  100468:	83 ec 0c             	sub    $0xc,%esp
  10046b:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  10046f:	6a 44                	push   $0x44
  100471:	6a 00                	push   $0x0
  100473:	8d 43 04             	lea    0x4(%ebx),%eax
  100476:	50                   	push   %eax
  100477:	e8 10 01 00 00       	call   10058c <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  10047c:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  100482:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  100488:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  10048e:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
}
  100494:	83 c4 18             	add    $0x18,%esp
  100497:	5b                   	pop    %ebx
  100498:	c3                   	ret    
  100499:	90                   	nop
  10049a:	90                   	nop
  10049b:	90                   	nop

0010049c <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  10049c:	55                   	push   %ebp
  10049d:	57                   	push   %edi
  10049e:	56                   	push   %esi
  10049f:	53                   	push   %ebx
  1004a0:	83 ec 1c             	sub    $0x1c,%esp
  1004a3:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  1004a7:	83 f8 01             	cmp    $0x1,%eax
  1004aa:	7f 04                	jg     1004b0 <program_loader+0x14>
  1004ac:	85 c0                	test   %eax,%eax
  1004ae:	79 02                	jns    1004b2 <program_loader+0x16>
  1004b0:	eb fe                	jmp    1004b0 <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  1004b2:	8b 34 c5 c4 1a 10 00 	mov    0x101ac4(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  1004b9:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  1004bf:	74 02                	je     1004c3 <program_loader+0x27>
  1004c1:	eb fe                	jmp    1004c1 <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  1004c3:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  1004c6:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  1004ca:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  1004cc:	c1 e5 05             	shl    $0x5,%ebp
  1004cf:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  1004d2:	eb 3f                	jmp    100513 <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  1004d4:	83 3b 01             	cmpl   $0x1,(%ebx)
  1004d7:	75 37                	jne    100510 <program_loader+0x74>
			copyseg((void *) ph->p_va,
  1004d9:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  1004dc:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  1004df:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  1004e2:	01 c7                	add    %eax,%edi
	memsz += va;
  1004e4:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  1004e6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  1004eb:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  1004ef:	52                   	push   %edx
  1004f0:	89 fa                	mov    %edi,%edx
  1004f2:	29 c2                	sub    %eax,%edx
  1004f4:	52                   	push   %edx
  1004f5:	8b 53 04             	mov    0x4(%ebx),%edx
  1004f8:	01 f2                	add    %esi,%edx
  1004fa:	52                   	push   %edx
  1004fb:	50                   	push   %eax
  1004fc:	e8 27 00 00 00       	call   100528 <memcpy>
  100501:	83 c4 10             	add    $0x10,%esp
  100504:	eb 04                	jmp    10050a <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  100506:	c6 07 00             	movb   $0x0,(%edi)
  100509:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  10050a:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  10050e:	72 f6                	jb     100506 <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  100510:	83 c3 20             	add    $0x20,%ebx
  100513:	39 eb                	cmp    %ebp,%ebx
  100515:	72 bd                	jb     1004d4 <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  100517:	8b 56 18             	mov    0x18(%esi),%edx
  10051a:	8b 44 24 34          	mov    0x34(%esp),%eax
  10051e:	89 10                	mov    %edx,(%eax)
}
  100520:	83 c4 1c             	add    $0x1c,%esp
  100523:	5b                   	pop    %ebx
  100524:	5e                   	pop    %esi
  100525:	5f                   	pop    %edi
  100526:	5d                   	pop    %ebp
  100527:	c3                   	ret    

00100528 <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  100528:	56                   	push   %esi
  100529:	31 d2                	xor    %edx,%edx
  10052b:	53                   	push   %ebx
  10052c:	8b 44 24 0c          	mov    0xc(%esp),%eax
  100530:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  100534:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100538:	eb 08                	jmp    100542 <memcpy+0x1a>
		*d++ = *s++;
  10053a:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  10053d:	4e                   	dec    %esi
  10053e:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  100541:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100542:	85 f6                	test   %esi,%esi
  100544:	75 f4                	jne    10053a <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  100546:	5b                   	pop    %ebx
  100547:	5e                   	pop    %esi
  100548:	c3                   	ret    

00100549 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  100549:	57                   	push   %edi
  10054a:	56                   	push   %esi
  10054b:	53                   	push   %ebx
  10054c:	8b 44 24 10          	mov    0x10(%esp),%eax
  100550:	8b 7c 24 14          	mov    0x14(%esp),%edi
  100554:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  100558:	39 c7                	cmp    %eax,%edi
  10055a:	73 26                	jae    100582 <memmove+0x39>
  10055c:	8d 34 17             	lea    (%edi,%edx,1),%esi
  10055f:	39 c6                	cmp    %eax,%esi
  100561:	76 1f                	jbe    100582 <memmove+0x39>
		s += n, d += n;
  100563:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  100566:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  100568:	eb 07                	jmp    100571 <memmove+0x28>
			*--d = *--s;
  10056a:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  10056d:	4a                   	dec    %edx
  10056e:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  100571:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  100572:	85 d2                	test   %edx,%edx
  100574:	75 f4                	jne    10056a <memmove+0x21>
  100576:	eb 10                	jmp    100588 <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  100578:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  10057b:	4a                   	dec    %edx
  10057c:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  10057f:	41                   	inc    %ecx
  100580:	eb 02                	jmp    100584 <memmove+0x3b>
  100582:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  100584:	85 d2                	test   %edx,%edx
  100586:	75 f0                	jne    100578 <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  100588:	5b                   	pop    %ebx
  100589:	5e                   	pop    %esi
  10058a:	5f                   	pop    %edi
  10058b:	c3                   	ret    

0010058c <memset>:

void *
memset(void *v, int c, size_t n)
{
  10058c:	53                   	push   %ebx
  10058d:	8b 44 24 08          	mov    0x8(%esp),%eax
  100591:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  100595:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  100599:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  10059b:	eb 04                	jmp    1005a1 <memset+0x15>
		*p++ = c;
  10059d:	88 1a                	mov    %bl,(%edx)
  10059f:	49                   	dec    %ecx
  1005a0:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  1005a1:	85 c9                	test   %ecx,%ecx
  1005a3:	75 f8                	jne    10059d <memset+0x11>
		*p++ = c;
	return v;
}
  1005a5:	5b                   	pop    %ebx
  1005a6:	c3                   	ret    

001005a7 <strlen>:

size_t
strlen(const char *s)
{
  1005a7:	8b 54 24 04          	mov    0x4(%esp),%edx
  1005ab:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1005ad:	eb 01                	jmp    1005b0 <strlen+0x9>
		++n;
  1005af:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1005b0:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  1005b4:	75 f9                	jne    1005af <strlen+0x8>
		++n;
	return n;
}
  1005b6:	c3                   	ret    

001005b7 <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  1005b7:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  1005bb:	31 c0                	xor    %eax,%eax
  1005bd:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1005c1:	eb 01                	jmp    1005c4 <strnlen+0xd>
		++n;
  1005c3:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1005c4:	39 d0                	cmp    %edx,%eax
  1005c6:	74 06                	je     1005ce <strnlen+0x17>
  1005c8:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  1005cc:	75 f5                	jne    1005c3 <strnlen+0xc>
		++n;
	return n;
}
  1005ce:	c3                   	ret    

001005cf <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  1005cf:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  1005d0:	3d a0 8f 0b 00       	cmp    $0xb8fa0,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  1005d5:	53                   	push   %ebx
  1005d6:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  1005d8:	b8 00 80 0b 00       	mov    $0xb8000,%eax
  1005dd:	0f 43 d8             	cmovae %eax,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  1005e0:	80 fa 0a             	cmp    $0xa,%dl
  1005e3:	75 2c                	jne    100611 <console_putc+0x42>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  1005e5:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  1005eb:	be 50 00 00 00       	mov    $0x50,%esi
  1005f0:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  1005f2:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  1005f5:	99                   	cltd   
  1005f6:	f7 fe                	idiv   %esi
  1005f8:	89 de                	mov    %ebx,%esi
  1005fa:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  1005fc:	eb 07                	jmp    100605 <console_putc+0x36>
			*cursor++ = ' ' | color;
  1005fe:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100601:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  100602:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100605:	83 f8 50             	cmp    $0x50,%eax
  100608:	75 f4                	jne    1005fe <console_putc+0x2f>
  10060a:	29 d0                	sub    %edx,%eax
  10060c:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  10060f:	eb 0b                	jmp    10061c <console_putc+0x4d>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  100611:	0f b6 d2             	movzbl %dl,%edx
  100614:	09 ca                	or     %ecx,%edx
  100616:	66 89 13             	mov    %dx,(%ebx)
  100619:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  10061c:	5b                   	pop    %ebx
  10061d:	5e                   	pop    %esi
  10061e:	c3                   	ret    

0010061f <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  10061f:	56                   	push   %esi
  100620:	53                   	push   %ebx
  100621:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  100625:	8d 58 ff             	lea    -0x1(%eax),%ebx
  100628:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  10062c:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  100631:	75 04                	jne    100637 <fill_numbuf+0x18>
  100633:	85 d2                	test   %edx,%edx
  100635:	74 10                	je     100647 <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  100637:	89 d0                	mov    %edx,%eax
  100639:	31 d2                	xor    %edx,%edx
  10063b:	f7 f1                	div    %ecx
  10063d:	4b                   	dec    %ebx
  10063e:	8a 14 16             	mov    (%esi,%edx,1),%dl
  100641:	88 13                	mov    %dl,(%ebx)
			val /= base;
  100643:	89 c2                	mov    %eax,%edx
  100645:	eb ec                	jmp    100633 <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  100647:	89 d8                	mov    %ebx,%eax
  100649:	5b                   	pop    %ebx
  10064a:	5e                   	pop    %esi
  10064b:	c3                   	ret    

0010064c <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  10064c:	55                   	push   %ebp
  10064d:	57                   	push   %edi
  10064e:	56                   	push   %esi
  10064f:	53                   	push   %ebx
  100650:	83 ec 38             	sub    $0x38,%esp
  100653:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  100657:	8b 7c 24 54          	mov    0x54(%esp),%edi
  10065b:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  10065f:	e9 62 03 00 00       	jmp    1009c6 <console_vprintf+0x37a>
		if (*format != '%') {
  100664:	80 fa 25             	cmp    $0x25,%dl
  100667:	74 13                	je     10067c <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  100669:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  10066d:	0f b6 d2             	movzbl %dl,%edx
  100670:	89 f0                	mov    %esi,%eax
  100672:	e8 58 ff ff ff       	call   1005cf <console_putc>
  100677:	e9 47 03 00 00       	jmp    1009c3 <console_vprintf+0x377>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  10067c:	47                   	inc    %edi
  10067d:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  100684:	00 
  100685:	eb 12                	jmp    100699 <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  100687:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  100688:	8a 11                	mov    (%ecx),%dl
  10068a:	84 d2                	test   %dl,%dl
  10068c:	74 1a                	je     1006a8 <console_vprintf+0x5c>
  10068e:	89 e8                	mov    %ebp,%eax
  100690:	38 c2                	cmp    %al,%dl
  100692:	75 f3                	jne    100687 <console_vprintf+0x3b>
  100694:	e9 41 03 00 00       	jmp    1009da <console_vprintf+0x38e>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100699:	8a 17                	mov    (%edi),%dl
  10069b:	84 d2                	test   %dl,%dl
  10069d:	74 0b                	je     1006aa <console_vprintf+0x5e>
  10069f:	b9 54 0a 10 00       	mov    $0x100a54,%ecx
  1006a4:	89 d5                	mov    %edx,%ebp
  1006a6:	eb e0                	jmp    100688 <console_vprintf+0x3c>
  1006a8:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  1006aa:	8d 42 cf             	lea    -0x31(%edx),%eax
  1006ad:	3c 08                	cmp    $0x8,%al
  1006af:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  1006b6:	00 
  1006b7:	76 13                	jbe    1006cc <console_vprintf+0x80>
  1006b9:	eb 1d                	jmp    1006d8 <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  1006bb:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  1006c0:	0f be c0             	movsbl %al,%eax
  1006c3:	47                   	inc    %edi
  1006c4:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  1006c8:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  1006cc:	8a 07                	mov    (%edi),%al
  1006ce:	8d 50 d0             	lea    -0x30(%eax),%edx
  1006d1:	80 fa 09             	cmp    $0x9,%dl
  1006d4:	76 e5                	jbe    1006bb <console_vprintf+0x6f>
  1006d6:	eb 18                	jmp    1006f0 <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  1006d8:	80 fa 2a             	cmp    $0x2a,%dl
  1006db:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  1006e2:	ff 
  1006e3:	75 0b                	jne    1006f0 <console_vprintf+0xa4>
			width = va_arg(val, int);
  1006e5:	83 c3 04             	add    $0x4,%ebx
			++format;
  1006e8:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  1006e9:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1006ec:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  1006f0:	83 cd ff             	or     $0xffffffff,%ebp
  1006f3:	80 3f 2e             	cmpb   $0x2e,(%edi)
  1006f6:	75 37                	jne    10072f <console_vprintf+0xe3>
			++format;
  1006f8:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  1006f9:	31 ed                	xor    %ebp,%ebp
  1006fb:	8a 07                	mov    (%edi),%al
  1006fd:	8d 50 d0             	lea    -0x30(%eax),%edx
  100700:	80 fa 09             	cmp    $0x9,%dl
  100703:	76 0d                	jbe    100712 <console_vprintf+0xc6>
  100705:	eb 17                	jmp    10071e <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  100707:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  10070a:	0f be c0             	movsbl %al,%eax
  10070d:	47                   	inc    %edi
  10070e:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  100712:	8a 07                	mov    (%edi),%al
  100714:	8d 50 d0             	lea    -0x30(%eax),%edx
  100717:	80 fa 09             	cmp    $0x9,%dl
  10071a:	76 eb                	jbe    100707 <console_vprintf+0xbb>
  10071c:	eb 11                	jmp    10072f <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  10071e:	3c 2a                	cmp    $0x2a,%al
  100720:	75 0b                	jne    10072d <console_vprintf+0xe1>
				precision = va_arg(val, int);
  100722:	83 c3 04             	add    $0x4,%ebx
				++format;
  100725:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  100726:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  100729:	85 ed                	test   %ebp,%ebp
  10072b:	79 02                	jns    10072f <console_vprintf+0xe3>
  10072d:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  10072f:	8a 07                	mov    (%edi),%al
  100731:	3c 64                	cmp    $0x64,%al
  100733:	74 34                	je     100769 <console_vprintf+0x11d>
  100735:	7f 1d                	jg     100754 <console_vprintf+0x108>
  100737:	3c 58                	cmp    $0x58,%al
  100739:	0f 84 a2 00 00 00    	je     1007e1 <console_vprintf+0x195>
  10073f:	3c 63                	cmp    $0x63,%al
  100741:	0f 84 bf 00 00 00    	je     100806 <console_vprintf+0x1ba>
  100747:	3c 43                	cmp    $0x43,%al
  100749:	0f 85 d0 00 00 00    	jne    10081f <console_vprintf+0x1d3>
  10074f:	e9 a3 00 00 00       	jmp    1007f7 <console_vprintf+0x1ab>
  100754:	3c 75                	cmp    $0x75,%al
  100756:	74 4d                	je     1007a5 <console_vprintf+0x159>
  100758:	3c 78                	cmp    $0x78,%al
  10075a:	74 5c                	je     1007b8 <console_vprintf+0x16c>
  10075c:	3c 73                	cmp    $0x73,%al
  10075e:	0f 85 bb 00 00 00    	jne    10081f <console_vprintf+0x1d3>
  100764:	e9 86 00 00 00       	jmp    1007ef <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  100769:	83 c3 04             	add    $0x4,%ebx
  10076c:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  10076f:	89 d1                	mov    %edx,%ecx
  100771:	c1 f9 1f             	sar    $0x1f,%ecx
  100774:	89 0c 24             	mov    %ecx,(%esp)
  100777:	31 ca                	xor    %ecx,%edx
  100779:	55                   	push   %ebp
  10077a:	29 ca                	sub    %ecx,%edx
  10077c:	68 5c 0a 10 00       	push   $0x100a5c
  100781:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100786:	8d 44 24 40          	lea    0x40(%esp),%eax
  10078a:	e8 90 fe ff ff       	call   10061f <fill_numbuf>
  10078f:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  100793:	58                   	pop    %eax
  100794:	5a                   	pop    %edx
  100795:	ba 01 00 00 00       	mov    $0x1,%edx
  10079a:	8b 04 24             	mov    (%esp),%eax
  10079d:	83 e0 01             	and    $0x1,%eax
  1007a0:	e9 a6 00 00 00       	jmp    10084b <console_vprintf+0x1ff>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  1007a5:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  1007a8:	b9 0a 00 00 00       	mov    $0xa,%ecx
  1007ad:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1007b0:	55                   	push   %ebp
  1007b1:	68 5c 0a 10 00       	push   $0x100a5c
  1007b6:	eb 11                	jmp    1007c9 <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  1007b8:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  1007bb:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1007be:	55                   	push   %ebp
  1007bf:	68 70 0a 10 00       	push   $0x100a70
  1007c4:	b9 10 00 00 00       	mov    $0x10,%ecx
  1007c9:	8d 44 24 40          	lea    0x40(%esp),%eax
  1007cd:	e8 4d fe ff ff       	call   10061f <fill_numbuf>
  1007d2:	ba 01 00 00 00       	mov    $0x1,%edx
  1007d7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1007db:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  1007dd:	59                   	pop    %ecx
  1007de:	59                   	pop    %ecx
  1007df:	eb 6a                	jmp    10084b <console_vprintf+0x1ff>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  1007e1:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  1007e4:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1007e7:	55                   	push   %ebp
  1007e8:	68 5c 0a 10 00       	push   $0x100a5c
  1007ed:	eb d5                	jmp    1007c4 <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  1007ef:	83 c3 04             	add    $0x4,%ebx
  1007f2:	8b 43 fc             	mov    -0x4(%ebx),%eax
  1007f5:	eb 41                	jmp    100838 <console_vprintf+0x1ec>
			break;
		case 'C':
			color = va_arg(val, int);
  1007f7:	83 c3 04             	add    $0x4,%ebx
  1007fa:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1007fd:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  100801:	e9 bf 01 00 00       	jmp    1009c5 <console_vprintf+0x379>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100806:	83 c3 04             	add    $0x4,%ebx
  100809:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  10080c:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  100810:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  100815:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100819:	88 44 24 24          	mov    %al,0x24(%esp)
  10081d:	eb 28                	jmp    100847 <console_vprintf+0x1fb>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  10081f:	84 c0                	test   %al,%al
  100821:	b2 25                	mov    $0x25,%dl
  100823:	0f 44 c2             	cmove  %edx,%eax
  100826:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  10082a:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  10082f:	80 3f 00             	cmpb   $0x0,(%edi)
  100832:	74 0a                	je     10083e <console_vprintf+0x1f2>
  100834:	8d 44 24 24          	lea    0x24(%esp),%eax
  100838:	89 44 24 04          	mov    %eax,0x4(%esp)
  10083c:	eb 09                	jmp    100847 <console_vprintf+0x1fb>
				format--;
  10083e:	8d 54 24 24          	lea    0x24(%esp),%edx
  100842:	4f                   	dec    %edi
  100843:	89 54 24 04          	mov    %edx,0x4(%esp)
  100847:	31 d2                	xor    %edx,%edx
  100849:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  10084b:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  10084d:	83 fd ff             	cmp    $0xffffffff,%ebp
  100850:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100857:	74 1f                	je     100878 <console_vprintf+0x22c>
  100859:	89 04 24             	mov    %eax,(%esp)
  10085c:	eb 01                	jmp    10085f <console_vprintf+0x213>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  10085e:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  10085f:	39 e9                	cmp    %ebp,%ecx
  100861:	74 0a                	je     10086d <console_vprintf+0x221>
  100863:	8b 44 24 04          	mov    0x4(%esp),%eax
  100867:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  10086b:	75 f1                	jne    10085e <console_vprintf+0x212>
  10086d:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100870:	89 0c 24             	mov    %ecx,(%esp)
  100873:	eb 1f                	jmp    100894 <console_vprintf+0x248>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  100875:	42                   	inc    %edx
  100876:	eb 09                	jmp    100881 <console_vprintf+0x235>
  100878:	89 d1                	mov    %edx,%ecx
  10087a:	8b 14 24             	mov    (%esp),%edx
  10087d:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100881:	8b 44 24 04          	mov    0x4(%esp),%eax
  100885:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  100889:	75 ea                	jne    100875 <console_vprintf+0x229>
  10088b:	8b 44 24 08          	mov    0x8(%esp),%eax
  10088f:	89 14 24             	mov    %edx,(%esp)
  100892:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  100894:	85 c0                	test   %eax,%eax
  100896:	74 0c                	je     1008a4 <console_vprintf+0x258>
  100898:	84 d2                	test   %dl,%dl
  10089a:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  1008a1:	00 
  1008a2:	75 24                	jne    1008c8 <console_vprintf+0x27c>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  1008a4:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  1008a9:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  1008b0:	00 
  1008b1:	75 15                	jne    1008c8 <console_vprintf+0x27c>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  1008b3:	8b 44 24 14          	mov    0x14(%esp),%eax
  1008b7:	83 e0 08             	and    $0x8,%eax
  1008ba:	83 f8 01             	cmp    $0x1,%eax
  1008bd:	19 c9                	sbb    %ecx,%ecx
  1008bf:	f7 d1                	not    %ecx
  1008c1:	83 e1 20             	and    $0x20,%ecx
  1008c4:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  1008c8:	3b 2c 24             	cmp    (%esp),%ebp
  1008cb:	7e 0d                	jle    1008da <console_vprintf+0x28e>
  1008cd:	84 d2                	test   %dl,%dl
  1008cf:	74 41                	je     100912 <console_vprintf+0x2c6>
			zeros = precision - len;
  1008d1:	2b 2c 24             	sub    (%esp),%ebp
  1008d4:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  1008d8:	eb 40                	jmp    10091a <console_vprintf+0x2ce>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1008da:	84 d2                	test   %dl,%dl
  1008dc:	74 34                	je     100912 <console_vprintf+0x2c6>
  1008de:	8b 44 24 14          	mov    0x14(%esp),%eax
  1008e2:	83 e0 06             	and    $0x6,%eax
  1008e5:	83 f8 02             	cmp    $0x2,%eax
  1008e8:	75 28                	jne    100912 <console_vprintf+0x2c6>
  1008ea:	45                   	inc    %ebp
  1008eb:	75 25                	jne    100912 <console_vprintf+0x2c6>
			 && numeric && precision < 0
			 && len + !!negative < width)
  1008ed:	31 c0                	xor    %eax,%eax
  1008ef:	8b 14 24             	mov    (%esp),%edx
  1008f2:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  1008f7:	0f 95 c0             	setne  %al
  1008fa:	8d 14 10             	lea    (%eax,%edx,1),%edx
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1008fd:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  100901:	7d 0f                	jge    100912 <console_vprintf+0x2c6>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  100903:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100907:	2b 14 24             	sub    (%esp),%edx
  10090a:	29 c2                	sub    %eax,%edx
  10090c:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100910:	eb 08                	jmp    10091a <console_vprintf+0x2ce>
  100912:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  100919:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  10091a:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  10091e:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100920:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100924:	2b 2c 24             	sub    (%esp),%ebp
  100927:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  10092c:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  10092f:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100932:	29 c5                	sub    %eax,%ebp
  100934:	89 f0                	mov    %esi,%eax
  100936:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  10093a:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  10093e:	eb 0f                	jmp    10094f <console_vprintf+0x303>
			cursor = console_putc(cursor, ' ', color);
  100940:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100944:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100949:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  10094a:	e8 80 fc ff ff       	call   1005cf <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  10094f:	85 ed                	test   %ebp,%ebp
  100951:	7e 07                	jle    10095a <console_vprintf+0x30e>
  100953:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  100958:	74 e6                	je     100940 <console_vprintf+0x2f4>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  10095a:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  10095f:	89 c6                	mov    %eax,%esi
  100961:	74 23                	je     100986 <console_vprintf+0x33a>
			cursor = console_putc(cursor, negative, color);
  100963:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  100968:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  10096c:	e8 5e fc ff ff       	call   1005cf <console_putc>
  100971:	89 c6                	mov    %eax,%esi
  100973:	eb 11                	jmp    100986 <console_vprintf+0x33a>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  100975:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100979:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  10097e:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  10097f:	e8 4b fc ff ff       	call   1005cf <console_putc>
  100984:	eb 06                	jmp    10098c <console_vprintf+0x340>
  100986:	89 f0                	mov    %esi,%eax
  100988:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  10098c:	85 f6                	test   %esi,%esi
  10098e:	7f e5                	jg     100975 <console_vprintf+0x329>
  100990:	8b 34 24             	mov    (%esp),%esi
  100993:	eb 15                	jmp    1009aa <console_vprintf+0x35e>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  100995:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100999:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  10099a:	0f b6 11             	movzbl (%ecx),%edx
  10099d:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1009a1:	e8 29 fc ff ff       	call   1005cf <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  1009a6:	ff 44 24 04          	incl   0x4(%esp)
  1009aa:	85 f6                	test   %esi,%esi
  1009ac:	7f e7                	jg     100995 <console_vprintf+0x349>
  1009ae:	eb 0f                	jmp    1009bf <console_vprintf+0x373>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  1009b0:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1009b4:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  1009b9:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  1009ba:	e8 10 fc ff ff       	call   1005cf <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  1009bf:	85 ed                	test   %ebp,%ebp
  1009c1:	7f ed                	jg     1009b0 <console_vprintf+0x364>
  1009c3:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  1009c5:	47                   	inc    %edi
  1009c6:	8a 17                	mov    (%edi),%dl
  1009c8:	84 d2                	test   %dl,%dl
  1009ca:	0f 85 94 fc ff ff    	jne    100664 <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  1009d0:	83 c4 38             	add    $0x38,%esp
  1009d3:	89 f0                	mov    %esi,%eax
  1009d5:	5b                   	pop    %ebx
  1009d6:	5e                   	pop    %esi
  1009d7:	5f                   	pop    %edi
  1009d8:	5d                   	pop    %ebp
  1009d9:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  1009da:	81 e9 54 0a 10 00    	sub    $0x100a54,%ecx
  1009e0:	b8 01 00 00 00       	mov    $0x1,%eax
  1009e5:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1009e7:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  1009e8:	09 44 24 14          	or     %eax,0x14(%esp)
  1009ec:	e9 a8 fc ff ff       	jmp    100699 <console_vprintf+0x4d>

001009f1 <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  1009f1:	8d 44 24 10          	lea    0x10(%esp),%eax
  1009f5:	50                   	push   %eax
  1009f6:	ff 74 24 10          	pushl  0x10(%esp)
  1009fa:	ff 74 24 10          	pushl  0x10(%esp)
  1009fe:	ff 74 24 10          	pushl  0x10(%esp)
  100a02:	e8 45 fc ff ff       	call   10064c <console_vprintf>
  100a07:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100a0a:	c3                   	ret    
