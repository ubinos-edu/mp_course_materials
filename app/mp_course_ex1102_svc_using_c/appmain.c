/*
 * Copyright (c) 2022 Sung Ho Park and CSOS
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <ubinos_config.h>

#include <stdio.h>
#include <stdlib.h>

void SVC_Handler_main(unsigned int * svc_args);

int appmain(int argc, char * argv[])
{
    __asm__ __volatile__ (
        "mov     r0, #0x11111111        \n\t"
        "mov     r1, #0x22222222        \n\t"
        "push    {r0, r1}               \n\t"

        "mov     r0,  #0x1000           \n\t"
        "mov     r1,  #0x1001           \n\t"
        "mov     r2,  #0x1002           \n\t"
        "mov     r3,  #0x1003           \n\t"

        "svc     #0xe                   \n\t"

        "pop     {r0, r1}               \n\t"
    );

    return 0;
}

void __attribute__((naked)) SVC_Handler(void)
{
    __asm__ __volatile__ (
        "tst    lr, #4                  \n\t" // Test bit (bitwise AND) 2 of EXC_RETURN
        "ite    eq                      \n\t"
        "mrseq  r0, msp                 \n\t" // if 0, stacking used msp, copy to r0
        "mrsne  r0, psp                 \n\t" //  if 1, stacking used psp, copy to r0
        "b      SVC_Handler_main        \n\t"
    );
}

void SVC_Handler_main(unsigned int * svc_args)
{
    uint8_t svc_number;
    uint32_t stacked_r0, stacked_r1, stacked_r2, stacked_r3;
    (void) svc_number;
    (void) stacked_r0;
    (void) stacked_r1;
    (void) stacked_r2;
    (void) stacked_r3;

    svc_number = ((char *) svc_args[6])[-2]; //Memory[(Stacked PC)-2]
    stacked_r0 = svc_args[0];
    stacked_r1 = svc_args[1];
    stacked_r2 = svc_args[2];
    stacked_r3 = svc_args[3];

    // other processing
    // ...

    // Return result (e.g. sum of first two arguments)
    svc_args[0] = stacked_r0 + stacked_r1;
    return;
}

