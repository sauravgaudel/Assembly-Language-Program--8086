.model small
.stack 100h
.data
msg1 db 'Enter string: $'
msg2 db 13,10,'Vowels: $'

str db 100        ; max buffer size
    db ?           ; actual number of characters entered
    db 100 dup('$')

v db 0

.code
main proc
    mov ax,@data
    mov ds,ax

    ; print msg1
    mov ah,09h
    lea dx,msg1
    int 21h

    ; read string
    mov ah,0Ah
    lea dx,str
    int 21h

    ; initialize pointer to first character
    lea si,str+2

l1:
    mov al,[si]
    cmp al,13        ; Enter key
    je disp
    cmp al,'A'
    je vow
    cmp al,'E'
    je vow
    cmp al,'I'
    je vow
    cmp al,'O'
    je vow
    cmp al,'U'
    je vow
    cmp al,'a'
    je vow
    cmp al,'e'
    je vow
    cmp al,'i'
    je vow
    cmp al,'o'
    je vow
    cmp al,'u'
    je vow

    jmp next

vow:
    inc v

next:
    inc si
    jmp l1

disp:
    ; print vowels message
    mov ah,09h
    lea dx,msg2
    int 21h

    ; print vowels count
    mov dl,v
    add dl, 30h
    mov ah, 02h
    int 21h

    ; exit program
    mov ax,4C00h
    int 21h

main endp

end main