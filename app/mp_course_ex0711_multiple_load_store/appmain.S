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
int_array:                      @ (int[8]) int_array
    .word   1, 2, 3, 4, 5, 6, 7, 8
int_array_2:                    @ (int[8]) int_array_2
    .word   0, 0, 0, 0, 0, 0, 0, 0


    .text
    .thumb

    .thumb_func
    .align  1
    .globl  appmain
    .type   appmain, %function
appmain:
    mov     r0, #0
    mov     r1, #0
    mov     r2, #0
    mov     r3, #0
    mov     r4, #0
    mov     r5, #0
    mov     r6, #0
    mov     r7, #0

    ldr     r5, =int_array      @ Set R5 to int_array (address)
    ldmia   r5, {r1-r4}         @ Read 4 words and store them to R1 - R4

    ldr     r6, =int_array_2    @ Set R6 to int_array_2 (address)
    stmia   r6!, {r1-r4}        @ R6 change to int_array_2 (address) + 0x10 after the store

    @@@@@@@@
    bx     lr

