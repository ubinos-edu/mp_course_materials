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

#define TEST_BUF_SIZE 8

uint8_t test_buf_1[TEST_BUF_SIZE];
uint8_t test_buf_2[TEST_BUF_SIZE];

int appmain(int argc, char * argv[])
{
    for (uint32_t i = 0; i < TEST_BUF_SIZE; i++)
    {
        test_buf_1[i] = i % 0xff;
        test_buf_2[i] = i % 0xff;
    }

    memset(test_buf_1, 7, TEST_BUF_SIZE);

    memset_simple(test_buf_2, 7, TEST_BUF_SIZE);

    if (memcmp(test_buf_1, test_buf_2, TEST_BUF_SIZE) == 0)
    {
        printf("\n\n    success\n\n");
    }
    else
    {
        printf("\n\n    fail\n\n");
    }

    return 0;
}
