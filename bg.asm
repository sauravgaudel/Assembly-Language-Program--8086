.model small
.stack 100h

.data
msg db "Enter your name: $"
myName db 100
       db ?          ; actual length
       db 100 dup(?)  ; input buffer

.code
main proc
    mov ax,@data
    mov ds,ax

    ; ===== INPUT NAME =====
    lea dx,msg
    mov ah,09h
    int 21h

    lea dx,myName
    mov ah,0ah
    int 21h

    ; ===== CLEAR SCREEN =====
    mov ax,0003h      ; 80x25 text mode
    int 10h

    ; ===== FILL SCREEN WITH RED BG, BLACK FG =====
    mov ax,0600h
    mov bh,24h        ; red bg, black fg
    mov cx,0
    mov dx,184Fh      ; bottom-right
    int 10h

    ; ===== COPY INPUT TO $-TERMINATED STRING =====
    mov cl,[myName+1] 
    xor ch, ch      
    mov si,offset myName+2
    

    ; ===== CALCULATE HORIZONTAL CENTER =====
    mov al,[myName+1]       ; length
    mov bl,80
    sub bl,al
    shr bl,1                ; column = (80 - length)/2
    mov dl,bl               ; DL = column
    mov dh,12               ; row = 12 (vertical center)
    mov bh,0

    ; ===== SET CURSOR =====
    mov ah,02h
    int 10h

   again:
    mov al, [si]
    mov dl, al
    mov ah, 02H
    int 21H
    inc si
    loop again


    ; ===== EXIT =====
    mov ax,4c00h
    int 21h

main endp
end main