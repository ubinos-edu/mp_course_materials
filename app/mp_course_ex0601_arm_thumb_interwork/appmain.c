/*
 * Copyright (c) 2022 Sung Ho Park and CSOS
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <ubinos_config.h>

static void arm_caller_func();
static void arm_callee_func();
static void thumb_caller_func();
static void thumb_callee_func();

int appmain(int argc, char * argv[])
{
    arm_caller_func();
    thumb_caller_func();

    return 0;
}

#pragma GCC push_options
#pragma GCC target ("arm")
void arm_caller_func()
{
    arm_callee_func();
    thumb_callee_func();

    return;
}
void arm_callee_func()
{
    return;
}
#pragma GCC pop_options

#pragma GCC push_options
#pragma GCC target ("thumb")
void thumb_caller_func()
{
    arm_callee_func();
    thumb_callee_func();

    return;
}
void thumb_callee_func()
{
    return;
}
#pragma GCC pop_options

