Tiny encryption and decryption generally refer to cryptographic  algorithms designed to be small, efficient, and suitable for  environments with limited resources, such as embedded systems, 
IoT devices, or applications where performance and memory usage are critical constraints. These algorithms aim to provide a reasonable level of security while being extremely lightweight.
Some characteristics of tiny encryption algorithm:
1)They consume less processing power and memory, making them suitable for low-power devices, They are designed to 
have a minimalistic codebase, which is essential for devices with limited memory.
2) Despite their small size, they are optimized for fast processing, which is crucial in real-time applications or devices with low computational power.
3) While they may not offer the same level of security as more complex algorithms, they provide adequate protection for 
many applications, especially where the risk level is relatively low


![image](https://github.com/AbdelrahmanKhaled826/TEA/assets/66374409/a338dd15-d3eb-4c8d-874f-c50340d6f724)


✓ The 128-bit key is divided into four 32-bit values: K[0], K[1],  K[2], K[3].
✓ Inputs to encryption algorithm are 64 bits of plain/cipher text, 128 bits of key and output is a cipher/plain text.
✓ It performs operations on 32bit words.
✓ Each round has 4 sub key k[i]. Each half of message is used to encrypt the other half over 64 rounds of processing and then combine to produce the cipher text block.
✓ A half block is processed and swapped iteratively and all operations are performed on modulo 32-bit.





### Assembly

![image](https://github.com/AbdelrahmanKhaled826/TEA/assets/66374409/5d45c5e1-15ab-4b90-ae5f-bbbca4f12a5f)

This code appears to be the beginning of an assembly language program. 
Here's a breakdown of the different sections:
.model small: This directive is typically used to define the memory model for the program. In this case, it's specifying a "small" memory model, 
which is often used for smaller programs running in environments like DOS.

org 100h: This directive sets the origin of the program to the address 100h, 
indicating where the program execution should start. In DOS, this is a common starting point for programs.
.data: This section declares various data items used in the program. 
Each line defines a variable with a name, type, and an optional initializer:
Variables like sum, delta, Y, Z, k0, k1, k2, k3 seem to be declared as 16-bit words (DW), some initialized with specific values.


![image](https://github.com/AbdelrahmanKhaled826/TEA/assets/66374409/f72cfc36-9c79-49f9-8500-d9100acb5a0d)

Put 9 in AH to print
Put address of  message in dx
Display from dx
Read character and store it in al
Compare if al is 1 or 2 or 3
Jump to valid function according choice 

Make Counter 6 loop by put 6 in cx to do encryption 6 times.
Put value of sum and delta in ax,bx
Add ax,bx and put value in sum
Put value of v1 in ax and shift left by 4
Add the value with k0
Do xor result with (v1+sum)
Shift right  v1 by 5 and added with k1 
Do xor 
Added result with v0
![image](https://github.com/AbdelrahmanKhaled826/TEA/assets/66374409/c1acf955-8580-4869-948d-3d2226f9bc8d)




## Invalid cases
• Data input must be only:
• Small latter a to z
• Capital later A to Z 
• Number from 0 to 9 
• Take only four character 
