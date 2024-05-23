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

    mov     r0,  #0x1000
    mov     r1,  #0x1001
    mov     r2,  #0x1002
    mov     r3,  #0x1003
    mov     r12, #0x1012

    @ MSP: *((unsigned int*)0x00000000) - 0x100
    @ SCB: (SCB_Type*)0xe000ed00,h
    @ STKALIGN: SCB->CCR[9]
    @ Padding or not: xPSR[9]

    @@@@
    svc     #15             @ SP is double-word aligned

    @@@@@@@@
    pop     {r0}
    mov     r0, #0x1000

    @@@@
    svc     #15             @ SP is not double-word aligned

    @@@@@@@@
    pop     {r1}

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
