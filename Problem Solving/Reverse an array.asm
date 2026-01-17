;Given an array of N integers, print the elements in reverse order.

;Input:
;First line: integer 
;Second line : array

;Output:Print the array elements in reverse order, separated by spaces.

;Example:
;Input:
;4
;5 2 3 8

;Output:8 3 2 5 
;=======================================================================

.model small
.stack 100h

.data
msgN   db "Enter Number : $"
msgA   db 13,10,"Enter array elements (digits): $"
outmsg db 13,10,"Reversed: $"

arr    db 20 dup(?)  
num db ?

.code
main proc
    mov ax, @data
    mov ds, ax

    ; ---- input ----
    lea dx, msgN
    mov ah, 9
    int 21h

take_number:
    mov ah, 1
    int 21h            
    sub al, '0'
    mov num, al   

    ; ---- input array ----
    lea dx, msgA
    mov ah, 9
    int 21h

    lea si, arr
    mov cl, num   

input:
    mov ah, 1
    int 21h         

    cmp al, ' '
    je  input              ; ignore spaces
    cmp al, 13
    je  input             ; ignore Enter

    mov [si], al
    inc si
    
    mov ah, 2
    mov dl, ' '
    int 21h

    dec cl
    jnz input

    ; ---- print reversed ----
    lea dx, outmsg
    mov ah, 9
    int 21h

    lea si, arr
    mov bl , num
    mov bh, 0
    mov di, bx ; direct num hobena .karon 16bit
    
    dec di  ; karon 0 theke n ; so total hobe n-1         
    add si, di  ; si akhn last index a   
    mov cl, num        

reverse:
    mov dl, [si]
    mov ah, 2
    int 21h

    mov dl, ' '
    mov ah, 2
    int 21h

    dec si
    dec cl
    jnz reverse

    exit:
        mov ah, 4Ch
        int 21h
main endp

end main
