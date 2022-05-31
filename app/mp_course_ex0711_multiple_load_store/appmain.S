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
    .word   1, 2, 3, 4, 5, 6, 7, 8
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
    @ Multiple Load/Store
    mov     r0, #0
    mov     r1, #0
    mov     r2, #0
    mov     r3, #0
    mov     r4, #0
    mov     r5, #0
    mov     r6, #0
    mov     r7, #0

    @@@@
    ldr     r7, =int_array      @ Set r7 to int_array (address)

    ldmia   r7, {r0-r3}         @ Read 4 words and store them to r0 - r3

    @@@@
    ldr     r7, =int_array_2    @ Set r7 to int_array_2 (address)
    
    stmia   r7, {r0-r3}         @ Write 4 words stored in r0 - r3 to memory location specified by r7

    @@@@@@@@
    @ Multiple Load/Store with Write Back
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
    ldr     r7, =int_array      @ Set r7 to int_array (address)

    ldmia   r7!, {r0-r3}        @ Change r7 to int_array (address) + 0x10 after the load

    @@@@
    ldr     r7, =int_array_2    @ Set r7 to int_array_2 (address)
    
    stmia   r7!, {r0-r3}        @ Change r7 to int_array_2 (address) + 0x10 after the store

    @@@@@@@@
    @ Multiple Load/Store Decrement Address before
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
    ldr     r7, =int_array      @ Set r7 to int_array (address)
    add     r7, r7, #16

    ldmdb   r7, {r0-r3}         @ Read 4 words and store them to r0 - r3

    @@@@
    ldr     r7, =int_array_2    @ Set r7 to int_array_2 (address)
    add     r7, r7, #16

    stmdb   r7, {r0-r3}         @ Write 4 words stored in r0 - r3 to memory location specified by r7

    @@@@@@@@
    bx     lr
