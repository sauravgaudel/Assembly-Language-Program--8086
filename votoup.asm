.model small
.stack 100h
.data
msg1 db "Enter a string(<100 size): $"
str db 100
    db ?
    db 100 dup('$')

.code
main proc
mov ax, @data
mov ds, ax

lea dx, msg1
mov ah, 09h
int 21h

lea dx, str
mov ah,0Ah
int 21h

mov si, offset str+2

mov cl, [str+1]
mov ch, 0h

loops:
mov bl, [si]
cmp bl, 'a'
je vowel
cmp bl, 'e'
je vowel
cmp bl, 'i'
je vowel
cmp bl, 'o'
je vowel
cmp bl, 'u'
je vowel
mov [si], bl
jmp normal

vowel:
sub bl, 20h
mov [si], bl

normal:
inc si
loop loops

mov dl, 0dh
mov ah, 02h
int 21h
mov dl,0Ah
mov ah, 02h
int 21h

mov dx, offset str+2
mov ah, 09h
int 21h

mov ax, 4c00h
int 21h
main endp

end main


