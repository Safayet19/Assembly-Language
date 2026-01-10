.model small
.stack 100h

.data
   msg db "Enter Number:  $"
   

.code
main proc
    mov ax, @data
    mov ds, ax

    ; prompt
    lea dx, msg
    mov ah, 9
    int 21h 
    
    mov ah, 1
    int 21h
    sub al , '0'
    mov cl , al
    
    ;====new line=====
    mov ah, 2
    mov dl, 13
    int 21h
    mov dl , 10
    int 21h
    
    
    xor ch, ch
    outer_loop: 
        push cx 
                
        mov bl , 'a'
        inner_loop:
            
            mov dl , bl 
            mov ah, 2
            int 21h  
            
            mov dl , ' '
            mov ah, 2
            int 21h
            
            inc bl 
            
            loop inner_loop
        
        mov ah, 2
        mov dl, 13
        int 21h
        mov dl , 10
        int 21h
        
        pop cx   ; outer cx 
        dec cx   ; star 1 less
        jnz outer_loop

exit:
    mov ah, 4Ch
    int 21h
main endp
end main
