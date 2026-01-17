.model small
.stack 100h

.data
msg    db "Enter your array (7 digits): $"
summsg db 13,10,"Sum = $"
array  db 7 dup(?)
sumv   db ?

.code
main proc
    mov ax, @data
    mov ds, ax

    ; prompt
    lea dx, msg
    mov ah, 9
    int 21h

    ; ---- input ----
    lea si, array
    mov cx, 7

input:
    mov ah, 1
    int 21h 
             
    mov [si], al
    inc si

    mov ah, 2
    mov dl, ' '
    int 21h
    loop input

    ; ---- sum ----
    xor ax, ax
    lea si, array
    mov cx, 7

sum_loop:
    mov bl, [si]
    sub bl, '0'
    add al, bl
    inc si
    loop sum_loop

    mov sumv, al  ; save sum

    ; print "Sum = "
    lea dx, summsg
    mov ah, 9
    int 21h

    ; -------- print sum --------
    xor bx, bx
    mov bl, sumv
    mov ax, bx
    
    xor cx, cx
    convert:
        xor dx, dx
        mov si, 10
        div si
        push dx
        inc cx
        cmp ax, 0
        jne convert
    
    print:
        pop dx
        add dl, '0'
        mov ah, 2
        int 21h
        loop print
    
        mov ah, 4Ch
        int 21h
main endp

end main
