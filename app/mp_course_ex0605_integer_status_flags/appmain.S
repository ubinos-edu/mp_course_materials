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
    
int_data1:
    .word   4294967294      @ 0x ffff fffe
int_data2:
    .word   0x12345678
int_data3:
    .word   -2147483648     @ 0x 8000 0000
int_data4:
    .word   -2              @ 0x ffff fffe
int_data5:
    .word   2147483647      @ 0x 7fff ffff


    .text
    .thumb

    .thumb_func
    .align  1
    .globl  appmain
    .type   appmain, %function
appmain:
    @@@@
    @ N Set to 1 when the result of the operation was negative, cleared to 0 otherwise.
    
    mov     r0, #0
    msr     apsr, r0
    mov     r1, #1
    mov     r2, #2
    subs    r0, r1, r2  @ 1 - 2 = -1 (N=1, Z=0, C=0, V=0)
    adds    r0, r1, r2  @ 1 + 2 =  3 (N=0, Z=0, C=0, V=0)

    @@@@
    @ Z Set to 1 when the result of the operation was zero, cleared to 0 otherwise.
    
    mov     r0, #0
    msr     apsr, r0
    mov     r1, #2
    mov     r2, #2
    mov     r3, #1
    subs    r0, r1, r2  @ 2 - 2 = 0 (N=0, Z=1, C=1, V=0)
    subs    r0, r1, r3  @ 2 - 1 = 1 (N=0, Z=0, C=1, V=0)

    @@@@
    @ C Set to 1 when the operation resulted in a carry, cleared to 0 otherwise.

    @    If the result of an addition is greater than or equal to 2^32 (0x 1 0000 0000 = 4294967296) (carry (unsigned overflow))
    mov     r0, #0
    msr     apsr, r0
    ldr     r3, =int_data1
    ldr     r1, [r3, #0] @ 4294967294 (0x ffff fffe)
    mov     r2, #3
    mov     r3, #1
    adds    r0, r1, r2   @ 4294967294 (0x ffff fffe) + 3 (0x 0000 0003) = 4294967297 (0x 1 0000 0001) (N=0, Z=0, C=1, V=0) (carry (unsigned overflow))
    adds    r0, r1, r3   @ 4294967294 (0x ffff fffe) + 1 (0x 0000 0001) = 4294967295 (0x   ffff ffff) (N=1, Z=0, C=0, V=0) (no carry (not unsigned overflow))

    @     If the result of a subtraction is positive or zero (not borrow (not unsigned underflow))
    mov     r0, #0
    msr     apsr, r0
    mov     r1, #2
    mov     r2, #1
    subs    r0, r1, r2  @ 2 (0x   0000 0002) + -1 (0x ffff ffff) =  1 (0x 1 0000 0001) (N=0, Z=0, C=1, V=0) (not borrow (not unsigned underflow))
    subs    r0, r2, r1  @ 1 (0x   0000 0001) + -2 (0x ffff fffe) = -1 (0x   ffff ffff) (N=1, Z=0, C=0, V=0) (borrow (unsigned underflow))
                        @   (0x 1 0000 0001) -    (0x 0000 0002) =    (0x   ffff ffff) 

    @     As the result of an inline barrel shifter operation in a move or logical instruction (lsl: logical shift left).
    mov     r0, #0
    msr     apsr, r0
    ldr     r3, =int_data2 @ 0x12345678
    ldr     r1, [r3, #0]
    movs    r0, r1, lsl #4 @ 0x 1234 5678 << 4 = 0x 1 2345 6780 (N=0, Z=0, C=1, V=0)

    @@@@
    @ V Set to 1 when the operation caused overflow, cleared to 0 otherwise (signed overflow)

    @     If adding two negative values results in a positive value 
    mov     r0, #0
    msr     apsr, r0
    ldr     r3, =int_data3 @ -2147483648 (0x 8000 0000)
    ldr     r1, [r3, #0]
    ldr     r3, =int_data4 @ -2 (0x ffff fffe)
    ldr     r2, [r3, #0]
    adds    r0, r1, r2 @ -2147483648 (0x 8000 0000) + -2 (0x ffff fffe) = 2147483646 (0x 1 7fff fffe) (N=0, Z=0, C=1, V=1)

    @    If adding two positive values results in a negative value 
    mov     r0, #0
    msr     apsr, r0
    ldr     r3, =int_data5 @ 2147483647 (0x 7fff ffff)
    ldr     r1, [r3, #0]
    mov     r2, #2
    adds    r0, r1, r2 @ 2147483647 (0x 7fff ffff) + 2 (0x 0000 0002) =  -2147483647 (0x 8000 0001) (N=1, Z=0, C=0, V=1)

    @     If subtracting a positive value from a negative value generates a positive value

    mov     r0, #0
    msr     apsr, r0
    ldr     r3, =int_data3 @ -2147483648 (0x 8000 0000)
    ldr     r1, [r3, #0]
    mov     r2, #2
    subs    r0, r1, r2 @ -2147483648 (0x 8000 0000) + -2 (0x ffff fffe) = 2147483646 (0x 1 7fff fffe) (N=0, Z=0, C=1, V=1)
 
    @      If subtracting a negative value from a positive value generates a negative value
    mov     r0, #0
    msr     apsr, r0
    ldr     r3, =int_data5 @ 2147483647 (0x 7fff ffff) 
    ldr     r1, [r3, #0]
    ldr     r3, =int_data4 @ -2 (0x ffff fffe)
    ldr     r2, [r3, #0]
    subs    r0, r1, r2 @ 2147483647 (0x 7fff ffff) + --2 (0x 0000 0002) = -2147483647 (0x 8000 0001) (N=1, Z=0, C=0, V=1)

    bx      lr

