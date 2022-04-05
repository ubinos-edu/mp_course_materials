/*
 * Copyright (c) 2022 Sung Ho Park and CSOS
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <ubinos/bsp.h>
#include <ubinos/ubiclib.h>

#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int a;
    int b;
    int c;
    int d;
} return_data_t;

static void func01(void);
static int func02(void);
static int func03(int p1);
static int func04(int p1, int p2);
static int func05(int p1, int p2, int p3, int p4, int p5);
static return_data_t func06(void);

static void func01(void)
{
}

static int func02(void)
{
    return 0;
}

static int func03(int p1)
{
    return p1;
}

static int func04(int p1, int p2)
{
    int r = -1;

    r = p1 + p2;

    return r;
}

static int func05(int p1, int p2, int p3, int p4, int p5)
{
    int r = -1;

    r = p1 + p2 + p3 + p4 + p5;

    return r;
}

static return_data_t func06(void)
{
    return_data_t data;

    data.a = 1;
    data.b = 2;
    data.c = 3;
    data.d = 4;

    return data;
}

int appmain(int argc, char * argv[])
{
    int r = 0;
    return_data_t data;

    func01();
    func02();

    r = func03(1);
    printf("result = %d\n", r);

    r = func04(1, 2);
    printf("result = %d\n", r);

    r = func05(1, 2, 3, 4, 5);
    printf("result = %d\n", r);

    data = func06();
    printf("result = %d, %d, %d, %d\n", data.a, data.b, data.c, data.d);

    return 0;
}

