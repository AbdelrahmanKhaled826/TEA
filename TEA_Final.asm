.model small

org 100h
.data
  ; name               type initializer
    sum                 DW     0       ; initiated by 0 to sum on it
    delta               DW     8436h   ; any value you add
    v0                  DW     ?       
    v1                  DW     ?
    k0                  DW     012h    ; any value you add
    k1                  DW     261h    ; any value you add
    k2                  DW     084h    ; any value you add
    k3                  DW     36h     ; any value you add  
    WEL_msg             DB     'Welcome to "TEA" Program $'
    msg                 DB     0Dh,0Ah,'Enter the text of 4 letters: $' ;v0v1
    encrypting          DB     0Dh,0Ah,'Encrypting your message.... $'
    encryptedMsg        DB     0Dh,0Ah,'Encrypted text: $'
    decryptedMsg        DB     0Dh,0Ah,'Decrypted text: $' 
    error_INV_Msg       DB     0Dh,0Ah,'Error, Invalid input!! $'
    choiceMsg           DB     0Dh,0Ah,'Enter 1 for encryption, 2 for decryption or 3 to Exit.. $'
    error_choice_Msg    DB     0Dh,0Ah,'Error, Invalid Choice!! $'
    Exit_msg            DB     0Dh,0Ah,'                          SEE YOU ^_^ $'
     
.code  

main proc  
    
    ; "Welcome to 'TEA': " disp on the screen
    mov ah, 09h      ; display string (from "dx") on screen
    lea dx, WEL_msg      
    int 21h          ; Dos interrupt "do it"
        
    ; "Enter the text of 4 letters: " disp on the screen
    mov ah, 09h      
    lea dx, msg      
    int 21h           
    
    ; reading v0
    mov ah, 01h      ; read char (stored in "al")
    int 21h
    call validate_input  ; validate input character
    mov bh, al
    int 21h
    call validate_input
    mov bl, al
    mov v0, bx
    
    ; reading v1
    mov ah, 01h      
    int 21h
    call validate_input  ; validate input character
    mov bh, al
    int 21h 
    call validate_input
    mov bl, al
    mov v1, bx
    
Choice:
    ; "Enter 1 for encryption or 2 for decryption: " disp on the screen
    mov ah, 09h      ; display string (from "dx") on screen
    lea dx, choiceMsg
    int 21h          ; Dos interrupt "do it" 
    
    ; reading user choice
    mov ah, 01h      ; read char (stored in "al")
    int 21h
    cmp al, '1'
    je encrypt
    cmp al, '2'
    je decrypt
    cmp al, '3'
    jmp end_program
    ; Invalid choice, print error message and terminate
    jmp invalid_choice 
    
 
end_program:
    ;ExitMsg
    mov ah, 09h      ; display string (from "dx") on screen
    lea dx, Exit_msg      
    int 21h          ; Dos interrupt "do it" 
    ; stop the program
    mov ah, 4ch 
    int 21h 
    
    main endp
     
; ==================== encryption procedure ==================== ;
encrypt proc
        
    mov cx, 6       ; counter for loop
            
encLoop:      
    ; sum += delta  
    mov bx, delta
    mov ax, sum
    add ax, bx
    mov sum, ax
    
    ; v0 += ((v1<<4) + k0) ^ (v1 + sum) ^ ((v1>>5) + k1)  
    ;____________________________________________________________; 
    ; dx = ((v1<<4) + k0)
    mov ax, v1
    shl ax, 4
    mov bx, k0
    add ax, bx
    mov dx, ax
    ; dx ^= (v1 + sum)
    mov ax, v1
    mov bx, sum
    add ax, bx
    xor dx, ax
    ; dx ^= ((v1>>5) + k1)
    mov ax, v1
    shr ax, 5
    mov bx, k1
    add ax, bx
    xor dx, ax
    ; v0 += dx
    mov ax, v0
    add ax, dx
    mov v0, ax 
    
    ; v1 += ((v0<<4) + k2) ^ (v0 + sum) ^ ((v0>>5) + k3)
    ;____________________________________________________________;
    ; dx = ((v0<<4) + k2)
    mov ax, v0
    shl ax, 4
    mov bx, k2
    add ax, bx
    mov dx, ax
    ; dx ^= (v0 + sum)
    mov ax, v0
    mov bx, sum
    add ax, bx
    xor dx, ax
    ; dx ^= ((v0>>5) + k3)
    mov ax, v0
    shr ax, 5
    mov bx, k3
    add ax, bx
    xor dx, ax
    ; v1 += dx
    mov ax, v1
    add ax, dx
    mov v1, ax 
                  
loop encLoop          ; "loop" use "cx" as its counter     
        
            ; "Encrypting your message...." disp on the screen
    mov ah, 09h
    mov dx, offset encrypting
    int 21h 
    
    ; "Encrypted text: " disp on the screen
    mov ah, 09h
    mov dx, offset encryptedMsg ; = lea dx, encryptedMsg
    int 21h
    
    mov ah, 02h      ; write a character to screen (stored in "dl")
    ; print v0       
    mov bx, v0
    mov dl, bh             
    int 21h
    mov dl, bl
    int 21h
    
    ; print v1
    mov bx, v1
    mov dl, bh             
    int 21h
    mov dl, bl
    int 21h 
    
    jmp Choice    
        
    encrypt endp
; =================== END of encryption proc =================== ;           
                                                                       
                                                                       
                                                                       
                                                                       
; ==================== decryption procedure ==================== ;
    decrypt proc
        
    mov cx, 6       ; counter for loop
        
decLoop:      
    ; v1 -= ((v0<<4) + k2) ^ (v0 + sum) ^ ((v0>>5) + k3) 
    ;____________________________________________________________;
    ; dx = ((v0<<4) + k2)
    mov ax, v0
    shl ax, 4
    mov bx, k2
    add ax, bx
    mov dx, ax
    ; dx ^= (v0 + sum)
    mov ax, v0
    mov bx, sum
    add ax, bx
    xor dx, ax
    ; dx ^= ((v0>>5) + k3)
    mov ax, v0
    shr ax, 5
    mov bx, k3
    add ax, bx
    xor dx, ax
    ; v1 -= dx
    mov ax, v1
    sub ax, dx
    mov v1, ax
    
    ; v0 -= ((v1<<4) + k0) ^ (v1 + sum) ^ ((v1>>5) + k1) 
    ;____________________________________________________________;   
    ; dx = ((v1<<4) + k0)
    mov ax, v1
    shl ax, 4
    mov bx, k0
    add ax, bx
    mov dx, ax
    ; dx ^= (v1 + sum)
    mov ax, v1
    mov bx, sum
    add ax, bx
    xor dx, ax
    ; dx ^= ((v1>>5) + k1)
    mov ax, v1
    shr ax, 5
    mov bx, k1
    add ax, bx
    xor dx, ax
    ; v0 -= dx
    mov ax, v0
    sub ax, dx
    mov v0, ax 
    
    ; sum -= delta  
    mov bx, delta
    mov ax, sum
    sub ax, bx
    mov sum, ax 
    
loop decLoop          ; "loop" use "cx" as its counter     
     
         ; "Decrypted text: "  disp on the screen
    mov ah, 09h
    mov dx, offset decryptedMsg ; = lea dx, decryptedMsg
    int 21h    
     
    mov ah, 02h  
    ; print v0       
    mov bx, v0
    mov dl, bh             
    int 21h
    mov dl, bl
    int 21h
    
    ; print v1
    mov bx, v1
    mov dl, bh             
    int 21h
    mov dl, bl
    int 21h 
    
    jmp Choice
decrypt endp
; =================== END of decryption proc =================== ;    

validate_input proc
    ; Validate input character - only accept capital and small letters and numbers
    cmp al, 'A'     ;Jump to invalid_char if AL is below 'A'
    jb  invalid_char
    cmp al, 'Z'
    jbe valid_char
    cmp al, 'a'
    jb  invalid_char
    cmp al, 'z'
    jbe valid_char
    cmp al, '0'
    jb  invalid_char
    cmp al, '9'
    jbe valid_char
invalid_char:
    ; Print error message and terminate program
    mov ah, 09h
    lea dx, error_INV_Msg
    int 21h
    jmp end_program
valid_char:
    ret
validate_input endp
;----------------------------------------------------------------------------------- 
         ;Invalid_choice
invalid_choice:
    ; Print error message for invalid choice
    mov ah, 09h
    lea dx, error_choice_Msg
    int 21h
    jmp end_program 
 

end