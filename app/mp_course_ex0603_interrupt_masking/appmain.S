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
    @@@@
    mov     r0, #0
    mrs     r0, primask
    msr     primask, r0

    mov     r0, #0
    mrs     r0, faultmask
    msr     faultmask, r0

    mov     r0, #0
    mrs     r0, basepri
    msr     basepri, r0

    cpsid   i
    mov     r0, #0
    mrs     r0, primask
    cpsie   i
    mov     r0, #0
    mrs     r0, primask

    cpsid   f
    mov     r0, #0
    mrs     r0, faultmask
    cpsie   f
    mov     r0, #0
    mrs     r0, faultmask

    bx      lr

