.686
.model flat

public _main
extern _ExitProcess@4 : PROC

.data
	;2x^2 - x - 15 = 0
	wsp_a dd +2.0
	wsp_b dd -1.0
	wsp_c dd -15.0

	dwa dd 2.0
	cztery dd 4.0
	x1 dd ?
	x2 dd ?
.code
	;d = b^2 - 4ac

	;x1 = -b - sqrt(d) / 2a
	;x2 = -b + sqrt(d) / 2a
	; dla d>0

	;x1 = -b/2a dla d=0

	;dla d<0 nie ma rzeczywistych
_main PROC

	finit
	fld wsp_a
	fld wsp_b
	fst st(2) ; kopiowanie wsp_b z st(0) do st(2)
	;sytuacja na stosie st(0) = b, st(1) = a, st(2) = b

	fmul st(0), st(0)
	fld cztery
	; 0 = 4, 1 = b^2, 2 = a, 3 = b
	fmul st(0), st(2) ;obliczenie 4*a
	fmul wsp_c ; obliczenie 4*a*c
	fsubp st(1), st(0)
	; 0: b^2-4ac, 1: a, 2: b
	fldz ; zaladowanie zera
	fcomi st(0), st(1)
	fstp st(0) ;usuniecie zera z wierzcholka stosu
	ja delta_ujemna ; if above 0
	; nie uwzgledniamy d = 0
	; 0: b^2 - 4ac, 1: a, 2: b
	fxch st(1) ;zamiana st(0) z st(1)
	fadd st(0), st(0) ; 2*a
	fstp st(3)
	;0: b^2 -4ac, 1: b, 2: 2*a
	fsqrt
	fst st(3)
	fchs ;zmiana znaku
	fsub st(0), st(1) ;-sqrt(delta)-b
	fdiv st(0), st(2)
	fstp x1
	; 0: b, 1: 2*a, 2: sqrt(delta)
	fchs
	fadd st(0), st(2)
	fdiv st(0), st(1)
	fstp x2

delta_ujemna:
	fstp st(0)
	fstp st(0)


	push 0
	call _ExitProcess@4

_main ENDP
end