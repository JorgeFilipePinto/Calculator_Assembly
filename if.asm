DATA_SEG    SEGMENT
    MSG_COUNT   DB  'Contagem: $'
DATA_SEG    ENDS

CODE_SEG    SEGMENT
    ASSUME CS: CODE_SEG, DS:DATA_SEG

START:
    MOV     AX, DATA_SEG
    MOV     DS, AX

    MOV     CX, 1 ; Inicializa o contador

DO_WHILE_LOOP:
    ; Mostra o valor atual do contador
    MOV     AH, 02h ; Fun??o para exibir caractere
    MOV     DL, '0' ; Valor inicial do caractere '0'
    ADD     DL, CL ; Adiciona o valor do contador para converter em caractere
    INT     21h

    ; Mostra a mensagem de contagem
    MOV     AH, 09h
    MOV     DX, OFFSET MSG_COUNT
    INT     21h

    INC     CX ; Incrementa o contador

    ; Verifica se o contador ? menor ou igual a 5
    CMP     CX, 6 ; 6 pois queremos ir at? 5
    JLE     DO_WHILE_LOOP ; Se for menor ou igual, continua o loop

    ; Fim do programa
    MOV     AH, 4CH
    MOV     AL, 0
    INT     21H

CODE_SEG    ENDS
    END START
