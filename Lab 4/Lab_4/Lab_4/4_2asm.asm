.686
.model flat

public _plus_jeden
public _liczba_przeciwna

.code

;ebp
;call
;a
_liczba_przeciwna PROC
	push ebp
	mov ebp, esp
	push ebx

	mov ebx, [ebp+8]
	mov eax, [ebx]
	neg eax
	mov [ebx], eax

	pop ebx
	pop ebp
	ret
_liczba_przeciwna ENDP



_plus_jeden PROC

	push ebp
	mov ebp, esp
	push ebx

	mov ebx, [ebp+8]
	mov eax, [ebx]
	inc eax
	mov [ebx], eax

	pop ebx
	pop ebp
	ret
_plus_jeden ENDP
END