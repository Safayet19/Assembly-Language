.model small
.stack 100h

.data
    num1 db "Enter 1st number: $" 
    num2 db 13, 10, "Enter 2nd number: $"
    result db 13, 10, "Sum: $" 
    
    n1 dw ?
    n2 dw ?
    

.code

main proc
    mov ax, @data
    mov ds, ax

    
    lea dx, num1
    mov ah, 9
    int 21h
    
    xor bx , bx
    read1:
        mov ah , 1 
        int 21h
        cmp al , 13
        je store1
        
        sub al , '0'
        xor ah , ah 
        
        mov cx , ax
        mov ax , bx
        
        mov si , 10
        mul ax
        
        add ax , cx
        mov bx , ax
        jmp read1
     
     
     store1:
        mov n1, bx
        
        ;====inpu 2nd number
        
        xor bx, bx
        read2:
           mov ah, 1
           int 21h
           cmp al, 13
           je store2
           
           sub al , '0'
           xor ah , ah
           
           mov cx, ax
           mov ax , bx
           
           mov si , 10
           mul si
           
           add ax, cx
           mov bx, ax
           jmp read2
    
    store2:
        mov n2 , bx 
        
        
        
        
           

    


exit:
    mov ah, 4Ch
    int 21h
main endp
end main
