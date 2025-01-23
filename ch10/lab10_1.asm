assume cs:code

stack segment
    db 16 dup(0)
stack ends

data segment
    db 'Rarity here!', 0
data ends

code segment
start:
    mov dh, 8
    mov dl, 3
    mov cl, 2
    mov ax, data
    mov ds, ax
    mov si, 0

    mov ax, stack
    mov ss, ax
    mov sp, 16
    call showStr

    mov ax, 4c00h
    int 21h

showStr:
    push bx
    push di
    push ax
    push si
    push es

    mov ax, 0b800h
    mov es, ax

    mov al, 160
    mul dh

    mov bx, ax
    mov ah, cl
    mov di, 0
    showChar:
        mov ch, 0
        mov cl, [si]
        jcxz ok
        mov al, [si]
        mov es:[bx + di], ax
        add di, 2
        inc si
        
        jmp showChar
    ok:
        pop es
        pop si
        pop ax
        pop di
        pop bx
        ret
code ends

end start