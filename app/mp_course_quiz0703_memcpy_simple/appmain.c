/*
 * Copyright (c) 2022 Sung Ho Park and CSOS
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <ubinos_config.h>

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "memcpy_simple.h"

#define TEST_BUF_SIZE 8

uint8_t test_buf_1[TEST_BUF_SIZE];
uint8_t test_buf_2[TEST_BUF_SIZE];

static void print_test_buf(void)
{
    printf("test_buf_1: 0x");
    for (uint32_t i = 0; i < TEST_BUF_SIZE; i++)
    {
        printf(" %02x", test_buf_1[i]);
    }
    printf("\n");

    printf("test_buf_2: 0x");
    for (uint32_t i = 0; i < TEST_BUF_SIZE; i++)
    {
        printf(" %02x", test_buf_2[i]);
    }
    printf("\n");
}

int appmain(int argc, char * argv[])
{
    for (uint32_t i = 0; i < TEST_BUF_SIZE; i++)
    {
        test_buf_1[i] = i % 0xff;
        test_buf_2[i] = 0;
    }

    printf("\n");

    printf("Before memcpy_simple\n");
    print_test_buf();
    printf("\n");

    memcpy_simple(test_buf_2, test_buf_1, TEST_BUF_SIZE);

    printf("After memcpy_simple\n");
    print_test_buf();
    printf("\n");

    if (memcmp(test_buf_1, test_buf_2, TEST_BUF_SIZE) == 0)
    {
        printf("success\n");
    }
    else
    {
        printf("fail\n");
    }

    return 0;
}
