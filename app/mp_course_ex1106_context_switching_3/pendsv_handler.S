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
    // Enhanced version - assume floating point support

    // -------------------------
    // Save current context
    mrs     r0, psp                 // Get current process stack pointer value

    tst     lr, #0x10               // Test bit 4. If zero, need to stack floating point regs
    it      eq
    vstmdbeq    r0!, {s16-s31}      // Save floating point registers
    mov     r2, lr
    mrs     r3, control
    stmdb   r0!, {r2-r11}           // Save LR,CONTROL and R4 to R11 in task stack (10 regs)

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

    ldmia   r0!, {r2-r11}           // Load LR, CONTROL and R4 to R11 from task stack (10 regs)
    mov     lr, r2
    msr     control, r3
    isb
    tst     lr, #0x10               // Test bit 4. If zero, need to unstack floating point regs
    it      eq
    vldmiaeq    r0!, {s16-s31}      // Load floating point registers

    msr     psp, r0                 // Set PSP to next task

    bx      lr                      // Return
