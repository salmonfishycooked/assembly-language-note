assume cs:codesg, ss:stacksg, ds:datasg

stacksg segment
    dw 0, 0, 0, 0, 0, 0, 0, 0
stacksg ends

datasg segment
    db '1. display      '
    db '2. brows        '
    db '3. replace      '
    db '4. modify       '
datasg ends

codesg segment
start:
    mov ax, datasg
    mov ds, ax

    mov ax, stacksg
    mov ss, ax
    mov sp, 10h

    mov bx, 0
    mov cx, 4

s0:
    push cx
    mov di, 0
    mov cx, 4
s:
    mov al, [bx + di + 3]
    and al, 11011111b
    mov [bx + di + 3], al
    inc di
    loop s

    add bx, 10h
    pop cx
    loop s0

    mov ax, 4c00h
    int 21h
    
codesg ends

end start