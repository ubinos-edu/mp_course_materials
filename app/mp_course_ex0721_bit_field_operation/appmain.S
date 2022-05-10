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
    @ Clear bit field within a register
    @ BFC <Rd>, <#lsb>, <#width>
    ldr     r0, =0x1234ffff
    bfc     r0, #4, #8          @ clear r0[11:4]


    @@@@@@@@
    @ Insert bit field to a register
    @ BFI <Rd>, <Rn>, <#lsb>, <#width>
    ldr     r0, =0x12345678
    ldr     r1, =0x33ffaacc
    bfi     r1, r0, #8, #16     @ insert r0[15:0] to r1[23:8]


    @@@@@@@@
    @ Count leading zero
    @ CLZ Rd, Rm
    ldr     r0, =0x12345678     @ b 0001 0010 ....
    clz     r1, r0


    @@@@@@@@
    @ Reverse bit order in register
    @ RBIT <Rd>, <Rn>
    ldr     r0, =0xb4e10c23     @  1011 0100 1110 0001 0000 1100 0010 0011
    rbit    r1, r0


    @@@@@@@@
    @ Copy bit field from source register
    @ UBFX <Rd>, <Rn>, <#lsb>, <#width>
    ldr     r0, =0x5678abcd
    ldr     r1, =0x12345678
    ubfx    r1, r0, #4, #8      @ copy r0[11:4] to r1


    @@@@@@@@
    @ Copy bit field from source and sign extend it
    @ SBFX <Rd>, <Rn>, <#lsb>, <#width>
    ldr     r0, =0x5678abcd
    ldr     r1, =0x12345678
    sbfx    r1, r0, #4, #8      @ copy r0[11:4] to r1 and sign extend
    ldr     r1, =0x12345678
    sbfx    r1, r0, #16, #8     @ copy r0[23:16] to r1 and sign extend


    @@@@@@@@
    bx      lr

