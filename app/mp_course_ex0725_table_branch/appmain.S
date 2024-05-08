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
    movs    r0, #0
    @ mov    r0, #0

tbb_start:                                          @ 0x08000246
    tbb     [pc, r0]        @ 32-bit (pc + 4)
tbb_table:                                          @ 0x0800024a
    .byte   2               @ + (2 * 2) bytes
    .byte   5               @ + (5 * 2) bytes
    .byte   8
    .byte   11
tbb_dest0:                                          @ 0x0800024e
    mov     r0, #1          @ 4 bytes
    b       tbb_start       @ 2 bytes
tbb_dest1:                                          @ 0x08000254
    mov     r0, #2
    b       tbb_start
tbb_dest2:                                          @ 0x0800025a
    mov     r0, #3
    b       tbb_start
tbb_dest3:                                          @ 0x08000260
    mov     r0, #4
    b       tbb_end
tbb_end:                                            @ 0x08000266

    @@@@@@@@
    mov     r0, #0

tbh_start:                                          @ 0x0800026a
    tbh     [pc, r0, lsl #1]    @ 32-bit (pc + 4)
tbh_table:                                          @ 0x0800026e
    .hword  4                   @ + (4 * 2) bytes
    .hword  7                   @ + (7 * 2) bytes
    .hword  10
    .hword  13
tbh_dest0:                                          @ 0x08000276
    mov     r0, #1              @ 4 bytes
    b       tbh_start           @ 2 bytes
tbh_dest1:                                          @ 0x0800027c
    mov     r0, #2
    b       tbh_start
tbh_dest2:                                          @ 0x08000282
    mov     r0, #3
    b       tbh_start
tbh_dest3:                                          @ 0x08000288
    mov     r0, #4
    b       tbh_end
tbh_end:                                            @ 0x0800028e

    @@@@@@@@
    bx      lr

