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
    @ Register Offset (pre-index)
    mov     r0, #0
    mov     r1, #0
    mov     r2, #0
    mov     r3, #0
    mov     r4, #0
    mov     r5, #0
    mov     r6, #0
    mov     r7, #0

    @@@@
    mov     r6, #4
    ldr     r7, =int_array

    ldr     r0, [r7, r6]
    ldr     r1, [r7, r6, lsl #1]

    @@@@
    mov     r6, #4
    ldr     r7, =int_array_2

    str     r0, [r7, r6]
    str     r1, [r7, r6, lsl #1]

    @@@@@@@@
    @ Register Offset (post-indexing)
    mov     r0, #0
    mov     r1, #0
    mov     r2, #0
    mov     r3, #0
    mov     r4, #0
    mov     r5, #0
    mov     r6, #0
    ldr     r7, =int_array_2
    stmia   r7, {r0-r3}
    mov     r7, #0

    @@@@
    ldr     r7, =int_array

    ldr     r0, [r7], #4
    ldr     r1, [r7], #4
    ldr     r2, [r7], #4
    ldr     r3, [r7], #4

    ldrd    r2,r3, [r7], #4

    @@@@
    ldr     r7, =int_array_2

    str     r0, [r7], #4
    str     r1, [r7], #4
    str     r2, [r7], #4
    str     r3, [r7], #4
    
    strd    r2,r3, [r7], #4

    @@@@@@@@
    bx      lr
