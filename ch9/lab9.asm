assume cs:code, ds:data

data segment
    db 'welcome to masm!'
data ends

code segment
start:
    mov ax, data
    mov ds, ax

    mov ax, 0B800h
    mov es, ax

    mov ah, 0cah

    mov bx, 0
    mov di, 160 * 12
    mov cx, 16
s:
    mov al, [bx]
    mov es:[di], ax
    inc bx
    add di, 2
    loop s

    mov ax, 4c00h
    int 21h
code ends

end start