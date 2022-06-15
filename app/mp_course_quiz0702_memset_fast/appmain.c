/*
 * Copyright (c) 2022 Sung Ho Park and CSOS
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <ubinos_config.h>

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "memset_fast.h"

#define TEST_BUF_SIZE   64

uint8_t test_buf_1[TEST_BUF_SIZE];
uint8_t test_buf_2[TEST_BUF_SIZE];

int appmain(int argc, char * argv[])
{
    uint8_t * test_ptr_2;
    uint32_t test_offset;
    uint32_t test_size;

    for (int step = 0; step <= 3 ; step++)
    {
        switch (step)
        {
        case 0:
            test_offset = 8;
            test_size = 32;
            break;
        case 1:
            test_offset = 9;
            test_size = 31;
            break;
        case 2:
            test_offset = 10;
            test_size = 31;
            break;
        case 3:
            test_offset = 8;
            test_size = 35;
            break;
        }

        printf("Test %d: ", step);

        for (uint32_t i = 0; i < TEST_BUF_SIZE; i++)
        {
            test_buf_1[i] = i & 0x000000ff;
            test_buf_2[i] = i & 0x000000ff;
        }

        memset(&test_buf_1[test_offset], 7, test_size);

        test_ptr_2 = memset_fast(&test_buf_2[test_offset], 7, test_size);

        if (test_ptr_2 != &test_buf_2[test_offset])
        {
            printf("fail\n");
            continue;
        }

        if (memcmp(test_buf_1, test_buf_2, TEST_BUF_SIZE) != 0)
        {
            printf("fail\n");
            continue;
        }

        printf("success\n");
    }

    return 0;
}
