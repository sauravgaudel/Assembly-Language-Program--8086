.MODEL SMALL
.STACK 100H
.DATA 
    MSG DB "ENTER THE NUMBERS $"
    NUM DW 0
    VALUE DW 0
    TEN DW 10

.CODE
    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX

        MOV AX,0003H
        INT 10H 

        MOV AH,09H
        MOV DX,OFFSET MSG
        INT 21H

        XOR BX,BX
    ENTER:    MOV AH,01H
        INT 21H
        CMP AL, 0dh
        JE DONE
        SUB AL,30H
        MOV CL,AL
        MOV CH,0
        MOV AX,BX
        MUL TEN
        ADD AX,CX
        MOV BX,AX
        JMP ENTER
 DONE: MOV AH,02H
 MOV DL,0DH
 INT 21H
 MOV DL,0AH
 INT 21H
 
 
 
 MOV NUM,BX
        MOV BX,1
 DO:    MOV AX,BX
        MUL NUM
        MOV VALUE,AX
        CALL PRINT
        MOV AH,02H
        MOV DL,0DH
        INT 21H
        MOV DL,0AH
        INT 21H
        INC BX
        CMP BX,10
        JBE DO

        MOV AH,00H 
        INT 16H
        MOV AX,4C00H
        INT 21H
    MAIN ENDP

    PRINT PROC
        XOR CX,CX
        MOV AX,NUM
CON:     XOR DX,DX
        DIV TEN
        PUSH DX
        INC CX
        CMP AX,0
        JNZ CON
  P:     POP DX
        ADD DL,30H
        MOV AH,02H
        INT 21H
        LOOP P

        MOV AH,02H
        MOV DL,"*"
        INT 21H


        XOR CX,CX
        MOV AX,BX
   CON1 :    XOR DX,DX
        DIV TEN
        PUSH DX
        INC CX
        CMP AX,0
        JNZ CON1
    P1: POP DX
        ADD DL,30H
        MOV AH,02H
        INT 21H
        LOOP P1

        MOV AH,02H
        MOV DL,"="
        INT 21H


        XOR CX,CX
        MOV AX,VALUE
   CON2 : XOR DX,DX
        DIV TEN
        PUSH DX
        INC CX
        CMP AX,0
        JNZ CON2
    P2: POP DX
        ADD DL,30H
        MOV AH,02H
        INT 21H
        LOOP P2
        RET
    PRINT ENDP
END MAIN