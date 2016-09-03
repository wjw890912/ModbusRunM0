#ifndef  __rambuf_H__
#define  __rambuf_H__
extern unsigned char sendbuf[10],sendlen,sendlenn;
void raminit(void);
unsigned short CRC16_M(volatile unsigned char *puchMsg,unsigned short usDataLen );
#endif
