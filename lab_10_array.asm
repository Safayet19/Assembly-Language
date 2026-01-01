.model small
.stack 21h

.data
   
   array dB 2, 5, 4, 8, 7, 6, 2
   msg dB "The inserted array is : $" 
   
   ;array1 dB 7 dup(4)
   
   
.code
main proc
    
    mov ax, @data
    mov ds, ax
    
    lea dx, msg
    mov ah, 9
    int 21h   
    
    lea si, array1
    mov cx, 7
    
    array_print:
        mov dl , [si]
        add dl , 48
        
        inc si
        mov ah , 2
        int 21h  
        
        mov dl , " " 
        int 21h
        
        loop array_print
    
    
    
    exit:
        mov ah, 4ch
        int 21h

main endp

ret
