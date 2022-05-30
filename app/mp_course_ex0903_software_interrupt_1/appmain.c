/*
 * Copyright (c) 2022 Sung Ho Park and CSOS
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <ubinos.h>
#include <ubinos/bsp/arch.h>

#include <stdio.h>
#include <stdlib.h>

#include "stm32f4xx_ll_bus.h"
#include "stm32f4xx_ll_system.h"
#include "stm32f4xx_ll_rcc.h"
#include "stm32f4xx_ll_tim.h"

int appmain(int argc, char * argv[])
{
    int r;
    unsigned int clockfreqk = 0;

    __disable_irq();

    r = bsp_getmckfreqk(&clockfreqk);
    ubi_assert(r == 0);

    uint32_t SystemCoreClock = clockfreqk;
    uint32_t TimOutClock;
    uint32_t InitialAutoreload;
    uint32_t PriorityGroup = 4;
    uint32_t PreemptPriority = 6;
    uint32_t Subpriority = 1;
    uint32_t EncodedPriority = 0;

    /* Enable the timer peripheral clock */
    LL_APB1_GRP1_EnableClock(LL_APB1_GRP1_PERIPH_TIM2); 
    
    /* Set counter mode */
    /* Reset value is LL_TIM_COUNTERMODE_UP */
    //LL_TIM_SetCounterMode(TIM2, LL_TIM_COUNTERMODE_UP);

    /* Set the pre-scaler value to have TIM2 counter clock equal to 10 kHz      */
    /*
        In this example TIM2 input clock (TIM2CLK)  is set to APB1 clock (PCLK1),
        since APB1 prescaler is equal to 1.
        TIM2CLK = PCLK1
        PCLK1 = HCLK
        => TIM2CLK = HCLK = SystemCoreClock
    */
    LL_TIM_SetPrescaler(TIM2, __LL_TIM_CALC_PSC(SystemCoreClock, 10000));
    
    /* Set the auto-reload value to have an initial update event frequency of 10 Hz */
        /* TIM2CLK = SystemCoreClock / (APB prescaler & multiplier)                 */
    TimOutClock = SystemCoreClock/4;
    InitialAutoreload = __LL_TIM_CALC_ARR(TimOutClock, LL_TIM_GetPrescaler(TIM2), 10);
    LL_TIM_SetAutoReload(TIM2, InitialAutoreload);
    
    /* Enable the update interrupt */
    LL_TIM_EnableIT_UPDATE(TIM2);
    
    /* Configure the NVIC to handle TIM2 update interrupt */
    NVIC_SetPriorityGrouping(PriorityGroup);
    EncodedPriority = NVIC_EncodePriority(PriorityGroup, PreemptPriority, Subpriority);
    NVIC_SetPriority(TIM2_IRQn, EncodedPriority);
    NVIC_EnableIRQ(TIM2_IRQn);
    
    /* Enable counter */
    // LL_TIM_EnableCounter(TIM2);
    
    /* Force update generation */
    LL_TIM_GenerateEvent_UPDATE(TIM2);

    //
    PriorityGroup = 0;
    EncodedPriority = 0;
    PreemptPriority = 0;
    Subpriority = 0;

    PriorityGroup = NVIC_GetPriorityGrouping();
    EncodedPriority = NVIC_GetPriority(TIM2_IRQn);
    NVIC_DecodePriority(EncodedPriority, PriorityGroup, &PreemptPriority, &Subpriority);

    __enable_irq();

    while(1)
    {
        bsp_busywaitms(1000);

        NVIC_SetPendingIRQ(TIM2_IRQn);
        __DSB(); // Ensure transfer is completed
        __ISB(); // Ensure side effect of the write is visible
    }

    return 0;
}

uint32_t _g_tick_count = 0;

void TIM2_IRQHandler(void)
{
  /* Check whether update interrupt is pending */
  if(LL_TIM_IsActiveFlag_UPDATE(TIM2) == 1)
  {
    /* Clear the update interrupt flag*/
    LL_TIM_ClearFlag_UPDATE(TIM2);
  }
  
    _g_tick_count++;
}

