.model small
.stack 100h

.data
    num   db "Enter four numbers: $"  
    large db 13, 10, "The Largest number is: $"

    n1 db ?
    n2 db ?
    n3 db ?
    n4 db ? 
    max db ?
    
.code
main proc
    mov ax, @data
    mov ds, ax

    lea dx, num
    mov ah, 9
    int 21h

    mov ah , 1 ; read first digit
    int 21h
    mov n1 , al
    
    mov ah, 1
    int 21h ; read space     
    
    mov ah , 1 ; read 2nd digit
    int 21h
    mov n2 , al
    
    mov ah, 1
    int 21h ; read space 
    
    mov ah , 1 ; read 3rd digit
    int 21h
    mov n3 , al
    
    mov ah, 1
    int 21h ; read space  
    
    mov ah , 1 ; read first digit
    int 21h
    mov n4 , al
    
    ; ============assume n1 is the largest number========
    mov al, n1
    mov max, al
    
    ;compare n2 with max
    mov al , n2
    cmp al, max
    jle compare_n3
    mov max, al ; else n2 max
    
    compare_n3:
        mov al , n3
        cmp al, max
        jle compare_n4
        mov max, al
    
    compare_n4:
        mov al, n4
        cmp al, max
        jle print
        mov max, al
    
    print:
        lea dx, large
        mov ah, 9
        int 21h
        
        mov dl, max
        mov ah, 2
        int 21h

exit:
    mov ah, 4Ch
    int 21h
main endp
end main
