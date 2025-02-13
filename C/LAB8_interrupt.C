#include <regx52.h>
void init_uart( ); //declare UART function
char recivevalue; //receive data
void main( )
{
init_uart( );
while (1);
}
void init_uart( )
{
SCON = 0x50; //Mode1
TMOD = 0x20; //Timer1 Mode2
TH1 = 0xe6; //set Baud=1200
TR1 = 1; //enable TCON Timer1
IE = 0x90; //enable UART
}
void UART_Isr(void) interrupt 4 //UART
{
while (RI == 0); //wait recieve flag == 1
RI = 0; //clear flag
recivevalue = SBUF;
P2 = recivevalue; //LED display data
if (recivevalue == 'q')
{
SBUF = recivevalue; //load data
while (TI == 0); //wait transmit flag == 1
TI=0; //clear flag
}
}