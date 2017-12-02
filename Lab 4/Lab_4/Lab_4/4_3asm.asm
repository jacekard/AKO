.686
.model flat
public _odejmij_jeden
.code

_odejmij_jeden PROC
	push ebp
	mov ebp, esp
	push ebx

	mov ecx, [ebp+8]
	mov ebx, [ecx]
	mov eax, [ebx]
	dec eax
	mov [ebx], eax
	;mov [ecx], ebx ;;dlaczego to dzia³a? i bez tej linijki te¿?
	pop ebx
	pop ebp
	ret

_odejmij_jeden ENDP

END