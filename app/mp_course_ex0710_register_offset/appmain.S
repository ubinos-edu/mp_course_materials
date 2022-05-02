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
    ldr    r0, =int_array
    mov    r1, #4
    mov    r2, #0
    mov    r3, #0
    mov    r4, #0

    @@@@
    ldr    r2, [r0, r1]
    ldr    r3, [r0, r1, lsl #1]

    @@@@
    mov    r2, #0
    mov    r3, #0

    @@@@
    ldr    r2, [r0], #4
    ldr    r3, [r0], #4
    ldr    r4, [r0], #4

    @@@@
    bx      lr          @ 16 bit 

