;Input:Book Title: Microprocessors and Interfacing 103
;Output:
;Formatted Title: MICROPROCESSORS AND INTERFACING 103
;Vowels:
;I O O E O A I E A I
;Consonants:
;M C R P R C S S R S N D N T R F C N G
;Total Vowels = 10 

;====================================================================
.model small
.stack 100h

.data
p1      db "Book Title: $"

fmtmsg  db 13,10,"Formatted Title: $"
vmsg    db 13,10,"Vowels:",13,10,"$"
cmsg    db 13,10,"Consonants:",13,10,"$"
tmsg    db 13,10,"Total Vowels = $"
crlf    db 13,10,"$"

str     db 80 dup(?)
vbuf    db 80 dup(?)
cbuf    db 80 dup(?)
vcount  db 0

.code
main proc
    mov ax, @data
    mov ds, ax

    ; prompt
    lea dx, p1
    mov ah, 9
    int 21h

    ; ---- read until Enter, store only first 30 chars ----
    lea si, str
    mov cx, 30

read_loop:
    mov ah, 1
    int 21h
    cmp al, 13
    je  end_read

    mov [si], al
    inc si
    dec cx
    jmp read_loop

end_read:
    mov [si], '$'
    lea si, str
    lea di, vbuf
    lea bx, cbuf
    mov vcount, 0

next_char:
    mov al, [si]
    cmp al, '$'
    je  done_process

    ; to uppercase if 'a'..'z'
    cmp al, 'a'
    jb  up_ok
    cmp al, 'z'
    ja  up_ok
    sub al, 20h
    mov [si], al

up_ok:
    ; only letters
    cmp al, 'A'
    jb  skip_store
    cmp al, 'Z'
    ja  skip_store

    ; vowel check
    cmp al, 'A' 
    je  store_v
    cmp al, 'E'
    je  store_v
    cmp al, 'I'
    je  store_v
    cmp al, 'O'
    je  store_v
    cmp al, 'U'
    je  store_v
    
    ; consonant
    mov [bx], al
    inc bx
    mov [bx], ' '
    inc bx
    jmp skip_store

store_v:
    mov [di], al
    inc di
    mov [di], ' '
    inc di
    inc vcount

skip_store:
    inc si
    jmp next_char

done_process:
    mov [di], '$'
    mov [bx], '$'

    ; output
    lea dx, fmtmsg
    mov ah, 9
    int 21h

    lea dx, str
    mov ah, 9
    int 21h

    lea dx, vmsg
    mov ah, 9
    int 21h

    lea dx, vbuf
    mov ah, 9
    int 21h

    lea dx, cmsg
    mov ah, 9
    int 21h

    lea dx, cbuf
    mov ah, 9
    int 21h

    lea dx, tmsg
    mov ah, 9
    int 21h

    ; print vowel count 
    xor ax, ax
    mov al, vcount
    mov dl, 10
    div dl             
    mov bh, ah   

    cmp al, 0
    je  print_ones
    add al, '0'
    mov dl, al
    mov ah, 2
    int 21h

print_ones:
    mov dl, bh
    add dl, '0'
    mov ah, 2
    int 21h

    lea dx, crlf
    mov ah, 9
    int 21h

    mov ah, 4Ch
    int 21h
main endp

end main
