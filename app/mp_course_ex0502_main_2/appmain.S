/*
 * Copyright (c) 2022 Sung Ho Park and CSOS
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <ubinos_config.h>

    .syntax unified
    .arch   armv7-m

    .text
    .thumb

    .thumb_func
    .align  1
    .globl  appmain
    .type   appmain, %function
appmain:
    push    {r7}
    sub     sp, #12
    add     r7, sp, #0
 
    str     r0, [r7, #4]
    str     r1, [r7, #0]
 
    movs    r3, #0
    mov     r0, r3
 
    adds    r7, #12
    mov     sp, r7
    pop     {r7}
    bx      lr

