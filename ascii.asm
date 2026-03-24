.model small
.stack 100h

.data
table1 db 1,2,3,4,5
table2 db 5 dup(?)
msg db "Result: $"

.code
main proc
mov ax, @data
mov ds, ax

mov ax, 0003h
int 10h

mov ah, 02h      ; function: set cursor position
mov bh, 0        ; page number
mov dh, 12      ; row (0-24)
mov dl, 35      ; column (0-79)
int 10h


lea si, table1
lea di, table2
mov cx, 5

convert:
mov al, [si]
add al, 30h
mov [di], al

inc si
inc di
loop convert

; display
mov dx, offset msg
mov ah, 09h
int 21h

lea si, table2
mov cx, 5

print:
mov dl, [si]
mov ah, 02h
int 21h

inc si
loop print

mov ax, 4c00h
int 21h

main endp
end main