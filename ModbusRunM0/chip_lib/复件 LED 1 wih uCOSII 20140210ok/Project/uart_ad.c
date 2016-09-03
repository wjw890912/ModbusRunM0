#include "ucos_ii.h"
#include "app_cfg.h"

#include <stdio.h>
#include "M051Series.h"
#include "initialization.h"

void usart1_init(UART_T* UART)
{
	SYS->P1_MFP = SYS_MFP_P12_RXD1 | SYS_MFP_P13_TXD1;
	UART_ResetIP(UART1);
	SYSCLK->APBCLK |= SYSCLK_APBCLK_UART1_EN_Msk; 
	SYSCLK->CLKSEL1 = (SYSCLK->CLKSEL1 &~SYSCLK_CLKSEL1_UART_IRC22M)|SYSCLK_CLKSEL1_UART_XTAL;
  SYSCLK->CLKDIV &=  ~(15<<8);
	UART->FCR  |= 6;
	UART->LCR |= UART_LCR_PBE_Msk |UART_LCR_EPE_Msk |UART_LCR_SPE_Msk;
	UART1->LCR &= ~UART_LCR_WLS_Msk ;
	UART1->LCR |= UART_WORD_LEN_8 ;
	UART1->LCR &= ~UART_LCR_NSB_Msk;
	UART->FUNSEL = 0;
	UART1_Init();
	UART->IER |= UART_IER_RDA_IEN_Msk |UART_IER_THRE_IEN_Msk ;
	NVIC_EnableIRQ(UART1_IRQn);
	}
void UART1_IRQHandler(void)
{
	unsigned char a;
		 if(UART1->ISR & UART_ISR_RDA_INT_Msk)                              //中:检查是否接收中断//en:Check if receive interrupt
    {
	     _UART_RECEIVEBYTE(UART1,a); 
			
    }
	else if(UART1->ISR & UART_ISR_THRE_INT_Msk)
	{
			if(sendlenn< sendlen &&  sendlenn< 20)
			{
			usart1_send(sendbuf[sendlenn]);
			sendlenn++;
			}
			else
			{
			sendlenn = 0;
			UART1->IER	&= ~( UART_IER_THRE_IEN_Msk );//关掉发送中断
			UART1->LCR |= UART_LCR_EPE_Msk ;
			}
		}
}

void usart1_send(unsigned char dat1)
{
	  unsigned char k,a,n;
	        a= dat1;
	        n= 0;
	       for(k=0;k<8;k++)
					{
						if(a&0x01 == 1)
							n++;
						a = a>>1;
						}
				n = n%2;
				if(n == 1)
				UART1->LCR |= UART_LCR_EPE_Msk;
				else
				UART1->LCR &= ~UART_LCR_EPE_Msk;
    	  _UART_SENDBYTE(UART1,dat1); 
				
	}

void usart1_sendbuf(unsigned char n)
{
// 	volatile 	unsigned char crch,crcl;
// 	volatile 	unsigned short crcback;
// 	crcback=CRC16_M(sendbuf,n);//CRC 
// 	crch=crcback/256;
// 	crcl=crcback%256; 
// 	sendbuf[n] = crch;
// 	sendbuf[n+1] = crcl;
// 	sendlen = n+2;
		sendlen = n;
	sendlenn = 0;
	UART1->IER	|=  UART_IER_THRE_IEN_Msk ;//打开发送中断
	}

void T_set_mode()
{
	sendbuf[0] = 0x01;
  sendbuf[1] = 0x03;
  sendbuf[2] = 0x00;
  sendbuf[3] = 0x02;
  sendbuf[4] = 0x00;
  sendbuf[5] = 0x09;
  usart1_sendbuf(6);
	
	}
	
	void T_set_mode1()
{
	sendbuf[0] = 0xff;
  sendbuf[1] = 0xff;
  sendbuf[2] = 0xff;
  sendbuf[3] = 0xff;
  sendbuf[4] = 0xff;
  sendbuf[5] = 0xff;
  usart1_sendbuf(6);
	
	}
