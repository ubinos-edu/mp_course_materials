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
    mov     r0, #0
    mov     r1, #6
    mov     r2, #2
    mov     r3, #-2
    mov     r4, #0

    @@@@
    mul     r0, r1, r2
    udiv    r0, r1, r2
    udiv    r0, r1, r3
    sdiv    r0, r1, r3

    @@@@
    udiv    r0, r1, r4

    ldr     r7, =0xe000ed14 @ SCB->CCR
    ldr     r6, [r7]
    orr     r6, 0x10 @ DIV_0_TRP bit[4]
    str     r6, [r7]

    ldr     r7, =0xe000ed24 @ SCB->SHCSR
    ldr     r6, [r7]
    orr     r6, 0x40000 @ USGFAULTENA bit[18]
    str     r6, [r7]

    udiv    r0, r1, r4

    @@@@@@@@
    mov     r0, #0
    mov     r1, #1
    mov     r2, #2
    mov     r3, #3

    mla     r0, r1, r2, r3 @ r0 = r3 + r1 * r2
    mls     r0, r1, r2, r3 @ r0 = r3 - r1 * r2

    @@@@@@@@
    mov     r0, #0
    mov     r1, #1
    mov     r2, #2
    ldr     r3, =#0x12345678
    mov     r4, #0x10

    @@@@
    umull   r1, r2, r3, r4 @ r2:r1 = r3 * r4

    @@@@@@@@
    mov     r1, #1
    mov     r2, #2
 
    umlal   r1, r2, r3, r4 @ r2:r1 = r2:r1 + r3 * r4

    @@@@@@@@
    mov     r1, #0xfffffffe @ r2:r1 = -2
    mov     r2, #0xffffffff
    mov     r3, #-2
    mov     r4, #0x10

    @@@@
    smull r1, r2, r3, r4 @ r2:r1 = -2 * 16 = -32
    umull r1, r2, r3, r4

    @@@@@@@@
    mov     r1, #0xfffffffe @ r2:r1 = -2
    mov     r2, #0xffffffff
 
    smlal   r1, r2, r3, r4 @  r2:r1 = r2:r1 + -2 * 16 = -34

    @@@@@@@@
    bx      lr

    .thumb_func
    .align 1
    .globl UsageFault_Handler
    .type UsageFault_Handler, %function
UsageFault_Handler:
    ldr     r1, [sp, #24]
    add     r1, #4
    str     r1, [sp, #24]
    bx      lr
