.686
.model flat
extern _ExitProcess@4 : PROC
extern __write : PROC
public _wyswietl_64

.code

_wyswietl_64 PROC

	push ebp
	mov ebp, esp
	push ebx
	push esi
	push edi
	mov esi, 10 ;dzielnik

	mov ecx, 22

	sub esp, ecx
	mov edi, esp

	mov ebx, [ebp+8] ;mlodsza czesc liczby
	mov eax, [ebp+12] ;starsza czesc liczby

	xor edx, edx
	;wpisz spacje
	mov [edi+ecx], byte ptr 0Ah
	dec ecx
ptl:
	mov edx, 0
	div esi
	push eax ;przechowaj w1
	mov eax, ebx
	cmp eax, 0
	jz koniec
	div esi
	add dl, '0'
	mov ebx, eax
	pop eax

	mov [edi + ecx], dl
	dec ecx
	jmp ptl
koniec:
	pop eax
	;wypelnianie zerami
	mov [edi+ecx], byte ptr 20H
	loop koniec

	mov [edi + ecx], byte ptr 10

wyswietl_liczbe:

	push 22
	push edi
	push 1
	call __write
	add esp, 12

	add esp, 22
	pop edi
	pop esi
	pop ebx
	pop ebp
	ret 
_wyswietl_64 ENDP
END
