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
    @@@@@@@@ After updating the CONTROL register with MSR instruction
    mrs     r0, CONTROL
    orr     r0, 0x2
    msr     CONTROL, r0
    isb

    @@@@@@@@ When disabling an interrupt using NVIC clear enable register
    ldr     r0, =0xe000e100 @ &SCB->NVIC-ISER[0]
    mov     r1, #0x1
    str     r1, [r0]
    dsb
    isb

    @@@@@@@@
    bx      lr


