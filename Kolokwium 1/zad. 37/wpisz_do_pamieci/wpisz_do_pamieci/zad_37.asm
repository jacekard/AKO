.686
.model flat

extern _ExitProcess@4 : PROC
extern __write : PROC
public _main

.data
cyfry db '1', '8','9','2',0
cyfry2 db '1',0
cyfry3 db '1','2',0
;mo¿ecie sobie popróbowaæ, czy dla ka¿dego przypadku dzia³a xd
przepis db 8 dup (?),0 ;przyk³adowo tutaj 8 bajtów, byle >=cyfry

.code
_main PROC

	mov esi, OFFSET cyfry
	mov edi, OFFSET przepis

	cmp [esi+1], byte PTR 0
	je jedna_cyfra
	cmp [esi+2], byte PTR 0
	je  dwie_cyfry
wiecej_cyfr:
	cmp [esi+3], byte PTR 0
	je dopisz_kropke
	mov al, [esi]
	mov [edi], al
	inc edi
	inc esi
	jmp wiecej_cyfr
dopisz_kropke:
	mov al, [esi]
	mov [edi], al
	mov [edi+1], byte PTR '.'
	mov al, [esi+1]
	mov [edi+2], al
	mov al, [esi+2]
	mov [edi+3], al
	jmp koniec
jedna_cyfra:
	mov [edi], byte PTR '0'
	mov [edi+1], byte PTR '.'
	mov [edi+2], byte PTR '0'
	mov al, [esi]
	mov [edi+3], al
	jmp koniec
dwie_cyfry:
	mov [edi], byte PTR '0'
	mov [edi+1], byte PTR '.'
	mov al, [esi]
	mov [edi+2], al
	mov al, [esi+1]
	mov [edi+3], al
	jmp koniec
koniec:

	push 5
	push OFFSET przepis
	push 1
	call __write
	add esp, 12

	push 0
	call _ExitProcess@4
_main ENDP
END