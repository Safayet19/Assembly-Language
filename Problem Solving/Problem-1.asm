;Write a program that lets the user type some text
;consisting of words separated by blanks, ending with 
;a carriage return, and displays the text in the same 
;word order as entered, but with the letters in each word reversed.

;Example: "this is a test" becomes "siht si a tset". 

;=========================================================================

.model small
.stack 100h

.data
prompt  db "Enter text: $"


inbuf   db 80, 0, 80 dup(?)
wordbuf db 80 dup(?)

.code
main proc
    mov ax, @data
    mov ds, ax

    ; prompt
    mov ah, 09h
    mov dx, offset prompt
    int 21h

    ; read line
    mov ah, 0Ah
    mov dx, offset inbuf
    int 21h

    ; new line before output
    mov ah, 02h
    mov dl, 0Dh
    int 21h
    mov dl, 0Ah
    int 21h

    ; CX = number of typed chars
    xor cx, cx
    mov cl, [inbuf+1]

    mov si, offset inbuf+2   ; input chars start here
    xor bx, bx               ; BX = word length (0..)

scan:
    cmp cx, 0
    je  finish_line

    mov al, [si]
    cmp al, ' '
    je  got_space

    ; store char into wordbuf[bx]
    mov [wordbuf+bx], al
    inc bx

    inc si
    dec cx
    jmp scan

got_space:
    ; print current word in reverse (if bx > 0)
    cmp bx, 0
    je  only_space

    mov di, bx
    dec di

print_word1:
    mov dl, [wordbuf+di]
    mov ah, 02h
    int 21h

    cmp di, 0
    je  done_word1
    dec di
    jmp print_word1

done_word1:
    xor bx, bx               ; reset word length

only_space:
    ; print the space
    mov dl, ' '
    mov ah, 02h
    int 21h

    inc si
    dec cx
    jmp scan

finish_line:
    ; print last word in reverse (if any)
    cmp bx, 0
    je  done_all

    mov di, bx
    dec di

print_last:
    mov dl, [wordbuf+di]
    mov ah, 02h
    int 21h

    cmp di, 0
    je  done_all
    dec di
    jmp print_last

done_all:
    ; newline
    mov ah, 02h
    mov dl, 0Dh
    int 21h
    mov dl, 0Ah
    int 21h

    ; exit
    mov ah, 4Ch
    mov al, 00h
    int 21h
main endp

end main
