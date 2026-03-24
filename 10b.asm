.model small
.stack 100h
.data
msg db "Enter n: $"
v1 db 2
v2 db 4
sum dw 0
carry dw 0

.code
main proc
mov ax, @data
mov ds, ax

lea dx, msg
mov ah, 09h
int 21H

mov bx, 00H

    back:
    mov ah, 01h
    int 21H         
    cmp al, 0dh      
    je skip
    
    sub al, 30h      
    mov cl, al
    mov ch, 0        
    
    mov ax, 10
    mul bx           
    add ax, cx       
    mov bx, ax       
    jmp back

skip:
mov cx, bx

xor bx, bx
xor dx, dx

loops:
mov al, v1
mov ah, 0
mul v2
add bx, ax
jnc skip2
inc dx
skip2:
inc v1
add v2, 02
loop loops

mov sum, bx
mov carry, dx

mov bx, 10
xor cx, cx

again:
mov ax, carry
xor dx, dx
div bx
mov carry, ax
mov ax, sum
div bx
push dx
inc cx
mov sum, ax
cmp sum, 0
je done
jmp again

done:
pop dx
add dl, 30h
mov ah, 02H
int 21h
loop done

mov ax, 4c00h
int 21H

main endp
end main