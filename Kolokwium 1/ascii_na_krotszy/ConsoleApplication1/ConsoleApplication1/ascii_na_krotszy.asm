.686
.model flat
extern __write : PROC
extern _ExitProcess@4 : PROC
public _main

.data
	tekst db 'ako da sie lubic!',0
	wynik db 20 dup(?)

.code

zapisz_5_bitow PROC
	and al, 00011111b
	movzx ax, al
	shl ax, cl
	mov bx, 00011111b
	shl bx, cl
	not bx
	and word PTR [edi], bx
	or word PTR [edi], ax
	
	ret
zapisz_5_bitow ENDP


ASCII_na_krotszy PROC
	mov cl, 0
ptl:
	mov al, [esi]
	inc esi
	cmp al, 0
	je ostatni
	cmp al, 20H
	je spacja
	sub al, 60H
	jmp zapisz
spacja:
	mov al, 27
zapisz:
	call zapisz_5_bitow
	cmp cl, 3
	jb dalej1
	inc edi
dalej1:
	add cl, 5
	cmp cl, 8
	jb dalej2
	sub cl, 8
dalej2:
	jmp ptl
ostatni:
	call zapisz_5_bitow

	ret
ASCII_na_krotszy ENDP


_main PROC
	
	mov esi, OFFSET tekst
	mov edi, OFFSET wynik

	call ASCII_na_krotszy

wyswietl:
	push 20
	push OFFSET wynik
	push 1
	call __write

	push 0
	call _ExitProcess@4

_main ENDP

END