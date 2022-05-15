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

tbb_start:
    tbb     [pc, r0]        @ 32-bit
tbb_table:
    .byte   2
    .byte   5
    .byte   8
    .byte   11
tbb_dest0:
    mov     r0, #1          @ 32-bit
    b       tbb_start       @ 16-bit
tbb_dest1:
    mov     r0, #2
    b       tbb_start
tbb_dest2:
    mov     r0, #3
    b       tbb_start
tbb_dest3:
    mov     r0, #4
    b       tbb_end
tbb_end:

    @@@@@@@@
    mov     r0, #0

tbh_start:
    tbh     [pc, r0, lsl #1]    @ 32-bit
tbh_table:
    .hword  4
    .hword  7
    .hword  10
    .hword  13
tbh_dest0:
    mov     r0, #1              @ 32-bit
    b       tbh_start           @ 16-bit
tbh_dest1:
    mov     r0, #2
    b       tbh_start
tbh_dest2:
    mov     r0, #3
    b       tbh_start
tbh_dest3:
    mov     r0, #4
    b       tbh_end
tbh_end:

    @@@@@@@@
    bx      lr

