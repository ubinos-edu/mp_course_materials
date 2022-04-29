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
    @@@@
    mov     r0, #0
    mov     r2, #1
    mov     r7, #0

    @ Copy value of PRIMASK (special register) to R7
    mrs     r7, PRIMASK

    @ Copy value of R2 into PRIMASK (special register)
    msr     PRIMASK, r2
    
    mrs     r7, PRIMASK
    msr     PRIMASK, r0

    @@@@
    mov     r0, #0
    mov     r2, #2
    mov     r7, #0

    @ Copy value of CONTROL (special register) to R7
    mrs     r7, CONTROL

    @ Copy value of R2 into CONTROL (special register)
    msr     CONTROL, r2
    
    mrs     r7, CONTROL
    msr     CONTROL, r0

    @@@@
    bx      lr

