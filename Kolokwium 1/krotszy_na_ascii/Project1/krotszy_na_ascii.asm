.686
.model flat

extern __write : PROC
extern _ExitProcess@4 : PROC
extern _MessageBoxA@16 : PROC
public _main

.data

tekst db 01100001b, 10111101b, 10101101b, 11001010b , 10100100b, 10111011b, 10101100b , 01001001b, 01100101b, 00000000b
wynik db 20 dup (?)
obszar dw 2 dup(?)

.code
_main PROC
	mov esi, OFFSET tekst
	mov edi, oFFSET wynik

	call krotszy_na_ascii

	push 0
	push OFFSET wynik
	push OFFSET wynik
	push 0
	call _MessageBoxA@16

	push 0
	call _ExitProcess@4

_main ENDP

krotszy_na_ascii PROC
	mov ecx, 0
start:
	call pobierz5bitow

	cmp cl, 2
	jbe modulo
	inc esi
	
modulo:
	push eax
	add cl, 5
	movzx eax, cl
	mov ecx, 8
	div cl
	movzx ecx, ah
	
	pop eax
	cmp al, 0
	jz koniec
	cmp al, 27
	je wpisz_spacje
	add al, 60h
	jmp zapisz
wpisz_spacje:
	mov al, 20h
zapisz:
	mov [edi], al
	inc edi
	jmp start
koniec:
	mov [edi], byte PTR 0
	ret
krotszy_na_ascii ENDP


pobierz5bitow PROC
	mov ax, word PTR [esi]
	shr ax, cl
	and al, 00011111b
	ret
pobierz5bitow ENDP

wpisz_adres_obszaru PROC
	mov eax, OFFSET obszar
	mov [eax], eax
	ret
wpisz_adres_obszaru ENDP

END