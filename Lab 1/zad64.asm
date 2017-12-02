<<<<<<< HEAD
extern _write : PROC
extern ExitProcess : PROC
public main

.data
hello db 10, 'Nazywam sie Rysiek', 10, 'It works!', 10

.code
main:
	mov rcx, 1 ; STDOUT
	mov RDX, OFFSET hello
	mov r8, 30 ; chars in 'hello'
	sub rsp, 40
	call _write
	add rsp, 40
	sub rsp, 8
	
	mov rcx, 0
	mov rcx, 1
	mov rcx, 2
	mov rcx, 0
	call ExitProcess

END
=======
extern _write : PROC
extern ExitProcess : PROC
public main

.data
hello db 10, 'Nazywam sie Rysiek', 10, 'It works!', 10

.code
main:
	mov rcx, 1 ; STDOUT
	mov RDX, OFFSET hello
	mov r8, 30 ; chars in 'hello'
	sub rsp, 40
	call _write
	add rsp, 40
	sub rsp, 8
	
	mov rcx, 0
	mov rcx, 1
	mov rcx, 2
	mov rcx, 0
	call ExitProcess

END
>>>>>>> initializing git
