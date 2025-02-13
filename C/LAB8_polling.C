#include <regx52.h>
void init_uart( ); //declare UART function
char recivevalue ; //receive data
void main(){
	init_uart();
	while (1){
		while (RI == 0); //wait recieve flag == 1
			RI = 0; //clear flag
			recivevalue = SBUF;
			P2 = recivevalue;     //LED display data
		while (TI == 0); //wait transmit flag
			TI=0; //clear flag
		if (recivevalue == 'q'){ 
			SBUF = 0x0D;			//load data
		}
	}
}
void init_uart( ){
		SCON=0x50; // Mode1
		TMOD=0x20; // Timer1 Mode2
		TH1=0xe6; //  set BAUD=1200
		TR1=1; //  enable TCON Timer1
}