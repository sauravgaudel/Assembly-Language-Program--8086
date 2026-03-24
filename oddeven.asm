.model small
.stack 100h

.data
table dw 1234h, 5678h, 1111h, 2222h, 3333h
count dw 5

ev db 0
odd  db 0

msg1 db "Even count: $"
msg2 db 13,10,"Odd count: $"

.code
main proc
mov ax, @data
mov ds, ax

lea si, table
mov cx, count

loop1:
mov ax, [si]        ; load 16-bit number

test ax, 0001h      ; check LSB
jnz odd_case        ; if LSB=1 → odd

inc ev
jmp next

odd_case:
inc odd

next:
add si, 2           ; move to next word
loop loop1

; display even count
lea dx, msg1
mov ah, 09h
int 21h

mov dl, ev


add dl, 30h
mov ah, 02h
int 21h

; display odd count
lea dx, msg2
mov ah, 09h
int 21h

mov dl, odd
add dl, 30h
mov ah, 02h
int 21h

mov ax, 4c00h
int 21h

main endp
end main