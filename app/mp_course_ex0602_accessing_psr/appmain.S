/*
 * Copyright (c) 2022 Sung Ho Park and CSOS
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <ubinos_config.h>

    .syntax unified
    .arch   armv7-m

    .text
    .thumb

    .thumb_func
    .align  1
    .globl  appmain
    .type   appmain, %function
appmain:
    movs    r0, #0
    mrs     r0, psr
    movs    r0, #0
    mrs     r0, apsr
    movs    r0, #0
    mrs     r0, ipsr

    movs    r0, #0
    msr     apsr, r0

    movs    r1, #1  
    movs    r2, #2
    movs    r3, #2
    subs    r0, r1, r2  @ 1 - 2 => Negative (N=1, Z=0), carry (not borrow or not underflow) (C=0)
    subs    r0, r2, r1  @ 2 - 1 => Positive (N=0, Z=0), carry (not borrow or not underflow) (C=1)
    subs    r0, r2, r3  @ 2 - 2 => Zero     (N=0, Z=1), carry (not borrow or not underflow) (C=1)

    bx      lr

