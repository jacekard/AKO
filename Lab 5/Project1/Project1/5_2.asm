.686
.model flat

public _nowy_exp

.data
x dword ?
mianownik dword 1
.code

_nowy_exp PROC
	push ebp
	mov ebp, esp

	push ebx

	mov esi, OFFSET x
	mov eax, [ebp+8]
	mov [esi], eax

	mov ecx, 20
	mov ebx, 1
	finit

	fld1
ptl:
	push ebx
	fld1
licz:
	fld dword PTR x
	dec ebx
	fmulp st(1), st(0)
	jnz licz
	
	pop ebx
	push ebx
	fld1
mian:
	fild mianownik
	fmulp st(1), st(0)
	inc mianownik
	dec ebx
	jnz mian
	
	mov mianownik, 1
	fdivp st(1), st(0)
	faddp st(1), st(0)
	pop ebx
	inc ebx

	loop ptl

	pop ebx
	pop ebp
	ret
_nowy_exp ENDP
end