/*
 * Copyright (c) 2022 Sung Ho Park and CSOS
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <ubinos_config.h>

    .syntax unified
    .arch   armv7e-m

    .data

    .align 2
lock_addr_1:
    .word   0x0


    .text
    .thumb

    .thumb_func
    .align  1
    .globl  appmain
    .type   appmain, %function
appmain:
    @@@@@@@@
    mov     r0, #0
    mov     r1, #3
    mov     r2, #1

    @@@@
    add     r0, r1, r2
    add     r0, r1, #2
    add     r0, r1, #0x876

    @@@@
    adds    r0, r1, r2
    adds    r0, r1, #2
    add     r0, r1, #0x876
    @ adds    r0, r1, #0x976
    addw    r0, r1, #0x976

    @@@@@@@@
    mov     r0, #0
    mov     r2, #0x30000000         @ r2:r1 0x30000000 20000000
    mov     r1, #0x20000000
    mov     r4, #0x10000000         @ r4:r3 0x10000000 F0000000
    mov     r3, #0xf0000000
    mov     r6, #0
    mov     r5, #0
    msr     apsr_nzcvq, r0

    @@@@
    adds    r5, r1, r3
    adc     r6, r2, r4              @ r6:r5 0x40000001 10000000

    @@@@@@@@
    mov     r0, #0
    mov     r1, #3
    mov     r2, #1

    @@@@
    sub     r0, r1, r2
    sub     r0, r1, #2
    sub     r0, r1, #0x876

    @@@@
    rsb     r0, r2, r1
    rsb     r0, r2, #2

    @@@@
    subs    r0, r1, r2
    subs    r0, r1, #2
    sub     r0, r1, #0x876
    @ subs    r0, r1, #0x976
    subw    r0, r1, #0x976

    @@@@@@@@
    mov     r0, #0
    mov     r2, #0x30000000         @ r2:r1 0x30000000 20000000
    mov     r1, #0x20000000
    mov     r4, #0x10000000         @ r4:r3 0x10000000 30000000
    mov     r3, #0x30000000
    mov     r6, #0
    mov     r5, #0
    msr     apsr_nzcvq, r0

    @@@@
    subs    r5, r1, r3
    sbc     r6, r2, r4              @ r6:r5 0x1fffffff f0000000

    @@@@@@@@
    bx      lr          @ 16 bit 

