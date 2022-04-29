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
    @@@@
    mov     r0, #0
    mov     r1, #-1
    mov     r2, #0
    mov     r3, #1
    mov     r4, #0
    msr     apsr, r0

    @ Copy value from Rx to R4
    mov     r4, r1
    mov     r4, r2
    mov     r4, r3

    @@@@
    mov     r0, #0
    mov     r1, #-1
    mov     r2, #0
    mov     r3, #1
    mov     r4, #0
    msr     apsr, r0

    @ Copy value from Rx to R4 with APSR (flags) update
    movs    r4, r1
    movs    r4, r2
    movs    r4, r3

    @@@@
    bx      lr

