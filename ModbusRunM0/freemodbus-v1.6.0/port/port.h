/*
 * FreeModbus Libary: BARE Port
 * Copyright (C) 2006 Christian Walter <wolti@sil.at>
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 *
 * File: $Id: port.h ,v 1.60 2013/08/13 15:07:05 Armink add Master Functions $
 */

#ifndef _PORT_H
#define _PORT_H

//#include <stm32f10x_conf.h>
#include "mbconfig.h"
//#include <rthw.h>
//#include <rtthread.h>

#include <assert.h>
#include <inttypes.h>

#define	INLINE
#define PR_BEGIN_EXTERN_C           extern "C" {
#define	PR_END_EXTERN_C             }

//TODO  暂时先写B12引脚，等组网测试时再确认
#define SLAVE_RS485_SEND_MODE  	 // PD14=0;
#define SLAVE_RS485_RECEIVE_MODE  //PD15=1;
#define MASTER_RS485_SEND_MODE  
#define MASTER_RS485_RECEIVE_MODE  

#define ENTER_CRITICAL_SECTION()	EnterCriticalSection()
#define EXIT_CRITICAL_SECTION()    ExitCriticalSection()

void EnterCriticalSection(void);
void ExitCriticalSection(void);

typedef uint8_t BOOL;

typedef unsigned char UCHAR;
typedef char    CHAR;

typedef uint16_t USHORT;
typedef int16_t SHORT;

typedef uint32_t ULONG;
typedef int32_t LONG;

#ifndef TRUE
#define TRUE            1
#endif

#ifndef FALSE
#define FALSE           0
#endif
/*						MYSELF PROTOCOL FARME

		         0	1	  2		  3		4-5	 6-7   8-9	   10	11
主机发送：		FF AA  + ADDR + FUNC + STA + STO + CRC +   0D  0A
		        1B 1B   1B     1B	  2B	2B	  2B	  1B  1B	
		  	   	
从机应答：		FF AA  + ADDR + FUNC + data 【N字节】+ CRC + 0D  0A  

*/

/*use bt protocol ???yes define it or not .*/
#define _USE_BITTLE_PROTOCOL

#ifdef _USE_BITTLE_PROTOCOL	/*use bt protocol */
//slave addr
#define    BT_ADDR	  4
// farme data offset
#define    BT_DATA	  6
//function code offset
#define  BT_FUNC_OFFSET  0
#endif



#endif
