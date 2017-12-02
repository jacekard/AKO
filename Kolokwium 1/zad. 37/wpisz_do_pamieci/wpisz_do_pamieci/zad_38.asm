.686
.model flat

extern _ExitProcess@4 : PROC
extern __write : PROC
public _main

.data
iskry db 16 dup (?),0
.code
_main PROC
	mov edi, offset iskry
	mov ebx, 0110110001101100b ;przyk³adowy zakodowany ci¹g
	mov ecx,32;bêdziemy przesuwaæ o 1 32 razy, bo ca³y rejestr 32 bitowy, bit po bicie
start:
	rcl ebx, 1
	dec ecx
	setc al
	cmp al,0 
	je zero_z_przodu
jeden_z_przodu:
	rcl ebx, 1
	dec ecx
	setc al
	cmp al, 0
	je siedem
dziewiec:
	mov al, 9
zapisz:
	add al, '0'
	mov [edi], al
	inc edi
sprawdz:
	cmp ecx, 0
	jne start
	jmp koniec
siedem:
	mov al, 7
	jmp zapisz
zero_z_przodu:
	rcl ebx, 1
	dec ecx
	setc al
	cmp al, 0
	je trzy
cztery:
	mov al, 4
	jmp zapisz
trzy:
	mov al, 3
	jmp zapisz

koniec:
	push 16
	push OFFSET iskry
	push 1
	call __write
	add esp, 12

	push 0
	call _ExitProcess@4
_main ENDP
END