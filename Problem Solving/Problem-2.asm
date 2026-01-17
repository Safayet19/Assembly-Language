;Input:Input load consists of one single digit decimal number (0=N=9).

;Output:
;a. Print whether the load is Odd or Even.
;b. Print the load visualization of the number based on the following rules:
;1. If the number is Even, print decreasing star (*) up to N.
;2. If the number is Odd, print increasing star (*) up to N.
;3. If the number is Zero, print “All Are Stars Here”.


.model small
.stack 100h

.data
oddm   db "Odd Load Detected",13,10,"$"
evenm  db "Even Load Detected",13,10,"$"
zerom  db "All Are Stars Here$"
newline   db 13,10,"$"

.code
main proc
    mov ax, @data
    mov ds, ax

    ; read one digit
    mov ah, 1
    int 21h
    sub al, '0'
    mov bl, al

    cmp bl, 0
    jne not_zero

    lea dx, zerom
    mov ah, 9
    int 21h
    jmp done

not_zero:
    
    mov al, bl
    and al, 1   ; AL and 1 = 0 hole even , AL and 1 = 1 hole odd
    cmp al, 0
    je  even_case

    lea dx, oddm
    mov ah, 9
    int 21h

    mov cl, 1
odd_outer:
    xor ch, ch
    mov si, cx

odd_stars:
    mov ah, 2
    mov dl, '*'
    int 21h
    dec si
    jnz odd_stars

    lea dx, newline
    mov ah, 9
    int 21h

    inc cl
    cmp cl, bl
    jbe odd_outer
    jmp done

even_case:
    lea dx, evenm
    mov ah, 9
    int 21h

    mov cl, bl
even_outer:
    xor ch, ch
    mov si, cx
even_stars:
    mov ah, 2
    mov dl, '*'
    int 21h
    dec si
    jnz even_stars

    lea dx, newline
    mov ah, 9
    int 21h

    dec cl
    jnz even_outer

done:
    mov ah, 4Ch
    int 21h
main endp
end main
