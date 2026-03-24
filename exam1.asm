.model small
.stack 100h
.data
msg db "Enter a string:$"
str db 100
    db ?
    db 100 dup('$')
newline db 0dh, 0ah, '$'

.code
main proc

mov ax, @data
mov ds, ax

lea dx, msg
mov ah, 09h
int 21h

mov dx, offset str
mov ah, 0ah
int 21h

mov si, offset str+2

mov dx, offset newline
mov ah, 09h
int 21h

mov al, [si]
cmp al, 'a'
jb yetaa
cmp al, 'z'
ja yetaa
sub al, 20h

yetaa:
mov dl, al
mov ah, 02h
int 21h
inc si

loops:
mov al, [si]
cmp al, 0dh
je last
cmp al, ' '
je here
mov dl, al
mov ah, 02h
int 21h
inc si
jmp loops

here:
mov dx, offset newline
mov ah, 09h
int 21h
inc si
mov al, [si]
cmp al, 'a'
jb here2
cmp al, 'z'
ja here2
sub al, 20h

here2:
mov dl, al
mov ah, 02h
int 21h
inc si
jmp loops

last:
mov ax, 4c00h
int 21h

main endp
end main

