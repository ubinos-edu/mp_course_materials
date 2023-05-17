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
    mov     r0, #0
    mov     r1, #0
    mov     r2, #0
    mov     r3, #0
    mov     r4, #0

    mov     r1, #1
    b       label1
    mov     r2, #2
label1:
    mov     r3, #3
    b.w     label2
    mov     r4, #4
label2:
    mov     r1, #1
    ldr     r6, =label3
    bx      r6
    mov     r2, #2
    .thumb_func
    .align  1
label3:
    mov     r3, #3

    @@@@@@@@
    bl      func_a
    ldr     r6, =func_b
    blx     r6

    @@@@@@@@
    mov     r0, #0
    mov     r1, #1
    mov     r2, #2
    mov     r3, #0
    mov     r4, #0

    cmp     r1, r2
    beq     label4
    mov     r3, #3
label4:
    cmp     r1, r2
    bne     label5
    mov     r4, #4
label5:


    @@@@@@@@
    mov     r0, #3
1:  cbz     r0, 2f
    sub     r0, #1
    b       1b
2:

    @@@@@@@@
    bl      func_b
    cbnz    r0, 1f
    bl      func_d
1:

    @@@@@@@@
    bl      func_c
    cbnz    r0, 1f
    bl      func_d
1:

    @@@@@@@@
    bx      lr


    .thumb_func
    .align  1
    .globl  func_a
    .type   func_a, %function
func_a:
    push    {lr}
    bl      func_b
    pop     {pc}


    .thumb_func
    .align  1
    .globl  func_b
    .type   func_b, %function
func_b:
    push    {lr}
    mov     r0, #1
    pop     {pc}


    .thumb_func
    .align  1
    .globl  func_c
    .type   func_c, %function
func_c:
    push    {lr}
    mov     r0, #0
    pop     {pc}


    .thumb_func
    .align  1
    .globl  func_d
    .type   func_d, %function
func_d:
    push    {lr}
    pop     {pc}
