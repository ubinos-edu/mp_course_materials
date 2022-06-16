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
    .align 1
    .globl SVC_Handler
    .type SVC_Handler, %function
SVC_Handler:
    tst     lr, #4                  // Test bit 2 of EXC_RETURN
    ite     eq                      
    mrseq   r0, msp                 // If 0, stacking used msp, copy to r0
    mrsne   r0, psp                 // If 1, stacking used psp, copy to r0
    b       SVC_Handler_main
