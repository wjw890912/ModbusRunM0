#line 1 "..\\..\\uCOS-II\\Ports\\ARM-Cortex-M0\\Generic\\RealView\\os_dbg.c"






















 

#line 1 "..\\..\\uCOS-II\\Source\\ucos_ii.h"




















 












 







 

#line 1 "..\\..\\Project\\app_cfg.h"











 
















 









 












 






 













 





























 









 















#line 45 "..\\..\\uCOS-II\\Source\\ucos_ii.h"
#line 1 "..\\..\\Project\\os_cfg.h"























 





                                        










                                        













                                        





                                        
#line 74 "..\\..\\Project\\os_cfg.h"


                                        
#line 84 "..\\..\\Project\\os_cfg.h"


                                        
#line 94 "..\\..\\Project\\os_cfg.h"


                                        





                                        






                                        
#line 119 "..\\..\\Project\\os_cfg.h"


                                        
#line 128 "..\\..\\Project\\os_cfg.h"


                                        






                                        






#line 46 "..\\..\\uCOS-II\\Source\\ucos_ii.h"
#line 1 "..\\..\\uCOS-II\\Ports\\ARM-Cortex-M0\\Generic\\RealView\\os_cpu.h"























 




















 

typedef unsigned char  BOOLEAN;
typedef unsigned char  INT8U;                     
typedef signed   char  INT8S;                     
typedef unsigned short INT16U;                    
typedef signed   short INT16S;                    
typedef unsigned int   INT32U;                    
typedef signed   int   INT32S;                    
typedef float          FP32;                      
typedef double         FP64;                      

typedef unsigned int   OS_STK;                    
typedef unsigned int   OS_CPU_SR;                 





















 












 









 

extern  OS_STK   OS_CPU_ExceptStk[64u];
extern  OS_STK  *OS_CPU_ExceptStkBase;





 


OS_CPU_SR  OS_CPU_SR_Save(void);
void       OS_CPU_SR_Restore(OS_CPU_SR cpu_sr);


void       OSCtxSw(void);
void       OSIntCtxSw(void);
void       OSStartHighRdy(void);

void       OS_CPU_PendSVHandler(void);

                                                   
void       OS_CPU_SysTickHandler(void);
void       OS_CPU_SysTickInit(INT32U  cnts);
#line 47 "..\\..\\uCOS-II\\Source\\ucos_ii.h"





 




























#line 88 "..\\..\\uCOS-II\\Source\\ucos_ii.h"









 




 
#line 111 "..\\..\\uCOS-II\\Source\\ucos_ii.h"







 








 
#line 134 "..\\..\\uCOS-II\\Source\\ucos_ii.h"


                                             





 

























 











 









 









 









 









 












 









 


#line 255 "..\\..\\uCOS-II\\Source\\ucos_ii.h"

#line 266 "..\\..\\uCOS-II\\Source\\ucos_ii.h"













#line 293 "..\\..\\uCOS-II\\Source\\ucos_ii.h"

#line 300 "..\\..\\uCOS-II\\Source\\ucos_ii.h"

#line 311 "..\\..\\uCOS-II\\Source\\ucos_ii.h"



#line 320 "..\\..\\uCOS-II\\Source\\ucos_ii.h"



#line 337 "..\\..\\uCOS-II\\Source\\ucos_ii.h"

 




 


typedef  INT8U    OS_PRIO;





typedef struct os_event {
    INT8U    OSEventType;                     
    void    *OSEventPtr;                      
    INT16U   OSEventCnt;                      
    OS_PRIO  OSEventGrp;                      
    OS_PRIO  OSEventTbl[((10u) / 8u + 1u)];   


    INT8U   *OSEventName;

} OS_EVENT;







 




typedef  INT8U    OS_FLAGS;











typedef struct os_flag_grp {                 
    INT8U         OSFlagType;                
    void         *OSFlagWaitList;            
    OS_FLAGS      OSFlagFlags;               

    INT8U        *OSFlagName;

} OS_FLAG_GRP;



typedef struct os_flag_node {                
    void         *OSFlagNodeNext;            
    void         *OSFlagNodePrev;            
    void         *OSFlagNodeTCB;             
    void         *OSFlagNodeFlagGrp;         
    OS_FLAGS      OSFlagNodeFlags;           
    INT8U         OSFlagNodeWaitType;        
                                             
                                             
                                             
                                             
} OS_FLAG_NODE;


 




 


typedef struct os_mbox_data {
    void   *OSMsg;                          
    OS_PRIO OSEventTbl[((10u) / 8u + 1u)];  
    OS_PRIO OSEventGrp;                     
} OS_MBOX_DATA;






 


typedef struct os_mem {                    
    void   *OSMemAddr;                     
    void   *OSMemFreeList;                 
    INT32U  OSMemBlkSize;                  
    INT32U  OSMemNBlks;                    
    INT32U  OSMemNFree;                    

    INT8U  *OSMemName;                     

} OS_MEM;


typedef struct os_mem_data {
    void   *OSAddr;                     
    void   *OSFreeList;                 
    INT32U  OSBlkSize;                  
    INT32U  OSNBlks;                    
    INT32U  OSNFree;                    
    INT32U  OSNUsed;                    
} OS_MEM_DATA;


 




 


typedef struct os_mutex_data {
    OS_PRIO OSEventTbl[((10u) / 8u + 1u)];   
    OS_PRIO OSEventGrp;                      
    BOOLEAN OSValue;                         
    INT8U   OSOwnerPrio;                     
    INT8U   OSMutexPIP;                      
} OS_MUTEX_DATA;






 

#line 499 "..\\..\\uCOS-II\\Source\\ucos_ii.h"





 


typedef struct os_sem_data {
    INT16U  OSCnt;                           
    OS_PRIO OSEventTbl[((10u) / 8u + 1u)];   
    OS_PRIO OSEventGrp;                      
} OS_SEM_DATA;






 


typedef struct os_stk_data {
    INT32U  OSFree;                     
    INT32U  OSUsed;                     
} OS_STK_DATA;


 




 

typedef struct os_tcb {
    OS_STK          *OSTCBStkPtr;            


    void            *OSTCBExtPtr;            
    OS_STK          *OSTCBStkBottom;         
    INT32U           OSTCBStkSize;           
    INT16U           OSTCBOpt;               
    INT16U           OSTCBId;                


    struct os_tcb   *OSTCBNext;              
    struct os_tcb   *OSTCBPrev;              


    OS_EVENT        *OSTCBEventPtr;          



    OS_EVENT       **OSTCBEventMultiPtr;     



    void            *OSTCBMsg;               




    OS_FLAG_NODE    *OSTCBFlagNode;          

    OS_FLAGS         OSTCBFlagsRdy;          


    INT32U           OSTCBDly;               
    INT8U            OSTCBStat;              
    INT8U            OSTCBStatPend;          
    INT8U            OSTCBPrio;              

    INT8U            OSTCBX;                 
    INT8U            OSTCBY;                 
    OS_PRIO          OSTCBBitX;              
    OS_PRIO          OSTCBBitY;              


    INT8U            OSTCBDelReq;            



    INT32U           OSTCBCtxSwCtr;          
    INT32U           OSTCBCyclesTot;         
    INT32U           OSTCBCyclesStart;       
    OS_STK          *OSTCBStkBase;           
    INT32U           OSTCBStkUsed;           



    INT8U           *OSTCBTaskName;



    INT32U           OSTCBRegTbl[1u];

} OS_TCB;

 




 


typedef  void (*OS_TMR_CALLBACK)(void *ptmr, void *parg);



typedef  struct  os_tmr {
    INT8U            OSTmrType;                        
    OS_TMR_CALLBACK  OSTmrCallback;                    
    void            *OSTmrCallbackArg;                 
    void            *OSTmrNext;                        
    void            *OSTmrPrev;
    INT32U           OSTmrMatch;                       
    INT32U           OSTmrDly;                         
    INT32U           OSTmrPeriod;                      

    INT8U           *OSTmrName;                        

    INT8U            OSTmrOpt;                         
    INT8U            OSTmrState;                       
                                                       
                                                       
                                                       
} OS_TMR;



typedef  struct  os_tmr_wheel {
    OS_TMR          *OSTmrFirst;                       
    INT16U           OSTmrEntries;
} OS_TMR_WHEEL;


 




 

extern  INT32U            OSCtxSwCtr;                


extern  OS_EVENT         *OSEventFreeList;           
extern  OS_EVENT          OSEventTbl[10u]; 



extern  OS_FLAG_GRP       OSFlagTbl[5u];   
extern  OS_FLAG_GRP      *OSFlagFreeList;            



extern  INT8U             OSCPUUsage;                
extern  INT32U            OSIdleCtrMax;              
extern  INT32U            OSIdleCtrRun;              
extern  BOOLEAN           OSStatRdy;                 
extern  OS_STK            OSTaskStatStk[15u];       


extern  INT8U             OSIntNesting;              

extern  INT8U             OSLockNesting;             

extern  INT8U             OSPrioCur;                 
extern  INT8U             OSPrioHighRdy;             

extern  OS_PRIO           OSRdyGrp;                         
extern  OS_PRIO           OSRdyTbl[((10u) / 8u + 1u)];        

extern  BOOLEAN           OSRunning;                        

extern  INT8U             OSTaskCtr;                        

extern  volatile  INT32U  OSIdleCtr;                                  





extern  OS_STK            OSTaskIdleStk[15u];       


extern  OS_TCB           *OSTCBCur;                         
extern  OS_TCB           *OSTCBFreeList;                    
extern  OS_TCB           *OSTCBHighRdy;                     
extern  OS_TCB           *OSTCBList;                        
extern  OS_TCB           *OSTCBPrioTbl[10u + 1u];     
extern  OS_TCB            OSTCBTbl[7u + 2u];    


extern  INT8U             OSTickStepState;           



extern  OS_MEM           *OSMemFreeList;             
extern  OS_MEM            OSMemTbl[5u]; 








extern  volatile  INT32U  OSTime;                    



extern  INT16U            OSTmrFree;                 
extern  INT16U            OSTmrUsed;                 
extern  INT32U            OSTmrTime;                 

extern  OS_EVENT         *OSTmrSem;                  
extern  OS_EVENT         *OSTmrSemSignal;            

extern  OS_TMR            OSTmrTbl[8u];  
extern  OS_TMR           *OSTmrFreeList;             
extern  OS_STK            OSTmrTaskStk[15u];

extern  OS_TMR_WHEEL      OSTmrWheelTbl[8u];


extern  INT8U   const     OSUnMapTbl[256];           

 





 





 




INT8U         OSEventNameGet          (OS_EVENT        *pevent,
                                       INT8U          **pname,
                                       INT8U           *perr);

void          OSEventNameSet          (OS_EVENT        *pevent,
                                       INT8U           *pname,
                                       INT8U           *perr);



INT16U        OSEventPendMulti        (OS_EVENT       **pevents_pend,
                                       OS_EVENT       **pevents_rdy,
                                       void           **pmsgs_rdy,
                                       INT32U           timeout,
                                       INT8U           *perr);








 




OS_FLAGS      OSFlagAccept            (OS_FLAG_GRP     *pgrp,
                                       OS_FLAGS         flags,
                                       INT8U            wait_type,
                                       INT8U           *perr);


OS_FLAG_GRP  *OSFlagCreate            (OS_FLAGS         flags,
                                       INT8U           *perr);


OS_FLAG_GRP  *OSFlagDel               (OS_FLAG_GRP     *pgrp,
                                       INT8U            opt,
                                       INT8U           *perr);



INT8U         OSFlagNameGet           (OS_FLAG_GRP     *pgrp,
                                       INT8U          **pname,
                                       INT8U           *perr);

void          OSFlagNameSet           (OS_FLAG_GRP     *pgrp,
                                       INT8U           *pname,
                                       INT8U           *perr);


OS_FLAGS      OSFlagPend              (OS_FLAG_GRP     *pgrp,
                                       OS_FLAGS         flags,
                                       INT8U            wait_type,
                                       INT32U           timeout,
                                       INT8U           *perr);

OS_FLAGS      OSFlagPendGetFlagsRdy   (void);
OS_FLAGS      OSFlagPost              (OS_FLAG_GRP     *pgrp,
                                       OS_FLAGS         flags,
                                       INT8U            opt,
                                       INT8U           *perr);


OS_FLAGS      OSFlagQuery             (OS_FLAG_GRP     *pgrp,
                                       INT8U           *perr);







 




void         *OSMboxAccept            (OS_EVENT        *pevent);


OS_EVENT     *OSMboxCreate            (void            *pmsg);


OS_EVENT     *OSMboxDel               (OS_EVENT        *pevent,
                                       INT8U            opt,
                                       INT8U           *perr);


void         *OSMboxPend              (OS_EVENT        *pevent,
                                       INT32U           timeout,
                                       INT8U           *perr);


INT8U         OSMboxPendAbort         (OS_EVENT        *pevent,
                                       INT8U            opt,
                                       INT8U           *perr);



INT8U         OSMboxPost              (OS_EVENT        *pevent,
                                       void            *pmsg);



INT8U         OSMboxPostOpt           (OS_EVENT        *pevent,
                                       void            *pmsg,
                                       INT8U            opt);



INT8U         OSMboxQuery             (OS_EVENT        *pevent,
                                       OS_MBOX_DATA    *p_mbox_data);







 



OS_MEM       *OSMemCreate             (void            *addr,
                                       INT32U           nblks,
                                       INT32U           blksize,
                                       INT8U           *perr);

void         *OSMemGet                (OS_MEM          *pmem,
                                       INT8U           *perr);

INT8U         OSMemNameGet            (OS_MEM          *pmem,
                                       INT8U          **pname,
                                       INT8U           *perr);

void          OSMemNameSet            (OS_MEM          *pmem,
                                       INT8U           *pname,
                                       INT8U           *perr);

INT8U         OSMemPut                (OS_MEM          *pmem,
                                       void            *pblk);


INT8U         OSMemQuery              (OS_MEM          *pmem,
                                       OS_MEM_DATA     *p_mem_data);








 




BOOLEAN       OSMutexAccept           (OS_EVENT        *pevent,
                                       INT8U           *perr);


OS_EVENT     *OSMutexCreate           (INT8U            prio,
                                       INT8U           *perr);


OS_EVENT     *OSMutexDel              (OS_EVENT        *pevent,
                                       INT8U            opt,
                                       INT8U           *perr);


void          OSMutexPend             (OS_EVENT        *pevent,
                                       INT32U           timeout,
                                       INT8U           *perr);

INT8U         OSMutexPost             (OS_EVENT        *pevent);


INT8U         OSMutexQuery            (OS_EVENT        *pevent,
                                       OS_MUTEX_DATA   *p_mutex_data);




 




 

#line 992 "..\\..\\uCOS-II\\Source\\ucos_ii.h"

 




 



INT16U        OSSemAccept             (OS_EVENT        *pevent);


OS_EVENT     *OSSemCreate             (INT16U           cnt);


OS_EVENT     *OSSemDel                (OS_EVENT        *pevent,
                                       INT8U            opt,
                                       INT8U           *perr);


void          OSSemPend               (OS_EVENT        *pevent,
                                       INT32U           timeout,
                                       INT8U           *perr);


INT8U         OSSemPendAbort          (OS_EVENT        *pevent,
                                       INT8U            opt,
                                       INT8U           *perr);


INT8U         OSSemPost               (OS_EVENT        *pevent);


INT8U         OSSemQuery              (OS_EVENT        *pevent,
                                       OS_SEM_DATA     *p_sem_data);



void          OSSemSet                (OS_EVENT        *pevent,
                                       INT16U           cnt,
                                       INT8U           *perr);




 




 

INT8U         OSTaskChangePrio        (INT8U            oldprio,
                                       INT8U            newprio);



INT8U         OSTaskCreate            (void           (*task)(void *p_arg),
                                       void            *p_arg,
                                       OS_STK          *ptos,
                                       INT8U            prio);



INT8U         OSTaskCreateExt         (void           (*task)(void *p_arg),
                                       void            *p_arg,
                                       OS_STK          *ptos,
                                       INT8U            prio,
                                       INT16U           id,
                                       OS_STK          *pbos,
                                       INT32U           stk_size,
                                       void            *pext,
                                       INT16U           opt);



INT8U         OSTaskDel               (INT8U            prio);
INT8U         OSTaskDelReq            (INT8U            prio);



INT8U         OSTaskNameGet           (INT8U            prio,
                                       INT8U          **pname,
                                       INT8U           *perr);

void          OSTaskNameSet           (INT8U            prio,
                                       INT8U           *pname,
                                       INT8U           *perr);



INT8U         OSTaskResume            (INT8U            prio);
INT8U         OSTaskSuspend           (INT8U            prio);



INT8U         OSTaskStkChk            (INT8U            prio,
                                       OS_STK_DATA     *p_stk_data);



INT8U         OSTaskQuery             (INT8U            prio,
                                       OS_TCB          *p_task_data);





INT32U        OSTaskRegGet            (INT8U            prio,
                                       INT8U            id,
                                       INT8U           *perr);

void          OSTaskRegSet            (INT8U            prio,
                                       INT8U            id,
                                       INT32U           value,
                                       INT8U           *perr);


 




 

void          OSTimeDly               (INT32U           ticks);


INT8U         OSTimeDlyHMSM           (INT8U            hours,
                                       INT8U            minutes,
                                       INT8U            seconds,
                                       INT16U           ms);



INT8U         OSTimeDlyResume         (INT8U            prio);



INT32U        OSTimeGet               (void);
void          OSTimeSet               (INT32U           ticks);


void          OSTimeTick              (void);





 


OS_TMR      *OSTmrCreate              (INT32U           dly,
                                       INT32U           period,
                                       INT8U            opt,
                                       OS_TMR_CALLBACK  callback,
                                       void            *callback_arg,
                                       INT8U           *pname,
                                       INT8U           *perr);

BOOLEAN      OSTmrDel                 (OS_TMR          *ptmr,
                                       INT8U           *perr);


INT8U        OSTmrNameGet             (OS_TMR          *ptmr,
                                       INT8U          **pdest,
                                       INT8U           *perr);

INT32U       OSTmrRemainGet           (OS_TMR          *ptmr,
                                       INT8U           *perr);

INT8U        OSTmrStateGet            (OS_TMR          *ptmr,
                                       INT8U           *perr);

BOOLEAN      OSTmrStart               (OS_TMR          *ptmr,
                                       INT8U           *perr);

BOOLEAN      OSTmrStop                (OS_TMR          *ptmr,
                                       INT8U            opt,
                                       void            *callback_arg,
                                       INT8U           *perr);

INT8U        OSTmrSignal              (void);






 

void          OSInit                  (void);

void          OSIntEnter              (void);
void          OSIntExit               (void);






void          OSSchedLock             (void);
void          OSSchedUnlock           (void);


void          OSStart                 (void);

void          OSStatInit              (void);

INT16U        OSVersion               (void);

 





 


void          OS_Dummy                (void);



INT8U         OS_EventTaskRdy         (OS_EVENT        *pevent,
                                       void            *pmsg,
                                       INT8U            msk,
                                       INT8U            pend_stat);

void          OS_EventTaskWait        (OS_EVENT        *pevent);

void          OS_EventTaskRemove      (OS_TCB          *ptcb,
                                       OS_EVENT        *pevent);


void          OS_EventTaskWaitMulti   (OS_EVENT       **pevents_wait);

void          OS_EventTaskRemoveMulti (OS_TCB          *ptcb,
                                       OS_EVENT       **pevents_multi);


void          OS_EventWaitListInit    (OS_EVENT        *pevent);



void          OS_FlagInit             (void);
void          OS_FlagUnlink           (OS_FLAG_NODE    *pnode);


void          OS_MemClr               (INT8U           *pdest,
                                       INT16U           size);

void          OS_MemCopy              (INT8U           *pdest,
                                       INT8U           *psrc,
                                       INT16U           size);


void          OS_MemInit              (void);






void          OS_Sched                (void);


INT8U         OS_StrLen               (INT8U           *psrc);


void          OS_TaskIdle             (void            *p_arg);

void          OS_TaskReturn           (void);


void          OS_TaskStat             (void            *p_arg);



void          OS_TaskStkClr           (OS_STK          *pbos,
                                       INT32U           size,
                                       INT16U           opt);



void          OS_TaskStatStkChk       (void);


INT8U         OS_TCBInit              (INT8U            prio,
                                       OS_STK          *ptos,
                                       OS_STK          *pbos,
                                       INT16U           id,
                                       INT32U           stk_size,
                                       void            *pext,
                                       INT16U           opt);


void          OSTmr_Init              (void);


 





 


void          OSDebugInit             (void);


void          OSInitHookBegin         (void);
void          OSInitHookEnd           (void);

void          OSTaskCreateHook        (OS_TCB          *ptcb);
void          OSTaskDelHook           (OS_TCB          *ptcb);

void          OSTaskIdleHook          (void);

void          OSTaskReturnHook        (OS_TCB          *ptcb);

void          OSTaskStatHook          (void);
OS_STK       *OSTaskStkInit           (void           (*task)(void *p_arg),
                                       void            *p_arg,
                                       OS_STK          *ptos,
                                       INT16U           opt);


void          OSTaskSwHook            (void);


void          OSTCBInitHook           (OS_TCB          *ptcb);


void          OSTimeTickHook          (void);


 





 


void          App_TaskCreateHook      (OS_TCB          *ptcb);
void          App_TaskDelHook         (OS_TCB          *ptcb);
void          App_TaskIdleHook        (void);

void          App_TaskReturnHook      (OS_TCB          *ptcb);

void          App_TaskStatHook        (void);


void          App_TaskSwHook          (void);


void          App_TCBInitHook         (OS_TCB          *ptcb);


void          App_TimeTickHook        (void);









 







 










 





 

#line 1402 "..\\..\\uCOS-II\\Source\\ucos_ii.h"






























 

#line 1440 "..\\..\\uCOS-II\\Source\\ucos_ii.h"


























 

#line 1478 "..\\..\\uCOS-II\\Source\\ucos_ii.h"














 

#line 1500 "..\\..\\uCOS-II\\Source\\ucos_ii.h"














 

#line 1526 "..\\..\\uCOS-II\\Source\\ucos_ii.h"






































 

#line 1572 "..\\..\\uCOS-II\\Source\\ucos_ii.h"






















 

#line 1602 "..\\..\\uCOS-II\\Source\\ucos_ii.h"























































#line 1664 "..\\..\\uCOS-II\\Source\\ucos_ii.h"





 





















 

#line 1700 "..\\..\\uCOS-II\\Source\\ucos_ii.h"

#line 1707 "..\\..\\uCOS-II\\Source\\ucos_ii.h"






#line 1719 "..\\..\\uCOS-II\\Source\\ucos_ii.h"
























 


























#line 1777 "..\\..\\uCOS-II\\Source\\ucos_ii.h"



































 

#line 1889 "..\\..\\uCOS-II\\Source\\ucos_ii.h"






	 	   	  			 		 	 	  		  	  			 			  		 	  				 	 		  	 	  	 		 		   		  	  			 				 		 		  	 	 	     	 					 	   	   	 	  	 		  	  			 	 	  		 		   		   	 			 
#line 26 "..\\..\\uCOS-II\\Ports\\ARM-Cortex-M0\\Generic\\RealView\\os_dbg.c"







 

  INT16U  const  OSDebugEn           = 1u;                



  INT32U  const  OSEndiannessTest    = 0x12345678L;                

  INT16U  const  OSEventEn           = (((0u > 0u) && (3u > 0u)) || (1u > 0u) || (1u > 0u) || (1u > 0u));
  INT16U  const  OSEventMax          = 10u;              
  INT16U  const  OSEventNameEn       = 1u;

  INT16U  const  OSEventSize         = sizeof(OS_EVENT);           
  INT16U  const  OSEventTblSize      = sizeof(OSEventTbl);         




  INT16U  const  OSEventMultiEn      = 1u;


  INT16U  const  OSFlagEn            = 1u;

  INT16U  const  OSFlagGrpSize       = sizeof(OS_FLAG_GRP);        
  INT16U  const  OSFlagNodeSize      = sizeof(OS_FLAG_NODE);       
  INT16U  const  OSFlagWidth         = sizeof(OS_FLAGS);           





  INT16U  const  OSFlagMax           = 5u;
  INT16U  const  OSFlagNameEn        = 1u;

  INT16U  const  OSLowestPrio        = 10u;

  INT16U  const  OSMboxEn            = 1u;

  INT16U  const  OSMemEn             = 1u;
  INT16U  const  OSMemMax            = 5u;            
  INT16U  const  OSMemNameEn         = 1u;

  INT16U  const  OSMemSize           = sizeof(OS_MEM);             
  INT16U  const  OSMemTblSize        = sizeof(OSMemTbl);




  INT16U  const  OSMutexEn           = 1u;

  INT16U  const  OSPtrSize           = sizeof(void *);             

  INT16U  const  OSQEn               = 0u;
  INT16U  const  OSQMax              = 3u;                  



  INT16U  const  OSQSize             = 0u;


  INT16U  const  OSRdyTblSize        = ((10u) / 8u + 1u);            

  INT16U  const  OSSemEn             = 1u;

  INT16U  const  OSStkWidth          = sizeof(OS_STK);             

  INT16U  const  OSTaskCreateEn      = 1u;
  INT16U  const  OSTaskCreateExtEn   = 1u;
  INT16U  const  OSTaskDelEn         = 1u;
  INT16U  const  OSTaskIdleStkSize   = 15u;
  INT16U  const  OSTaskProfileEn     = 1u;
  INT16U  const  OSTaskMax           = 7u + 2u;  
  INT16U  const  OSTaskNameEn        = 1u;
  INT16U  const  OSTaskStatEn        = 1u;
  INT16U  const  OSTaskStatStkSize   = 15u;
  INT16U  const  OSTaskStatStkChkEn  = 1u;
  INT16U  const  OSTaskSwHookEn      = 1u;

  INT16U  const  OSTCBPrioTblMax     = 10u + 1u;        
  INT16U  const  OSTCBSize           = sizeof(OS_TCB);             
  INT16U  const  OSTicksPerSec       = 1000u;
  INT16U  const  OSTimeTickHookEn    = 1u;
  INT16U  const  OSVersionNbr        = 292u;

  INT16U  const  OSTmrEn             = 1u;
  INT16U  const  OSTmrCfgMax         = 8u;
  INT16U  const  OSTmrCfgNameEn      = 1u;
  INT16U  const  OSTmrCfgWheelSize   = 8u;
  INT16U  const  OSTmrCfgTicksPerSec = 10u;


  INT16U  const  OSTmrSize           = sizeof(OS_TMR);
  INT16U  const  OSTmrTblSize        = sizeof(OSTmrTbl);
  INT16U  const  OSTmrWheelSize      = sizeof(OS_TMR_WHEEL);
  INT16U  const  OSTmrWheelTblSize   = sizeof(OSTmrWheelTbl);
#line 134 "..\\..\\uCOS-II\\Ports\\ARM-Cortex-M0\\Generic\\RealView\\os_dbg.c"



 





 


  INT16U  const  OSDataSize = sizeof(OSCtxSwCtr)

                                           + sizeof(OSEventFreeList)
                                           + sizeof(OSEventTbl)


                                           + sizeof(OSFlagTbl)
                                           + sizeof(OSFlagFreeList)


                                           + sizeof(OSCPUUsage)
                                           + sizeof(OSIdleCtrMax)
                                           + sizeof(OSIdleCtrRun)
                                           + sizeof(OSStatRdy)
                                           + sizeof(OSTaskStatStk)


                                           + sizeof(OSTickStepState)


                                           + sizeof(OSMemFreeList)
                                           + sizeof(OSMemTbl)
#line 174 "..\\..\\uCOS-II\\Ports\\ARM-Cortex-M0\\Generic\\RealView\\os_dbg.c"
                                           + sizeof(OSTime)


                                           + sizeof(OSTmrFree)
                                           + sizeof(OSTmrUsed)
                                           + sizeof(OSTmrTime)
                                           + sizeof(OSTmrSem)
                                           + sizeof(OSTmrSemSignal)
                                           + sizeof(OSTmrFreeList)
                                           + sizeof(OSTmrTbl)
                                           + sizeof(OSTmrWheelTbl)

                                           + sizeof(OSIntNesting)
                                           + sizeof(OSLockNesting)
                                           + sizeof(OSPrioCur)
                                           + sizeof(OSPrioHighRdy)
                                           + sizeof(OSRdyGrp)
                                           + sizeof(OSRdyTbl)
                                           + sizeof(OSRunning)
                                           + sizeof(OSTaskCtr)
                                           + sizeof(OSIdleCtr)
                                           + sizeof(OSTaskIdleStk)
                                           + sizeof(OSTCBCur)
                                           + sizeof(OSTCBFreeList)
                                           + sizeof(OSTCBHighRdy)
                                           + sizeof(OSTCBList)
                                           + sizeof(OSTCBPrioTbl)
                                           + sizeof(OSTCBTbl);



 
















 


void  OSDebugInit (void)
{
    void  *ptemp;


    ptemp = (void *)&OSDebugEn;

    ptemp = (void *)&OSEndiannessTest;

    ptemp = (void *)&OSEventMax;
    ptemp = (void *)&OSEventNameEn;
    ptemp = (void *)&OSEventEn;
    ptemp = (void *)&OSEventSize;
    ptemp = (void *)&OSEventTblSize;
    ptemp = (void *)&OSEventMultiEn;

    ptemp = (void *)&OSFlagEn;
    ptemp = (void *)&OSFlagGrpSize;
    ptemp = (void *)&OSFlagNodeSize;
    ptemp = (void *)&OSFlagWidth;
    ptemp = (void *)&OSFlagMax;
    ptemp = (void *)&OSFlagNameEn;

    ptemp = (void *)&OSLowestPrio;

    ptemp = (void *)&OSMboxEn;

    ptemp = (void *)&OSMemEn;
    ptemp = (void *)&OSMemMax;
    ptemp = (void *)&OSMemNameEn;
    ptemp = (void *)&OSMemSize;
    ptemp = (void *)&OSMemTblSize;

    ptemp = (void *)&OSMutexEn;

    ptemp = (void *)&OSPtrSize;

    ptemp = (void *)&OSQEn;
    ptemp = (void *)&OSQMax;
    ptemp = (void *)&OSQSize;

    ptemp = (void *)&OSRdyTblSize;

    ptemp = (void *)&OSSemEn;

    ptemp = (void *)&OSStkWidth;

    ptemp = (void *)&OSTaskCreateEn;
    ptemp = (void *)&OSTaskCreateExtEn;
    ptemp = (void *)&OSTaskDelEn;
    ptemp = (void *)&OSTaskIdleStkSize;
    ptemp = (void *)&OSTaskProfileEn;
    ptemp = (void *)&OSTaskMax;
    ptemp = (void *)&OSTaskNameEn;
    ptemp = (void *)&OSTaskStatEn;
    ptemp = (void *)&OSTaskStatStkSize;
    ptemp = (void *)&OSTaskStatStkChkEn;
    ptemp = (void *)&OSTaskSwHookEn;

    ptemp = (void *)&OSTCBPrioTblMax;
    ptemp = (void *)&OSTCBSize;

    ptemp = (void *)&OSTicksPerSec;
    ptemp = (void *)&OSTimeTickHookEn;


    ptemp = (void *)&OSTmrTbl[0];
    ptemp = (void *)&OSTmrWheelTbl[0];

    ptemp = (void *)&OSTmrEn;
    ptemp = (void *)&OSTmrCfgMax;
    ptemp = (void *)&OSTmrCfgNameEn;
    ptemp = (void *)&OSTmrCfgWheelSize;
    ptemp = (void *)&OSTmrCfgTicksPerSec;
    ptemp = (void *)&OSTmrSize;
    ptemp = (void *)&OSTmrTblSize;

    ptemp = (void *)&OSTmrWheelSize;
    ptemp = (void *)&OSTmrWheelTblSize;


    ptemp = (void *)&OSVersionNbr;

    ptemp = (void *)&OSDataSize;

    ptemp = ptemp;                              
}
