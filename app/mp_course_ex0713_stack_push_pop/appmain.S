/*
 * Copyright (c) 2022 Sung Ho Park and CSOS
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <ubinos_config.h>

    .syntax unified
    .arch   armv7e-m


    .text
    .thumb

    .thumb_func
    .align  1
    .globl  appmain
    .type   appmain, %function
appmain:
    @@@@@@@@
    mov     r0, #0
    mov     r1, #1
    mov     r2, #2
    mov     r3, #3
    mov     r4, #4
    mov     r5, #5
    mov     r6, #6
    mov     r7, #7
    mov     r8, #8

    @@@@
    push    {r1, r4-r7}     @ Decrese Before (Pre-indexing, High -> Low), Write Back 
    push    {r8}

    @@@@@@@@
    mov     r0, #0
    mov     r1, #0
    mov     r2, #0
    mov     r3, #0
    mov     r4, #0
    mov     r5, #0
    mov     r6, #0
    mov     r7, #0
    mov     r8, #0

    @@@@
    pop     {r8}            @ Increase After (Post-indexing, Low -> High), Write Back
    pop     {r0, r1}
    pop     {r2-r4}

    @@@@@@@@
    mov     r0, #0
    mov     r1, #1
    mov     r2, #2
    mov     r3, #3

    @@@@
    push    {r0-r3, lr}
    mov     r0, #1
    mov     r1, #0
    mov     r2, #0
    mov     r3, #0

    @@@@@@@@
    pop     {r0-r3, pc}

