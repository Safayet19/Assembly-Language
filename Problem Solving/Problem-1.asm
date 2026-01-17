;Write a program that lets the user type some text
;consisting of words separated by blanks, ending with 
;a carriage return, and displays the text in the same 
;word order as entered, but with the letters in each word reversed.

;Example: "this is a test" becomes "siht si a tset". 

;=========================================================================

.model small
.stack 100h

.data
prompt db "Enter text: $"
line   db 200 dup(0)       

.code
main proc
    mov ax, @data
    mov ds, ax

    ; print prompt
    lea dx, prompt 
    mov ah, 9
    int 21h

    ; ===== Read full line into 'line' =====
    lea si, line
    xor cx, cx              ; CX = length

read_loop:
    mov ah, 1            ;read input
    int 21h     

    cmp al, 13              ; Enter?
    je  read_done

    mov [si], al            ; store char
    inc si
    inc cx

    jmp read_loop

read_done:
    ; newline
    mov ah, 2
    mov dl, 13
    int 21h
    mov dl, 10
    int 21h

    ; ===== Process buffer and print output =====
    lea si, line            ; SI = current char
    mov di, si              ; DI = start of current word

scan:
    cmp cx, 0
    je  end_line

    mov al, [si]
    cmp al, ' '
    je  space_found

    inc si
    dec cx
    jmp scan

space_found:
    ; print word reversed: DI .. (SI-1)
    mov bx, si
    dec bx

    cmp bx, di
    jb  only_space ; empty word (multiple spaces)

rev1:
    mov dl, [bx]
    mov ah, 2
    int 21h
    dec bx
    cmp bx, di
    jae rev1

only_space:
    ; print the space
    mov dl, ' '
    mov ah, 2
    int 21h

    inc si
    dec cx
    mov di, si
    jmp scan

end_line:
    mov bx, si
    dec bx

    cmp bx, di
    jb  done

rev_last:
    mov dl, [bx]
    mov ah, 2
    int 21h
    dec bx
    cmp bx, di
    jae rev_last

done:
    ; newline
    mov ah, 2
    mov dl, 13
    int 21h
    mov dl, 10
    int 21h

    ; exit
    mov ah, 4ch            
    int 21h
main endp

end main
