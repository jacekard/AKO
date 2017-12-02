.686
.model flat
extern _ExitProcess@4 : PROC
extern __write : PROC
public _wyswietl_96

.code

_wyswietl_96 PROC
	push ebp
	mov ebp, esp

	mov ecx, [ebp + 8] ; a2
	mov ebx, [ebp + 12]; a1
	mov eax, [ebp + 16] ; a0

	sub esp, 30 ;rezerwuj 30 bajtow na cyfry + 2 na entery
	mov edi, esp
	push edi ;wrzuc adres do wyswietlenia
	mov esi, 29 ;licznik

	mov byte PTR [edi+esi], 0Ah
	dec esi
	

ptl: ;zacznij dzielenie
	push esi
	mov esi, 10 ;dzielnik
	
	mov edx, 0 ;wyzeruj reszte
	div esi
	push eax
	mov eax, ebx
	div esi
	push eax
	mov eax, ecx
	div esi
	cmp eax, 0
	je zapisz_ostatni

zapisz:
	mov ecx, eax
	pop ebx
	pop eax

	pop esi
	add dl, '0'
	mov [edi+esi], dl
	dec esi

	jmp ptl

zapisz_ostatni:
	mov ecx, eax
	pop ebx
	pop eax

	pop esi
	add dl, '0'
	mov [edi+esi], dl
	dec esi

koniec:

	pop edi

	push 30
	push edi
	push 1
	call __write
	add esp, 12

	add esp, 30
	pop ebp
	ret

_wyswietl_96 ENDP
end