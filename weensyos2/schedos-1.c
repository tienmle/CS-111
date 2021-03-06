#include "schedos-app.h"
#include "x86sync.h"

/*****************************************************************************
 * schedos-1
 *
 *   This tiny application prints red "1"s to the console.
 *   It yields the CPU to the kernel after each "1" using the sys_yield()
 *   system call.  This lets the kernel (schedos-kern.c) pick another
 *   application to run, if it wants.
 *
 *   The other schedos-* processes simply #include this file after defining
 *   PRINTCHAR appropriately.
 *
 *****************************************************************************/

#ifndef PRINTCHAR
#define PRINTCHAR	('1' | 0x0C00)
#endif

//Extra credit for exercise 8
#define __EXERCISE_8__


void
start(void)
{
	int i;
	for (i = 0; i < RUNCOUNT; i++) {
		// Write characters to the console, yielding after each one.
		#ifndef __EXERCISE_8__
		// Uses a system call to print characters
		sys_print(PRINTCHAR);
		#endif
		#ifdef __EXERCISE_8__
		//Use a lock to print a character, prevents race conditions
		while(atomic_swap(&spinlock,1) != 0)
			continue;
		*cursorpos++ = PRINTCHAR;
		atomic_swap(&spinlock,0);
		#endif

		sys_yield();
	}

	// Yield forever.
	while (1)
		sys_exit(0);
}
