.model small
.stack 21h

.data
   
 
   msg dB "Enter your array : $" 
   output dB 13,10, "Array is : $" 
  
   
   array dB 6 dup(?)
   
   
.code
main proc
    
    mov ax, @data
    mov ds, ax
    
    lea dx, msg
    mov ah, 9
    int 21h   
    
    lea si , array ;load in array
    mov cx, 6 ; 6 total input
    
    array_input:
        mov ah , 1
        int 21h
        
        mov [si] , al 
        inc si
        mov dl , " "; take space too
        int 21h
        loop array_input
    
    lea dx, output
    mov ah, 9
    int 21h 
    
    lea si, array
    mov cx , 6
    display: 
        mov dl , [si] 
        mov ah, 2
        int 21h 
        inc si
        mov dl , " "
        int 21h 
        loop display
    
    
    
    exit:
        mov ah, 4ch
        int 21h

main endp

ret
