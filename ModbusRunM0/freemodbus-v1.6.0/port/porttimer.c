/*
 * FreeModbus Libary: STM32 Port
 * Copyright (C) 2013 Armink <armink.ztl@gmail.com>
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
 * File: $Id: porttimer.c,v 1.60 2013/08/13 15:07:05 Armink $
 */

/* ----------------------- Platform includes --------------------------------*/
#include "port.h"

/* ----------------------- Modbus includes ----------------------------------*/
#include "mb.h"
#include "mbport.h"
#include "M051Series.h"
/* ----------------------- static functions ---------------------------------*/
static void prvvTIMERExpiredISR(void);

static 	  USHORT  MBTimerout50us;
/* ----------------------- Start implementation -----------------------------*/
BOOL xMBPortTimersInit(USHORT usTim1Timerout50us)
{

/*	uint16_t PrescalerValue = 0;
	 MBTimerout50us= usTim1Timerout50us;
   CLK_EnableModuleClock(TMR0_MODULE);
    // Set timer frequency to 20KHZ	 (50us)
   CLK_SetModuleClock(TMR0_MODULE, CLK_CLKSEL1_TMR0SEL_PCLK, 0);
   //Trmclk_prescale=pclk/20000=84000000/20000
   //TIMER_SET_PRESCALE_VALUE(TIMER0, 0);
   TIMER_Open(TIMER0, TIMER_PERIODIC_MODE,20000);//20KHZ

    // Enable timer interrupt
    TIMER_EnableInt(TIMER0);
	NVIC_SetPriority(TMR0_IRQn, 3 ); //定时器的中断优先级应该比串口的低
    NVIC_EnableIRQ(TMR0_IRQn);


    // Stop Timer 0
   TIMER_Stop(TIMER0);
				   */
	 MBTimerout50us= usTim1Timerout50us;
	   /* Initial Timer1 TIMER_PERIODIC_MODE  setting   20kHZ*/
    TIMER_Open(TIMER1, TIMER_PERIODIC_MODE, 20000);
    TIMER_EnableInt(TIMER1);
	NVIC_SetPriority(TMR1_IRQn, 3 );
    /* Enable Timer1 NVIC */
    NVIC_EnableIRQ(TMR1_IRQn);
    /* Start Timer1 counting */
    TIMER_Start(TIMER1);
	return TRUE;
}

unsigned char Timehandel=0;	//定时器标志
int timecut=0;//计数器

void vMBPortTimersEnable()
{
	 Timehandel=1;//开始计时
	 timecut=0;
/*	TIMER_Open(TIMER0, TIMER_PERIODIC_MODE,20000);//20
    TIMER_EnableInt(TIMER0);
	NVIC_SetPriority(TMR0_IRQn, 3 ); //定时器的中断优先级应该比串口的低
    NVIC_EnableIRQ(TMR0_IRQn);
	 TIMER_Start(TIMER0);*/

	 TIMER_EnableInt(TIMER1);
    /* Enable Timer1 NVIC */
   NVIC_EnableIRQ(TMR1_IRQn);
    /* Start Timer1 counting */
    TIMER_Start(TIMER1);
	 
}

void vMBPortTimersDisable()
{
    /* Start Timer1 counting */
   TIMER_Stop(TIMER1);
	Timehandel=0;//禁止计时
	timecut=0;//清空计数 */
}

void prvvTIMERExpiredISR(void)
{
	(void) pxMBPortCBTimerExpired();
}


void TMR1_IRQHandler(void)
{
	 
	 if(TIMER_GetIntFlag(TIMER1) == 1)
    {
		  	  TIMER_ClearIntFlag(TIMER1);

			if(Timehandel)
			{
				 timecut++;
			   if(timecut>= MBTimerout50us)	//超时事件发生
			   {
			   	
			   	 	prvvTIMERExpiredISR();//收到一帧RTU
					timecut=0;//再次清空
			   }
			   
			
			}
			else
			{
				 timecut=0;
			
			}
				
   }
}

