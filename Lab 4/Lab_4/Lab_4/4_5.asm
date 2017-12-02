public suma_siedmiu_liczb

.code

suma_siedmiu_liczb PROC
	push rbp
	mov rbp, rsp

	mov rax, 0
	add rax, rcx
	add rax, rdx
	add rax, r8
	add rax, r9
	add rax, [rbp+48]
	add rax, [rbp+56]
	add rax, [rbp+64]

	pop rbp
	ret

suma_siedmiu_liczb ENDP

END

	;rcx - pierwsza liczba
	;rdc - druga liczba
	;r8 - trzecia liczba
	;r9 - czwarta liczba
	;
	;
	;rbp ---- rbp
	;call ------ rbp +8
	;32-bajtowy 'shadow space' rbp+16
	;pi¹ta liczba rbp+48
	;szósta liczba rbp +56
	;siódma liczba rbp +64