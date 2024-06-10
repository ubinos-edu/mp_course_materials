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

static void init_buf(void)
{
    for (uint32_t i = 0; i < BUF_SIZE; i++)
    {
        buf_1[i] = i % 0xff;
        buf_2[i] = i % 0xff;
    }
}

static void check_result(void * target_buf, void * result)
{
    printf("        check data: ");
    if (memcmp(buf_1, buf_2, BUF_SIZE) == 0)
    {
        printf("success\n");
    }
    else
    {
        printf("fail\n");
    }
    printf("        check return value: ");
    if (result == target_buf)
    {
        printf("success\n");
    }
    else
    {
        printf("fail\n");
    }

    printf("\n");
}

int appmain(int argc, char * argv[])
{
    void * result;
    void * target_buf;
    void * ref_buf;
    size_t size;
    uint8_t data;

    printf("\n");

    printf("    Test 1: \n");
    init_buf();
    ref_buf = test_buf_1;
    target_buf = test_buf_2;
    size = TEST_BUF_SIZE;
    data = 7;
    result = memset(ref_buf, data, size);
    result = memset_simple(target_buf, data, size);
    check_result(target_buf, result);

    printf("    Test 2: \n");
    init_buf();
    ref_buf = test_buf_1;
    target_buf = test_buf_2;
    size = 3;
    data = 5;
    result = memset(ref_buf, data, size);
    result = memset_simple(target_buf, data, size);
    check_result(target_buf, result);

    printf("    Test 3: \n");
    init_buf();
    ref_buf = test_buf_1;
    target_buf = test_buf_2;
    size = 0;
    data = 6;
    result = memset(ref_buf, data, size);
    result = memset_simple(target_buf, data, size);
    check_result(target_buf, result);

    printf("    Test 4: \n");
    init_buf();
    ref_buf = test_buf_1;
    target_buf = test_buf_2;
    ref_buf = &test_buf_1[1];
    target_buf = &test_buf_2[1];
    size = 6;
    data = 9;
    result = memset(ref_buf, data, size);
    result = memset_simple(target_buf, data, size);
    check_result(target_buf, result);

    printf("\n");
    fflush(stdout);

    return 0;
}
