assume cs:code

code segment
begin:
    ;transport program do0 to 0000:0200
    mov ax, cs
    mov ds, ax
    mov si, offset do0_start

    mov ax, 0
    mov es, ax
    mov di, 200h

    mov cx, offset do0_end - offset do0_start
    cld
    rep movsb

    ;set the corresponding interruption vector table (number 0 interruption)
    mov word ptr es:[0], 200h
    mov word ptr es:[2], 0

    mov ax, 4c00h
    int 21h


do0_start:
    jmp short do0
    db "Rarity said you have an error on division!"
do0:
    mov ax, cs
    mov ds, ax
    mov si, 202h

    mov ax, 0b800h
    mov es, ax
    mov di, 12 * 160 + 24 * 2

    mov ah, 2
    mov cx, 42
    s:
        mov al, [si]
        mov es:[di], ax
        add di, 2
        inc si
        loop s
    
    mov ax, 4c00h
    int 21h

do0_end: nop
code ends

end begin