.686
.model flat

extern _ExitProcess@4 : PROC

public _main

.data
pwnd db 64h, 35h, 34h, 61h, 32h, 63h,67h,34h,60h,61h,64h,37h,36h, 5fh, 37h, 60h
    db 64h,66h,37h,67h,33h,61h,37h,32h,32h,61h,34h,66h,60h,36h,67h,62h,5dh,34h,40h,3eh, 0ah

n = $ - pwnd

aa dd 0, 1, 2
bb dw 3,4,5,6
cc dw 7,8,9,10,11,12,13

.code
;14 bajtów powinno wyjsc
_main PROC
	
	movzx ecx, pwnd
	mov edx, ecx
	mov eax, n
	add ecx, n

	mov edi, OFFSET bb - OFFSET aa

	mov eax, dword PTR cc[edi+2]

	push 0
	call _ExitProcess@4

;14 bajtów powinno wyjsc
_main ENDP
END