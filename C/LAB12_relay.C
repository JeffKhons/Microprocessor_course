#include <regx51.h>
void delay(unsigned int);
void main( )
{
while(1)
{
P2_0 = 0; //relay & LED switch on
delay(5000);
P2_0 = 1; //relay & LED switch off
delay(5000);
}
}
void delay(unsigned int t)
{
while (t--);
}
