/*
 * Copyright (c) 2022 Sung Ho Park and CSOS
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#ifndef MEMCPY_SIMPLEL_H_
#define MEMCPY_SIMPLEL_H_

#ifdef	__cplusplus
extern "C"
{
#endif

#include <stdint.h>
#include <stddef.h>

/*!
 * 메모리 영역을 복사한다.
 *
 * @param   destination 복사될 메모리 영역 주소<br>
 *
 * @param   source      복사할 메모리 영역 주소<br>
 *
 * @param   size        복사할 메모리 영역 크기 (바이트 단위)<br>
 *          <br>
 *
 * @return  destination<br>
 */
void * memcpy_simple(void * destination, void * source, size_t size);


#ifdef	__cplusplus
}
#endif

#endif /* MEMCPY_SIMPLEL_H_ */
