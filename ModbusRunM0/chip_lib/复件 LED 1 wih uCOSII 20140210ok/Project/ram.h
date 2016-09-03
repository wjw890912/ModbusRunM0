
#ifndef  __RAM_H__
#define  __RAM_H__
#include "ucos_ii.h"
#include "app_cfg.h"

#include <stdio.h>
#include "M051Series.h"
#include "initialization.h"
extern OS_STK          AppTaskStartStk[APP_TASK_START_STK_SIZE];
extern OS_STK          AppTaskTestStk[APP_TASK_Test_SIZE];
void  AppTaskStart              (void        *p_arg);
void  AppTest                   (void        *p_arg);
void  AppTest1                   (void        *p_arg);
#endif
