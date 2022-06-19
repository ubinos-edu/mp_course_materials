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
word_array:     @ VSCode watch expression: ((int[6]) word_array),h
    .word   0x01020304, 0x11121314, 0x21222324, 0x31323334, 0x41424344, 0x51525354
word_array_2:   @ VSCode watch expression: ((int[6]) word_array_2),h
    .word          0x0,        0x0,        0x0,        0x0,        0x0,        0x0


    .text
    .thumb

    .thumb_func
    .align  1
    .globl  appmain
    .type   appmain, %function
appmain:
    push    {r4-r7}

    @@@@@@@@
    @ Memory access
    mov     r0, #0
    mov     r1, #0
    mov     r2, #0
    mov     r3, #0
    ldr     r6, =word_array
    ldr     r7, =word_array_2
    stmia   r7, {r0-r3}

    @@@@
    ldr     r0, [r6]
    str     r0, [r7]

    @@@@@@@@
    @ Memory access with imediate offset
    mov     r0, #0
    mov     r1, #0
    mov     r2, #0
    mov     r3, #0
    ldr     r6, =word_array
    ldr     r7, =word_array_2
    stmia   r7, {r0-r3}

    @@@@
    ldr     r0, [r6, #4]
    str     r0, [r7, #4]

    @@@@@@@@
    @ Memory access with imediate offset and write back
    mov     r0, #0
    mov     r1, #0
    mov     r2, #0
    mov     r3, #0
    ldr     r6, =word_array
    ldr     r7, =word_array_2
    stmia   r7, {r0-r3}

    @@@@
    ldr     r0, [r6, #4]!
    ldr     r1, [r6, #4]!
    str     r0, [r7, #4]!
    str     r1, [r7, #4]!

    @@@@@@@@
    @ Memory access with register offset
    mov     r0, #0
    mov     r1, #0
    mov     r2, #0
    mov     r3, #0
    ldr     r6, =word_array
    ldr     r7, =word_array_2
    stmia   r7, {r0-r3}
    mov     r5, #4

    @@@@
    ldr     r0, [r6, r5]
    str     r0, [r7, r5]

    @@@@@@@@
    @ Memory access with register offset and barrel shifter
    mov     r0, #0
    mov     r1, #0
    mov     r2, #0
    mov     r3, #0
    ldr     r6, =word_array
    ldr     r7, =word_array_2
    stmia   r7, {r0-r3}
    mov     r5, #4

    @@@@
    ldr     r0, [r6, r5, lsl #1]
    str     r0, [r7, r5, lsl #1]

    @@@@@@@@
    @ Memory access with post ingexing)
    mov     r0, #0
    mov     r1, #0
    mov     r2, #0
    mov     r3, #0
    ldr     r6, =word_array
    ldr     r7, =word_array_2
    stmia   r7, {r0-r3}

    @@@@
    ldr     r0, [r6], #4
    ldr     r1, [r6], #4
    str     r0, [r7], #4
    str     r1, [r7], #4

    @@@@@@@@
    @ Byte memory access
    mov     r0, #0
    mov     r1, #0
    mov     r2, #0
    mov     r3, #0
    ldr     r6, =word_array
    ldr     r7, =word_array_2
    stmia   r7, {r0-r3}

    @@@@
    ldrb    r0, [r6]
    strb    r0, [r7]

    @@@@@@@@
    @ Half word memory access
    mov     r0, #0
    mov     r1, #0
    mov     r2, #0
    mov     r3, #0
    ldr     r6, =word_array
    ldr     r7, =word_array_2
    stmia   r7, {r0-r3}

    @@@@
    ldrh    r0, [r6]
    strh    r0, [r7]

    @@@@@@@@
    @ Double word memory access
    mov     r0, #0
    mov     r1, #0
    mov     r2, #0
    mov     r3, #0
    ldr     r6, =word_array
    ldr     r7, =word_array_2
    stmia   r7, {r0-r3}

    @@@@
    ldrd    r0, r1, [r6]
    strd    r0, r1, [r7]

    @@@@@@@@
    @ Multiple memory access with increment after
    mov     r0, #0
    mov     r1, #0
    mov     r2, #0
    mov     r3, #0
    ldr     r6, =word_array
    ldr     r7, =word_array_2
    stmia   r7, {r0-r3}

    @@@@
    ldmia   r6, {r0-r3}
    stmia   r7, {r0-r3}

    @@@@@@@@
    @ Multiple memory access with increment after and write back
    mov     r0, #0
    mov     r1, #0
    mov     r2, #0
    mov     r3, #0
    ldr     r6, =word_array
    ldr     r7, =word_array_2
    stmia   r7, {r0-r3}

    @@@@
    ldmia   r6!, {r0-r1}
    ldmia   r6!, {r2-r3}
    stmia   r7!, {r0-r1}
    stmia   r7!, {r2-r3}

    @@@@@@@@
    @ Multiple memory access with decrement before
    mov     r0, #0
    mov     r1, #0
    mov     r2, #0
    mov     r3, #0
    ldr     r6, =word_array
    ldr     r7, =word_array_2
    stmia   r7, {r0-r3}
    add     r6, r6, #16
    add     r7, r7, #16

    @@@@
    ldmdb   r6, {r0-r3}
    stmdb   r7, {r0-r3}

    @@@@@@@@
    pop     {r4-r7}
    bx      lr
