.686
.model flat
;dane dw 7, 21, 2, 10, 11, 1, 2, 2, 25, 7 
;
;n=4 k=2
;iloœæ pomiarów = 10
;Dane dobrane tak aby œrednie wychodzi³y ca³kowite :D
;wynik_srednie 10, 6, 4, 9
;

extern _MessageBoxW@16 : PROC
extern _ExitProcess@4 : PROC
public _main

.data
dane dw 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 
wynik dw 5 dup (?), 0

.code

; ecx - n ilosc elementow do sredniej 
; ebx - k przesuniecie
; edx - m liczba elementow
; edi - wynik
; esi - wskaznik na dane

_main PROC
	mov ecx, 4
	mov ebx, 2
	mov edx, 10
	mov edi, OFFSET wynik
	mov esi, OFFSET dane

	;program
	push edi
	mov eax, 0
start:
	call oblicz_SMA
	add eax, ebx
	push eax
	add eax, ecx
	add edi, 2
	add esi, ebx
	add esi, ebx
	cmp eax, edx
	pop eax
	jbe start

	pop edi
wyswietl:
	push 0
	push edi
	push edi
	push 0
	call _MessageBoxW@16

	push 0
	call _ExitProcess@4

_main ENDP

oblicz_SMA PROC
	pusha
	mov eax, 0
	push ecx
	mov edx, 0
dodaj:
	add ax, [esi]
	dec ecx
	add esi, 2
	cmp ecx, 0
	jnz dodaj
	pop ecx
	div ecx
zapisz:
	mov [edi], ax
	popa
	ret
oblicz_SMA ENDP


END
