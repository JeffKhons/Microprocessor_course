#include <regx51.h>
#include <string.h>
void print_msg(char[]);
void write(char, int);
void delay(unsigned int);
void display();
void display_for_interupt1();
void runhorse();
int count,count0,count1;
int i;
void main( ){
	IE = 0x85;
	IP = 0x04;
	count = 0;
	count0 = 0;											// interrupt 0 counter
	count1 = 0;
	write(0x38, 0);              		// use 2 lines and 5x7 matrix
	write(0x0C, 0);                 // LCD ON, cursor ON, cursor blinking ON
	write(0x06, 0);									// interrupt 1 counter
	write(0x01, 0);
	while (1){			
		if(count == 0){
			display();
		}
		else{
			display_for_interupt1();
		}
	}
}
void print_msg(char msg[]){
		int i;
		for (i=0; i<strlen(msg); i++)    // for every character
		write(msg[i], 1);                // monitor displays character
}
void write(char cmd, int rs_value){
		P2 = cmd; // P2=cmd
		P3_0 = rs_value; // RS=rs (1or0)
		P3_1 = 1; // ENABLE high
		delay(100);
		P3_1 = 0; // ENABLE low
}
void delay(unsigned int i){
		while (i--);
}

void INT0_interrupt(void) interrupt 0{
		delay(30000);
		if(count == 1){
			count = 0;
			count1 = 0;
		}
		count0++;
}

void INT1_interrupt(void) interrupt 2{
	  delay(30000);
		if(count == 0){
			count = 1;
			count0 = 0;
		}
		count1++;
}

void display(){
		if(count0 == 0){
			if (P1 < 80){
				write(0x01, 0);
				write(0x80, 0);
				print_msg("LOW");
					if(P1 < 20){
					write(0xC0, 0);
					print_msg("=");
					}
					else{
					write(0xC0, 0);
					print_msg("====");
					}
				delay(100000);
			}
			else if(P1 > 80 && P1 < 170){
				write(0x01, 0);
				write(0x80, 0);
				print_msg("MIDDLE");
					if(P1 > 100 && P1 < 140){
					write(0xC0, 0);
					print_msg("======");
					}
					else{
					write(0xC0, 0);
					print_msg("=========");
					}
				delay(100000);
			}
			else if(P1 > 170 && P1 < 255){
				write(0x01, 0);
				write(0x80, 0);
				print_msg("HIGH");
					if(P1 > 170 && P1 < 200){
					write(0xC0, 0);
					print_msg("===========");
					}
					else{
					write(0xC0, 0);
					print_msg("==============");
					}
				delay(100000);
			}
			else write(0x01, 0);
		}			
		else if(count0 == 1){
			delay(1000);                
			write(0x01, 0);   							// clear
		}
	  else if(count0 == 2){
			write(0x80, 0);
			print_msg("E14109022");   			// display E14109022!
			
			write(0x40, 0);           			// CGRAM
			write(0x00, 1);
			
			write(0x41, 0);
			write(0x09, 1);
			
			write(0x42, 0);
			write(0x09, 1);
			
			write(0x43, 0);
			write(0x00, 1);
			
			write(0x44, 0);
			write(0x11, 1);
			
			write(0x45, 0);
			write(0x0E, 1);
			
			write(0x46, 0);
			write(0x00, 1);
			
			write(0x8E, 0);
			write(0x00, 1);
			
			write(0x48, 0);
			write(0x00, 1);
			
			write(0x49, 0);
			write(0x0A, 1);
			
			write(0x4A, 0);
			write(0x1F, 1);
			
			write(0x4B, 0);
			write(0x1F, 1);
			
			write(0x4C, 0);
			write(0x0E, 1);
			
			write(0x4D, 0);
			write(0x04, 1);
			
			write(0x4E, 0);
			write(0x00, 1);
				
			write(0x8F, 0);
			write(0x01, 1);
	  }
		
		else if(count0 == 3){
			write(0x01, 0);
			delay(1000);
			write(0x80, 0);
			print_msg("BEST(1)");       	// display BEST!
      write(0xC0, 0);
			print_msg("WORST(2)");       // display WORST!
			delay(100000);
		}
		else{
		  delay(50);
		}
}

void display_for_interupt1(){
	  if(count1 == 1){
			write(0x01, 0);
			write(0x80, 0);
			print_msg("Final Exam");       	// display Final Exam!
			delay(100000);
		}
		else if(count1 == 2){
			delay(1000);
			write(0x01, 0);
			write(0x80, 0);
			runhorse();
		}
		else if(count1 == 3){
			delay(1000);
			write(0x01, 0);
			write(0x80, 0);
			print_msg("Final Exam");       	// display Final Exam!			
			for(i = 0;i < 10; i++){
				write(0x18, 0);
				delay(20000);
			}
			for(i = 0;i < 100; i++){
				write(0x8F, 0);
				print_msg("      Final Exam");
				write(0x18, 0);
				delay(20000);
			}
		}
		else delay(30);
}
void runhorse(){
		write(0x80, 0);
		print_msg("Final Exam");       	// display TA IS BEST runhorse!
			for(i = 1; i < 17; i++){
				if(i==1){
					write(0x80, 0);
					print_msg("Final Exam");
				}
				else if(i==2){
					write(0x01, 0);
					write(0x80, 0);
					print_msg(" Final Exam");
				}
				else if(i==3){
					write(0x01, 0);
					write(0x80, 0);
					print_msg("  Final Exam");
				}
				else if(i==4){
					write(0x01, 0);
					write(0x80, 0);
					print_msg("   Final Exam");
				}
				else if(i==5){
					write(0x01, 0);
					write(0x80, 0);
					print_msg("    Final Exam");
				}
				else if(i==6){
					write(0x01, 0);
					write(0x80, 0);
					print_msg("     Final Exam");
				}
				else if(i==7){
					write(0x01, 0);
					write(0x80, 0);
					print_msg("      Final Exam");
				}
				else if(i==8){
					write(0x01, 0);
					write(0x80, 0);
					print_msg("m      Final Exa");
				}
				else if(i==9){
					write(0x01, 0);
					write(0x80, 0);
					print_msg("am      Final Ex");
				}
				else if(i==10){
					write(0x01, 0);
					write(0x80, 0);
					print_msg("xam      Final E");
				}
				else if(i==11){
					write(0x01, 0);
					write(0x80, 0);
					print_msg("Exam      Final ");
				}
				else if(i==12){
					write(0x01, 0);
					write(0x80, 0);
					print_msg(" Exam      Final");
				}
				else if(i==13){
					write(0x01, 0);
					write(0x80, 0);
					print_msg("l  Exam      Fina");
				}
				else if(i==14){
					write(0x01, 0);
					write(0x80, 0);
					print_msg("al  Exam      Fin");
				}
				else if(i==15){
					write(0x01, 0);
					write(0x80, 0);
					print_msg("nal  Exam      Fi");
				}
				else if(i==16){
					write(0x01, 0);
					write(0x80, 0);
					print_msg("inal  Exam      F");
				}
				else{
					write(0x01, 0);
					write(0x80, 0);
					print_msg("Final  Exam      ");
				}
				delay(30000);
			}
}		
