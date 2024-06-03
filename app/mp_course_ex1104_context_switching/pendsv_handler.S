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
    .align 1
    .globl PendSV_Handler
    .type PendSV_Handler, %function
PendSV_Handler:
    // Context switching code
    // Simple version - assume No floating point support

    // -------------------------
    // Save current context
    mrs     r0, psp                 // Get current process stack pointer value

    stmdb   r0!, {r4-r11}           // Save R4 to R11 in task stack (8 regs)

    ldr     r1, =curr_task
    ldr     r2, [r1]                // Get current task ID
    ldr     r3, =PSP_array
    str     r0, [r3, r2, lsl #2]    // Save PSP value into PSP_array

    // -------------------------
    // Load next context
    ldr     r4, =next_task
    ldr     r4, [r4]                // Get next task ID
    str     r4, [r1]                // Set curr_task = next_task
    ldr     r0, [r3, r4, lsl #2]    // Load PSP value from PSP_array

    ldmia   r0!, {r4-r11}           // Load R4 to R11 from taskstack (8 regs)

    msr     psp, r0                 // Set PSP to next task

    bx      lr                      // Return
