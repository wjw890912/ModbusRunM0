/*
 * FreeModbus Libary: NUC442 Port
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
 * File: $Id: portserial.c,v 1.60 2013/08/13 15:07:05 Armink $
 */

#include "port.h"
/* ----------------------- Modbus includes ----------------------------------*/
#include "mb.h"
#include "mbport.h"
#include "M051Series.h"
/* ----------------------- static functions ---------------------------------*/
static void prvvUARTTxReadyISR(void);
static void prvvUARTRxISR(void);
/* ----------------------- Start implementation -----------------------------*/

void vMBPortSerialEnable(BOOL xRxEnable, BOOL xTxEnable)
{
	if (xRxEnable) //开启或者关闭接收中断
	{
	    
		SLAVE_RS485_RECEIVE_MODE;
//	UART_EnableInt(UART3, UART_INTEN_RDAIEN_Msk);
  	//	Sysdelay(1);//1ms
	 UART_ENABLE_INT(UART0, UART_IER_RDA_IEN_Msk); //接收中断打开
	}
	else
	{
	
	   SLAVE_RS485_SEND_MODE;	
//	UART_DisableInt(UART3, UART_INTEN_RDAIEN_Msk);
      UART_DISABLE_INT(UART0, UART_IER_RDA_IEN_Msk); //接收中断关闭
	//	  Sysdelay(1);//1ms

	}
	if (xTxEnable)	//开启或者关闭发送中断
	{

//	UART_EnableInt(UART3,  UART_INTEN_THREIEN_Msk);
   UART_ENABLE_INT(UART0, UART_IER_THRE_IEN_Msk);//发送空中断开启

	}
	else
	{
	
   UART_DISABLE_INT(UART0, UART_IER_THRE_IEN_Msk);//发送空中断关闭
  //UART_DisableInt(UART3, UART_INTEN_THREIEN_Msk);

	}
}


  	
    
void vMBPortClose(void)
{



}
//默认一个从机 串口1 波特率可设置  奇偶检验可设置
BOOL xMBPortSerialInit(UCHAR ucPORT, ULONG ulBaudRate, UCHAR ucDataBits,
		eMBParity eParity)
{


		 /*---------------------------------------------------------------------------------------------------------*/
    /* Init UART                                                                                               */
    /*---------------------------------------------------------------------------------------------------------*/
     SYS_ResetModule(UART0_RST);
	CLK_SetModuleClock(UART0_MODULE , CLK_CLKSEL1_UART_S_HIRC, CLK_CLKDIV_UART(1));
	CLK_EnableModuleClock(UART0_MODULE);
    //Configure UART0 and set UART0 Baudrate 
    UART_Open(UART0, ulBaudRate);
		//UART_EnableInt(UART0, UART_ISR_RDA_IF_Msk);
	


		 /* Enable IP clock */
   // CLK_EnableModuleClock(UART3_MODULE);
    /* Select IP clock source */
   // CLK_SetModuleClock(UART3_MODULE, CLK_CLKSEL1_UARTSEL_HIRC , CLK_CLKDIV0_UART(1));
   /* Set GPD multi-function pins for UART3 RXD and TXD */
  //  SYS->GPD_MFPL |= SYS_GPD_MFPL_PD4MFP_UART3_RXD | SYS_GPD_MFPL_PD5MFP_UART3_TXD  ;
//	GPIO_SetMode(PD, 5, GPIO_MODE_OUTPUT);
//	GPIO_SetMode(PD, 4, GPIO_MODE_INPUT);
  //  UART_Open(UART3, ulBaudRate);
 //   UART_DisableFlowCtrl(UART3);
//	UART_SetLine_Config(UART3, ulBaudRate, UART_WORD_LEN_8,UART_PARITY_NONE,UART_STOP_BIT_1);
	  	
	//配置485发送和接收模式
//    TODO   暂时先写B13 等之后组网测试时再修改
//	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP;
//	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_13;
//	GPIO_Init(GPIOB, &GPIO_InitStructure);

	ENTER_CRITICAL_SECTION(); //关全局中断

	  	UART_ENABLE_INT(UART0, UART_IER_RDA_IEN_Msk); //接收中断
	//	UART_ENABLE_INT(UART0, UART_IER_THRE_IEN_Msk);//发送空中断
		
		NVIC_SetPriority(UART0_IRQn, 2 );
	    NVIC_EnableIRQ(UART0_IRQn);



  //	UART_EnableInt(UART3, UART_INTEN_RDAIEN_Msk );
//	NVIC_SetPriority(UART3_IRQn, 2 );
  // 	NVIC_EnableIRQ(UART3_IRQn);	
	EXIT_CRITICAL_SECTION(); //开全局中断		 
	return TRUE;
}

BOOL xMBPortSerialPutByte(CHAR ucByte)//写一个字节到硬件
{

	UART_WRITE(UART0, ucByte);

	return TRUE;
}

BOOL xMBPortSerialGetByte(CHAR * pucByte) //读一个自己从硬件
{	   
	*pucByte = UART_READ(UART0);
	return TRUE;
}

/* 
 * Create an interrupt handler for the transmit buffer empty interrupt
 * (or an equivalent) for your target processor. This function should then
 * call pxMBFrameCBTransmitterEmpty( ) which tells the protocol stack that
 * a new character can be sent. The protocol stack will then call 
 * xMBPortSerialPutByte( ) to send the character.
 */
void prvvUARTTxReadyISR(void)
{
	pxMBFrameCBTransmitterEmpty();
}

/* 
 * Create an interrupt handler for the receive interrupt for your target
 * processor. This function should then call pxMBFrameCBByteReceived( ). The
 * protocol stack will then call xMBPortSerialGetByte( ) to retrieve the
 * character.
 */
void prvvUARTRxISR(void)
{
	pxMBFrameCBByteReceived();
}



/*******************************************************************************
 * Function Name  : USART1_IRQHandler
 * Description    : This function handles USART1 global interrupt request.
 * Input          : None
 * Output         : None
 * Return         : None
 *******************************************************************************/


void UART0_IRQHandler(void)
{
    
	   
		 char u=8;

	if(UART_IS_RX_READY(UART0))
	 {
					   //数据接收中断
     // u=UART_READ(UART0);    
    //UART_ClearIntFlag(UART0 , UART_ISR_MODEM_INT_Msk);//清除中断
	prvvUARTRxISR();

	
     }
	 else
	 if(UART_IS_TX_EMPTY(UART0))
	 
	  {

	                   //发送空中断
        //UART_WRITE(UART0, 8);
	  	prvvUARTTxReadyISR();
	   
	 }
	 else
	 {
	 
	  //	UART_ClearIntFlag(UART3 , UART_INTSTS_BUFERRINT_Msk|UART_INTSTS_MODEMINT_Msk|UART_INTSTS_RXTOINT_Msk);
	 }	  
	
}	
