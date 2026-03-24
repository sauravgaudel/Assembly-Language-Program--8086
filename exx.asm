.model small
.stack 100h
.data
msg db 'Sum: $'

arr db 10,65,120,151,80
sum dw 0

.code
main proc
mov ax,@data
mov ds,ax

mov cx,5
mov si,offset arr

l1:
mov al,[si]

cmp al,60
jb skip
cmp al,150
ja skip

cbw
add sum,ax

skip:
inc si
loop l1

mov ah,09h
lea dx,msg
int 21h

mov ax,4c00h
int 21h
main endp
end main