.686
.model flat

public _srednia_harm

.data
n dword ?
jeden dword 1
zero dword 0
wynik dword ?

.code
_srednia_harm PROC
	push ebp
	mov ebp, esp
	push esi
	push edi

	mov edi, OFFSET n
	mov ecx, dword PTR [ebp+12] ;ilosc el tablicy
	mov [edi], ecx
	mov esi, dword PTR [ebp+8] ;wskaznik na tablice


	finit
	fild dword PTR n
	fild dword PTR zero
ptl:
	dec ecx
	fild dword PTR jeden
	fld dword PTR [esi+4*ecx]
	fdivp st(1), st(0)
	faddp st(1), st(0)
	jnz ptl
	
	fdivp st(1), st(0)
	
	pop edi
	pop esi
	pop ebp
	ret 
_srednia_harm ENDP
END