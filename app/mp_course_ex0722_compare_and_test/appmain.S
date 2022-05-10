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
    mov     r0, #0
    mov     r1, #1
    mov     r2, #2
    mov     r3, #1
    mov     r4, #-2
    mov     r5, #-1


    @@@@@@@@
    @ CMP <Rn>, <Rm> Compare: Calculate Rn - Rm.
    msr     apsr_nzcvq, r0
    cmp     r1, r2              @ 1 - 2
    msr     apsr_nzcvq, r0
    cmp     r2, r3              @ 2 - 1
    msr     apsr_nzcvq, r0
    cmp     r1, r3              @ 1 - 1

    @@@@@@@@
    @ CMP <Rn>, #<immed> Compare: Calculate Rn – immediate data.
    msr     apsr_nzcvq, r0
    cmp     r1, #2              @ 1 - 2
    msr     apsr_nzcvq, r0
    cmp     r2, #1              @ 2 - 1
    msr     apsr_nzcvq, r0
    cmp     r1, #1              @ 1 - 1
  

    @@@@@@@@
    @ CMN <Rn>, <Rm> Compare negative: Calculate Rn + Rm.
    msr     apsr_nzcvq, r0
    cmn     r1, r4              @ 1 + -2
    msr     apsr_nzcvq, r0
    cmn     r2, r5              @ 2 + -1
    msr     apsr_nzcvq, r0
    cmn     r1, r5              @ 1 + -1

    @@@@@@@@
    @ CMN <Rn>, #<immed> Compare negative: Calculate Rn + immediate data.
    msr     apsr_nzcvq, r0
    cmn     r1, #-2              @ 1 + -2
    msr     apsr_nzcvq, r0
    cmn     r2, #-1              @ 2 + -1
    msr     apsr_nzcvq, r0
    cmn     r1, #-1              @ 1 + -1


    @@@@@@@@
    mov     r0, #0
    mov     r1, #0x81000000
    mov     r2, #0x00100000
    mov     r3, #0x01000000
    mov     r4, #0x80000000


    @@@@@@@@
    @ TST <Rn>, <Rm> (,<shift>) Test (bitwise AND): Calculate AND result between Rn and Rm.
    msr     apsr_nzcvq, r0
    tst     r1, r2              @ 0x81000000 & 0x00100000 = 0x00000000 (C = 0)
    msr     apsr_nzcvq, r0
    tst     r1, r3              @ 0x81000000 & 0x01000000 = 0x01000000 (C = 0)
    msr     apsr_nzcvq, r0
    tst     r1, r4              @ 0x81000000 & 0x80000000 = 0x80000000 (C = 0)
    msr     apsr_nzcvq, r0
    tst     r1, r4, lsl #1      @ 0x81000000 & (0x80000000 << 1) = 0x00000000


    @@@@@@@@
    @ TST <Rn>, #<immed> Test (bitwise AND): Calculate AND result between Rn and immediate data.
    msr     apsr_nzcvq, r0
    tst     r1, #0x00100000     @ 0x81000000 & 0x00100000 = 0x00000000 (C = 0)
    msr     apsr_nzcvq, r0
    tst     r1, #0x01000000     @ 0x81000000 & 0x01000000 = 0x01000000 (C = 0)
    msr     apsr_nzcvq, r0
    tst     r1, #0x80000000     @ 0x81000000 & 0x80000000 = 0x80000000 (C = 1?)


    @@@@@@@@
    @ TEQ <Rn>, <Rm> (,<shift>) Test (bitwise XOR): Calculate XOR result between Rn and Rm.
    msr     apsr_nzcvq, r0
    teq     r1, r2              @ 0x81000000 ^ 0x00100000 = 0x81100000 (C = 0)
    msr     apsr_nzcvq, r0
    teq     r1, r3              @ 0x81000000 ^ 0x01000000 = 0x80000000 (C = 0)
    msr     apsr_nzcvq, r0
    teq     r1, r4              @ 0x81000000 ^ 0x80000000 = 0x01000000 (C = 0)
    msr     apsr_nzcvq, r0
    teq     r1, r4, lsl #1      @ 0x81000000 ^ (0x80000000 << 1) = 0x81000000


    @@@@@@@@
    @ TEQ <Rn>, #<immed> Test (bitwise XOR): Calculate XOR result between Rn and immediate data.
    msr     apsr_nzcvq, r0
    teq     r1, #0x00100000     @ 0x81000000 ^ 0x00100000 = 0x81100000 (C = 0)
    msr     apsr_nzcvq, r0
    teq     r1, #0x01000000     @ 0x81000000 ^ 0x01000000 = 0x80000000 (C = 0)
    msr     apsr_nzcvq, r0
    teq     r1, #0x80000000     @ 0x81000000 ^ 0x80000000 = 0x01000000 (C = 1?)

    @@@@@@@@
    bx      lr

