/*
 * Copyright (c) 2022 Sung Ho Park and CSOS
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <ubinos_config.h>
#include <ubinos/bsp/arch.h>

#include <stdio.h>
#include <stdlib.h>

// Define SVC functions
int __attribute__((naked)) svc_service_add(int x, int y) // Service #0 : Add
{
    __asm__ __volatile__ (
        "svc        #0x00               \n\t"
        "bx         lr                  \n\t"
    );
}

int __attribute__((naked)) svc_service_sub(int x, int y) // Service #1 : Sub
{
    __asm__ __volatile__ (
        "svc        #0x01               \n\t"
        "bx         lr                  \n\t"
    );
}

int __attribute__((naked)) svc_service_incr(int x) // Service #2 : Incr
{
    __asm__ __volatile__ (
        "svc        #0x02               \n\t"
        "bx         lr                  \n\t"
    );
}

void SVC_Handler_main(unsigned int * svc_args);

int appmain(int argc, char * argv[])
{
    int x, y, z;

    x = 3; y = 5;
    z = svc_service_add(x, y);
    printf ("3+5 = %d \n", z);

    x = 9; y = 2;
    z = svc_service_sub(x, y);
    printf ("9-2 = %d \n", z);

    x = 3;
    z = svc_service_incr(x);
    printf ("3++ = %d \n", z);

    return 0;
}

void SVC_Handler_main(unsigned int * svc_args)
{
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
    case 0:
        svc_args[0] = svc_args[0] + svc_args[1];
        break;
    case 1:
        svc_args[0] = svc_args[0] - svc_args[1];
        break;
    case 2:
        svc_args[0] = svc_args[0] + 1;
        break;
    default: // Unknown SVC request
        break;
    }

    return;
}

void __attribute__((naked)) SVC_Handler(void)
{
    __asm__ __volatile__ (
        "tst    lr, #4                  \n\t" // Test bit (bitwise AND) 2 of EXC_RETURN
        "ite    eq                      \n\t"
        "mrseq  r0, msp                 \n\t" // if 0, stacking used msp, copy to r0
        "mrsne  r0, psp                 \n\t" // if 1, stacking used psp, copy to r0
        "b      SVC_Handler_main        \n\t"
    );
}
