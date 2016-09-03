/* ----------------------- System includes ----------------------------------*/
#include "stdlib.h"
#include "string.h"

/* ----------------------- Platform includes --------------------------------*/
#include "port.h"

/* -----------------------  includes ----------------------------------*/
#include "mb.h"
#include "mbframe.h"
#include "mbproto.h"
#include "mbconfig.h"
#include "mb.h"
#include "mbrtu.h"
#include "mbcrc.h"
#include "mbport.h"
/* ----------------------- board include ----------------------------------*/
#include "M051Series.h"
/* ----------------------- Static functions ---------------------------------*/
eMBException    prveMBError2Exception( eMBErrorCode eErrorCode );
/* ----------------------- Start implementation -----------------------------*/

#ifdef _USE_BITTLE_PROTOCOL
/*
						MYSELF PROTOCOL FARME

		 0	1	  2		  3		4-5	 6-7   8-9	   10	11
		FF AA  + ADDR + FUNC + STA + STO + CRC +   0D  0A
		  1B 1B   1B     1B	  2B	2B	  2B	  1B 1B
		
		The  <pucFrame> is begain "FUNC " and it's data output buff too! 
		so the 	 usLen is sampl to 	pucFrame input or output used .

					 
					 FUNC must ==  BT_FUNC_READ_HOLDING_REGISTER

*/
eMBException
eBTFuncReadHoldingRegister( UCHAR * pucFrame, USHORT * usLen )
{

    USHORT          usRegAddress;
    eMBException    eStatus = MB_EX_NONE;
    eMBErrorCode    eRegStatus;

    if( pucFrame[0] ==0x04)//ensure them is bt protocol
    {
			/*
			02：采集电能整数部分 XXX KW.H
			04：采集电能小数部分 x.XX KW.H
			05：采集电流
			06：采集电压
			*/
      	  switch(pucFrame[1])
		  {
		  	case 0x02:
			//电能整数部分
			pucFrame[0] =0x08;//need change to 08
			pucFrame[1] =0x02;
			//data
			pucFrame[2] =0x00;
			pucFrame[3] =0x89;	  //repos
			pucFrame[4] =0x00;
			pucFrame[5] =0x00;
			*usLen=	6;//data len

			break;
			case 0x04:
			//电能小数部分
			pucFrame[0] =0x06;//need change to 08
			pucFrame[1] =0x04;
			//data
			pucFrame[2] =0;
		    pucFrame[3] =0x0;
		//	FF 55 05 00 02 00 06 04 00 0A 8F 02 ：
			*usLen=	4;//data len
			break;
			case 0x05:
			//电流
			pucFrame[0] =0x06;//need change to 08
			pucFrame[1] =0x05;
			//data
			pucFrame[2] =3;
		    pucFrame[3] =0xe8;
			*usLen=	4;//data len
		//	FF 55 05 00 02 00 06 05 00 02 39 3A 
			break;
			case 0x06:
			//电压
			pucFrame[0] =0x06;//need change to 08
			pucFrame[1] =0x06;
			//data
			pucFrame[2] =22000>>8;
		    pucFrame[3] =22000;
			*usLen=	4;//data len
		//	FF 55 05 00 02 00 06 06 00 00 40 28 
			break;
		   }
  			/*pucFrame[1] =0x01;
			pucFrame[2] =0x02;
			pucFrame[3] =0x03;
			pucFrame[4] =0x04;
			pucFrame[5] =0x05;
			pucFrame[6] =0x06;	 //data area
			pucFrame[7] =0x07;
			pucFrame[8] =0x08;
			*usLen=	9;//data len
			   */
			eRegStatus=	MB_ENOERR;
        /* If an error occured convert it into a Modbus exception. */
        if( eRegStatus != MB_ENOERR )
        {
            eStatus = prveMBError2Exception( eRegStatus );
        }



    }
    else
    {
        /* Can't be a valid request because the length is incorrect. */
        eStatus = MB_EX_ILLEGAL_DATA_VALUE;
    }
    return eStatus;

}
#endif


