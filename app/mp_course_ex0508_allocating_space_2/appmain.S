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
int_data:
    .word   0

    .align 2
int_data2:
    .word   1

    .align 2
string_data:
    .asciz  "Hello"

    .align 2
char_array:
    .byte   'A', 'B', 'C'

    .align 2
int_array:
    .word   0, 1, 2, 3

    .align 2
float_data:
    .float  0.5

    .align 3
double_data:
    .double 0.25

    .align 2
format_int:
    .asciz  "%d\n"

    .align 2
format_string:
    .asciz  "%s\n"

    .align 2
format_char:
    .asciz  "%c\n"

    .align 2
format_float:
    .asciz  "%f\n"

endian_test:
    .align 2
    .word   0x12345678
    .align 1
    .hword  0x1234
    .hword  0x5678
    .align 0
    .byte   0x12
    .byte   0x34
    .byte   0x56
    .byte   0x78

align_test:
    .align 2
    .word   0x12345678
    .align 2
    .hword  0x1234
    .align 2
    .hword  0x5678
    .align 2
    .byte   0x12
    .align 2
    .byte   0x34
    .align 2
    .byte   0x56
    .align 2
    .byte   0x78

    .text
    .thumb

    .thumb_func
    .align  1
    .fpu softvfp
    .globl  appmain
    .type   appmain, %function
appmain:
    push    {lr}

    ldr     r3, =int_data
    ldr     r1, [r3, #0]
    ldr     r0, =format_int
    bl      printf

    ldr     r3, =int_data2
    ldr     r1, [r3, #0]
    ldr     r0, =format_int
    bl      printf

    ldr     r1, =string_data
    ldr     r0, =format_string
    bl      printf

    ldr     r3, =char_array
    ldr     r1, [r3, #1]
    ldr     r0, =format_char
    bl      printf

    ldr     r3, =int_array
    ldr     r1, [r3, #8]
    ldr     r0, =format_int
    bl      printf

    ldr     r3, =float_data
    ldr     r0, [r3, #0]
    bl      __aeabi_f2d
    mov     r2, r1
    mov     r1, r0
    ldr     r0, =format_float
    bl      printf

    ldr     r3, =double_data
    ldrd    r1, r2, [r3]
    ldr     r0, =format_float
    bl      printf

    movs    r0, #0

    pop     {pc}

