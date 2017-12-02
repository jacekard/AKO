.686
.model flat

	extern _ExitProcess@4 : PROC
	extern __write : PROC
	public _main

.data

dane db 11101010b, 01001000b, 01101101b, 00000010b, 0011010b, 11101111b, 00000100b, 00010000b, 01000000b , 00000000b
wynik db 15 dup(?)

Sty dd 255,256
Lut dw 16,17,18,19
Mar db 8,9,10,11

.code
;-----------ZAD 3------------;
uuencode PROC
	mov ebx, 165178h
	shl ebx, 0Ah
	add ebx, 40000000h

start:
	mov ecx, 3
ptl:
	mov al, [esi]
	cmp al, 0
	jz koniec
	shl eax, 8
	inc esi
	loop ptl
koniec:
	mov ecx, 4
konwersja:
	rol eax, 6
	mov ebx, 0
	mov bl, al
	and bl, 00111111b
	add bl, 32
	mov [edi], bl

	cmp bl, 0
	je zakoncz

	inc edi
	loop konwersja
	jmp start
zakoncz:
	ret

uuencode ENDP
;-----------ZAD 3 END------------;


_main PROC
	mov esi , offset dane
	mov edi , offset wynik

	call uuencode

	push 11
	push OFFSET wynik
	push 1
	call __write
	add esp, 12

	push 0
	call _ExitProcess@4

_main ENDP
END

