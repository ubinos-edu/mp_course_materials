/*
 * Copyright (c) 2022 Sung Ho Park and CSOS
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <ubinos_config.h>

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "memset_simple.h"

#define TEST_BUF_MARGIN 8
#define TEST_BUF_SIZE 16

#define BUF_SIZE (TEST_BUF_MARGIN + TEST_BUF_SIZE + TEST_BUF_MARGIN)
#define TEST_BUF_OFFSET 3

__attribute__((aligned(16))) uint8_t buf_1[BUF_SIZE];
__attribute__((aligned(16))) uint8_t buf_2[BUF_SIZE];

uint8_t * test_buf_1 = &buf_1[TEST_BUF_MARGIN + TEST_BUF_OFFSET];
uint8_t * test_buf_2 = &buf_2[TEST_BUF_MARGIN + TEST_BUF_OFFSET];

int appmain(int argc, char * argv[])
{
    void * result;

    for (uint32_t i = 0; i < BUF_SIZE; i++)
    {
        buf_1[i] = i % 0xff;
        buf_2[i] = i % 0xff;
    }

    memset(test_buf_1, 7, TEST_BUF_SIZE);

    result = memset_simple(test_buf_2, 7, TEST_BUF_SIZE);

    if (memcmp(buf_1, buf_2, BUF_SIZE) == 0 && result == test_buf_2)
    {
        printf("\n\n    success\n\n");
    }
    else
    {
        printf("\n\n    fail\n\n");
    }

    return 0;
}
