.model small
.stack 100h
.data
    msg1 db 'Enter string: $'
    msg2 db 13,10,'Uppercase string: $'

    str db 100        ; max length
        db ?          ; actual length
        db 100 dup('$')

.code
main proc
    mov ax,@data
    mov ds,ax

    ; print message
    mov ah,09h
    lea dx,msg1
    int 21h

    ; input string
    mov ah,0Ah
    lea dx,str
    int 21h

    lea si,str+2

next:
    mov al,[si]
    cmp al,13
    je display

    cmp al,'a'
    jb skip
    cmp al,'z'
    ja skip
    sub al,20h

skip:
    mov [si],al
    inc si
    jmp next

display:
    mov ah,09h
    lea dx,msg2
    int 21h

    mov ah,09h
    lea dx,str+2
    int 21h

    mov ax,4c00h
    int 21h
main endp
end main