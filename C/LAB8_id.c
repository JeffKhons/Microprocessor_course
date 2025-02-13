#include<regx51.h>
bit receive_full=1;
bit transmit_flag = 1;
char index = 0;
char rxbuf[9];
char *stuID = "E14109022";
char *correct = "Correct";
char *wrong = "Wrong";
char end[]={0x0D,0X0A};
int i= 0;

void init_UART(void){
    SCON=0x50;
    TMOD=0x20;
    TH1=0xe6;
    TR1=1;
    IE=0x90;
}

void UART_ISR()interrupt 4{
	if(RI){
		RI=0;
		rxbuf[index++]=SBUF;
		P2=rxbuf[index-1];
		index%=9;
		if(!index)
			receive_full = 1;
	}
	else{
		TI=0;
		transmit_flag=1;
	}
}
void send_msg(char *c){
	for(;*c!='\0';c++){
	while(!transmit_flag);
	transmit_flag= 0;
	SBUF= *c;
}
}

void chang_line(){
	for(i=0;i<2;i++){
		while(!transmit_flag);
			transmit_flag=0;
		SBUF = end[i];
	}
}

int check(){
	for(i = 0; i < 9; i++)
		if(*(stuID+i) !=*(rxbuf+i))
			return 1;
		return 0;
	}

void main(){
	init_UART();
	while(1){
		if(receive_full){
			receive_full = 0;
			chang_line();
			if(check()){
				send_msg(wrong);
				chang_line();
			}
			else{send_msg(correct);
				chang_line();
			}
		}
	}
}