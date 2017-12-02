.686
.model flat

public _szukaj_max ; int x, int y, int z
;
; EBP <--- EBP + 0
; œlad rozkazu CALL <-- EBP+4
; x <-- EBP+8
; y <-- EBP+12
; z <-- EBP+16
.code

_szukaj_max PROC
	push ebp
	mov ebp, esp

	mov eax, [ebp+8] ;x
	mov ebx, [ebp+12] ;y
	mov ecx, [ebp+16] ;z
	mov edx, [ebp+20] ;w

	cmp eax, ebx
	jg eax_wiekszy
	mov eax, ebx
eax_wiekszy:
	
	cmp ecx, edx
	jg ecx_wiekszy
	mov ecx, edx
ecx_wiekszy:
	cmp eax, ecx
	jg eax_wiekszy2
	mov eax, ecx
eax_wiekszy2:
	pop ebp
	ret
	

	mov eax, [ebp+8] ;wpisz x do eax 
	cmp eax, [ebp+12] ;porownaj z y
	jge x_wieksze ;jesli x>=y
	mov eax, [ebp+12]
	cmp eax, [ebp+16] ;porownaj y z zetem
	jge y_wieksze ; jesli y>=z
	mov eax, [ebp+16]
	cmp eax, [ebp+20]
zakoncz:
	pop ebp
	ret
x_wieksze:
	cmp eax, [ebp+16]
	jge zakoncz
	mov eax, [ebp+16] ;wpisz z gdy jest najwieksze
	jmp zakoncz
y_wieksze:
	jge zakoncz
_szukaj_max ENDP

END
	

