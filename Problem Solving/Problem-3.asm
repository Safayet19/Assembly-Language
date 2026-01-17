;===========================================================================
;a. Print whether the number is Odd or Even.
;b. Print the multiplication table of the number based on the following rules:
;1. If the number is Even, print table from 1 to 10.
;2. If the number is Odd, print table from 1 to 5.
;3. If the number is Zero, print “All is Well”.
;c. Each line of the table must be printed in the format, N x i = result.

;Sample Test Cases:
;Input:
;4
;Output:
;Even Number
;4 x 1 = 4
;4 x 2 = 8
;4 x 3 = 12
;4 x 4 = 16
;4 x 5 = 20
;4 x 6 = 24
;4 x 7 = 28
;4 x 8 = 32
;4 x 9 = 36
;4 x 10 = 40

;Input:
;7
;Output:
;Odd Number
;7 x 1 = 7
;7 x 2 = 14
;7 x 3 = 21
;7 x 4 = 28
;7 x 5 = 35

;Input:0
;Output:All is Well    

;===========================================================================

.model small
.stack 100h

.data
oddm   db "Odd Number",13,10,"$"
evenm  db "Even Number",13,10,"$"
zerom  db "All is Well$"

.code
main proc
    mov ax, @data
    mov ds, ax

    mov ah, 1
    int 21h
    sub al, '0'
    mov bl, al   ; BL = N

    ; newline after input
    mov ah, 2
    mov dl, 13
    int 21h
    mov dl, 10
    int 21h

    cmp bl, 0
    jne check_odd_even

    lea dx, zerom
    mov ah, 9
    int 21h
    jmp exit

check_odd_even:
    mov al, bl
    and al, 1
    cmp al, 0
    je  even_case

    ; odd -> limit = 5
    lea dx, oddm
    mov ah, 9
    int 21h
    mov bh, 5  ; BH = limit
    jmp start_table

even_case:
    ; even -> limit = 10
    lea dx, evenm
    mov ah, 9
    int 21h
    mov bh, 10 ; BH = limit

start_table:
    mov cl, 1               ; CL = i

row:
    ; print N (single digit)
    mov ah, 2
    mov dl, bl
    add dl, '0'
    int 21h

    ; print " x "
    mov dl, ' '
    int 21h
    mov dl, 'x'
    int 21h
    mov dl, ' '
    int 21h

    ; print i (CL) (1..10)
    cmp cl, 10
    jne i_one_digit
    mov dl, '1'
    int 21h
    mov dl, '0'
    int 21h
    jmp after_i

i_one_digit:
    mov dl, cl
    add dl, '0'
    int 21h

after_i:
    ; print " = "
    mov dl, ' '
    int 21h
    mov dl, '='
    int 21h
    mov dl, ' '
    int 21h

    ; product = N * i  (AX = BL * CL)
    mov al, bl
    mul cl                  ; AX = product (0..90)

    ; print product in decimal using DIV 10
    mov dl, 10
    div dl                  ; AL=tens, AH=ones
    mov dh, ah              ; save ones

    cmp al, 0
    je  p_ones_only
    add al, '0'
    mov dl, al
    mov ah, 2
    int 21h

p_ones_only:
    mov dl, dh
    add dl, '0'
    mov ah, 2
    int 21h

    ; newline
    mov ah, 2
    mov dl, 13
    int 21h
    mov dl, 10
    int 21h

    inc cl
    cmp cl, bh
    jbe row

exit:
    mov ah, 4Ch
    int 21h
main endp

end main
