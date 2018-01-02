.686
.XMM
.model flat

public _sumowanie
.data

.code

_sumowanie PROC
	 push ebp
	 mov ebp, esp
	 push ebx
	 push esi
	 push edi

	 mov esi, [ebp+8] ; adres pierwszej tablicy
	 mov edi, [ebp+12] ; adres drugiej tablicy
	 mov ebx, [ebp+16] ; adres tablicy wynikowej

	 movups xmm5, [esi]
	 movups xmm6, [edi]
	 PADDSB xmm5, xmm6
	 ; zapisanie do pamieci
	 movups [ebx], xmm5
	 pop edi
	 pop esi
	 pop ebx
	 pop ebp
	 
	 ret
_sumowanie ENDP
end

