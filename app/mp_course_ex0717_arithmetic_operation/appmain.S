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
    mov     r1, #3
    mov     r2, #1
    mov     r3, #0x81000000
    mov     r9, #1

    @@@@
    msr     apsr_nzcvq, r3
    adds    r0, r1, r2              @ 16 bit instruction
    msr     apsr_nzcvq, r3
    add     r0, r1, r2              @ 32 bit instruction
    msr     apsr_nzcvq, r3
    adds    r0, r1, r9              @ 32 bit instruction
    msr     apsr_nzcvq, r3
    add     r0, r1, r9              @ 32 bit instruction

    @@@@
    adds    r0, r1, r2              @ 16 bit instruction
    adds.w  r0, r1, r2              @ 32 bit instruction

    @@@@
    add     r0, r1, #0x0002         @ 32 bit instruction adds.w
    add     r0, r1, #0x0876         @ 32 bit instruction addw
    @ adds    r0, r1, #0x0876         @ 32 bit instruction addw
    add     r0, r1, #0x1000         @ 32 bit instruction adds.w

    @@@@@@@@
    mov     r0, #0
    mov     r2, #0x00000000         @ r2:r1   0x 00000000 80000000
    mov     r1, #0x80000000
    mov     r4, #0x00000000         @ r4:r3 + 0x 00000000 80000000
    mov     r3, #0x80000000
    mov     r6, #0
    mov     r5, #0
    msr     apsr_nzcvq, r0

    @@@@
    adds    r5, r1, r3              @ carry
    adc     r6, r2, r4              @ r6:r5   0x 00000001 00000000

    @@@@@@@@
    mov     r0, #0
    mov     r2, #0x00000000         @ r2:r1   0x 00000000 80000000
    mov     r1, #0x80000000
    mov     r4, #0x00000000         @ r4:r3 + 0x 00000000 70000000
    mov     r3, #0x70000000
    mov     r6, #0
    mov     r5, #0
    msr     apsr_nzcvq, r0

    @@@@
    adds    r5, r1, r3              @ no carry
    adc     r6, r2, r4              @ r6:r5   0x 00000000 f0000000

    @@@@@@@@
    mov     r0, #0
    mov     r1, #3
    mov     r2, #1
    mov     r3, #0x81000000
    mov     r9, #1

    @@@@
    msr     apsr_nzcvq, r3
    subs    r0, r1, r2              @ 16 bit instruction
    msr     apsr_nzcvq, r3
    sub     r0, r1, r2              @ 32 bit instruction
    msr     apsr_nzcvq, r3
    subs    r0, r1, r9              @ 32 bit instruction
    msr     apsr_nzcvq, r3
    sub     r0, r1, r9              @ 32 bit instruction

    @@@@
    subs    r0, r1, r2              @ 16 bit instruction
    subs.w  r0, r1, r2              @ 32 bit instruction

    @@@@
    sub     r0, r1, #2              @ 32 bit instruction subs.w
    sub     r0, r1, #0x876          @ 32 bit instruction subw
    @ subs     r0, r1, #0x876          @ 32 bit instruction subw
    sub     r0, r1, #0x1000         @ 32 bit instruction subs.w

    @@@@
    sub     r0, r2, #2
    rsb     r0, r2, #2
    sub     r0, r2, r1
    rsb     r0, r2, r1

    @@@@@@@@
    mov     r0, #0
    mov     r2, #0x00000001         @ r2:r1   0x 00000001 00000001
    mov     r1, #0x00000001
    mov     r4, #0x00000000         @ r4:r3 - 0x 00000000 00000002 = + 0x ffffffff fffffffe
    mov     r3, #0x00000002
    mov     r6, #0
    mov     r5, #0
    msr     apsr_nzcvq, r0

    @@@@
    subs    r5, r1, r3              @ borrow (no carry)
    sbc     r6, r2, r4              @ r6:r5   0x 00000000 ffffffff

    @@@@@@@@
    mov     r0, #0
    mov     r2, #0x00000001         @ r2:r1   0x 00000001 00000001
    mov     r1, #0x00000001
    mov     r4, #0x00000000         @ r4:r3 - 0x 00000000 00000001 = + 0x ffffffff ffffffff
    mov     r3, #0x00000001
    mov     r6, #0
    mov     r5, #0
    msr     apsr_nzcvq, r0

    @@@@
    subs    r5, r1, r3              @ not borrow (carry)
    sbc     r6, r2, r4              @ r6:r5   0x 00000001 00000000

    @@@@@@@@
    mov     r0, #0
    mov     r1, #6
    mov     r2, #2
    mov     r3, #-2 @ 0x ffff fffe
    mov     r4, #2147483648 @ 0x 8000 0000
    mov     r5, #0

    @@@@    Multiplication of signed int
    mul     r0, r1, r2              @ 0x 0000 0006 * 0x 0000 0002 (          2) = 0x   0000 000C : 0x 0000 000c ==           12 (0x           0000 000c) (Valid  )
    mul     r0, r1, r3              @ 0x 0000 0006 * 0x ffff fffe (         -2) = 0x 5 FFFF FFF4 : 0x ffff fff4 ==          -12 (0x           ffff fff4) (Valid  )
                                    @                             ( 4294967294)                                 !=  25769803764 (0x 0000 0005 ffff fff4) (Invalid)
    mul     r0, r1, r4              @ 0x 0000 0006 * 0x 8000 0000 (-2147483648) = 0x 3 0000 0000 : 0x 0000 0000 != -12884901888 (0x ffff fffd 0000 0000) (Invalid)
                                    @                             ( 2147483648)                                 !=  12884901888 (0x 0000 0003 0000 0000) (Invalid)

    @@@@    Multiplication of unsigned int type always causes overflow

    udiv    r0, r1, r2
    udiv    r0, r1, r3
    sdiv    r0, r1, r3

    @@@@
    udiv    r0, r1, r5

    @@@@    Enable divided by zero trap
    ldr     r7, =0xe000ed14 @ SCB->CCR
    ldr     r6, [r7]
    orr     r6, 0x10 @ DIV_0_TRP bit[4]
    str     r6, [r7]

    @@@@    Enable usage failt
    ldr     r7, =0xe000ed24 @ SCB->SHCSR
    ldr     r6, [r7]
    orr     r6, 0x40000 @ USGFAULTENA bit[18]
    str     r6, [r7]

    udiv    r0, r1, r5

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
    mov     r0, #0x0 @ r1:r2 = 0x 0000 0000 0000 0000
    mov     r1, #0x0
    mov     r2, #6
    mov     r3, #2
    mov     r4, #-2 @ 0x ffff fffe

    @@@@
    smull r0, r1, r2, r3 @ r1:r0 = r2 * r3 = 0x 0000 0006 * 0x 0000 0002 (         2) = 0x 0000 0000 0000 000c (         12)
    smull r0, r1, r2, r4 @ r1:r0 = r2 * r3 = 0x 0000 0006 * 0x ffff fffe (        -2) = 0x ffff ffff ffff fff4 (        -12)

    umull r0, r1, r2, r3 @ r1:r0 = r2 * r3 = 0x 0000 0006 * 0x 0000 0002 (         2) = 0x 0000 0000 0000 000c (         12)
    umull r0, r1, r2, r4 @ r1:r0 = r2 * r3 = 0x 0000 0006 * 0x ffff fffe (4294967294) = 0x 0000 0005 ffff fff4 (25769803764)

    @@@@@@@@
    mov     r1, #0xfffffffe @ r2:r1 = -2
    mov     r2, #0xffffffff

    smlal   r1, r2, r3, r4 @  r2:r1 = r2:r1 + (r3 * r4) = -2 + (2 * -2) = -6

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
