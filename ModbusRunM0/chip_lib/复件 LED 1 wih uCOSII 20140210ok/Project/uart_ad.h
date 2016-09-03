
#ifndef  __uart_H__
#define  __uart_H__
void usart1_init(UART_T* UART);
void usart1_send(unsigned char data);
void usart1_sendbuf(unsigned char n);
void T_set_mode(void);
void T_set_mode1(void);
#endif
