/*
 * Copyright (c) 2022 Sung Ho Park and CSOS
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <ubinos.h>
#include <ubinos/bsp/arch.h>

#include <stdio.h>
#include <stdlib.h>

int appmain(int argc, char * argv[])
{
    int r;
    unsigned int clockfreqk = 0;
    unsigned int counter = 0;
    unsigned int tickpersec = 100;

    __disable_irq();

    r = bsp_getmckfreqk(&clockfreqk);
    ubi_assert(r == 0);

    counter = (clockfreqk * 1000 / tickpersec) - 1;
    ubi_assert((SysTick_LOAD_RELOAD_Msk - 1) >= counter);

    r = SysTick_Config(counter);
    ubi_assert(r == 0);

    __enable_irq();

    while(1)
    {
    }

    return 0;
}

uint32_t _g_tick_count = 0;

void SysTick_Handler(void)
{
    _g_tick_count++;
}

