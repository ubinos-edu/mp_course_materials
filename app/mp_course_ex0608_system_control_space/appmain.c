/*
 * Copyright (c) 2022 Sung Ho Park and CSOS
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <ubinos/bsp.h>
#include <ubinos/ubiclib.h>

#include <stdio.h>
#include <stdlib.h>

#include <ubinos/bsp/arch.h>

int appmain(int argc, char * argv[])
{
    printf("SCnSCB                      = 0x%08x\n", (unsigned int) SCnSCB);
    printf("SCB                         = 0x%08x\n", (unsigned int) SCB);
    printf("    SCB->CCR                = 0x%08x\n", (unsigned int) &(SCB->CCR));
    printf("SysTick                     = 0x%08x\n", (unsigned int) SysTick);
    printf("NVIC                        = 0x%08x\n", (unsigned int) NVIC);
    printf("ITM                         = 0x%08x\n", (unsigned int) ITM);
    printf("DWT                         = 0x%08x\n", (unsigned int) DWT);
    printf("TPI                         = 0x%08x\n", (unsigned int) TPI);
    printf("CoreDebug                   = 0x%08x\n", (unsigned int) CoreDebug);

    return 0;
}

