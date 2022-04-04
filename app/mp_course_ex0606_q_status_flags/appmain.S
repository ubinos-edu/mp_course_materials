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
    @@@@
    @ saturation for signed value: 32767 (0x 0000 7fff) to -32768 (0x ffff 8000)
    mov     r0, #0
    msr     apsr, r0
    ldr     r1, =0x00020000 @ 131072
    ssat    r0, #16, r1     @ V = 1, r0 = 0x 0000 7fff (32767)

    mov     r0, #0
    msr     apsr, r0
    ldr     r1, =0x00008000 @ 32768
    ssat    r0, #16, r1     @ V = 1, r0 = 0x 0000 7fff (32767)

    mov     r0, #0
    msr     apsr, r0
    ldr     r1, =0x00007fff @ 32767
    ssat    r0, #16, r1     @ V = 0, r0 = 0x 0000 7fff (32767)

    mov     r0, #0
    msr     apsr, r0
    ldr     r1, =0xffff8000 @ -32768
    ssat    r0, #16, r1     @ V = 0, r0 = 0x ffff 8000 (-32768)

    mov     r0, #0
    msr     apsr, r0
    ldr     r1, =0xffff7fff @ -32769
    ssat    r0, #16, r1     @ V = 1, r0 = 0x ffff 8000 (-32768)

    mov     r0, #0
    msr     apsr, r0
    ldr     r1, =0xfffe0000 @ -131072
    ssat    r0, #16, r1     @ V = 1, r0 = 0x ffff 8000 (-32768)

    @@@@
    @ saturation for unsigned value: 65535 (0x 0000 ffff) to 0 (0x 0000 0000)
    mov     r0, #0
    msr     apsr, r0
    ldr     r1, =0x00020000 @ 131072
    usat    r0, #16, r1     @ V = 1, r0 = 0x 0000 ffff (65535)

    mov     r0, #0
    msr     apsr, r0
    ldr     r1, =0x0000ffff @ 65535
    usat    r0, #16, r1     @ V = 0, r0 = 0x 0000 ffff (65535)

    mov     r0, #0
    msr     apsr, r0
    ldr     r1, =0x00000000 @ 0
    usat    r0, #16, r1     @ V = 0, r0 = 0x 0000 0000 (0)

    mov     r0, #0
    msr     apsr, r0
    ldr     r1, =0xffffffff @ -1
    usat    r0, #16, r1     @ V = 1, r0 = 0x 0000 0000 (0)

    mov     r0, #0
    msr     apsr, r0
    ldr     r1, =0xfffe0000 @ -131072
    usat    r0, #16, r1     @ V = 1, r0 = 0x 0000 0000 (0)

    @@@@
    bx      lr

