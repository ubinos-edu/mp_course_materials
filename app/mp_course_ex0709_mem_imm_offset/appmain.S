/*
 * Copyright (c) 2022 Sung Ho Park and CSOS
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <ubinos_config.h>

    .syntax unified
    .arch   armv7e-m

    .data

    .align 2
byte_array:                     @ VSCode watch expression: ((char[8]) byte_array),h
    .byte   1, 2, 3, 4, -1, -2, -3, -4
byte_array_2:                   @ VSCode watch expression: ((char[8]) byte_array_2),h
    .byte   0, 0, 0, 0,  0,  0,  0,  0

    .align 2
int_array:                      @ VSCode watch expression: ((int[8]) int_array),h
    .word   0, 1, 2, 3, 4, 5, 6, 7
int_array_2:                    @ VSCode watch expression: ((int[8]) int_array_2),h
    .word   0, 0, 0, 0, 0, 0, 0, 0


    .text
    .thumb

    .thumb_func
    .align  1
    .globl  appmain
    .type   appmain, %function
appmain:
    @@@@@@@@
    @ Immediate Offset (pre-index)
    mov     r0, #0
    mov     r1, #0
    mov     r2, #0
    mov     r3, #0
    mov     r4, #0
    mov     r5, #0
    mov     r6, #0
    mov     r7, #0

    @@@@
    ldr     r7, =byte_array

    ldrb    r0, [r7, #0x3]      @ Read a byte value from memory[r7 + 0x3], and store the value in r0.

    @@@@
    ldr     r7, =byte_array_2

    strb    r0, [r7, #0x3]      @ Write a byte value in r0 to memory[r7 + 0x3].

    @@@@
    ldr     r7, =byte_array

    ldrb    r0, [r7, #0x5] 
    ldrsb   r1, [r7, #0x5] 

    @@@@@@@@
    @ Immediate Offset and Write Back
    mov     r0, #0
    mov     r1, #0
    mov     r2, #0
    mov     r3, #0
    mov     r4, #0
    mov     r5, #0
    mov     r6, #0
    mov     r7, #0

    @@@@
    ldr     r7, =int_array

    ldr     r0, [r7, #0x8]!     @ After the access to memory[r7 + 0x8], r7 is updated to r7 + 0x8
    ldr     r1, [r7, #0x8]!     @ After the access to memory[r7 + 0x8], r7 is updated to r7 + 0x8

    @@@@
    ldr     r7, =int_array_2

    str     r0, [r7, #0x8]!     @ After the access to memory[r7 + 0x8], r7 is updated to r7 + 0x8
    str     r1, [r7, #0x8]!     @ After the access to memory[r7 + 0x8], r7 is updated to r7 + 0x8

    @@@@@@@@
    @ PC Related Addressing (Literal)
    mov     r0, #0
    mov     r1, #0
    mov     r2, #0
    mov     r3, #0
    mov     r4, #0
    mov     r5, #0
    mov     r6, #0
    mov     r7, #0

    @@@@
    ldr     r0, [pc, #12]
    ldr     r1, [pc, #12]
    ldr.w   r2, [pc, #12]
    ldr.w   r3, [pc, #12]
    ldr     r4, [pc, #12]

    @@@@@@@@
    bx      lr          @ 16 bit 

    .hword  0x0001
    .hword  0x0002
    .hword  0x0003
    .hword  0x0004
    .hword  0x0005
    .hword  0x0006
    .hword  0x0007
    .hword  0x0008
    .hword  0x0009
    .hword  0x000a
    .hword  0x000b
    .hword  0x000c
    .hword  0x000d
    .hword  0x000e
    .hword  0x000f

@ 8000282:  4803    ldr     r0, [pc, #12]   ; (8000290 <appmain+0x4c>)  (pc + 2) + 12
@ 8000284:  4903    ldr     r1, [pc, #12]   ; (8000294 <appmain+0x50>)  (pc + 4) + 12
@ 8000286:  200c    ldr.w   r2, [pc, #12]   ; (8000294 <appmain+0x50>)  (pc + 2) + 12
@ 8000288:  f8df
@ 800028a:	300c    ldr.w   r3, [pc, #12]   ; (8000298 <appmain+0x54>)  (pc + 2) + 12
@ 800028c:  f8df 
@ 800028e:  4903    ldr     r4, [pc, #12]   ; (800029c <appmain+0x58>)  (pc + 2) + 12
@ 8000290:  4770    bx      lr
@ 8000292:  0001    .short	0x0001
@ 8000294:  0002    .word	0x00030002
@ 8000296:  0003
@ 8000298:  0004    .word	0x00050004
@ 800029a:  0005
@ 800029c:  0006    .word	0x00070006
@ 800029e:  0007
@ 80002a0:  0008    .word	0x00090008
@ 8000292:  0009
