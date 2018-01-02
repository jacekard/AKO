.686
.XMM
.model flat

public _pm_jeden

.data
 jeden dword -1.0, -1.0, -1.0, -1.0
.code

_pm_jeden PROC
	push ebp
	mov ebp, esp
	push esi

	mov esi, [ebp+8] ; adres tablicy wejsciowej
	movups xmm3, [esi]
	movups xmm5, jeden

	ADDSUBPS xmm3, xmm5
	movups [esi], xmm3

	pop esi
	pop ebp
	ret

_pm_jeden ENDP
END