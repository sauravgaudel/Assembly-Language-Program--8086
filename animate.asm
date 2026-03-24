.model small
.stack 100h

.data
msg db "Enter string: $"
str db 50
    db ?
    db 50 dup(?)

.code
main proc
mov ax, @data
mov ds, ax

; input message
lea dx, msg
mov ah, 09h
int 21h

; take input
lea dx, str
mov ah, 0Ah
int 21h

; clear screen
mov ax, 0003h
int 10h

; get string length
mov cl, [str+1]

; starting position (right side)
mov bh, 0
mov dh, 12      ; middle row
mov dl, 70      ; start near right edge

move_loop:

; set cursor
mov ah, 02h
int 10h

; print string
lea si, str+2
mov ch, 0

print_loop:
mov al, [si]
cmp al, 0Dh
je done_print
mov ah, 0Eh
int 10h
inc si
jmp print_loop

done_print:

; delay (important for visible movement)
mov cx, 0FFFFh
delay1:
mov dx, 0FFFFh
delay2:
dec dx
jnz delay2
dec cx
jnz delay1

; move left
dec dl
cmp dl, 0
jne move_loop

; exit
mov ax, 4C00h
int 21h

main endp
end main