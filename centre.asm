.model small
.stack 100h

.data
; Input buffer: first byte = max length, second byte = actual length
buffer db 100       ; maximum 20 characters
       db ?        ; actual number of chars entered
       db 20 dup(?) ; space for input

.code
main proc
    mov ax, @data
    mov ds, ax

    ; 1. Clear screen (mode 3)
    mov ax, 0003h
    int 10h

    ; 2. Get string input
    lea dx, buffer
    mov ah, 0Ah       ; DOS buffered input
    int 21h

    ; 3. Convert to uppercase
    lea si, buffer+2  ; actual string starts at offset 2
convert_loop:
    mov al, [si]
    cmp al, 0Dh       ; Enter key = end of string
    je done_convert
    cmp al, 'a'
    jb skip_char
    cmp al, 'z'
    ja skip_char
    sub al, 20h       ; convert lowercase → uppercase
skip_char:
    mov [si], al
    inc si
    jmp convert_loop
done_convert:

    ; 4. Calculate center of window (2,10 to 22,70)
    mov si, offset buffer+2          ; start of string
    mov cl, [buffer+1] 
    mov ch, 0             ; length count
done_count:
    ; cx = string length

    ; Window: row 2–22, col 10–70
    ; center row = (2 + 22)/2 = 12
    ; center col = (10 + 70)/2 = 40
    ; adjust left = 40 - (cx/2)
    mov ax, cx
    shr ax, 1          ; divide length by 2
    mov bx, 40
    sub bx, ax         ; starting column = bx
    mov dh, 12         ; center row
    mov dl, bl         ; starting column

    ; 5. Move cursor to center
    mov ah, 02h
    mov bh, 0          ; page 0
    int 10h

    ; 6. Print the string
    lea si, buffer+2
print_loop:
    mov al, [si]
    cmp al, 0Dh
    je done_print
    mov dl, al
    mov ah, 02h       ; BIOS teletype output
    int 21h
    inc si
    jmp print_loop
done_print:

    ; 7. Exit program
    mov ax, 4C00h
    int 21h

main endp
end main