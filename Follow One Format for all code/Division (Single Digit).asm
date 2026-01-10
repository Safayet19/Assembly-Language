.model small
.stack 100h

.data
    num1 db "Enter Dividend: $"
    num2 db 13,10, "Enter Divisor: $"
    
    quotient db 13,10, "Quotient: $"
    remainder db 13,10, "Remainer: $"
    error db 13, 10, "Can't Divided by zero $"
    
    n1 db ?
    n2 db ?
    r db ?
    q db ?
   
.code

main proc
     
     mov ax, @data
     mov ds, ax
     
     ;=======input dividend======   
     lea dx, num1
     mov ah, 9
     int 21h
     
     mov ah , 1
     int 21h
     sub al , '0'
     mov n1, al
     
     ;=======input divisor======   
     lea dx, num2
     mov ah, 9
     int 21h
     
     mov ah , 1
     int 21h
     sub al , '0'
     mov n2, al 
     
     cmp al, 0 ; zero hole vag jabena
     je div_error: 
        
    ;=======Divison======
    mov al , n1
    xor ah, ah
    div n2
    mov q, al ; quotient
    mov r, ah ; remainder
    
    ;===print=====
     lea dx, quotient
     mov ah, 9
     int 21h     
     
     mov al, q
     add al , '0'
     mov dl , al
     mov ah, 2
     int 21h
     
     lea dx, remainder
     mov ah, 9
     int 21h     
     
     mov al, r
     add al , '0'
     mov dl , al
     mov ah, 2
     int 21h 
     jmp exit
     
     div_error:
     lea dx, error
     mov ah, 9
     int 21h  
     jmp exit 
        
     exit:
        mov ah, 4ch
        int 21h
        
    
main endp
end main