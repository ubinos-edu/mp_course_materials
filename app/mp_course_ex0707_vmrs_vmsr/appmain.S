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
    mov     r3, #0
    vmov.f32 s0, #1.00000000
    vmov.f32 s1, #2.25000000
    vcmp.f32 s0, s1

    @ Copy value in FPSCR to R0
    vmrs    r0, FPSCR

    @ Copy flags from FPSCR to the flags in APSR
    vmrs    APSR_nzcv, FPSCR

    @ Copy R3 to FPSCR, a floating point unit system register
    vmsr    FPSCR, r3

    @@@@
    bx      lr

