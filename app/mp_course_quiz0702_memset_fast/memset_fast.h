/*
 * Copyright (c) 2022 Sung Ho Park and CSOS
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#ifndef MEMSET_FAST_H_
#define MEMSET_FAST_H_

#ifdef	__cplusplus
extern "C"
{
#endif

#include <stdint.h>
#include <stddef.h>

/*!
 * 메모리 영역을 특정 값으로 채운다.
 * 
 * @param   buffer      채울 메모리 영역 시작 주소<br>
 * 
 * @param   value       채울 값<br>
 * 
 * @param   size        채울 메모리 영역 크기 (바이트 단위)<br>
 *          <br>
 *
 * @return  buffer<br>
 */
void * memset_fast(void * buffer, int value, size_t size);


#ifdef	__cplusplus
}
#endif

#endif /* MEMSET_FAST_H_ */
