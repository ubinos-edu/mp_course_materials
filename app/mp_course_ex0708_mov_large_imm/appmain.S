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
    .globl  test1
    .type   test1, %function
test1:
    @@@@
    ldr     r3, =0x34567890
    ldr     r4, =0x45678901

    @@@@
    bx      lr

    @@@@
    .pool

    .thumb_func
    .align  1
    .globl  appmain
    .type   appmain, %function
appmain:
    @@@@
    ldr     r1, =0x12345678
    ldr     r2, =0x23456789

    bl      test1

    @@@@
    movw    r0, #0x789A @ Set R0 to 0x0000789A
    movt    r0, #0x3456 @ Set upper 16-bit of R0 to 0x3456, now R0 = 0x3456789A

    @@@@
    bx      lr


