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
    
int_data6:
    .word   0x00020000
int_data7:
    .word   0x00007fff
int_data8:
    .word   0xffff8000      @ - 0x 0000 8000
int_data9:
    .word   0xfffe0000      @ - 0x 0002 0000


    .text
    .thumb

    .thumb_func
    .align  1
    .globl  appmain
    .type   appmain, %function
appmain:
    @@@@
    @ Sticky saturation flag: 32767 (0x 0000 7fff) to -32768 (0x ffff 8000)
    mov     r0, #0
    msr     apsr, r0
    ldr     r3, =int_data6 @ 0x 0002 0000
    ldr     r1, [r3, #0]
    ssat    r0, #16, r1

    mov     r0, #0
    msr     apsr, r0
    ldr     r3, =int_data7 @ 0x 0000 7fff
    ldr     r1, [r3, #0]
    ssat    r0, #16, r1

    mov     r0, #0
    msr     apsr, r0
    ldr     r3, =int_data8 @ - 0x 0000 8000 (0x ffff 8000)
    ldr     r1, [r3, #0]
    ssat    r0, #16, r1

    mov     r0, #0
    msr     apsr, r0
    ldr     r3, =int_data9 @ - 0x 0002 0000 (0x fffe 0000)
    ldr     r1, [r3, #0]
    ssat    r0, #16, r1

    bx      lr

