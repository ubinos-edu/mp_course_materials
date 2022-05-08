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
int_array:
    .word   0x11111111, 0x22222222


    .text
    .thumb

    .thumb_func
    .align  1
    .globl  appmain
    .type   appmain, %function
appmain:
    @@@@@@@@
    ldr     r0, =int_array
    ldr     r1, =0xe000ed00 @ SCB
    mov     r2, #0
    mov     r3, #0

    @@@@
    ldr    r2, [r0]
    ldr    r3, [r1] @ Read chip ID

    @@@@@@@@
    mov     r2, #0
    mov     r3, #0

    @@@@
    ldrt    r2, [r0]
    ldrt    r3, [r1] @ Read chip ID

    @@@@@@@@
    bx      lr          @ 16 bit 
