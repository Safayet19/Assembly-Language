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
    
    mov si , 1
    xor ch, ch
    outer_loop:
        push cx  
        mov cx , si
        mov bl , 1 ; ekhane jeta print korate chai seta
        
        inner_loop:
            
            mov ah, 2
            mov dl , bl 
            add dl , '0'
            int 21h 
            inc bl
            
            loop inner_loop
        
        mov ah, 2
        mov dl, 13
        int 21h
        mov dl , 10
        int 21h
        
        pop cx   ; outer cx 
        inc si   ; star 1 incrment  
        loop outer_loop

exit:
    mov ah, 4Ch
    int 21h
main endp
end main
