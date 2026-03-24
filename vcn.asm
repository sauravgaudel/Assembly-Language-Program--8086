.model small
.stack 100h

.data
msg db "Enter a string:$"

str db 100
    db ?
    db 100 dup(?)

v_msg db 0dh,0ah,"Vowel is: $"
c_msg db 0dh,0ah,"Consonant is: $"
n_msg db 0dh,0ah,"Numeral is: $"
o_msg db 0dh,0ah,"Other is: $"

vow db 0
con db 0
num db 0
oth db 0

.code
main proc

    mov ax,@data
    mov ds,ax

    lea dx,msg
    mov ah,09h
    int 21h

    lea dx,str
    mov ah,0ah
    int 21h

    mov si,offset str+2
    mov cl,[str+1]
    xor ch,ch

back:
    mov al,[si]

    cmp al, ' '
    je next

    cmp al,'A'
    je vowel
    cmp al,'E'
    je vowel
    cmp al,'I'
    je vowel
    cmp al,'O'
    je vowel
    cmp al,'U'
    je vowel
    cmp al,'a'
    je vowel
    cmp al,'e'
    je vowel
    cmp al,'i'
    je vowel
    cmp al,'o'
    je vowel
    cmp al,'u'
    je vowel

    cmp al,'A'
    jb check_digit
    cmp al,'Z'
    jbe consonant

    cmp al,'a'
    jb check_digit
    cmp al,'z'
    jbe consonant

check_digit:
    cmp al,'0'
    jb other
    cmp al,'9'
    jbe number

    jmp other

vowel:
    inc vow
    jmp next

consonant:
    inc con
    jmp next

number:
    inc num
    jmp next

other:
    inc oth

next:
    inc si
    loop back


    ; vowel
    lea dx,v_msg
    mov ah,09h
    int 21h

    mov al,vow
    mov ah,0
    call DecimalPrint

    ; consonant
    lea dx,c_msg
    mov ah,09h
    int 21h

    mov al,con
    mov ah,0
    call DecimalPrint

    ; numeral
    lea dx,n_msg
    mov ah,09h
    int 21h

    mov al,num
    mov ah,0
    call DecimalPrint

    ; other
    lea dx,o_msg
    mov ah,09h
    int 21h

    mov al,oth
    mov ah,0
    call DecimalPrint

    ; exit
    mov ax,4c00h
    int 21h

main endp


DecimalPrint proc
    mov bx,10
    xor cx,cx

divide_loop:
    xor dx,dx
    div bx         

    push dx         
    inc cx

    cmp ax,0
    jne divide_loop

print_loop:
    pop dx
    add dl,30h
    mov ah,02h
    int 21h
    loop print_loop

    ret
DecimalPrint endp

end main