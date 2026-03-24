.model small
.stack 100h
.data

msg db "Enter a string: $"
str db 100
    db ?
    db 100 dup(?)
row db 8
col db 35

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

; convert to uppercase
lea si, str+2

loops:
mov al, [si]
cmp al, 0Dh
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
lea si, str+2

; clear screen
mov ax, 0003h
int 10h

mov ah, 02h
mov bh, 0
mov dh, row
mov dl, col
int 10h

again:
mov dl, [si]
cmp dl, 0Dh
je last

cmp dl, ' '
je new

mov ah, 02h
int 21h
inc col
inc si
jmp again

new:
inc row

; move cursor to new row
mov ah, 02h
mov bh, 0
mov dh, row
mov dl, col
int 10h

inc si
jmp again

last:
mov ax, 4c00h
int 21h

main endp
end main