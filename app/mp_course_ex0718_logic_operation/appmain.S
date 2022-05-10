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
    mov     r0, #0x0
    mov     r1, #0x4321
    mov     r2, #0x0f00

    @@@@
    and     r1, r2 @ r1 = r1 & r2

    @@@@@@@@
    mov     r0, #0x0
    mov     r1, #0x4321

    @@@@
    and     r0, r1, #0x0f00 @ r0 = r1 & 0x0f00

    @@@@@@@@
    mov     r0, #0x0

    @@@@
    and     r0, r1, r2 @ r0 = r1 & r2


    @@@@@@@@
    mov     r0, #0x0
    mov     r1, #0x4021
    mov     r2, #0x0300

    @@@@
    orr     r1, r2 @ r1 = r1 | r2

    @@@@@@@@
    mov     r0, #0x0
    mov     r1, #0x4021

    @@@@
    orr     r0, r1, #0x0300 @ r0 = r1 | 0x0300

    @@@@@@@@
    mov     r0, #0x0

    @@@@
    orr     r0, r1, r2 @ r0 = r1 | r2


    @@@@@@@@
    mov     r0, #0x0
    mov     r1, #0x4321
    mov     r2, #0x0200

    @@@@
    bic     r1, r2 @ r1 = r1 & ~r2

    @@@@@@@@
    mov     r0, #0x0
    mov     r1, #0x4321

    @@@@
    bic     r0, r1, #0x0200 @ r0 = r1 & ~0x0200

    @@@@@@@@
    mov     r0, #0x0

    @@@@
    bic     r0, r1, r2 @ r0 = r1 & ~r2


    @@@@@@@@
    mov     r0, #0x0
    mov     r1, #0x4321
    mov     r2, #0x0f00

    @@@@
    orn     r1, r2 @ r1 = r1 | ~r2

    @@@@@@@@
    mov     r0, #0x0
    mov     r1, #0x4321

    @@@@
    orn     r0, r1, #0x0f00 @ r0 = r1 | ~0x0f00

    @@@@@@@@
    mov     r0, #0x0

    @@@@
    orn     r0, r1, r2 @ r0 = r1 | ~r2


    @@@@@@@@
    mov     r0, #0x0
    mov     r1, #0x00ff
    mov     r2, #0x0ff0

    @@@@
    eor     r1, r2 @ r1 = r1 ^ r2

    @@@@@@@@
    mov     r0, #0x0
    mov     r1, #0x00ff

    @@@@
    eor     r0, r1, #0x0ff0 @ r0 = r1 ^ 0x0ff0

    @@@@@@@@
    mov     r0, #0x0

    @@@@
    eor     r0, r1, r2 @ r0 = r1 ^ r2

    @@@@@@@@
    mov     r1, #0x81000000
    mov     r2, #0x80000000
    mov     r3, #0x00000000
    mov     r0, #0
    msr     apsr_nzcvq, r0
    ands    r0, r1, r2              @ (C = 0)
    ands    r0, r1, r3              @ (C = 0)
    ands    r0, r1, #0x80000000     @ (C = 1?)
    ands    r0, r1, #0x00000000     @ (C = 1?)
    mov     r0, #0
    msr     apsr_nzcvq, r0
    orrs    r0, r1, r2              @ (C = 0)
    orrs    r0, r1, r3              @ (C = 0)
    orrs    r0, r1, #0x80000000     @ (C = 1?)
    orrs    r0, r1, #0x00000000     @ (C = 1?)
    mov     r0, #0
    msr     apsr_nzcvq, r0
    eors    r0, r1, r2              @ (C = 0)
    eors    r0, r1, r3              @ (C = 0)
    eors    r0, r1, #0x80000000     @ (C = 1?)
    eors    r0, r1, #0x00000000     @ (C = 1?)

    @@@@@@@@
    bx      lr

