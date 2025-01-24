; This program will install my int9 program
; function: when you press key "A", it will show a screen of "A" if you release key "A"
assume cs:code

stack segment
    db 64 dup(0)
stack ends

code segment
begin:
    ; install my int9 program to 0000:0204
    ; use 0000:0200 to save cs and ip of the original int9 program for invoking
    mov ax, 0
    mov ds, ax
    push ds:[9 * 4]
    pop ds:[200h]
    push ds:[9 * 4 + 2]
    pop ds:[202h]

    ; copy my int9 program to 0000:0204
    mov ax, cs
    mov ds, ax
    mov si, offset int9

    mov ax, 0
    mov es, ax
    mov di, 204h

    mov cx, offset int9_end - offset int9
    cld
    rep movsb

    ; set the corresponding interruption entry for my int9 program
    cli
    mov word ptr es:[9 * 4], 204h
    mov word ptr es:[9 * 4 + 2], 0
    sti

    mov ax, 4c00h
    int 21h

int9:
    push ax
    push ds
    push cx

    in al, 60h

    ; call the original int9 program
    pushf
    call dword ptr cs:[200h]

    ; check if the scan code is "A"'s state of release
    cmp al, 1eh + 80h
    jne int9ret

    mov ax, 0b800h
    mov ds, ax
    mov bx, 0
    mov cx, 25 * 80
    showA:
        mov byte ptr ds:[bx], 'A'
        add bx, 2

        loop showA

    int9ret:
        pop cx
        pop ds
        pop ax
        iret

int9_end: nop
code ends

end begin