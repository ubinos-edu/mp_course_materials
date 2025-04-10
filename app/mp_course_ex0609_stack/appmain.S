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
    @ VSCode watch expression for stack : (int[8]) (* ((int *) $sp)),h
    @ Multiple register push: large number register first
    @ Multiple register pop: small number register first 

    movs    r0, #0
 
    mov     r1, #1
    mov     r2, #2
    push    {r1}
    push    {r2}
    mov     r1, #0
    mov     r2, #0
    pop     {r2}
    pop     {r1}

    mov     r1, #1
    mov     r2, #2
    mov     r3, #3
    push    {r1-r3}
    mov     r1, #0
    mov     r2, #0
    mov     r3, #0
    pop     {r1-r3}

    mov     r1, #1
    mov     r2, #2
    mov     r3, #3
    push    {r1, r3}
    mov     r1, #0
    mov     r2, #0
    mov     r3, #0
    pop     {r1, r3}

    mov     r1, #1
    mov     r2, #2
    mov     r3, #3
    push    {r2, r1, r3}
    mov     r1, #0
    mov     r2, #0
    mov     r3, #0
    pop     {r3, r2, r1}

    mrs     r0, msp
    mrs     r1, psp

    bx      lr

