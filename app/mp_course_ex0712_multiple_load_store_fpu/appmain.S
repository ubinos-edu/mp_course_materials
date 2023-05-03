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
float_array:                      @ VSCode watch expression: ((float[8]) float_array),h
    .float  0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8
float_array_2:                    @ VSCode watch expression: ((float[8]) float_array_2),h
    .float  0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0


    .text
    .thumb

    .thumb_func
    .align  1
    .globl  appmain
    .type   appmain, %function
appmain:
    @@@@@@@@
    @ Multiple Load/Store for FPU
    mov     r0, #0
    mov     r1, #0
    mov     r2, #0
    mov     r3, #0
    mov     r4, #0
    mov     r5, #0
    mov     r6, #0
    mov     r7, #0
    vldr.32 s0, =0x00000000
    vldr.32 s1, =0x00000000
    vldr.32 s2, =0x00000000
    vldr.32 s3, =0x00000000
    vldr.32 s4, =0x00000000
    vldr.32 s5, =0x00000000
    vldr.32 s6, =0x00000000
    vldr.32 s7, =0x00000000

    @@@@
    ldr     r7, =float_array        @ Set r7 to float_array (address)

    vldmia  r7, {s0-s3}             @ Read 4 words and store them to s0 - s3

    @@@@
    ldr     r7, =float_array_2      @ Set r7 to float_array_2 (address)

    vstmia  r7, {s0-s3}             @ Store 4 words stored in s0 - s3 to memory[r7]

    @ @@@@@@@@
    @ @ Multiple Load/Store for FPU with Write Back
    mov     r0, #0
    mov     r1, #0
    mov     r2, #0
    mov     r3, #0
    mov     r4, #0
    mov     r5, #0
    mov     r6, #0
    mov     r7, #0
    vldr.32 s0, =0x00000000
    vldr.32 s1, =0x00000000
    vldr.32 s2, =0x00000000
    vldr.32 s3, =0x00000000
    vldr.32 s4, =0x00000000
    vldr.32 s5, =0x00000000
    vldr.32 s6, =0x00000000
    vldr.32 s7, =0x00000000
    ldr     r7, =float_array_2
    vstmia  r7, {s0-s3}
    mov     r7, #0

    @@@@
    ldr     r7, =float_array        @ Set r7 to float_array (address)

    vldmia  r7!, {s0-s3}            @ Change r7 to float_array (address) + 0x10 after the load

    @@@@
    ldr     r7, =float_array_2      @ Set R4 to float_array_2 (address)

    vstmia  r7!, {s0-s3}            @ Change r7 to float_array_2 (address) + 0x10 after the store

    @@@@@@@@
    @ Multiple Load/Store Decrement Address before for FPU
    mov     r0, #0
    mov     r1, #0
    mov     r2, #0
    mov     r3, #0
    mov     r4, #0
    mov     r5, #0
    mov     r6, #0
    mov     r7, #0
    vldr.32 s0, =0x00000000
    vldr.32 s1, =0x00000000
    vldr.32 s2, =0x00000000
    vldr.32 s3, =0x00000000
    vldr.32 s4, =0x00000000
    vldr.32 s5, =0x00000000
    vldr.32 s6, =0x00000000
    vldr.32 s7, =0x00000000
    ldr     r7, =float_array_2
    vstmia  r7, {s0-s3}
    mov     r7, #0

    @@@@
    ldr     r7, =float_array        @ Set r7 to float_array (address)
    add     r7, r7, #16

    vldmdb  r7!, {s0-s3}            @ Read 4 words and store them to s0 - s3

    @@@@
    ldr     r7, =float_array_2      @ Set r7 to float_array (address)
    add     r7, r7, #16

    vstmdb  r7!, {s0-s3}            @ Write 4 words and store them to s0 - s3

    @ @@@@@@@@
    @ @ Multiple Load/Store Decrement Address before for FPU (not consecutive register order)
    @ mov     r0, #0
    @ mov     r1, #0
    @ mov     r2, #0
    @ mov     r3, #0
    @ mov     r4, #0
    @ mov     r5, #0
    @ mov     r6, #0
    @ mov     r7, #0
    @ vldr.32 s0, =0x00000000
    @ vldr.32 s1, =0x00000000
    @ vldr.32 s2, =0x00000000
    @ vldr.32 s3, =0x00000000
    @ vldr.32 s4, =0x00000000
    @ vldr.32 s5, =0x00000000
    @ vldr.32 s6, =0x00000000
    @ vldr.32 s7, =0x00000000
    @ ldr     r7, =float_array_2
    @ vstmia  r7, {s0-s3}
    @ mov     r7, #0

    @ @@@@
    @ ldr     r7, =float_array        @ Set r7 to float_array (address)
    @ add     r7, r7, #16

    @ vldmdb  r7!, {s3, s0-s1}        @

    @ @@@@
    @ ldr     r7, =float_array_2      @ Set r7 to float_array (address)
    @ add     r7, r7, #16

    @ vstmdb  r7!, {s1, s0, s3}       @

    @@@@@@@@
    bx     lr

