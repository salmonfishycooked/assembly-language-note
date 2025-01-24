; int 7ch install program
assume cs:code

code segment
begin:
    ; move the program showStr to the position int7ch points to
    mov ax, cs
    mov ds, ax
    mov si, offset showStr

    mov ax, 0
    mov es, ax
    mov di, 200h

    mov cx, offset showStr_end - offset showStr
    cld
    rep movsb

    ; set the corresponding interruption vector entry
    mov di, 7ch * 4
    mov word ptr es:[di], 200h
    mov word ptr es:[di + 2], 0

    mov ax, 4c00h
    int 21h

showStr:
    push ax
    push bx
    push es
    push di
    push si
    push dx
    push cx

    mov ax, 0b800h
    mov es, ax
    mov al, 160
    mul dh
    mov dh, 0
    add ax, dx
    add ax, dx
    mov di, ax

    mov ah, cl
    mov cx, 0
    showCh:
        mov cl, [si]
        jcxz ok
        mov al, cl
        mov es:[di], ax
        add di, 2
        inc si
        
        loop showCh

    ok:
        pop cx
        pop dx
        pop si
        pop di
        pop es
        pop bx
        pop ax
        iret
showStr_end: nop
code ends

end begin