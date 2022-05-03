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
    @@@@@@@@
    @ Multiple Load/Store
    mov     r0, #0
    mov     r1, #0
    mov     r2, #0
    mov     r3, #0
    mov     r4, #0

    @@@@
    ldr     r4, =int_array      @ Set R4 to int_array (address)
    ldmia   r4, {r0-r3}         @ Read 4 words and store them to R0 - R3

    @@@@
    ldr     r4, =int_array_2    @ Set R4 to int_array_2 (address)
    stmia   r4, {r0-r3}         @ Write 4 words stored in R0 - R3 to memory location specified by R4

    @@@@@@@@
    @ Multiple Load/Store with Write Back
    mov     r0, #0
    mov     r1, #0
    mov     r2, #0
    mov     r3, #0
    mov     r4, #0
    ldr     r4, =int_array_2
    stmia   r4, {r0-r3}
    
    @@@@
    ldr     r4, =int_array      @ Set R4 to int_array (address)
    ldmia   r4!, {r0-r3}        @ R4 change to int_array (address) + 0x10 after the load

    @@@@
    ldr     r4, =int_array_2    @ Set R4 to int_array_2 (address)
    stmia   r4!, {r0-r3}        @ R4 change to int_array_2 (address) + 0x10 after the store

    @@@@@@@@
    @ Multiple Load/Store Decrement Address before
    mov     r0, #0
    mov     r1, #0
    mov     r2, #0
    mov     r3, #0
    mov     r4, #0

    @@@@
    ldr     r4, =int_array      @ Set R4 to int_array (address)
    add     r4, r4, #16
    ldmdb   r4, {r0-r3}         @ Read 4 words and store them to R0 - R3

    @@@@@@@@
    bx     lr

