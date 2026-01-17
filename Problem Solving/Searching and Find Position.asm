.model small
.stack 21h

.data
msg     db "Enter your array : $"
output  db 13,10, "Array is : $"

smsg    db 13,10, "Enter value to search : $"
found  db 13,10, "Found at index = $"
notf    db 13,10, "Not Found$"

array   db 7 dup(?)
key     db ?

.code
main proc

    mov ax, @data
    mov ds, ax

    ; ---- input ----
    lea dx, msg
    mov ah, 9
    int 21h

    lea si, array
    mov cx, 7

array_input:
    mov ah, 1
    int 21h

    mov [si], al
    inc si

    mov ah, 2
    mov dl, ' '
    int 21h
    loop array_input

    ; ---- display array ----
    lea dx, output
    mov ah, 9
    int 21h

    lea si, array
    mov cx, 7

display:
    mov dl, [si]
    mov ah, 2
    int 21h

    mov dl, ' '
    mov ah, 2
    int 21h

    inc si
    loop display

    ; ---- search ----
    lea dx, smsg
    mov ah, 9
    int 21h

    mov ah, 1   ; take input value
    int 21h
    mov key, al

    lea si, array
    mov cx, 7
    mov bl, 0            ; index = 0

search_loop:
    mov al, [si]
    cmp al, key
    je  yes_found
    inc si
    inc bl
    loop search_loop

    lea dx, notf
    mov ah, 9
    int 21h
    jmp exit

yes_found:
    lea dx, found
    mov ah, 9
    int 21h

    ; print index 
    mov dl, bl
    add dl, '0'
    mov ah, 2
    int 21h

exit:
    mov ah, 4Ch
    int 21h

main endp
end main
