.model small
.stack 100h

.data
msg db "Enter a string: $"
str db 100
    db ?
    db 100 dup(?)

.code
main proc

mov ax, @data
mov ds, ax

lea dx, msg
mov ah, 09h
int 21H

lea dx, str
mov ah, 0ah
int 21H

mov cl, [str+1]
mov ch, 0
mov si, offset str+2
add si, cx
dec si

mov dl, 0ah
mov ah, 02H
int 21H


back:
mov al, [si]
mov dl, al
mov ah, 02H
int 21H
dec si
loop back

mov ax, 4c00h
int 21H

main endp 
end main