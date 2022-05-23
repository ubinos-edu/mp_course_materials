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
    @@@@@@@@
    ldr     r4, =0x40013800             @ SYSCFG->MEMRMP
    mov     r0, #0x0                    @ REMAPMEMORY_FLASH
    mov     r1, #0x1                    @ REMAPMEMORY_SYSTEMFLASH (SYSCFG_MEMRMP_MEM_MODE_0)
    mov     r2, #0x2                    @ REMAPMEMORY_SRAM (SYSCFG_MEMRMP_MEM_MODE_1)

    @@@@

    @@@@
    str     r1, [r4]

    @@@@
    str     r2, [r4]

    @@@@
    str     r0, [r4]

    @@@@@@@@
    bx      lr


