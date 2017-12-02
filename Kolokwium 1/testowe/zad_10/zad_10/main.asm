.686
.model flat

extern _ExitProcess@4 : PROC

public _main

.data
znaki db 01111111b, 11011011b, 10111001b, 01111101b, 01010101b, 11101010b, 10111110b, 10111111b,00000111b, 00000000b
.code
;14 bajtów powinno wyjsc
_main PROC
	mov esi, OFFSET znaki

	mov word PTR [esi], eax

	xor ecx, ecx ;wynik
	xor eax, eax
ptl:
	mov al, [esi]
	cmp al, 0
	jz koniec
	bt ax, 7
	jc dwu_lub_3_bity
	inc esi
	add ecx, 2
	jmp ptl
dwu_lub_3_bity:
	bt ax, 5
	jc trzy_bity
	add esi, 2
	add ecx, 2
	jmp ptl
trzy_bity:
	add esi, 3
	add ecx, 2
	jmp ptl

koniec:
	add ecx, 2
	push 0
	call _ExitProcess@4

_main ENDP
END
