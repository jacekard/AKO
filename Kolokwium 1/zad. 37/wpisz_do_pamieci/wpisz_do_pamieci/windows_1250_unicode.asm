.686
.model flat

extern _ExitProcess@4 : PROC
extern __write : PROC
public _main


.data
q dw 0B193h


.code
_main PROC
	mov ax, [q]
	add ah, al

	push 0
	call _ExitProcess@4
_main ENDP
END
