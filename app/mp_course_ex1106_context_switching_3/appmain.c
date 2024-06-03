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
    Enhancement:
        * Support system call using SVC
        * Support FPU
*/

/*
    Context of task
        17 xPSR
        16 PC
        15 LR
        14 R12
        13 R3
        12 R2
        11 R1
        10 R0
        9  R11
        8  R10
        7  R9
        6  R8
        5  R7
        4  R6
        3  R5
        2  R4
        1  control
        0  exc_return

        or

        25 space
        24 fpscr
        23 s15
        ...
        19 s1
        18 s0
        17 xPSR
        16 PC
        15 LR
        14 R12
        13 R3
        12 R2
        11 R1
        10 R0
        9  R11
        8  R10
        7  R9
        6  R8
        5  R7
        4  R6
        3  R5
        2  R4
        1  control
        0  exc_return
 */

// Define SVC functions
int __attribute__((naked)) svc_service_yield(void)
{
    __asm__ __volatile__ (
        "svc        #0x00               \n\t"
        "bx         lr                  \n\t"
    );
}

int __attribute__((naked)) svc_service_os_start(void)
{
    __asm__ __volatile__ (
        "svc        #0x01               \n\t"
        "bx         lr                  \n\t"
    );
}

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
uint32_t svc_exc_return; // EXC_RETURN use by SVC

// -------------------------------------------------------------
// Start of main program
int appmain(int argc, char * argv[]) {
    // Enable double word stack alignment
    //     (recommended in Cortex-M3 r1p1, default in Cortex-M3 r2px and Cortex-M4)
    SCB->CCR |= SCB_CCR_STKALIGN_Msk;

    // Starting the task scheduler
    svc_service_os_start();

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
    uint32_t control;
    (void) control;

    float f1, f2;
    f1 = 1.0;
    f2 = 0.25;
    control = __get_CONTROL();
    f1 += f2;
    control = __get_CONTROL();
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
        svc_service_yield();
    };
}

// ------------------------------------------------------------
void reschedule(void)
{
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
}

// ------------------------------------------------------------
void os_start(void)
{
    uint32_t psp;
    (void) psp;

    // Create stack frame for task0
    PSP_array[0] = ((unsigned int) task0_stack) + (sizeof task0_stack) - 18*4;
    HW32_REG((PSP_array[0] + (16*4))) = (unsigned long) task0; // initial Program Counter
    HW32_REG((PSP_array[0] + (17*4))) = 0x01000000; // initial xPSR
    HW32_REG((PSP_array[0] + ( 1*4))) = 0x3;// initial CONTROL : unprivileged, PSP, no FP
    HW32_REG((PSP_array[0] )) = 0xFFFFFFFDUL; // initial EXC_RETURN

    // Create stack frame for task1
    PSP_array[1] = ((unsigned int) task1_stack) + (sizeof task1_stack) - 18*4;
    HW32_REG((PSP_array[1] + (16*4))) = (unsigned long) task1; // initial Program Counter
    HW32_REG((PSP_array[1] + (17*4))) = 0x01000000; // initial xPSR
    HW32_REG((PSP_array[1] + ( 1*4))) = 0x3; // initial CONTROL : unprivileged, PSP, no FP
    HW32_REG((PSP_array[1] )) = 0xFFFFFFFDUL; // initial EXC_RETURN

    // Create stack frame for task2
    PSP_array[2] = ((unsigned int) task2_stack) + (sizeof task2_stack) - 18*4;
    HW32_REG((PSP_array[2] + (16*4))) = (unsigned long) task2; // initial Program Counter
    HW32_REG((PSP_array[2] + (17*4))) = 0x01000000; // initial xPSR
    HW32_REG((PSP_array[2] + ( 1*4))) = 0x3; // initial CONTROL : unprivileged, PSP, no FP
    HW32_REG((PSP_array[2] )) = 0xFFFFFFFDUL; // initial EXC_RETURN

    // Create stack frame for task3
    PSP_array[3] = ((unsigned int) task3_stack) + (sizeof task3_stack) - 18*4;
    HW32_REG((PSP_array[3] + (16*4))) = (unsigned long) task3; // initial Program Counter
    HW32_REG((PSP_array[3] + (17*4))) = 0x01000000; // initial xPSR
    HW32_REG((PSP_array[3] + ( 1*4))) = 0x3; // initial CONTROL : unprivileged, PSP, no FP
    HW32_REG((PSP_array[3] )) = 0xFFFFFFFDUL; // initial EXC_RETURN

    curr_task = 0; // Switch to task #0 (Current task)

    svc_exc_return = HW32_REG((PSP_array[curr_task]));
    __set_PSP((PSP_array[curr_task] + 10*4)); // Return to thread with PSP

    psp = __get_PSP();

    NVIC_SetPriority(PendSV_IRQn, 0xFF); // Set PendSV to lowest possible priority

    unsigned int freqk;
    bsp_getcpuclockfreqk(&freqk);
    SysTick_Config(freqk); // 1000 Hz SysTick interrupt

    __set_CONTROL(0x1); // Switch to use unprivileged state
    __ISB(); // Execute ISB after changing CONTROL (architectural recommendation)
}

// ------------------------------------------------------------
void SysTick_Handler(void) // 1KHz
{
    uint32_t psp;
    (void) psp;

    psp = __get_PSP();

    // Increment systick counter for LED blinking
    systick_count++;

    reschedule();

    return;
}

void SVC_Handler_main(unsigned int * svc_args)
{
    uint32_t psp;
    (void) psp;

    psp = __get_PSP();

    // Stack frame contains:
    // r0, r1, r2, r3, r12, r14, the return address and xPSR
    // - Stacked R0 = svc_args[0]
    // - Stacked R1 = svc_args[1]
    // - Stacked R2 = svc_args[2]
    // - Stacked R3 = svc_args[3]
    // - Stacked R12 = svc_args[4]
    // - Stacked LR = svc_args[5]
    // - Stacked PC = svc_args[6]
    // - Stacked xPSR= svc_args[7]
    unsigned int svc_number;
    svc_number = ((char *)svc_args[6])[-2];

    switch(svc_number)
    {
    case 0: // svc_service_yield
        reschedule();
        break;
    case 1: // svc_service_os_start
        os_start();
        break;
    default: // Unknown SVC request
        break;
    }

    psp = __get_PSP();

    return;
}
