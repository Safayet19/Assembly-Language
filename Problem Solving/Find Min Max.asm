.model small
.stack 21h

.data
msg    db "Enter your array: $"
minmsg db 13,10,"Min = $"
maxmsg db 13,10,"Max = $"

array  db 7 dup(?)
minv   db ?
maxv   db ?

.code
main proc
    mov ax, @data
    mov ds, ax

    ; prompt
    lea dx, msg
    mov ah, 9
    int 21h

    ; -------- input 7 digits --------
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

;==dhori 1st tai min , 1st tai max 

    mov al, array[0]
    mov minv, al
    mov maxv, al

    mov si, 1
    mov cx, 6

read:
    mov al, array[si]

    cmp al, minv
    jae not_min
    mov minv, al

    not_min:
        cmp al, maxv
        jbe no_max
        mov maxv, al
    
    no_max:
        inc si
        loop read

    ; -------- print MIN --------
    lea dx, minmsg
    mov ah, 9
    int 21h

    mov dl, minv
    mov ah, 2
    int 21h

    ; -------- print MAX --------
    lea dx, maxmsg
    mov ah, 9
    int 21h

    mov dl, maxv
    mov ah, 2
    int 21h

    exit:
        mov ah, 4Ch
        int 21h

main endp
end main
