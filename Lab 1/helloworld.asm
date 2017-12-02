.model flat
.686
 
extern _MessageBoxA@16 : PROC
extern _MessageBeep@4 : PROC
extern _ExitProcess@4 : PROC
 
public _main
 
.data
    tekst db "Hello World!", 0
    tytul db "test", 0
.code
_main PROC
    push 0
    push OFFSET tytul
    push OFFSET tekst
    push 0
    call _MessageBoxA@16
    cmp eax, 1
    jz _beep
    jmp _exit
 
_beep:
    push 0
    call _MessageBeep@4
 
_exit:
push 0
call _ExitProcess@4
_main ENDP

END