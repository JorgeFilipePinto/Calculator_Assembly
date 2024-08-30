.model large
.stack
.data
d1 db 10
menu db "1- Adicao / 2- Subtracao / 3- Multiplicacao / 4- Divisao / 5- Sair", '$'
ESCREVE macro msg
 mov ax, seg msg
 mov ds, ax
 LEA dx, msg
 mov ah,9
 int 21h
endm
.code


MeuCodigo:

initMenu:
    ESCREVE menu
    
    mov al,13 ;Carriage Return
    mov ah,14
    int 10h
    mov al,10 ;Linha nova
    mov ah,14
    int 10h
    
    mov ah,0 ;L? 1? caracter
    int 16h
    
    cmp al,31h
    je soma
    cmp al,32h
    je subtracao
    cmp al,33h
    je multiplicacao
    cmp al,34h
    ;je divisao
    
    jmp initMenu
    
    
soma:
    mov ah,0 ;L? 1? caracter
    int 16h
    mov ah,14 ;Escreve caracter
    int 10h
    sub al,48 ;descodifica caracter
    mov bl,al
    mov al,'+' ;Escreve caracter "+"
    mov ah,14
    int 10h
    
    mov ah,0 ;L? 2? caracter 
    int 16h
    mov ah,14 ;Escreve caracter
    int 10h
    mov cl,al
    sub al,48 ;descodifica caracter
    add cl,bl
    mov al,'=' ;Escreve caracter "="
    mov ah,14
    int 10h

    mov al,cl
    mov ah,14
    int 10h
    
    mov al,13 ;Carriage Return
    mov ah,14
    int 10h
    mov al,10 ;Linha nova
    mov ah,14
    int 10h
    jmp initMenu  
    
subtracao:
    
    mov ah,0 ;L? 1? caracter
    int 16h
    mov ah,14 ;Escreve caracter
    int 10h
    
    sub al,48 ;descodifica caracter
    mov bl,al
    
    mov al,'-' ;Escreve caracter "-"
    mov ah,14
    int 10h
    
    mov ah,0 ;L? 2? caracter 
    int 16h
    
    mov ah,14 ;Escreve caracter
    int 10h
    
    sub al,48
    mov cl,al
    
    sub bl,cl
    
    mov al,'=' ;Escreve caracter "="
    mov ah,14
    int 10h
    
    add bl,48
    mov al,bl
    mov ah,14
    int 10h
    
    mov al,13 ;Carriage Return
    mov ah,14
    int 10h
    mov al,10 ;Linha nova
    mov ah,14
    int 10h
    jmp initMenu 

multiplicacao:
     mov d1,10 ; Inicializa vari?vel
     mov ah,0 ;L? 1? caracter
     int 16h
     mov ah,14 ;Escreve caracter
     int 10h
     sub al,48 ;descodifica caracter
     mov bl,al
     mov al,'x' ;Escreve caracter "x"
     mov ah,14
     int 10h
     mov ah,0 ;L? 2? caracter 
     int 16h
     mov ah,14 ;Escreve caracter
     int 10h
     sub al,48 ;descodifica caracter
     mul bl ;multiplica-os
     mov bl,al
     mov al,'=' ;Escreve caracter "="
     mov ah,14
     int 10h

     mov al,bl
     cmp al,d1
     jb s3

     mov ah,0
     div d1
     push ax
     add al,48
     mov ah,14 ;Escreve 1? caracter
     int 10h
     pop ax
     mov al,ah
     add al,48
     mov ah,14 ;Escreve 2? caracter
     int 10h
     jmp s4
     
     s3:
     add al,48
     mov ah,14 ;Escreve caracter
     int 10h
     
     s4:
        mov al,13 ;Carriage Return
        mov ah,14
        int 10h
        mov al,10 ;Linha nova
        mov ah,14
        int 10h
        
        jmp initMenu


divisao:
    mov d1,10 ; Inicializa vari?vel
    mov ah,0 ;L? 1? caracter
    int 16h
    mov ah,14 ;Escreve caracter
    int 10h
    sub al,48 ;Descodifica caracter
    mov ah,0
    push ax
    mov al,':' ;Escreve caracter ":"
    mov ah,14
    int 10h
    mov ah,0 ;L? 2? caracter
    int 16h
    mov ah,14 ;Escreve caracter
    int 10h
    push ax
    mov al,'=' ;Escreve caracter "="
    mov ah,14
    int 10h
    pop ax
    sub al,48 ;Descodifica caracter
    mov ah,0
    mov bx,ax
    pop ax
    div bl ;Divide-os
    push ax
    add al,48
    mov ah,14 ;Escreve caracter
    int 10h
    mov al,',' ;Escreve caracter ","
    mov ah,14 
    int 10h
    pop ax
    mov al,ah ;Escreve decimal
    mov ah,0
    mul d1
    div bl
    
    mov al,13 ;Carriage Return
    mov ah,14
    int 10h
    mov al,10 ;Linha nova
    mov ah,14
    int 10h
    
    jmp initMenu


    
    
mov ah,4ch
int 21h
End MeuCodigo
.End
