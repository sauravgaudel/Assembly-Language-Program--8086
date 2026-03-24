.model small
.stack 100h
.data
msg db 'Sum of even numbers: $'

arr dw 2,3,4,5,6
sum db 0

.code
main proc
mov ax,@data
mov ds,ax

mov cx,5
mov si,offset arr

l1:
mov ax,[si]
test ax,1
jnz skip

add sum, al

skip:
add si,2
loop l1

mov ah,09h
lea dx,msg
int 21h

mov ah, 02h
add sum, 30h
mov dl, sum
int 21h

mov ax,4c00h
int 21h
main endp
end main