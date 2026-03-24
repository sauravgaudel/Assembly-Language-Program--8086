.model small
.stack 100h
.data

str db "Programming in assembly language is fun $"

.code
main proc
mov ax, @data
mov ds, ax


mov ax, 0003h
int 10H

mov ax, 0600h
mov bh, 70h
mov ch, 5
mov cl, 20
mov dh, 20
mov dl, 60
int 10h


mov dh, 12
mov dl, 30
mov bh, 0
mov ah, 02H
int 10H

mov dx, offset str
mov ah, 09h
int 21H

mov ax, 4c00h
int 21H

main endp
end main