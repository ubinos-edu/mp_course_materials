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
    mov     r6, #0x0

    @ Set R6 to a 16-bit constant 0x1234
    movw    r6, #0x1234
    @ Set the upper 16-bit of R6 to 0x8765
    movt    r6, #0x8765

    @@@@
    bx      lr

