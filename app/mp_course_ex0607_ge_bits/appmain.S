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
    msr     apsr, r0
    ldr     r0, =0x00010004 @ r0 = ( 1,  4)
    ldr     r1, =0x00020003 @ r1 = ( 2,  3)
    ssub16  r2, r0, r1      @ r2 = (-1,  1) (0x ffff 0001) ge = 00 11
    sel     r2, r1, r0      @ r2 = ( 1,  3) (0x 0001 0003) Min.
    sel     r2, r0, r1      @ r2 = ( 2,  4) (0x 0002 0004) Max.

    @@@@
    bx      lr

