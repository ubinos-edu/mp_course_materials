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

    mrs     r0, control
    vmov.f32 s0, #1.00000000
    vmov.f32 s1, #2.25000000
    vadd.f32 s0, s0, s1
    mrs     r0, control

    mov     r0,  #0x1000
    mov     r1,  #0x1001
    mov     r2,  #0x1002
    mov     r3,  #0x1003
    mov     r12, #0x1012

    @ MSP: ( *((uint32_t*)0x00000000) ),h
    @      (uint32_t[0x30]) ( *(*((uint32_t*)0x00000000) - 0x30*4) ) ,h
    @      (uint32_t[0x38]) ( *(0x________ - 0x30*4) ) ,h
    @      $msp,h
    @      0x20020000 - 0x30*4 = 0x2001ff40
    @ FPU: (FPU_Type*)(*0xe000ef30),h
    @      (uint32_t[6])(*0xe000ef30),h

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

    vmov.f32 s0, #1.00000000
    vmov.f32 s1, #2.25000000
    vadd.f32 s0, s0, s1

    push    {r0}
    pop     {r0}

    bx      lr
