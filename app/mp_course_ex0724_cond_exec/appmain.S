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
    mov     r0, #1
    mov     r1, #0
    mov     r2, #0
    mov     r3, #0
    mov     r4, #0

    @@@@
    cmp     r0, #1
    ite     eq
    moveq   r2, #2
    movne   r2, #1

    @@@@
    cmp     r1, #1
    ite     eq
    moveq   r2, #2
    movne   r2, #1

    @@@@
    cmp     r0, #1
    itett   eq
    moveq   r2, #2
    movne   r2, #1
    moveq   r3, #3
    moveq   r4, #4

    @@@@
    cmp     r1, #1
    itett   eq
    moveq   r2, #2
    movne   r2, #1
    moveq   r3, #3
    moveq   r4, #4


    @@@@@@@@
    bx      lr

