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
    @ VSCode watch expression: ((int[8]) word_array),h
word_array:
    @ VSCode watch expression: ((int[8]) word_array_2),h
    .word   0x03020100, 0x13121110, 0x23222120, 0x33323130, 0x43424140, 0x53525150
word_array_2:
    .word          0x0,        0x0,        0x0,        0x0,        0x0,        0x0


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

    ldrb    r2, [r7, #0x6] 
    ldrsb   r3, [r7, #0x6] 

    @@@@
    ldr     r7, =word_array
    ldrd    r4,r5, [r7, #0x4] 
    ldrd    r4,r5, [r7, #0x4]!

    ldr     r7, =word_array_2
    strd    r4,r5, [r7, #0x4] 

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
    ldr     r7, =word_array_2
    strd    r4,r5, [r7, #0x4] 

    @@@@
    ldr     r7, =word_array

    ldr     r0, [r7, #0x4]!     @ After the access to memory[r7 + 0x4], r7 is updated to r7 + 0x4
    ldr     r1, [r7, #0x4]!     @ After the access to memory[r7 + 0x4], r7 is updated to r7 + 0x4

    @@@@
    ldr     r7, =word_array_2

    str     r0, [r7, #0x4]!     @ After the access to memory[r7 + 0x4], r7 is updated to r7 + 0x4
    str     r1, [r7, #0x4]!     @ After the access to memory[r7 + 0x4], r7 is updated to r7 + 0x4

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

    @ <080002da>  ldr   r0, [pc, #20] ; (80002f0 <appmain+0xac>) current address + 2 + 20
    @ <080002dc>  ldr   r1, [pc, #20] ; (80002f4 <appmain+0xb0>) current address + 4 + 20
    @ <080002de>  ldr.w r2, [pc, #20] ; (80002f4 <appmain+0xb0>) current address + 2 + 20
    @ <080002e2>  ldr.w r3, [pc, #20] ; (80002f8 <appmain+0xb4>) current address + 2 + 20
    @ <080002e6>  ldr   r4, [pc, #20] ; (80002fc <appmain+0xb8>) current address + 2 + 20
    @ <080002e8>  bx lr
    @ <080002ea>  .short 0x0001
    @ <080002ec>  .word 0x00030002
    @ <080002f0>  .word 0x00050004
    @ <080002f4>  .word 0x00070006
    @ <080002f8>  .word 0x00090008
    @ <080002fc>  .word 0x000b000a
    @ <08000300>  .word 0x000d000c
    @ <08000304>  .word 0x000f000e

    @ <080002da>  movs  r0, #0
    @ <080002dc>  ldr   r0, [pc, #20] ; (80002f4 <appmain+0xb0>) current address + 4 + 20
    @ <080002de>  ldr   r1, [pc, #20] ; (80002f4 <appmain+0xb0>) current address + 2 + 20
    @ <080002e0>  ldr.w r2, [pc, #20] ; (80002f8 <appmain+0xb4>) current address + 4 + 20
    @ <080002e4>  ldr.w r3, [pc, #20] ; (80002fc <appmain+0xb8>) current address + 4 + 20
    @ <080002e8>  ldr   r4, [pc, #20] ; (8000300 <appmain+0xbc>) current address + 4 + 20
    @ <080002ea>  bx lr
    @ <080002ec>  .word 0x00020001
    @ <080002f0>  .word 0x00040003
    @ <080002f4>  .word 0x00060005
    @ <080002f8>  .word 0x00080007
    @ <080002fc>  .word 0x000a0009
    @ <08000300>  .word 0x000c000b
    @ <08000304>  .word 0x000e000d
    @ <08000308>  .word 0x0000000f
