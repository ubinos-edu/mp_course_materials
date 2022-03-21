/*
 * Copyright (c) 2022 Sung Ho Park and CSOS
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <ubinos_config.h>

    .syntax unified
    .arch   armv7-m

    .data

    .align 2
msgstr:
    .asciz "Hello World!\n" @ Define a null-terminated string

    .text
    .thumb

    .thumb_func
    .align  1
    .globl  appmain
    .type   appmain, %function
appmain:
    push    {lr}        @ push return address onto stack

    ldr     r0, =msgstr @ load pointer to format string
    bl      printf      @ printf("Hello World!\n");

    movs    r0, #0      @ move return code into r0

    pop     {pc}        @ return from appmain

