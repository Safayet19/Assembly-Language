.model small
.stack 100h

.data
    n       dw 0
    hexbuf  db 5 dup(?)                 ; 4 digits + '$'
    msgIn   db "Enter number: $"        ; <<< input line
    msgOut  db 13,10,"$"                ; just newline before output

.code
main proc
    mov ax, @data
    mov ds, ax

    ; ---- show input line ----
    lea dx, msgIn
    mov ah, 9
    int 21h

    ; ===== read decimal N (multi-digit) =====
    xor bx, bx                  ; BX = N

readN:
    mov ah, 1
    int 21h
    cmp al, 13                  ; Enter?
    je  doneRead

    sub al, '0'
    xor ah, ah
    mov cx, ax                  ; digit

    mov ax, bx
    mov si, 10
    mul si                      ; AX = BX*10
    add ax, cx
    mov bx, ax
    jmp readN

doneRead:
    mov n, bx

    ; newline before output
    lea dx, msgOut
    mov ah, 9
    int 21h

    ; ===== convert to hex into buffer =====
    mov ax, n

    lea si, hexbuf + 4          ; put '$' at end
    mov dl, '$'
    mov [si], dl
    dec si                      ; last digit position

    xor bl, bl                  ; BL = digit count

    cmp ax, 0
    jne conv_loop

    ; N = 0 => store '0'
    mov dl, '0'
    mov [si], dl
    inc bl
    jmp print_hex

conv_loop:
    xor dx, dx
    mov bp, 16
    div bp                      ; AX=quot, DX=rem

    mov dl, dl
    cmp dl, 9
    jbe is09
    add dl, 7
is09:
    add dl, '0'

    mov [si], dl
    dec si
    inc bl

    cmp ax, 0
    jne conv_loop

    inc si                      ; point to first digit

print_hex:
    mov dx, si
    mov ah, 9
    int 21h

    ; newline
    mov ah, 2
    mov dl, 13
    int 21h
    mov dl, 10
    int 21h

    ; print digit count
    mov dl, bl
    add dl, '0'
    mov ah, 2
    int 21h

exit:
    mov ah, 4Ch
    int 21h
main endp
end main
