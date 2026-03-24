.model small
.stack 100h
.data
msg1 db 'Enter string: $'
msg2 db 13,10,'Words:',13,10,'$'
nl db 13,10,'$'

str db 100
    db ?
    db 100 dup('$')

.code
main proc
mov ax,@data
mov ds,ax

mov ah,09h
lea dx,msg1
int 21h

mov ah,0Ah
lea dx,str
int 21h

mov ah,09h
lea dx,msg2
int 21h

lea si,str+2

l1:
mov al,[si]
cmp al,13
je done

cmp al,' '
je newline

mov dl,al
mov ah,02h
int 21h
jmp next

newline:
mov ah,09h
lea dx,nl
int 21h

next:
inc si
jmp l1

done:
mov ax,4c00h
int 21h
main endp
end main