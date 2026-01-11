.model small
.stack 100h

.data

    msg db "Enter loop number: $" 
    n dB ?

.code

main proc

    mov ax, @data
    mov ds, ax
    
    
    lea dx, msg
    mov ah, 9
    int 21h
    
    mov ah, 1
    int 21h 
    sub al , '0'
    mov cl , al
    mov n , al
    
     mov ah, 2 
     mov dl, 13
     int 21h
     mov dl , 10 
     int 21h  
     
    xor ch , ch 
    mov si , 1
    outer_loop:
        push cx
        mov cx , si
        
        inner_loop: 
           
            mov ah , 2 
            mov dl , '*'
            int 21h 
            loop inner_loop
         
         mov ah, 2
         mov dl, 13
         int 21h
         mov dl , 10 
         int 21h
         
         pop cx 
         inc si
         loop outer_loop  
     
    xor ch , ch 
    mov cl , n
    dec cl
    outer_loop1:
        push cx
        inner_loop1: 
           
            mov ah , 2 
            mov dl , '*'
            int 21h 
            loop inner_loop1
         
         mov ah, 2
         mov dl, 13
         int 21h
         mov dl , 10 
         int 21h
         
         pop cx 
         dec cx
         jnz outer_loop1
                          
    
    exit:
        mov ah, 4ch
        int 21h
    
    

main endp

end main




