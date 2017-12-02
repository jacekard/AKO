.686
.model flat

extern __write : PROC
extern _ExitProcess@4 : PROC
public _main


.data
p dw 65, 129, 257
.code

_main PROC

	mov ebx, OFFSET p
	mov edi, 1
	mov eax, [edi][ebx]


	mov eax, 01010101b
	mov ebx, 0
	mov cl, 0

ptl:
	bt eax, ebx
	jnc dalej
	inc cl
dalej:
	inc ebx
	cmp ebx, 32
	jne ptl
	

	push 0
	call _ExitProcess@4
_main ENDP

sprawdz_bit PROC
	bt eax, edx
	jc koniec
	inc cl
koniec:
	ret

sprawdz_bit ENDP

END