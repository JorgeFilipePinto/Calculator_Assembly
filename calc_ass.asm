org 100h

.model small
.data
.code

jmp start       ; jump over data declaration 

msg0:    db      0dh,0ah," ___> Simple calculator <___" ,0dh,0ah,'$' 
msg:     db      0dh,0ah,"1-Add",0dh,0ah,"2-Multiply",0dh,0ah,"3-Subtract",0dh,0ah,"4-Divide", 0Dh,0Ah, '$' 
msg1:    db      0dh,0ah,"Enter a number between 1,4 if you want any calculation ::",0Dh,0Ah,'$'
msg2:    db      0dh,0ah,"Enter First No : ", 0Dh,0Ah, " $"
msg3:    db      0dh,0ah,"Enter Second No :", 0Dh,0Ah, " $"
msg4:    db      0dh,0ah,"Choice Error....please Enter any key which is in rang (1-4)" , 0Dh,0Ah," $" 
msg5:    db      0dh,0ah,"Result : ", 0Dh,0Ah, " $" 
msg6:    db      0dh,0ah,'thank you for using the calculator! press any key... ', 0Dh,0Ah, '$'

start:  mov ah,9
        mov dx, offset msg0 
        int 21h

        mov ah,9
        mov dx, offset msg 
        int 21h

        mov ah,9                  
        mov dx, offset msg1
        int 21h 
        
        mov ah,0                       
        int 16h  
        cmp al,31h  
        je Addition
        cmp al,32h  
        je Multiply
        cmp al,33h
        je Subtract
        cmp al,34h
        je Divide
        mov ah,09h
        mov dx, offset msg4
        int 21h
        mov ah,0
        int 16h
        jmp start 

Addition:   mov ah,9  
            mov dx, offset msg2  
            int 21h
            mov cx,0 
            call InputNo  
            push dx
            mov ah,9
            mov dx, offset msg3
            int 21h 
            mov cx,0
            call InputNo
            pop bx
            add dx,bx
            push dx 
            mov ah,9
            mov dx, offset msg5
            int 21h
            mov cx,10000
            pop dx
            call View 
            jmp exit 

InputNo:    mov ah,0
            int 16h 
            mov dx,0  
            mov bx,1 
        InputLoop:
            sub al,30h 
            call ViewNo 
            mov ah,0
            inc cx   
            int 16h 
            cmp al,0dh 
            jne InputLoop 
            ret 

View:       mov ax,dx
            mov dx,0
            div cx 
            mov bx,dx 
            mov dx,0
            mov ax,cx 
            mov cx,10
            div cx
            mov dx,bx 
            mov cx,ax
            cmp ax,0
            jne View
            call ViewNo
            ret

ViewNo:     add dl,30h 
            mov ah,2
            int 21h
            ret

exit:       mov dx,offset msg6
            mov ah, 09h
            int 21h  

            mov ah, 0
            int 16h
            ret

Multiply:   mov ah,9
            mov dx, offset msg2
            int 21h
            mov cx,0
            call InputNo
            push dx
            mov ah,9
            mov dx, offset msg3
            int 21h 
            mov cx,0
            call InputNo
            pop bx
            mul bx 
            push dx 
            mov ah,9
            mov dx, offset msg5
            int 21h
            mov cx,10000
            pop dx
            call View 
            jmp exit 

Subtract:   mov ah,9
            mov dx, offset msg2
            int 21h
            mov cx,0
            call InputNo
            push dx
            mov ah,9
            mov dx, offset msg3
            int 21h 
            mov cx,0
            call InputNo
            pop bx
            sub bx,dx
            mov dx,bx
            push dx 
            mov ah,9
            mov dx, offset msg5
            int 21h
            mov cx,10000
            pop dx
            call View 
            jmp exit 

Divide:     mov ah,9
            mov dx, offset msg2
            int 21h
            mov cx,0
            call InputNo
            push dx
            mov ah,9
            mov dx, offset msg3
            int 21h 
            mov cx,0
            call InputNo
            pop bx
            mov ax,bx
            mov cx,dx
            mov dx,0
            mov bx,0
            div cx
            mov bx,dx
            mov dx,ax
            push bx 
            push dx 
            mov ah,9
            mov dx, offset msg5
            int 21h
            mov cx,10000
            pop dx
            call View
            pop bx
            cmp bx,0
            je exit 
            ;jmp short exit