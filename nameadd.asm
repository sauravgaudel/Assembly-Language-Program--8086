.model small
.stack 100H
.data
 msg1 db "Enter you name: $"
 msg2 db 0dh, 0ah, "ENter you address: $"
 out1 db "Name : $"
 out2 db "Address: $"

 str1 db 100
      db ?
      db 100 dup('$')
 str2 db 100
      db ?
      db 100 dup('$')
.code
main proc

mov ax, @data
mov ds, ax

lea dx, msg1
mov ah, 09h
int 21H

lea dx, str1
mov ah, 0ah
int 21h

lea dx, msg2
mov ah, 09h
int 21H

lea dx, str2
mov ah, 0ah
int 21h

mov ax, 0003h
int 10H

mov ah, 02H
mov bh, 0
mov dh, 10
mov dl, 30
int 10h

lea dx, out1
mov ah, 09h
int 21H

mov si, offset str1+2
mov cl, [str1+1]
xor ch, ch

back1:
mov al, [si]
cmp al, 0dh
je here
mov ah, 02H
mov dl, al
int 21H

inc si

loop back1

here:

mov ah, 02H
mov bh, 0
mov dh, 11
mov dl, 30
int 10h

lea dx, out2
mov ah, 09h
int 21H

mov si, offset str2+2
mov cl, [str2+1]
xor ch, ch

back2:
mov al, [si]
cmp al, 0dh
je done
mov ah, 02H
mov dl, al
int 21H

inc si
loop back2

done:
mov ax, 4c00h
int 21H

main endp
end main

