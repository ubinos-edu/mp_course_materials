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
    .globl  memset_simple
    .type   memset_simple, %function
memset_simple:

    /* memset_simple.h 에서 정의된 함수, memset_simple 를 구현하라. */

    bx lr
