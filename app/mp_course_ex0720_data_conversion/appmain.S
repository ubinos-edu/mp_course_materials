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
    @@@@@@@@
    ldr     r0, =#0x55AA8765    @ b 0101 ... 0101
    mov     r1, #0

    @@@@
    sxtb    r1, r0              @ 0x65                  -> 0x00000065
    uxtb    r1, r0              @ 0x65                  -> 0x00000065
    sxth    r1, r0              @ 0x8765 (- 0x0000789B) -> 0xFFFF8765 (- 0x0000789B)
    uxth    r1, r0              @ 0x8765                -> 0x00008765

    @@@@
    sxtb    r1, r0, ror #8      @ 0x87   (- 0x00000078) -> 0xFFFFFF87 (- 0x00000078)
    sxth    r1, r0, ror #16
    uxtb    r1, r0, ror #8      @ 0x87                  -> 0x00000087
    uxth    r1, r0, ror #16

    @@@@@@@@
    ldr     r0, =#0x12345678
    mov     r1, #0
    mov     r2, #0
    mov     r3, #0
    mov     r4, #0
    ldr     r5, =#0x12345687

    @@@@
    rev     r1, r0
    rev16   r2, r0
    revsh   r3, r0
    revsh   r4, r5

    @@@@@@@@
    bx      lr

