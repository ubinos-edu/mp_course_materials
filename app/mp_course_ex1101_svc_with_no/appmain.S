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
    mov     r0, #0x11111111
    mov     r1, #0x22222222
    push    {r0, r1}

    @@@@@@@@
    svc     #0xe

    @@@@@@@@
    bx      lr

    @@@@@@@@
    pop     {r0, r1}

    .thumb_func
    .align 1
    .globl SVC_Handler
    .type SVC_Handler, %function
SVC_Handler:
    tst     lr, #0x4        @ Test bit (bitwise AND) 2 of EXC_RETURN (return stack)
    ite     eq
    mrseq   r0, msp         @ if 0, stacking used msp, copy to r0
    mrsne   r0, psp         @ if 1, stacking used psp, copy to r0
    ldr     r0, [r0, #24]   @ Get stacked PC from the stack frame (stacked PC = address of instruction after SVC)
    ldrb    r0, [r0, #-2]   @ Get first byte of the SVC instruction (now the SVC number is in r0)
    bx      lr
