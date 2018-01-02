.686
.XMM
.model flat

public _int2float

.data

.code

_int2float PROC
	;cvtpi2ps zamienia dwie liczby calk. typu int na dwie liczby typu float
	push ebp
	mov ebp, esp

	push esi
	push edi

	mov esi, [ebp+8] ; adres tablicy wejsciowej
	mov edi, [ebp+12] ; adres tablicy wyjsciowej

	cvtpi2ps xmm5, qword PTR [esi]
	movups [edi], xmm5

	pop edi
	pop esi
	pop ebp
	ret
_int2float ENDP



end

