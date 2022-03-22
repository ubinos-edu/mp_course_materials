/*
 * Copyright (c) 2022 Sung Ho Park and CSOS
 *
 * SPDX-License-Identifier: Apache-2.0
 */

/* For Cortex-M3 devices */

#include <ubinos_config.h>

    .syntax unified
    .arch   armv7-m


    .text
    .thumb


    .thumb_func
    .align  1
    .globl  asm_test_01
    .type   asm_test_01, %function
asm_test_01:
    push    {r7}
    add     r7, sp, #0

    mov     sp, r7
    pop     {r7}
    bx      lr


    .thumb_func
    .align  1
    .globl  asm_test_02
    .type   asm_test_02, %function
asm_test_02:
    push    {r7}
    mov     r7, sp

    mov     sp, r7
    pop     {r7}
    bx      lr


    .thumb_func
    .align  1
    .globl  asm_test_03
    .type   asm_test_03, %function
asm_test_03:
    push    {r7}
    mov     r7, sp

    mov     r0, #0
    sub     r0, #18
    mrs     r0, psr
    msr     psr, r0

    mov     r0, #0
    sub     r0, #18
    mrs     r0, apsr
    msr     apsr, r0

    mov     r0, #0
    sub     r0, #18
    mrs     r0, ipsr

    mov     sp, r7
    pop     {r7}
    bx      lr


    .thumb_func
    .align  1
    .globl  asm_test_04
    .type   asm_test_04, %function
asm_test_04:
    mrs     r0, basepri
    msr     basepri, r0

    mrs     r0, primask
    msr     primask, r0

    mrs     r0, faultmask
    msr     faultmask, r0

    mrs     r0, control
    msr     control, r0

    bx      lr


    .thumb_func
    .align  1
    .globl  asm_test_05
    .type   asm_test_05, %function
asm_test_05:
    cpsid   i
    mrs     r0, primask
    cpsie   i
    mrs     r0, primask

    cpsid   f
    mrs     r0, faultmask
    cpsie   f
    mrs     r0, faultmask

    bx      lr


    .thumb_func
    .align  1
    .globl  asm_test_06
    .type   asm_test_06, %function
asm_test_06:
    mov     r1, #1
    mov     r2, #2
    mov     r3, #3

    push    {r1}
    push    {r2}
    push    {r3}

    mov     r1, #0
    mov     r2, #0
    mov     r3, #0

    pop     {r3}
    pop     {r2}
    pop     {r1}

    bx      lr


    .thumb_func
    .align  1
    .globl  asm_test_07
    .type   asm_test_07, %function
asm_test_07:
    mov     r1, #1
    mov     r2, #2
    mov     r3, #3

    push    {r1-r3}

    mov     r1, #0
    mov     r2, #0
    mov     r3, #0

    pop     {r1-r3}

    bx      lr


    .thumb_func
    .align  1
    .globl  asm_test_08
    .type   asm_test_08, %function
asm_test_08:
    mov     r1, #1
    mov     r2, #2
    mov     r3, #3

    push    {r1-r3, lr}

    mov     r1, #0
    mov     r2, #0
    mov     r3, #0

    pop     {r1-r3, pc}


    .thumb_func
    .align  1
    .globl  asm_test_09
    .type   asm_test_09, %function
asm_test_09:
    mrs     r0, msp
    msr     msp, r0

    mrs     r0, psp
    msr     psp, r0

    mov     r0, #8
    msr     psp, r0
    mov     r0, #0
    mrs     r0, psp

    bx      lr

