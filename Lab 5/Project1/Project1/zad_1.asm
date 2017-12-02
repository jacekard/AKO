.686
.model flat

public _main
extern _ExitProcess@4 : PROC

.data
a db 64h, 35h, 34h, 61h, 32h, 63h,67h,34h,60h,61h,64h,37h,36h, 5fh, 37h, 60h,
b db 64h,66h,37h,67h,33h,61h,37h,32h,32h,61h,34h,66h,60h,36h,67h,62h,5dh,34h,40h,3eh, 0ah
.code

_main PROC


	push 0
	call _ExitProcess@4

_main ENDP
end