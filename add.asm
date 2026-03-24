.MODEL SMALL
.STACK 100H

.DATA
MSG1 DB 'Enter first number: $'
MSG2 DB 0DH,0AH,'Enter second number: $'
MSG3 DB 0DH,0AH,'Result is: $'

.CODE
MAIN PROC

    MOV AX, @DATA
    MOV DS, AX

    ; first message
    MOV AH, 09H
    LEA DX, MSG1
    INT 21H

    ; first input
    MOV AH, 01H
    INT 21H
    SUB AL, 30H
    MOV BL, AL

    ; second message
    MOV AH, 09H
    LEA DX, MSG2
    INT 21H

    ; second input
    MOV AH, 01H
    INT 21H
    SUB AL, 30H

    ; addition
    ADD AL, BL

    ; print result message
    MOV AH, 09H
    LEA DX, MSG3
    INT 21H

    ; convert result to ASCII
    ADD AL, 30H

    ; display result
    MOV DL, AL
    MOV AH, 02H
    INT 21H

    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN