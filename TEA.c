#include <stdio.h>
// Global variables
int sum = 0;
int delta = 0x8436;
int v0, v1;
int k0 = 0x012;
int k1 = 0x261;
int k2 = 0x084;
int k3 = 0x36;
int indication;
// Function prototypes
void encrypt();
void decrypt();
void validate_input(short* result);
int main() {
char choice;
// "Welcome to 'TEA': " disp on the screen
printf("Welcome to \"TEA\" Program\n");
// "Enter the text of 4 letters: " disp on the screen
printf("Enter the text of 4 letters: ");
// reading v0
validate_input(&v0);
// reading v1
validate_input(&v1);
Choice:
if (indication!=1)
{
// "Enter 1 for encryption, 2 for decryption or 3 to Exit.. " disp on the screen
printf("Enter 1 for encryption, 2 for decryption or 3 to Exit: ");
// reading user choice
scanf(" %c", &choice);
switch (choice)
{
case '1':
encrypt();
break;
case '2':
decrypt();
break;
case '3':
printf("SEE YOU ^_^\n");
return 0;
default:
printf("Error, Invalid Choice!!\n");
break;
}
}
else
return 0;
goto Choice;
return 0;
}
// ==================== encryption procedure ==================== ;
void encrypt() {
int i;
for (i = 0; i < 6; ++i) {
// sum += delta
sum += delta;
// v0 += ((v1<<4) + k0) ^ (v1 + sum) ^ ((v1>>5) + k1)
v0+= ((v1 << 4) + k0) ^ (v1 + sum) ^ ((v1 >> 5) + k1);
// v1 += ((v0<<4) + k2) ^ (v0 + sum) ^ ((v0>>5) + k3)
v1+= ((v0 << 4) + k2) ^ (v0 + sum) ^ ((v0 >> 5) + k3);
}
// "Encrypting your message...." disp on the screen
printf("Encrypting your message....\n");
// "Encrypted text: " disp on the screen
printf("Encrypted text: %c %c %c %c\n", v0,v0>>8, v1,v1>>8);
}
// =================== END of encryption proc =================== ;
// ==================== decryption procedure ==================== ;
void decrypt() {
int i;
for (i = 0; i < 6; ++i) {
// v1 -= ((v0<<4) + k2) ^ (v0 + sum) ^ ((v0>>5) + k3)
int dx = ((v0 << 4) + k2) ^ (v0 + sum) ^ ((v0 >> 5) + k3);
v1 -= dx;
// v0 -= ((v1<<4) + k0) ^ (v1 + sum) ^ ((v1>>5) + k1)
dx = ((v1 << 4) + k0) ^ (v1 + sum) ^ ((v1 >> 5) + k1);
v0 -= dx;
// sum -= delta
sum -= delta;
}
// "Decrypted text: " disp on the screen
printf("Decrypted text: %c %c %c %c\n", v0>>8,v0, v1>>8,v1);
}
// =================== END of decryption proc =================== ;
// Validate input character - only accept capital and small letters and numbers
void validate_input(short* result) {
short input;
char c,d,*ptr;
for(char i=0;i<2;i++)
{
c=getchar();
input =(input<<8)|c;
ptr=&input;
d=*ptr;
}
for (int i=0; i<2; i++)
{
if ((d >= 'A' && d <= 'Z') || (d>= 'a' && d <= 'z') || (d >= '0' && d <= '9'))
{
d=input>>8;
}
else
{
printf("not valid char");
indication++;
break;
}
}
*result=input;
}
