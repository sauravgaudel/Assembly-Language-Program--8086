.model small
.stack 100h

.data
table db 60,70,80,90,100,140,180,40
str db "Sum:$"

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

cmp al, 50
jb no

cmp al, 150
ja no

add bx, ax

no:
inc si
loop loops

mov dx, offset str
mov ah, 09h
int 21h

; convert to decimal and print
mov ax, bx
mov bx, 10
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
add dl, 30h
mov ah, 02h
int 21h
loop print

mov ax, 4c00h
int 21h

main endp
end main