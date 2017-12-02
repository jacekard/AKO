; Zamiana z UTF8 na UTF16 i wyœwietlenie napisu za pomoc¹ funkcji MessageBoxW@16
.686
.model flat
extern _ExitProcess@4 : PROC
extern _MessageBoxW@16 : PROC
public _main 
.data
bufor db 50h, 6fh, 0c5h, 82h, 0c4h, 85h,63h,7ah,65h,6eh,69h, 65h, 20h
	  db 7ah, 6fh, 73h, 74h, 61h,0c5h,82h, 6fh, 20h, 6eh, 61h, 77h, 69h
	  db 0c4h, 85h, 7ah, 61h, 6eh, 65h, 2eh,0e2h, 91h,0a4h
	  db 0ah, 0f0h, 9fh, 9ah,82h, 20h, 2dh, 20h, 0f0h, 9fh, 9ah, 8ch
wynik db 98 dup (?)
tytul dw 'u', 't', 'f', '8', ' ', '-', '>', 'u','t','f', '1','6', 0
.code
_main PROC
mov ecx, OFFSET wynik - OFFSET bufor ;ile znakow
mov edi, OFFSET wynik
mov esi, OFFSET bufor
ptl:
xor ebx, ebx
mov al, [esi]
inc esi
dec ecx
rcl al, 1
jc znak_wielobajtowy
rcr al, 1
mov bl, al
jmp zapisz_bx

znak_wielobajtowy:
rcl al, 2
jc znak_3_4_bajtowy
rcr al, 3
and al, 00011111b
mov bl, al
mov al, [esi]
inc esi
dec ecx
and al, 00111111b
shl bx, 6
or bl, al
jmp zapisz_bx

znak_3_4_bajtowy:
rcl al, 1
jc znak_4_bajtowy
rcr al, 4
and al, 00001111b
mov bl, al

mov edx, 1
do_twice:
mov al, [esi]
inc esi
dec ecx
and al, 00111111b
shl bx, 6
or bl, al

cmp edx, 0
jz zapisz_bx
dec edx
jmp do_twice

jmp zapisz_bx

znak_4_bajtowy:
rcr al, 4
and al, 00000111b
mov bl, al

mov edx, 2
do_3_times:
mov al, [esi]
inc esi
dec ecx
and al, 00111111b
shl ebx, 6
or bl, al

cmp edx, 0
jz cztery_bajty_kontynuuj
dec edx
jmp do_3_times

cztery_bajty_kontynuuj:
sub ebx, 10000h
shl ebx, 6
mov ax, bx
shr ax, 6
or ax, 1101110000000000b
shr ebx, 16
or bx, 1101100000000000b
mov [edi], bx
add edi, 2
mov bx, ax

zapisz_bx:
mov [edi], bx
add edi, 2
spr_warunek:
cmp ecx, 0
jnz ptl

wyswietlanie:
push 0
push OFFSET tytul
push OFFSET wynik
push 0
call _MessageBoxW@16


push 0
call _ExitProcess@4

_main ENDP
END