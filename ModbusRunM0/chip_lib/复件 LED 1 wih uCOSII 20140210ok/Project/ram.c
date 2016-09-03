#include "ucos_ii.h"
#include "app_cfg.h"

#include <stdio.h>
#include "M051Series.h"
#include "initialization.h"



OS_STK          AppTaskStartStk[APP_TASK_START_STK_SIZE];
OS_STK          AppTaskTestStk[APP_TASK_Test_SIZE];
OS_STK          AppTaskTest1Stk[APP_TASK_Test1_SIZE];

OS_EVENT *DispSem;

INT8U  index;

typedef struct{
	unsigned char buffer[6];//msg
	unsigned char index;
}msg_t;


#define MSG_COUNT	3
static msg_t msg[MSG_COUNT];

OS_EVENT *CommMbox;





void  AppTaskStart (void *p_arg)
{
		INT8U  os_err;
	  unsigned char i;
	  DispSem = OSSemCreate(1); /* Create Semaphore*/
		CommMbox = OSMboxCreate((void *)0); /* Create COMM mailbox */
	  for(i = 0; i < MSG_COUNT; i++)
	  {
	  	msg[i].index = i;
	  }
	
	
	
		OSTaskCreateExt((void (*)(void *)) AppTest,            /* Create the start task                                */
				(void           *) 0,
				(OS_STK         *)&AppTaskTestStk[APP_TASK_Test_SIZE - 1],
				(INT8U           ) APP_Test_PRIO,
				(INT16U          ) APP_Test_PRIO,
				(OS_STK         *)&AppTaskTestStk[0],
				(INT32U          ) APP_TASK_Test_SIZE,
				(void           *) 0,
				(INT16U          )(OS_TASK_OPT_STK_CHK | OS_TASK_OPT_STK_CLR));

#if (OS_TASK_NAME_EN > 0)
    OSTaskNameSet((INT8U     )APP_Test_PRIO,
                  (INT8U    *)"Start_Test",
                  (INT8U    *)&os_err);
#endif
	
		OSTaskCreateExt((void (*)(void *)) AppTest1,            /* Create the start task                                */
				(void           *) 0,
				(OS_STK         *)&AppTaskTest1Stk[APP_TASK_Test1_SIZE - 1],
				(INT8U           ) APP_Test1_PRIO,
				(INT16U          ) APP_Test1_PRIO,
				(OS_STK         *)&AppTaskTest1Stk[0],
				(INT32U          ) APP_TASK_Test1_SIZE,
				(void           *) 0,
				(INT16U          )(OS_TASK_OPT_STK_CHK | OS_TASK_OPT_STK_CLR));

#if (OS_TASK_NAME_EN > 0)
    OSTaskNameSet((INT8U     )APP_Test1_PRIO,
                  (INT8U    *)"Start_Test1",
                  (INT8U    *)&os_err);
#endif
	

    OS_CPU_SysTickInit(12000);   //1ms                          /* Init uC/OS periodic time src (SysTick).              */

#if (OS_TASK_STAT_EN > 0)
    OSStatInit();                                               /* Determine CPU capacity                               */
#endif

    while (TRUE) {                                          /* Task body, always written as an infinite loop.       */

        
        OSTimeDly(500);

        }
}

 void  AppTest (void *p_arg)
{
	  INT8U  err;
	  msg_t *pmsg;
    while (TRUE)
	{                                          /* Task body, always written as an infinite loop.       */
// 		 OSSemPend(DispSem,3, &err);
// 		 switch (err)
// 		{
// 		  case OS_ERR_NONE:
// 			{
// 			  P01 = 0;
// 			  T_set_mode();
//         OSTimeDly(70);		
// 			  P01 = 1;
// 			err = OSSemPost(DispSem);			
// 			}
// 			break;
// 		  case OS_ERR_TIMEOUT:
// 			{
// 			 T_set_mode1();
// 	     }
// 			break;
// 		 }
    pmsg = (msg_t*)OSMboxPend(CommMbox, 1000, &err);
		if (err == OS_ERR_NONE)
		{
			sendbuf[0] = pmsg->buffer[0];
      sendbuf[1] = pmsg->buffer[1];
      sendbuf[2] = pmsg->buffer[2];
      sendbuf[3] = pmsg->buffer[3];
      sendbuf[4] = pmsg->buffer[4];
      sendbuf[5] = pmsg->buffer[5];
      usart1_sendbuf(6);
		  } 
		else 
		{
		  T_set_mode1();
		}
		

		 
// 	 OSTimeDly(1000);
	}
}

 void  AppTest1 (void *p_arg)
{
	
// 	  msg_t *pmsg;
    while (TRUE) 
	{                                          /* Task body, always written as an infinite loop.       */

//      OSSemPend(DispSem, 3, &err);
//      OSTimeDly(1000);
// 		 err = OSSemPost(DispSem);		
// 		switch (err)
// 		{
// 		  case OS_ERR_NONE:
// 			break;
// 		  case OS_ERR_SEM_OVF:
// 			break;
// 		 }
		 (&msg[0])->buffer[0] = 0xff;
		 (&msg[1])->buffer[0] = 0x55;
		 (&msg[2])->buffer[0] = 0xaa;
		
		OSMboxPost(CommMbox, (void *)&msg[index++]);
		if(index >= MSG_COUNT)
			index = 0;
    OSTimeDly(3000);
// 		OSMboxQuery();
   }
}
