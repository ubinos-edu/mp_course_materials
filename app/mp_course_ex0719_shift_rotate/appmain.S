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
    ldr     r1, =#0xa0000005 @ b 1010 0000 ... 0000 0101
    mov     r2, #1
    mov     r3, #2
    mov     r4, #0x0

    @@@@@@@@ lsl
    mov     r0, #0x0
    msr     apsr_nzcvq, r4
    @@@@
    lsls    r0, r1, #1 @ r0 = r1 << #1

    mov     r0, #0x0
    msr     apsr_nzcvq, r4
    lsl     r0, r1, #1 @ r0 = r1 << #1

    @@@@
    mov     r0, #0x0
    msr     apsr_nzcvq, r4
    @@@@
    lsls    r0, r1, #2 @ r0 = r1 << #2

    @@@@
    mov     r0, #0x0
    msr     apsr_nzcvq, r4
    @@@@
    lsls    r0, r1, r2 @ r0 = r1 << r2

    @@@@
    mov     r0, #0x0
    msr     apsr_nzcvq, r4
    @@@@
    lsls    r0, r1, r3 @ r0 = r1 << r3

    @@@@@@@@ lsr
    mov     r0, #0x0
    msr     apsr_nzcvq, r4
    @@@@
    lsrs    r0, r1, #1 @ r0 = r1 >> #1

    @@@@
    mov     r0, #0x0
    msr     apsr_nzcvq, r4
    @@@@
    lsrs    r0, r1, #2 @ r0 = r1 >> #2

    @@@@
    mov     r0, #0x0
    msr     apsr_nzcvq, r4
    @@@@
    lsrs    r0, r1, r2 @ r0 = r1 >> r2

    @@@@
    mov     r0, #0x0
    msr     apsr_nzcvq, r4
    @@@@
    lsrs    r0, r1, r3 @ r0 = r1 >> r3

    @@@@@@@@ ror
    mov     r0, #0x0
    msr     apsr_nzcvq, r4
    @@@@
    rors    r0, r1, #1 @ r0 = r1 >> #1

    @@@@
    mov     r0, #0x0
    msr     apsr_nzcvq, r4
    @@@@
    rors    r0, r1, #2 @ r0 = r1 >> #2

    @@@@
    mov     r0, #0x0
    msr     apsr_nzcvq, r4
    @@@@
    rors    r0, r1, r2 @ r0 = r1 >> r2

    @@@@
    mov     r0, #0x0
    msr     apsr_nzcvq, r4
    @@@@
    rors    r0, r1, r3 @ r0 = r1 >> r3

    @@@@@@@@ rrx
    mov     r0, #0x0
    msr     apsr_nzcvq, r4
    @@@@
    rrxs    r0, r1 @ r0 = r1 >> 1
    rrxs    r0, r0 @ r0 = r0 >> 1


    @@@@@@@@ asr
    mov     r0, #0x0
    msr     apsr_nzcvq, r4
    @@@@
    asrs    r0, r1, #1 @ r0 = r1 >> #1

    @@@@
    mov     r0, #0x0
    msr     apsr_nzcvq, r4
    @@@@
    asrs    r0, r1, #2 @ r0 = r1 >> #2

    @@@@
    mov     r0, #0x0
    msr     apsr_nzcvq, r4
    @@@@
    asrs    r0, r1, r2 @ r0 = r1 >> r2

    @@@@
    mov     r0, #0x0
    msr     apsr_nzcvq, r4
    @@@@
    asrs    r0, r1, r3 @ r0 = r1 >> r3


    @@@@@@@@
    bx      lr

