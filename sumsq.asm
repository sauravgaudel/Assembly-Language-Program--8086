.MODEL SMALL
.STACK 100H
.DATA
    str db "Enter any number(1-255): $"
    MSG DB 0dh, 0ah, "SUM OF NUMBERS : $"
    SUM DW 0
    CARRY DW 0

.CODE
    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX

        lea dx, str
        mov ah,09h
        int 21h

        mov bx, 00H

        here:
        mov ah, 01h
        int 21H         
        cmp al, 0dh      
        je yehaa
        
        sub al, 30h      
        mov cl, al
        mov ch, 0        
        
        mov ax, 10
        mul bx           
        add ax, cx       
        mov bx, ax       
        jmp here



        yehaa:
        MOV CX,bx
        XOR BX,BX
        XOR DX,DX
     BACK:   MOV AL,CL
        MUL CL
        ADD BX,AX
        JNC SKIP
        INC DX
    SKIP:
        LOOP BACK

        XOR CX,CX
        MOV SUM,BX
        MOV CARRY,DX
        MOV BX,10
  CONTINUE:MOV AX,CARRY
        XOR DX,DX
        DIV BX
        MOV CARRY,AX
        MOV AX,SUM
        DIV BX
        PUSH DX
        INC CX
        MOV SUM,AX
        CMP SUM,0
        JNZ CONTINUE

        lea dx, MSG
        mov ah, 09h
        int 21h


   PRINT:     POP DX
        ADD DL,30H
        MOV AH,02H
        INT 21H
        LOOP PRINT

        MOV AH,00H
        INT 16H
        
        MOV AX,4C00H
        INT 21H

    MAIN ENDP
END MAIN