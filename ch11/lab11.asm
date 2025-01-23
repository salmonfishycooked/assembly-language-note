assume cs:codesg

stacksg segment
    db 16 dup(0)
stacksg ends

datasg segment
    db "Rarity's magical, All-purpose castle!", 0
datasg ends

codesg segment
begin:
    mov ax, datasg
    mov ds, ax
    mov si, 0

    mov ax, stacksg
    mov ss, ax
    mov sp, 16

    call letterc

    mov ax, 4c00h
    int 21h

letterc:
    push si
    push cx

    mov ch, 0
    convert:
        mov cl, [si]
        jcxz ok
        cmp cl, 61h
        jb notUpper
        cmp cl, 7ah
        ja notUpper

        sub cl, 20h
        mov [si], cl
    notUpper:
        inc si
        jmp convert
    
    ok:
        pop cx
        pop si
        ret
codesg ends

end begin