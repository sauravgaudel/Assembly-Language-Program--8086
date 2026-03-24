.model small
.stack 100h
.data
 msg db "Enter a string: $"
 str db 24
     db ?
     db 24 dup(?)
row db 0
.code
main proc

mov ax, @data
mov ds, ax

lea dx, msg
mov ah, 09h
int 21H

lea dx, str
mov ah, 0ah
int 21h

mov ax, 0003h
int 10H

lea si, str+2

back:
mov al, [si]
cmp al, 0dh
je done
mov dh, row
mov dl, 39
mov bh, 0
mov ah, 02H
int 10H

mov dl, al
mov ah, 02H
int 21H
inc si
inc row
jmp back

done:
mov ax, 4c00h
int 21H

main endp
end main


