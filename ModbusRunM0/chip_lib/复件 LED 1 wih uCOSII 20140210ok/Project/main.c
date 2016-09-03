/*---------------------------------------------------------------------------------------------------------*/
/*                                                                                                         */
/* Copyright(c) 2010 Nuvoton Technology Corp. All rights reserved.                                         */
/*                                                                                                         */
/*---------------------------------------------------------------------------------------------------------*/
#include "ucos_ii.h"
#include "app_cfg.h"

#include <stdio.h>
#include "M051Series.h"
#include "initialization.h"
#define DBG_PRINTF      printf
uint32_t msTicks = 0; /* Variable to store millisecond ticks */
#define PLLCON_SETTING      SYSCLK_PLLCON_50MHz_XTAL
#define PLL_CLOCK           50000000


/*---------------------------------------------------------------------------------------------------------*/
/* MAIN function                                                                                           */
/*---------------------------------------------------------------------------------------------------------*/
int main(void)
{
	INT8U  os_err;

	SystemInit();
	SystemCoreClockUpdate();
// 	SYS_Init();
	_GPIO_SET_PIN_MODE(P0, 1, GPIO_PMD_OUTPUT);
	P36 = 0;
	usart1_init(UART1);
	OSInit();	//Initialize "uC/OS-II, The Real-Time Kernel"
	
	OSTaskCreateExt((void (*)(void *)) AppTaskStart,            /* Create the start task                                */
				(void           *) 0,
				(OS_STK         *)&AppTaskStartStk[APP_TASK_START_STK_SIZE - 1],
				(INT8U           ) APP_TASK_START_PRIO,
				(INT16U          ) APP_TASK_START_PRIO,
				(OS_STK         *)&AppTaskStartStk[0],
				(INT32U          ) APP_TASK_START_STK_SIZE,
				(void           *) 0,
				(INT16U          )(OS_TASK_OPT_STK_CHK | OS_TASK_OPT_STK_CLR));

#if (OS_TASK_NAME_EN > 0)
    OSTaskNameSet((INT8U     )APP_TASK_START_PRIO,
                  (INT8U    *)"Start_Task",
                  (INT8U    *)&os_err);
#endif

	OSStart();  //Start multitasking (i.e. give control to uC/OS-II)
	raminit();
	while(1)
	{
		 OSTimeDly(500);
	}
	
}






