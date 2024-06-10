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
    .globl  memset_fast
    .type   memset_fast, %function
memset_fast:
    // memset_fast.h 에서 정의된 함수, memset_fast 를 구현하라.
    // 각 매개변수 전달을 위해 사용되는 레지스터
    //    void * buffer : r0
    //    int value     : r1
    //    size_t size   : r2

    cbz     r2, 4f              @ 크기가 0이면 label "4"로 분기
    movs    r3, r0              @ r3에 메모리 주소 복사
    bfi     r1, r1, #8, #8      @ Insert r1[ 7: 0] to r1[15: 8]
    bfi     r1, r1, #16, #16    @ Insert r1[15: 0] to r1[31:16]
1:
                                @ 메모리 주소가 4 바이트 단위로 정렬되어 있는지 검사 (r3[1:0]이 0인지 검사)
                                @ 정렬되어 있으면 label "2"로 분기
                                @ 메모리에 1 바이트를 채우고 주소 1 증가
                                @ 크기 1 감소
                                @ 크기가 0이면 label "4"로 분기
                                @ label "1"로 분기
2:
                                @ 크기가 4 미만인지 검사
                                @ 미만이면 label "3"으로 분기
                                @ 메모리에 4 바이트를 채우고 주소 4 증가
                                @ 크기 4 감소
                                @ 크기가 0이면 label "4"로 분기
                                @ label "2"로 분기
3:
                                @ 메모리에 1 바이트를 채우고 주소 1 증가
                                @ 크기 1 감소
                                @ 크기가 0이면 label "4"로 분기
                                @ label "3"으로 분기
4:

    // r0: return value
    bx      lr
