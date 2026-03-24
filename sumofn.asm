.model small
.stack 100h
.data
msg1 db 'Enter n: $'
msg2 db 13,10,'Sum: $'

n db ?
sum dw 0

.code
main proc
mov ax,@data
mov ds,ax

mov ah,09h
lea dx,msg1
int 21h

mov ah,01h
int 21h
sub al,30h
mov cl,al

mov bl,1

l1:
mov bh,0
add sum,bx
inc bl
loop l1

mov ah,09h
lea dx,msg2
int 21h

mov ax,4c00h
int 21h
main endp
end main