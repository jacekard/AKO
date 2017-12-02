.686
.model flat

extern _ExitProcess@4 : PROC
extern __write : PROC
public _main

.data
slowoESI db 'a',0
slowoEDI db 'ab',0
.code
_main PROC
	mov esi, OFFSET slowoESI
	mov edi, OFFSET slowoEDI
start:
	mov al, [esi]
	mov bl, [edi]
	inc esi
	inc edi
	cmp al,0
	jz al_zero
	cmp bl, 0
	jz bl_zero
	cmp al, bl
	jb al_pierwszy
	ja bl_pierwszy
	je start
al_pierwszy:
	add cl, 1
	CLC
	jmp koniec
bl_pierwszy:
	add cl, 1
	stc
	jmp koniec
al_zero:
	cmp bl, 0
	jnz al_pierwszy
	mov cl, 0
	add cl, 0
	clc
	jmp koniec
bl_zero:
	cmp al,0
	jnz bl_pierwszy
	mov cl, 0
	add cl, 0
	clc
	jmp koniec
koniec:
	
	push 0
	call _ExitProcess@4



_main ENDP
END