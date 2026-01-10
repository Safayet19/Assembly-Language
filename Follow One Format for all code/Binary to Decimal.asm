.model small
.stack 100h

.data
   msg db "Enter Binary number: $"
   result db 13, 10, "Decimal: $" 

.code
main proc
    mov ax, @data
    mov ds, ax

    ; prompt
    lea dx, msg
    mov ah, 9
    int 21h 
    
    xor bx, bx
    read_digit:
        mov ah, 1  
        int 21h
        cmp al , 13
        je convert_decimal
        
        sub al , '0'
        xor ah, ah
        
        mov cx , ax
        mov ax, bx 
        mov si , 2
        mul si
        
        add ax , cx
        mov bx, ax
        jmp read_digit
    
    
    convert_decimal:
           lea dx, result
           mov ah, 9
           int 21h
           
           mov ax, bx
           cmp ax , 0
           jne dec_digit
           mov dl , '0'
           mov ah, 2
           int 21h
           jmp exit
     
     dec_digit:
        xor cx, cx
        
        hex_div:
            xor dx, dx
            mov bx , 10
            div bx
            
            push dx
            inc cx
            cmp ax , 0
            jne hex_div
   
   print: 
        pop dx
        add dl, '0'
        mov ah , 2  
        int 21h
        loop print

exit:
    mov ah, 4Ch
    int 21h
main endp
end main
