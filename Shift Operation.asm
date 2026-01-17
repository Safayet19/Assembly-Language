.model small
.stack 100h
.data
.code

main proc
    mov ax, @data
    mov ds, ax

    mov ax, 1
    shl ax, 1          ; AX = 2

    mov bx, 0
    shr bx, 2          ; BX = 0

    add ax, bx         ; AX = 2
    shl ax, 2          ; AX = 8   (0..9)

    ; print AX (single digit)
    mov dl, al
    add dl, '0'
    mov ah, 2
    int 21h

    mov ah, 4Ch
    int 21h
main endp

end main
