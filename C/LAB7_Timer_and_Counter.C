#include <regx51.h> // include header file for 8052
#define TH0_init 0x3C //TH0 = 00111100
#define TL0_init 0xB8 //TL0 = 10110000
#define Timer0_int_exe_time 10 //the parameter can be changed

int counter = 0;
int light = 1 ;
void main( ){
TMOD = 0x01; //set timer0 to mode 1(16-bits timer) and timer0 gate=1	
IE = 0x82; //enable timer0 interrupt
P2 = 0xfe;
P1 = 0x01;
TL0 = TL0_init; TH0 = TH0_init; //set TH0 & TL0
TCON = 0x10; 
while(1){
}  
}
void timer0_interrupt(void) interrupt 1{ // ‘iinterrupt 1 is vector of INT0
	  if(P1==0x00){
    counter++;
			  if(counter==Timer0_int_exe_time){
				light*=2;
				if(light==256)
					light = 1;
				P2 = 0xff - light ;
				counter = 0;
			}
		}	
}



