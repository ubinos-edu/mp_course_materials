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

SCnSCB_Type * _g_scnscb = SCnSCB;
SCB_Type * _g_scb = SCB;
SysTick_Type * _g_systick = SysTick;
NVIC_Type * _g_nvic = NVIC;
ITM_Type * _g_itm = ITM;
DWT_Type * _g_dwt = DWT;
TPI_Type * _g_tpi = TPI;
CoreDebug_Type * _g_coredebug = CoreDebug;

void asm_test_01(void);
void asm_test_02(void);
void asm_test_03(void);
void asm_test_04(void);
void asm_test_05(void);
void asm_test_06(void);
void asm_test_07(void);
void asm_test_08(void);
void asm_test_09(void);
void asm_test_10(void);

int appmain(int argc, char * argv[])
{
    printf("\n\n\n");
    printf("================================================================================\n");
    printf("ex01 (build time: %s %s)\n", __TIME__, __DATE__);
    printf("================================================================================\n");
    printf("\n");
    printf("\n");

    printf("_g_nvic = %x\n", (unsigned int) _g_nvic);

    asm_test_01();
    asm_test_02();
    asm_test_03();
    asm_test_04();
    asm_test_05();
    asm_test_06();
    asm_test_07();
    asm_test_08();
    asm_test_09();

    for (unsigned int i = 0; ; i++) {
        printf("Hi, World! (%u)\n", i);
        bsp_busywaitms(1000);
    }

    return 0;
}

