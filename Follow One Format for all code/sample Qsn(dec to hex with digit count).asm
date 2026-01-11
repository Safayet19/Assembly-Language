.model small
.stack 100h

.data
   n       dw ?
   
   msg     db "Enter NUmber: $"
   msgout  db 13, 10, "$"
   msgdig  db 13, 10, "Digits: $"

.code

main proc
    mov ax, @data
    mov ds, ax

    lea dx, msg
    mov ah, 9
    int 21h

    xor bx, bx
read:
    mov ah, 1
    int 21h
    cmp al, 13
    je  store

    sub al, '0'
    xor ah, ah

    mov cx, ax              ; CX = digit
    mov ax, bx              ; AX = current number
    mov si, 10
    mul si                  ; AX = AX * 10
    add ax, cx              ; FIX: add digit
    mov bx, ax

    jmp read

store:
    mov n, bx

    lea dx, msgout
    mov ah, 9
    int 21h

    mov ax, n
    cmp ax, 0
    jne hex_digit

    ; n == 0 -> print "0" and digit count = 1
    mov dl, '0'
    mov ah, 2
    int 21h
    mov bl, 1
    jmp print_count

hex_digit:
    xor cx, cx

hex_div:
    xor dx, dx
    mov si, 16
    div si                  ; AX = AX/16, DX = remainder
    push dx
    inc cx
    cmp ax, 0
    jne hex_div

    mov bl, cl              ; save digit count (e.g., FF -> 2)

print_hex:
    pop dx
    cmp dl, 9
    jbe print
    add dl, 7

print:
    add dl, '0'
    mov ah, 2
    int 21h
    loop print_hex

print_count:
    lea dx, msgdig
    mov ah, 9
    int 21h

    mov dl, bl
    add dl, '0'
    mov ah, 2
    int 21h

exit:
    mov ah, 4ch
    int 21h

main endp
end main
