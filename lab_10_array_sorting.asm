.model small
.stack 21h

.data
   
 
   msg dB "Enter your array : $" 
   asc dB 13,10, "Ascending Sort : $" 
   dsc dB 13,10, "Descending Sort : $"                                    
                                      
   
   array dB 7 dup(?)
   
   
.code
main proc
    
    mov ax, @data
    mov ds, ax
    
    lea dx, msg
    mov ah, 9
    int 21h   
    
    lea bx , array ;load in array , bcz si will use in another case
    mov cx, 7 ; 7 total input
    
    mov ah , 1
    array_input:
       
        int 21h
        
        mov [bx] , al 
        inc bx
        mov dl , " "; take space too
        int 21h
        loop array_input
    
    
    mov cx, 7
    dec cx ; bubble sort ; n-1
    
    outer_loop1: 
        mov bx , cx ; save cx value
        mov si , 0
        
        inner_loop1:  
            mov al , array[si] ; 0th index
            mov dl , array[si + 1] ; 1st index
            cmp al, dl
            jc no_swap ; jump if carry found; (3-2) = 1; no carry no swap
             
            swap: ; else swap
            mov array[si] , dl, 
            mov array[si + 1] , al      
            
            no_swap:
                inc si  ;normally go si++ ; index
                dec bx  ; bx-- , comparsion
            jnz inner_loop1
            loop outer_loop1
    
    
        
    lea dx, asc
    mov ah, 9
    int 21h 
    
    lea bx, array
    mov cx , 7
    display: 
        mov dl , [bx] 
        mov ah, 2
        int 21h 
        inc bx
        mov dl , " "
        int 21h 
        loop display
    
    
    ;===============================descending==================
    mov cx, 7
    dec cx ; bubble sort ; n-1
    
    outer_loop2: 
        mov bx , cx ; save cx value
        mov si , 0
        
        inner_loop2:  
            mov al , array[si] ; 0th index
            mov dl , array[si + 1] ; 1st index
            cmp al, dl
            jc swap1 ; jump if carry found; (3-2) = 1; no carry no swap
             
            swap1: ; else swap     ;or jnc use
            mov array[si] , dl, 
            mov array[si + 1] , al      
            
            no_swap1:
                inc si  ;normally go si++ ; index
                dec bx  ; bx-- , comparsion
            jnz inner_loop2
            loop outer_loop2
     
    lea dx, dsc
    mov ah, 9
    int 21h 
    
    lea bx, array
    mov cx , 7
    display1: 
        mov dl , [bx] 
        mov ah, 2
        int 21h 
        inc bx
        mov dl , " "
        int 21h 
        loop display1
    
    
    exit:
        mov ah, 4ch
        int 21h

main endp

ret
