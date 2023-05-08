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
lock_addr_1:
    .word   0x0


    .text
    .thumb

    .thumb_func
    .align  1
    .globl  appmain
    .type   appmain, %function
appmain:
    @@@@@@@@
    mov     r0, #0
    ldr     r1, =lock_addr_1
    str     r0, [r1]
    msr     apsr, r0

    @@@@
    mov     r2, #1          @ load the ‘lock taken’ value (0: free, 1: lock)
try1:
    ldrex   r0, [r1]        @ load the lock value
    cmp     r0, #0          @ is the lock free?
    itte    eq
    strexeq r0, r2, [r1]    @ try and claim the lock
    cmpeq   r0, #0          @ did this succeed?
    bne     try1            @ no, try again

    @@@@@@@@
    mov     r0, #0
    ldr     r1, =lock_addr_1
    str     r0, [r1]
    mov     r3, #0
    msr     apsr, r0

    @@@@
    mov     r2, #1          @ load the ‘lock taken’ value (0: free, 1: lock)
try2:
    ldrex   r0, [r1]        @ load the lock value
    svc     #15             @ <- execute other
    cmp     r0, #0          @ is the lock free?
    itte    eq
    strexeq r0, r2, [r1]    @ try and claim the lock
    cmpeq   r0, #0          @ did this succeed?
    bne     try2            @ no, try again

    @@@@@@@@
    mov     r0, #0
    ldr     r1, =lock_addr_1
    str     r0, [r1]
    mov     r3, #0
    msr     apsr, r0

    @@@@
    mov     r2, #1          @ load the ‘lock taken’ value (0: free, 1: lock)
try3:
    ldrex   r0, [r1]        @ load the lock value
    bl      func_a          @ <- execute other
    cmp     r0, #0          @ is the lock free?
    itte    eq
    strexeq r0, r2, [r1]    @ try and claim the lock
    cmpeq   r0, #0          @ did this succeed?
    bne     try3            @ no, try again

    @@@@@@@@
    bx      lr

    .thumb_func
    .align 1
    .globl func_a
    .type func_a, %function
func_a:
    clrex                   @ <- accessed
    bx      lr

    .thumb_func
    .align 1
    .globl SVC_Handler
    .type SVC_Handler, %function
SVC_Handler:
    bx      lr
