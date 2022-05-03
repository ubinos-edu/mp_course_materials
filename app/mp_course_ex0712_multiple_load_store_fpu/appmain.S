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
float_array:                      @ (float[8]) float_array
    .float  0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8
float_array_2:                    @ (float[8]) float_array_2
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
    vldr.32 s0, =0x00000000
    vldr.32 s1, =0x00000000
    vldr.32 s2, =0x00000000
    vldr.32 s3, =0x00000000
    mov     r4, #0

    @@@@
    ldr     r4, =float_array        @ Set R4 to float_array (address)
    vldmia  r4, {s0-s3}             @ Read 4 words and store them to s0 - s3

    @@@@
    ldr     r4, =float_array_2      @ Set R4 to float_array_2 (address)
    vstmia  r4, {s0-s3}             @ Write 4 words stored in s0 - s3 to memory location specified by R4

    @ @@@@@@@@
    @ @ Multiple Load/Store for FPU with Write Back
    vldr.32 s0, =0x00000000
    vldr.32 s1, =0x00000000
    vldr.32 s2, =0x00000000
    vldr.32 s3, =0x00000000
    mov     r4, #0

    @@@@
    ldr     r4, =float_array        @ Set R4 to float_array (address)
    vldmia  r4!, {s0-s3}            @ R4 change to float_array (address) + 0x10 after the load

    @@@@
    ldr     r4, =float_array_2      @ Set R4 to float_array_2 (address)
    vstmia  r4!, {s0-s3}            @ R4 change to float_array_2 (address) + 0x10 after the store

    @@@@@@@@
    @ Multiple Load/Store Decrement Address before for FPU
    vldr.32 s0, =0x00000000
    vldr.32 s1, =0x00000000
    vldr.32 s2, =0x00000000
    vldr.32 s3, =0x00000000
    mov     r4, #0

    @@@@
    ldr     r4, =float_array        @ Set R4 to float_array (address)
    add     r4, r4, #16
    vldmdb  r4!, {s0-s3}            @ Read 4 words and store them to s0 - s3

    @@@@@@@@
    bx     lr

