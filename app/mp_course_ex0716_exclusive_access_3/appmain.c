/*
 * Copyright (c) 2021 Sung Ho Park
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <ubinos.h>

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

#define INSERT_DELAY_BETWEEN_CHECK_LOCK_FLAG 1

static volatile int lock_flag = 0;
static char * task1_msg = "task1: hello world\n";
static char * task2_msg = "task2: hi world\n";

static void root_func(void * arg);
static void task1_func(void * arg);
static void task2_func(void * arg);

int appmain(int argc, char * argv[])
{
    int r;
    (void) r;

    r = task_create(NULL, root_func, NULL, task_getmiddlepriority() + 1, 0, "root");
    ubi_assert(r == 0);

    ubik_comp_start();

    return 0;
}

static void root_func(void * arg)
{
    int r;
    (void) r;

    printf("\n\n\n");
    printf("================================================================================\n");
    printf("mp course exclusive access 3 (build time: %s %s)\n", __TIME__, __DATE__);
    printf("================================================================================\n");
    printf("\n");

    srand(time(NULL));

    fflush(stdout);

    r = task_create(NULL, task1_func, NULL, task_getmiddlepriority(), 0, "task1");
    ubi_assert(r == 0);

    r = task_create(NULL, task2_func, NULL, task_getmiddlepriority(), 0, "task2");
    ubi_assert(r == 0);
}

static void task1_func(void * arg)
{
    unsigned int delayms;

    printf("\n");

    for (unsigned int i = 0; ; i++)
    {
        if (lock_flag == 0)
        {
#if (INSERT_DELAY_BETWEEN_CHECK_LOCK_FLAG == 1)
            bsp_busywaitms(2);
#endif
            lock_flag = 1;

            for (unsigned int j = 0; j < strlen(task1_msg); j++)
            {
                delayms = (rand() % 10 + 1) * 20;
                printf("%c", task1_msg[j]);
                task_sleepms(delayms);
            }

            lock_flag = 0;
        }

        task_sleepms(1);
    }
}

static void task2_func(void * arg)
{
    unsigned int delayms;

    printf("\n");

    for (unsigned int i = 0; ; i++)
    {
        if (lock_flag == 0)
        {
#if (INSERT_DELAY_BETWEEN_CHECK_LOCK_FLAG == 1)
            bsp_busywaitms(2);
#endif
            lock_flag = 1;
            
            for (unsigned int j = 0; j < strlen(task2_msg); j++)
            {
                delayms = (rand() % 10 + 1) * 20;
                printf("%c", task2_msg[j]);
                task_sleepms(delayms);
            }

            lock_flag = 0;
        }

        task_sleepms(1);
    }
}

