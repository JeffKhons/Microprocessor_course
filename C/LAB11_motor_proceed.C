#include<regx51.h>
void delay(int); 
void turn();

code char one_phase[] = {0x01,0x02,0x04,0x08};
code char two_phase[] = {0x08,0x04,0x02,0x01};
code char three_phase[] = {0x01, 0x03, 0x02, 0x06, 0x04, 0x0C, 0x08, 0x09};
code char four_phase[] = {0x09, 0x08, 0x0C, 0x04, 0x06, 0x02, 0x03, 0x01};
int dir , delay_time;

void main ()
{
	IP = 0x04;
	IE = 0x85;
	delay_time = 3000;
	dir = 0; 
	while(1)
	{
		turn();
	}
}
void INT0_interrupt(void) interrupt 0
{
	if(dir == 0)
		dir = 1;
	else if(dir == 1)
		dir = 0;
	else if(dir == 2)
		dir = 3;
	else if(dir == 3)
		dir = 2;
}
void INT1_interrupt(void) interrupt 2
{
	if(dir == 0)
		dir = 2;
	else if(dir == 1)
		dir = 3;
	else 
		dir = dir;
}
void turn() 
{
	int x;
	if(dir == 0) //one phase, turn right
	{
		for(x=0;x<4;x++)
		{
			P1=one_phase[x]; 
			delay(delay_time);
		}
	}
	else  if(dir == 1)//two phase, turn left 
	{
		for(x=0;x<4;x++)
		{
			P1=two_phase[x]; 
			delay(delay_time);
		}
	}
	else if(dir == 2)
	{
		delay_time = 1000;
		for(x=0;x<8;x++)
		{
			P1=three_phase[x]; 
			delay(delay_time);
		}
	}
	else if(dir == 3)
	{
		delay_time = 1000;
		for(x=0;x<8;x++)
		{
			P1=four_phase[x]; 
			delay(delay_time);
		}
	}
}
void delay(int t)
{
	while(t--);
}