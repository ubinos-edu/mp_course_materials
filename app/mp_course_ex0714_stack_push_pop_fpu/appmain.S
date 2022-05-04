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
    vldr    s0, =0x3dcccccd @ 0.1
    vldr    s1, =0x3e4ccccd @ 0.2
    vldr    s2, =0x3e99999a @ 0.3
    vldr    s3, =0x3ecccccd @ 0.4
    vldr    s4, =0x3f000000 @ 0.5
    vldr    s5, =0x3f19999a @ 0.6
    vldr    s6, =0x3f333333 @ 0.7
    vldr    s7, =0x3f4ccccd @ 0.8

    @@@@
    vpush   {s0, s1-s7}

    @@@@@@@@
    vldr    s0, =0x00000000
    vldr    s1, =0x00000000
    vldr    s2, =0x00000000
    vldr    s3, =0x00000000
    vldr    s4, =0x00000000
    vldr    s5, =0x00000000
    vldr    s6, =0x00000000
    vldr    s7, =0x00000000

    @@@@
    vpop    {s0, s1-s7}

    @@@@@@@@
    bx     lr

