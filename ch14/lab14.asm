; this program shows the current time on the center of the screen
assume cs:code

stack segment
    db 32 dup(0)
stack ends

code segment
begin:
    mov ax, stack
    mov ss, ax
    mov sp, 32

    mov bx, 160 * 12 + 24 * 2

    mov dl, '/'
    mov al, 9
    call showNumber

    mov al, 8
    call showNumber

    mov dl, ' '
    mov al, 7
    call showNumber

    mov dl, ':'
    mov al, 4
    call showNumber

    mov al, 2
    call showNumber
    
    mov dl, ' '
    mov al, 0
    call showNumber

    mov ax, 4c00h
    int 21h

; arguments: (bx) = offset at which data shows on the screen, (dl) = division character
; (al) = location that will be read in CMOS
showNumber:
    push cx

    out 70h, al
    in al, 71h

    mov ah, al
    mov cl, 4
    shr ah, cl
    and al, 00001111b

    add al, 30h
    add ah, 30h

    mov cx, 0b800h
    mov es, cx

    mov es:[bx], ah
    mov byte ptr es:[bx + 1], 2
    add bx, 2
    mov es:[bx], al
    mov byte ptr es:[bx + 1], 2
    add bx, 2
    mov es:[bx], dl
    mov byte ptr es:[bx + 1], 2
    add bx, 2

    pop cx
    ret
code ends

end begin