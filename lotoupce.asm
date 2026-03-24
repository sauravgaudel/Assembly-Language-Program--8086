.model small
.stack 100h
.data

msg db "Enter a string: $"
str db 100
    db ?
    db 100 dup('$')

.code
main proc
mov ax, @data
mov ds, ax

lea dx, msg
mov ah, 09h
int 21h

lea dx, str
mov ah, 0ah
int 21h

lea si, str+2

loops:
mov al, [si]
cmp al, '$'
je done
cmp al, 'a'
jb no
cmp al, 'z'
ja no
sub al, 20h
mov [si], al

no:
inc si
jmp loops

done:

mov ax, 0003h
int 10h

mov ah, 02h
mov bh, 0h
mov dh, 11
mov dl, 40
mov cl, [str+1]
mov al, cl
shr al,1
mov cl, al
mov al, 40
sub al, cl
mov dl, al
int 10h

lea dx, str+2
mov ah, 09h
int 21h

mov ax, 4c00h
int 21h

main endp

end main