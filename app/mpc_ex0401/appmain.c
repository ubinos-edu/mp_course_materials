/*
 * Copyright (c) 2022 Sung Ho Park and CSOS
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <ubinos_config.h>
#include <ubinos/bsp.h>
#include <ubinos/bsp/arch.h>

#include <stdio.h>

SCnSCB_Type * _g_scnscb = SCnSCB;
SCB_Type * _g_scb = SCB;
SysTick_Type * _g_systick = SysTick;
NVIC_Type * _g_nvic = NVIC;
ITM_Type * _g_itm = ITM;
DWT_Type * _g_dwt = DWT;
TPI_Type * _g_tpi = TPI;
CoreDebug_Type * _g_coredebug = CoreDebug;

void GPIO_reset(GPIO_TypeDef* GPIOx)
{
    // Set all pins as analog input mode
    GPIOx->CRL = 0; // Bit 0 to 7, all set as analog input
    GPIOx->CRH = 0; // Bit 8 to 15, all set as analog input
    GPIOx->ODR = 0; // Default output value is 0
    return;
}

int appmain(int argc, char * argv[])
{
    printf("\n\n\n");
    printf("================================================================================\n");
    printf("ex01 (build time: %s %s)\n", __TIME__, __DATE__);
    printf("================================================================================\n");
    printf("\n");
    printf("\n");

    GPIO_reset(GPIOA); /* Reset GPIO A */

    uint32_t fpu_type = SCB_GetFPUType();
    printf("FPU Type = %lu\n", fpu_type);

    for (unsigned int i = 0; ; i++) {
        printf("Hi, World! (%u)\n", i);
        bsp_busywaitms(5000);
    }

    return 0;
}

