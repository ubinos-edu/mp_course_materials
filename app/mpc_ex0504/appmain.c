/*
 * Copyright (c) 2022 Sung Ho Park and CSOS
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <ubinos_config.h>

#include <stdio.h>

static char msgstr[] = "Hello World!\n"; // Define a null-terminated string

int appmain(int argc, char * argv[])
{
    printf(msgstr);

    return 0;
}

