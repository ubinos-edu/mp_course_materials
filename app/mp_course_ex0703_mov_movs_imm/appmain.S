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
    mov     r0, #0x0
    msr     apsr, r0

    @ Set R3 value to 0x34
    mov     r3, #0x34
    @ Set R3 value to 0
    mov     r3, #0

    @ Set R3 value to 0x34 with APSR (flags) upudate
    movs    r3, #0x34
    @ Set R3 value to 0 with APSR (flags) upudate
    movs    r3, #0x0

    @@@@
    bx      lr

