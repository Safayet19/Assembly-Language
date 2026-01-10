.model small
.stack 100h

.data
   msg db "Enter Charachter: $"
   up  db 13,10,"Upper Case: $"
   low db 13,10,"Lower Case: $"

.code
main proc
    mov ax, @data
    mov ds, ax

    ; prompt
    lea dx, msg
    mov ah, 9
    int 21h

    ; read char
    mov ah, 1
    int 21h
    mov bl, al

    ; ---- Upper case ----
    lea dx, up
    mov ah, 9
    int 21h

    mov al, bl
    cmp al, 'a'
    jb  print_up
    cmp al, 'z'
    ja  print_up
    sub al, 32

print_up:
    mov dl, al
    mov ah, 2
    int 21h

    ; ---- Lower case ----
    lea dx, low
    mov ah, 9
    int 21h

    mov al, bl
    cmp al, 'A'
    jb  print_low
    cmp al, 'Z'
    ja  print_low
    add al, 32

print_low:
    mov dl, al
    mov ah, 2
    int 21h

exit:
    mov ah, 4Ch
    int 21h
main endp
end main
