.model small
.stack 100h

.data
table db 60,70,80,90,100,140,180,40
msg db "Sum (HEX): $"

.code
main proc
mov ax, @data
mov ds, ax

mov bx, 0000h
mov cx, 08h
lea si, table

loops:
mov al, [si]
mov ah, 00h

cmp al, 30
jb skip

cmp al, 100
ja skip

add bx, ax

skip:
inc si
loop loops

; print message
mov dx, offset msg
mov ah, 09h
int 21h

; HEX conversion
mov ax, bx
mov bx, 16
mov cx, 0

again:
mov dx, 0
div bx
push dx
inc cx
cmp ax, 0
jne again

print:
pop dx
cmp dl, 9
jbe digit

add dl, 7      ; for A-F

digit:
add dl, 30h
mov ah, 02h
int 21h
loop print

mov ax, 4c00h
int 21h

main endp
end main