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
    NVIC_SetPriorityGrouping(0);
    NVIC_SetPriority(TIM3_IRQn, 8);
    NVIC_EnableIRQ(TIM3_IRQn);
    __enable_irq();

    // void NVIC_EnableIRQ (IRQn_Type IRQn) Enable an external interrupt
    // void NVIC_DisableIRQ (IRQn_Type IRQn) Disable an external interrupt
    // void NVIC_SetPriority (IRQn_Type IRQn, uint32_t priority)  Set the priority of an interrupt
    // void __enable_irq(void) Clear PRIMASK to enable interrupts
    // void __disable_irq(void) Set PRIMASK to disable all interrupts
    // void NVIC_SetPriorityGrouping(uint32_t PriorityGroup)

    // printf("SCnSCB                      = 0x%08x\n", (unsigned int) SCnSCB);
    // printf("SCB                         = 0x%08x\n", (unsigned int) SCB);
    // printf("    SCB->CCR                = 0x%08x\n", (unsigned int) &(SCB->CCR));
    // printf("SysTick                     = 0x%08x\n", (unsigned int) SysTick);
    // printf("NVIC                        = 0x%08x\n", (unsigned int) NVIC);
    // printf("ITM                         = 0x%08x\n", (unsigned int) ITM);
    // printf("DWT                         = 0x%08x\n", (unsigned int) DWT);
    // printf("TPI                         = 0x%08x\n", (unsigned int) TPI);
    // printf("CoreDebug                   = 0x%08x\n", (unsigned int) CoreDebug);

    return 0;
}

