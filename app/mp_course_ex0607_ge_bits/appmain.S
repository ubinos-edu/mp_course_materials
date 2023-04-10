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
    ldr     r0, =0x00010001 @ r0 = ( 1,  1)
    ldr     r1, =0xfffc0002 @ r1 = (-4,  2)
    sadd16  r2, r0, r1      @ r2 = (-3,  3) (0x fffd 0003) ge = 00 11
    sel     r2, r1, r0      @ r2 = ( 1,  2) (0x 0001 0002)

    @@@@
    bx      lr

