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
process_stack:
    .space   256, 0x0

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
    mov     r0, #0x2
    msr     control, r0
    ldr     sp, =process_stack
    add     sp, sp, #256

    mov     r0, #0x33333333
    mov     r1, #0x44444444
    push    {r0, r1}

    mov     r0,  #0x1000
    mov     r1,  #0x1001
    mov     r2,  #0x1002
    mov     r3,  #0x1003
    mov     r12, #0x1012

    @@@@
    svc     #15

    @@@@@@@@
    pop     {r0}
    mov     r0, #0x1000

    @@@@
    svc     #15

    @@@@@@@@
    pop     {r1}

    @@@@@@@@
    mov     r0, #0x0
    msr     control, r0

    pop    {r0, r1}

    bx      lr


    .thumb_func
    .align 1
    .globl SVC_Handler
    .type SVC_Handler, %function
SVC_Handler:
    mov     r0,  #0x2000
    mov     r1,  #0x2001
    mov     r2,  #0x2002
    mov     r3,  #0x2003
    mov     r12, #0x2012

    push    {r0}
    pop     {r0}

    bx      lr
