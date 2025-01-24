assume cs:code

data segment
    db "Rarity here!", 0
data ends

code segment
begin:
    mov ax, data
    mov ds, ax
    mov si, 0

    mov dh, 10
    mov dl, 10
    mov cl, 2
    int 7ch

    mov dh, 12
    int 7ch

    mov ax, 4c00h
    int 21h
code ends

end begin