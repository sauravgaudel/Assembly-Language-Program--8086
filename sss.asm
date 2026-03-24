.model small 
.stack 100h 
.data 
list1 db 10h,20h,30h,40h,50h 
list2 db 5 dup(?) 
.code 
main proc far 
mov ax,@data 
mov ds,ax 
mov si,offset list1 ;move the offset address of list1 to si 
mov di,offset list2 ;move the offset address of list2 to di 
mov cx,0005h    ;cx is always used as counter 
again: 
mov al,[si] ;mov the first element of list1 to al i.e content of ds:si 
mov [di],al ;transfer the first element of list1 to list2 
    inc si      
    inc di 
loop again  ;auto decrements cx and the loop continues till cx=0000h 

mov ax,4c00h 
int 21h 

main endp 
end main 