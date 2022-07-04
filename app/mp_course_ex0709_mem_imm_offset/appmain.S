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
    @ movs    r0, #0
    ldr     r0, [pc, #20]
    ldr     r1, [pc, #20]
    ldr.w   r2, [pc, #20]
    ldr.w   r3, [pc, #20]
    ldr     r4, [pc, #20]

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

@ <080002ca>  ldr   r0, [pc, #20] ; (80002e0 <appmain+0x9c>) pc + 2 + 20
@ <080002cc>  ldr   r1, [pc, #20] ; (80002e4 <appmain+0xa0>) pc + 4 + 20
@ <080002ce>  ldr.w r2, [pc, #20] ;  80002e4 <appmain+0xa0>  pc + 2 + 20
@ <080002d2>  ldr.w r3, [pc, #20] ;  80002e8 <appmain+0xa4>  pc + 2 + 20
@ <080002d6>  ldr   r4, [pc, #20] ; (80002ec <appmain+0xa8>) pc + 2 + 20
@ <080002d8>  bx lr
@ <080002da>  .short 0x0001
@ <080002dc>  .word 0x00030002
@ <080002e0>  .word 0x00050004
@ <080002e4>  .word 0x00070006
@ <080002e8>  .word 0x00090008
@ <080002ec>  .word 0x000b000a
@ <080002f0>  .word 0x000d000c
@ <080002f4>  .word 0x000f000e
@ <080002f8>  .word 0x20000200
@ <080002fc>  .word 0x20000208
@ <08000300>  .word 0x20000210
@ <08000304>  .word 0x20000230

@ <080002c8>  ldr   r0, [pc, #20] ; (80002e0 <appmain+0x9c>) pc + 4 + 20
@ <080002ca>  ldr   r1, [pc, #20] ; (80002e0 <appmain+0x9c>) pc + 2 + 20
@ <080002cc>  ldr.w r2, [pc, #20] ;  80002e4 <appmain+0xa0>  pc + 4 + 20
@ <080002d0>  ldr.w r3, [pc, #20] ;  80002e8 <appmain+0xa4>  pc + 4 + 20
@ <080002d4>  ldr   r4, [pc, #20] ; (80002ec <appmain+0xa8>) pc + 4 + 20
@ <080002d6>  bx lr
@ <080002d8>  .word 0x00020001
@ <080002dc>  .word 0x00040003
@ <080002e0>  .word 0x00060005
@ <080002e4>  .word 0x00080007
@ <080002e8>  .word 0x000a0009
@ <080002ec>  .word 0x000c000b
@ <080002f0>  .word 0x000e000d
@ <080002f4>  .word 0x0000000f
@ <080002f8>  .word 0x20000200
@ <080002fc>  .word 0x20000208
@ <08000300>  .word 0x20000210
@ <08000304>  .word 0x20000230


@ <080002ca>  ldr.w r0, [pc, #21] ;  80002e1 <appmain+0x9d>  pc + 2 + 21
@ <080002ce>  ldr.w r1, [pc, #21] ;  80002e5 <appmain+0xa1>  pc + 2 + 21
@ <080002d2>  ldr.w r2, [pc, #21] ;  80002e9 <appmain+0xa5>  pc + 2 + 21
@ <080002d6>  ldr.w r3, [pc, #21] ;  80002ed <appmain+0xa9>  pc + 2 + 21
@ <080002da>  ldr.w r4, [pc, #21] ;  80002f1 <appmain+0xad>  pc + 2 + 21
@ <080002de>  bx lr
@ <080002e0>  .word 0x00020001
@ <080002e4>  .word 0x00040003
@ <080002e8>  .word 0x00060005
@ <080002ec>  .word 0x00080007
@ <080002f0>  .word 0x000a0009
@ <080002f4>  .word 0x000c000b
@ <080002f8>  .word 0x000e000d
@ <080002fc>  .word 0x0000000f
@ <08000300>  .word 0x20000200
@ <08000304>  .word 0x20000208
@ <08000308>  .word 0x20000210
@ <0800030c>  .word 0x20000230

@ <080002c8>  ldr.w r0, [pc, #21] ;  80002e1 <appmain+0x9d>   pc + 4 + 21
@ <080002cc>  ldr.w r1, [pc, #21] ;  80002e5 <appmain+0xa1>   pc + 4 + 21
@ <080002d0>  ldr.w r2, [pc, #21] ;  80002e9 <appmain+0xa5>   pc + 4 + 21
@ <080002d4>  ldr.w r3, [pc, #21] ;  80002ed <appmain+0xa9>   pc + 4 + 21
@ <080002d8>  ldr.w r4, [pc, #21] ;  80002f1 <appmain+0xad>   pc + 4 + 21
@ <080002dc>  bx lr
@ <080002de>  .short 0x0001
@ <080002e0>  .word 0x00030002
@ <080002e4>  .word 0x00050004
@ <080002e8>  .word 0x00070006
@ <080002ec>  .word 0x00090008
@ <080002f0>  .word 0x000b000a
@ <080002f4>  .word 0x000d000c
@ <080002f8>  .word 0x000f000e
@ <080002fc>  .word 0x20000200
@ <08000300>  .word 0x20000208
@ <08000304>  .word 0x20000210
@ <08000308>  .word 0x20000230

@ <080002c8>  ldr.w r0, [pc, #22] ;  80002e2 <appmain+0x9e>  pc + 4 + 22
@ <080002cc>  ldr.w r1, [pc, #22] ;  80002e6 <appmain+0xa2>  pc + 4 + 22
@ <080002d0>  ldr.w r2, [pc, #22] ;  80002ea <appmain+0xa6>  pc + 4 + 22
@ <080002d4>  ldr.w r3, [pc, #22] ;  80002ee <appmain+0xaa>  pc + 4 + 22
@ <080002d8>  ldr.w r4, [pc, #22] ;  80002f2 <appmain+0xae>  pc + 4 + 22
@ <080002dc>  bx lr
@ <080002de>  .short 0x0001
@ <080002e0>  .word 0x00030002
@ <080002e4>  .word 0x00050004
@ <080002e8>  .word 0x00070006
@ <080002ec>  .word 0x00090008
@ <080002f0>  .word 0x000b000a
@ <080002f4>  .word 0x000d000c
@ <080002f8>  .word 0x000f000e
@ <080002fc>  .word 0x20000200
@ <08000300>  .word 0x20000208
@ <08000304>  .word 0x20000210
@ <08000308>  .word 0x20000230

