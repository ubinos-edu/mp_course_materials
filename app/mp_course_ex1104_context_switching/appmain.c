/*
 * Copyright (c) 2022 Sung Ho Park and CSOS
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <ubinos.h>
#include <ubinos/bsp/arch.h>

#include <stdio.h>
#include <stdlib.h>

/*
    Context of task
        15 xPSR
        14 PC
        13 LR
        12 R12
        11 R3
        10 R2
        9  R1
        8  R0
        7  R11
        6  R10
        5  R9
        4  R8
        3  R7
        2  R6
        1  R5
        0  R4
 */

// /* Macros for word accesses */
#define HW32_REG(ADDRESS) (*((volatile unsigned long *)(ADDRESS)))

void task0(void);
void task1(void);
void task2(void);
void task3(void);

// Event to tasks
uint32_t systick_count = 0;

// Stack for each task (8Kbytes each - 1024 x 4 bytes)
uint32_t task0_stack[1024] __attribute__ ((aligned (8)));
uint32_t task1_stack[1024] __attribute__ ((aligned (8)));
uint32_t task2_stack[1024] __attribute__ ((aligned (8)));
uint32_t task3_stack[1024] __attribute__ ((aligned (8)));

// Data use by OS
uint32_t curr_task=0; // Current task
uint32_t next_task=1; // Next task
uint32_t PSP_array[4]; // Process Stack Pointer for each task

// -------------------------------------------------------------
// Start of main program
int appmain(int argc, char * argv[]) {
    // Enable double word stack alignment
    //     (recommended in Cortex-M3 r1p1, default in Cortex-M3 r2px and Cortex-M4)
    SCB->CCR |= SCB_CCR_STKALIGN_Msk;

    // Starting the task scheduler

    // Create stack frame for task0
    PSP_array[0] = ((unsigned int) task0_stack) + (sizeof task0_stack) - 16*4;
    HW32_REG((PSP_array[0] + (14*4))) = (unsigned long) task0; // initial Program Counter
    HW32_REG((PSP_array[0] + (15*4))) = 0x01000000; // initial xPSR

    // Create stack frame for task1
    PSP_array[1] = ((unsigned int) task1_stack) + (sizeof task1_stack) - 16*4;
    HW32_REG((PSP_array[1] + (14*4))) = (unsigned long) task1; // initial Program Counter
    HW32_REG((PSP_array[1] + (15*4))) = 0x01000000; // initial xPSR

    // Create stack frame for task2
    PSP_array[2] = ((unsigned int) task2_stack) + (sizeof task2_stack) - 16*4;
    HW32_REG((PSP_array[2] + (14*4))) = (unsigned long) task2; // initial Program Counter
    HW32_REG((PSP_array[2] + (15*4))) = 0x01000000; // initial xPSR

    // Create stack frame for task3
    PSP_array[3] = ((unsigned int) task3_stack) + (sizeof task3_stack) - 16*4;
    HW32_REG((PSP_array[3] + (14*4))) = (unsigned long) task3; // initial Program Counter
    HW32_REG((PSP_array[3] + (15*4))) = 0x01000000; // initial xPSR

    curr_task = 0; // Switch to task #0 (Current task)

    __set_PSP((PSP_array[curr_task] + 16*4)); // Set PSP to top of task 0 stack

    NVIC_SetPriority(PendSV_IRQn, 0xFF); // Set PendSV to lowest possible priority

    unsigned int freqk;
    bsp_getcpuclockfreqk(&freqk);
    SysTick_Config(freqk); // 1000 Hz SysTick interrupt

    __set_CONTROL(0x3); // Switch to use Process Stack, unprivileged state
    __ISB(); // Execute ISB after changing CONTROL (architectural recommendation)

    task0(); // Start task 0

    while(1) {
        bsp_abortsystem(); // Should not be here
    };
}

// ------------------------------------------------------------
void task0(void)
{
    bsp_busywaitms(250 * 0);
    while (1) {
        printf("0\n");
        bsp_busywaitms(100);
    };
}
// ------------------------------------------------------------
void task1(void)
{
    bsp_busywaitms(250 * 1);
    while (1) {
        printf("1\n");
        bsp_busywaitms(100);
    };
}
// ------------------------------------------------------------
void task2(void)
{
    bsp_busywaitms(250 * 2);
    while (1) {
        printf("2\n");
        bsp_busywaitms(100);
    };
}

// ------------------------------------------------------------
void task3(void)
{
    bsp_busywaitms(250 * 3);
    while (1) {
        printf("3\n");
        bsp_busywaitms(100);
    };
}

// ------------------------------------------------------------
void SysTick_Handler(void) // 1KHz
{
    uint32_t psp = __get_PSP();
    (void) psp;

    // Increment systick counter for LED blinking
    systick_count++;

    // Simple task round robin scheduler
    switch (curr_task) {
        case (0):
            next_task = 1;
            break;
        case (1):
            next_task = 2;
            break;
        case (2):
            next_task = 3;
            break;
        case (3):
            next_task = 0;
            break;
        default:
            next_task = 0;
            bsp_abortsystem(); // Should not be here
            break;
    }

    if (curr_task!=next_task) { // Context switching needed
        SCB->ICSR |= SCB_ICSR_PENDSVSET_Msk; // Set PendSV to pending
    }

    return;
}
