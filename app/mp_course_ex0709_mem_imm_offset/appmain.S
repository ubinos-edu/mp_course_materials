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
byte_array:
    .byte   1, 2, 3, 4, -1, -2

    .align 2
int_array:
    .word   0, 1, 2, 3, 4, 5, 6, 7


    .text
    .thumb

    .thumb_func
    .align  1
    .globl  appmain
    .type   appmain, %function
appmain:
    @@@@
    ldr     r0, =byte_array
    mov     r1, #0
    mov     r2, #0
    mov     r3, #0

    @@@@
    ldrb    r1, [r0, #0x3] @ Read a byte value from address r0 + 0x3, and store the read data in R0.

    @@@@
    ldrb    r2, [r0, #0x5] 
    ldrsb   r3, [r0, #0x5] 

    @@@@
    ldr     r0, =int_array
    mov     r1, #0
    mov     r2, #0
    mov     r3, #0

    @@@@
    ldr    r1, [r0, #0x8]! @ After the access to memory[01+0x8], r0 is updated to R0+0x8
    ldr    r2, [r0]

    @@@@
    mov     r0, #0
    mov     r1, #0
    mov     r2, #0
    mov     r3, #0

    @@@@
    ldr     r0, [pc, 4]

    @@@@
    bx      lr          @ 16 bit 

    .align 2
    .word  0x12345678
