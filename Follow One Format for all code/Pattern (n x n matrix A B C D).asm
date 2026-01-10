.model small
.stack 100h

.data
   msg db "Enter Number:  $"

.code
main proc
    mov ax, @data
    mov ds, ax

    lea dx, msg
    mov ah, 9
    int 21h

    mov ah, 1
    int 21h
    sub al, '0'
    mov bl, al   ; n columns   
    mov cl, al   ; n rows
    xor ch, ch   ; cx = n

    ; new line
    mov ah, 2
    mov dl, 13
    int 21h
    mov dl, 10
    int 21h

outer_loop:
        push cx
        mov cl, bl   ; reload from BL (not AL)
        xor ch, ch 
        mov dl , 'A'

inner_loop:
        
        mov ah, 2
        int 21h  
        inc dl
        loop inner_loop

        mov ah, 2
        mov dl, 13
        int 21h
        mov dl, 10
        int 21h

        pop cx
        loop outer_loop

exit:
    mov ah, 4Ch
    int 21h
main endp
end main
