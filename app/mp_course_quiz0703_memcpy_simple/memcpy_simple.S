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
    .globl  memcpy_simple
    .type   memcpy_simple, %function
memcpy_simple:
    /* memcpy_simple.h 에서 정의된 함수, memcpy_simple 를 구현하라. */
    // r0: void * destination, r1: void * source, r2: size_t size
    push    {r4}










    // r0: return value (void * destination)
    bx lr
