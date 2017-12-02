<<<<<<< HEAD
.686
.model flat

extern _ExitProcess@4 : PROC
extern _MessageBoxW@16 : PROC
extern __write : PROC
extern __read : PROC
public _main

.data

latin2_male db  165, 134, 169, 136, 228, 162, 152, 171, 190
utf16  dw 0104h, 0106h, 0118h, 0141h, 0143h, 00D3h, 015Ah, 0179h, 017Bh

tytul dw 'A', 's', 'e', 'm', 'b', 'l', 'e', 'r', 0
tekst_pocz db 10, 'Prosze napisac jakis tekst'
		   db ' i nacisnac Enter', 10
koniec_t db ?
magazyn db 80 dup (?)
wynik dw 80 dup (?)
nowa_linia db 10
liczba_znakow dd ?

.code
_main PROC

mov ecx, (OFFSET koniec_t) - (OFFSET tekst_pocz) ;ecx liczba znakow tekstu
push ecx
push OFFSET tekst_pocz
push 1 ;nr urzadzenia, ekran nr 1
call __write

add esp, 12 ;usuniecie parametrow ze stosu!!

push 80 ;maksymalna liczba znakow
push OFFSET magazyn
push 0 ;nr urzadzenia, klawiatura nr 0
call __read

add esp, 12 ;usuniecie parametrow ze stosu!!

mov liczba_znakow, eax
mov ecx, eax ;ecx teraz jest licznikiem petli rownym ilosci znakow
;mov ebx, 0 ; indeks poczatkowy

mov eax, 0
mov esi, OFFSET wynik

ptl:
mov ebx, 0
mov dx, 0

mov dl, magazyn[eax]
cmp dl, 'a'
jb continue
cmp dl, 'z'
ja znaki_polskie

sub dl, 32
jmp continue

znaki_polskie:
cmp dl, latin2_male[bx]
jz zamien
inc bx
jmp znaki_polskie

zamien:
mov dx, utf16[2*ebx]

continue:
mov [esi], dx
add esi, 2
dalej:
inc eax
loop ptl

;message box
push 0
push OFFSET tytul
push OFFSET wynik
push 0
call _MessageBoxW@16

push 0
call _ExitProcess@4



_main ENDP
=======
.686
.model flat

extern _ExitProcess@4 : PROC
extern _MessageBoxW@16 : PROC
extern __write : PROC
extern __read : PROC
public _main

.data

latin2_male db  165, 134, 169, 136, 228, 162, 152, 171, 190
utf16  dw 0104h, 0106h, 0118h, 0141h, 0143h, 00D3h, 015Ah, 0179h, 017Bh

tytul dw 'A', 's', 'e', 'm', 'b', 'l', 'e', 'r', 0
tekst_pocz db 10, 'Prosze napisac jakis tekst'
		   db ' i nacisnac Enter', 10
koniec_t db ?
magazyn db 80 dup (?)
wynik dw 80 dup (?)
nowa_linia db 10
liczba_znakow dd ?

.code
_main PROC

mov ecx, (OFFSET koniec_t) - (OFFSET tekst_pocz) ;ecx liczba znakow tekstu
push ecx
push OFFSET tekst_pocz
push 1 ;nr urzadzenia, ekran nr 1
call __write

add esp, 12 ;usuniecie parametrow ze stosu!!

push 80 ;maksymalna liczba znakow
push OFFSET magazyn
push 0 ;nr urzadzenia, klawiatura nr 0
call __read

add esp, 12 ;usuniecie parametrow ze stosu!!

mov liczba_znakow, eax
mov ecx, eax ;ecx teraz jest licznikiem petli rownym ilosci znakow
;mov ebx, 0 ; indeks poczatkowy

mov eax, 0
mov esi, OFFSET wynik

ptl:
mov ebx, 0
mov dx, 0

mov dl, magazyn[eax]
cmp dl, 'a'
jb continue
cmp dl, 'z'
ja znaki_polskie

sub dl, 32
jmp continue

znaki_polskie:
cmp dl, latin2_male[bx]
jz zamien
inc bx
jmp znaki_polskie

zamien:
mov dx, utf16[2*ebx]

continue:
mov [esi], dx
add esi, 2
dalej:
inc eax
loop ptl

;message box
push 0
push OFFSET tytul
push OFFSET wynik
push 0
call _MessageBoxW@16

push 0
call _ExitProcess@4



_main ENDP
>>>>>>> initializing git
END