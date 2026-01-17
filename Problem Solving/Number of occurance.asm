.model small
.stack 100h

.data
msg     db "Enter your array (7 digits): $"
ask     db 13,10,"Enter value to count: $"
outmsg  db 13,10,"Occurrence = $"

array   db 7 dup(?)
key     db ?
countv  db ?

.code
main proc
    mov ax, @data
    mov ds, ax

    ; prompt
    lea dx, msg
    mov ah, 9
    int 21h

    ; ---- input  ----
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

    ; ---- ask key ----
    lea dx, ask
    mov ah, 9
    int 21h

    mov ah, 1
    int 21h
    mov key, al

    ; ---- count occurrence ----
    lea si, array
    mov cx, 7
    xor bl, bl  ; BL = count

count_loop:
    mov al, [si]
    cmp al, key
    jne not_eq
    inc bl

not_eq:
    inc si
    loop count_loop
    mov countv, bl

    ; ---- print result ----
    lea dx, outmsg
    mov ah, 9
    int 21h
    
    mov dl, countv
    add dl , '0'
    mov ah , 2
    int 21h

    mov ah, 4Ch
    int 21h
main endp

end main
