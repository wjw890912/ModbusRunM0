






	  ������־

 MODBUS RTU ��Ҫ����˻���RS485�� M0�ϵĲ�Ʒ�������д��
 �����Ѿ�˳������ ARM ��˾�� M3�ں�CPU��M4�ں�CPU���У�
 ����M4�ں�CPU��MODBUS ���Ѿ�������Ŀ��ȥ�ˡ�

1����ֲMODBUS1.60��M051ϵ���ϡ�
1�����޸�MODBUSЭ��ջ���ϲ�Ӧ����Ȧ�ͱ��ּĴ���ȫ����Ϊ8���ֽ�
/* -----------------------Slave Defines -------------------------------------*/
#define S_DISCRETE_INPUT_START        1
#define S_DISCRETE_INPUT_NDISCRETES   8
#define S_COIL_START                  1
#define S_COIL_NCOILS                 8
#define S_REG_INPUT_START             1
#define S_REG_INPUT_NREGS             8
#define S_REG_HOLDING_START           1
#define S_REG_HOLDING_NREGS           8
/* -----------------------Master Defines -------------------------------------*/
#define M_DISCRETE_INPUT_START        1
#define M_DISCRETE_INPUT_NDISCRETES   8
#define M_COIL_START                  1
#define M_COIL_NCOILS                 8
#define M_REG_INPUT_START             1
#define M_REG_INPUT_NREGS             8
#define M_REG_HOLDING_START           1
#define M_REG_HOLDING_NREGS           8
2�����޸Ķ�ʱ���ļ�������20KHZ�Ķ�ʱ��1.
3�����޸Ĵ����շ��Լ����Ϳ��жϺͽ����жϡ�
4����Ԥ��������Ϊ9600  NONEУ�� ����λ8 ֹͣ1 
20160902

2��Ӳ����ʹ�õ����ڱ��ص�����Ƶ�4·�ƿؼ̵�����PCB�塣
1��RS485�������Զ��ģ������ǿ��·��Ҧ��ԭ������ƣ������⡣
���͵�ʱ����տ����յ������ֽڡ�����������MODBUSЭ��ջ���ϱ�һ������Ĵ��롣
����ѭ�������������ͷ籩����������·�޸��˴�����쳣�����֣���ǿ�ƹرմ���MODBUS�����ϱ���
ֵ��ע����ǣ������Լ��������Ӧ��ȥ������Ķ�����Ϊ�ҵ��Ǹ���·��OK�ġ����޸�Ҳ���Ե��Ǿ�û���˴�����ϵĹ��ܡ�
�޸���
/* If the request was not sent to the broadcast address we
             * return a reply. */
            if( ucRcvAddress != MB_ADDRESS_BROADCAST )
            {
                if( eException != MB_EX_NONE )
                {
                    /* An exception occured. Build an error frame. */
                    usLength = 0;
                    ucMBFrame[usLength++] = ( UCHAR )( ucFunctionCode | MB_FUNC_ERROR );
                    ucMBFrame[usLength++] = eException;
					break;
					/*��Ϊ����ӦҦ����·�����ķ��ͽ��տ����յ��������ղ�ȫ����
					���break��Ϊ�˱���MODBUS���յ��������ݶ��ϱ�����״̬�롣
					���Լ����Զ��շ���·�����޸ġ�
                	*/
				}
                eStatus = peMBFrameSendCur( ucMBAddress, ucMBFrame, usLength );


����Ĵ�����м�����һ��break���Ǵ�����ǰ������:)


2����ʹ��MODBUS poll ���ж�ȡHOLD�Ĵ���ֵ0-5 OK ����OK ��
20160902


