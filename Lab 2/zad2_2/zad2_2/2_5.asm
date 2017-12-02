<<<<<<< HEAD
;.686
;.model flat
;
;extern _ExitProcess@4 : PROC
;extern _MessageBoxA@16 : PROC
;extern __write : PROC
;extern __read : PROC
;public _main
;
;.data
;
;latin2_male db  165, 134, 169, 136, 228, 162, 152, 171, 190
;latin2_duze  db 164, 143, 168, 157, 227, 224, 151, 141, 189
;
;tytul db 'Assembler', 0
;tekst_pocz db 10, 'Prosze napisac jakis tekst'
		   ;db ' i nacisnac Enter', 10
;koniec_t db ?
;magazyn db 80 dup (?)
;nowa_linia db 10
;liczba_znakow dd ?
;
;.code
;_main PROC
;
;mov ecx, (OFFSET koniec_t) - (OFFSET tekst_pocz) ;ecx liczba znakow tekstu
;push ecx
;push OFFSET tekst_pocz
;push 1 ;nr urzadzenia, ekran nr 1
;call __write
;
;add esp, 12 ;usuniecie parametrow ze stosu!!
;
;push 80 ;maksymalna liczba znakow
;push OFFSET magazyn
;push 0 ;nr urzadzenia, klawiatura nr 0
;call __read
;
;add esp, 12 ;usuniecie parametrow ze stosu!!
;
;mov liczba_znakow, eax
;mov ecx, eax ;ecx teraz jest licznikiem petli rownym ilosci znakow
;;mov ebx, 0 ; indeks poczatkowy
;mov edi, OFFSET magazyn
;mov ebx, 0
;
;ptl:
;mov ebx, 0
;mov dl, [edi]
;cmp dl, 'a'
;jb dalej
;cmp dl, 'z'
;ja znaki_polskie
;
;sub dl, 32
;jmp continue
;
;znaki_polskie:
;cmp dl, latin2_male[ebx]
;jz zamien
;inc ebx
;jmp znaki_polskie
;
;zamien:
;mov dl, latin2_duze[ebx]
;
;
;
;
;continue:
;mov [edi], dl
;dalej:
;inc edi
;loop ptl
;
;; console
;push liczba_znakow
;push OFFSET magazyn
;push 1
;call __write
;add esp, 12
;
;;message box
;;push 0
;;push OFFSET tytul
;;push OFFSET magazyn
;;push 0
;;call _MessageBoxA@16
;
;push 0
;call _ExitProcess@4
;
;_main ENDP
=======
;.686
;.model flat
;
;extern _ExitProcess@4 : PROC
;extern _MessageBoxA@16 : PROC
;extern __write : PROC
;extern __read : PROC
;public _main
;
;.data
;
;latin2_male db  165, 134, 169, 136, 228, 162, 152, 171, 190
;latin2_duze  db 164, 143, 168, 157, 227, 224, 151, 141, 189
;
;tytul db 'Assembler', 0
;tekst_pocz db 10, 'Prosze napisac jakis tekst'
		   ;db ' i nacisnac Enter', 10
;koniec_t db ?
;magazyn db 80 dup (?)
;nowa_linia db 10
;liczba_znakow dd ?
;
;.code
;_main PROC
;
;mov ecx, (OFFSET koniec_t) - (OFFSET tekst_pocz) ;ecx liczba znakow tekstu
;push ecx
;push OFFSET tekst_pocz
;push 1 ;nr urzadzenia, ekran nr 1
;call __write
;
;add esp, 12 ;usuniecie parametrow ze stosu!!
;
;push 80 ;maksymalna liczba znakow
;push OFFSET magazyn
;push 0 ;nr urzadzenia, klawiatura nr 0
;call __read
;
;add esp, 12 ;usuniecie parametrow ze stosu!!
;
;mov liczba_znakow, eax
;mov ecx, eax ;ecx teraz jest licznikiem petli rownym ilosci znakow
;;mov ebx, 0 ; indeks poczatkowy
;mov edi, OFFSET magazyn
;mov ebx, 0
;
;ptl:
;mov ebx, 0
;mov dl, [edi]
;cmp dl, 'a'
;jb dalej
;cmp dl, 'z'
;ja znaki_polskie
;
;sub dl, 32
;jmp continue
;
;znaki_polskie:
;cmp dl, latin2_male[ebx]
;jz zamien
;inc ebx
;jmp znaki_polskie
;
;zamien:
;mov dl, latin2_duze[ebx]
;
;
;
;
;continue:
;mov [edi], dl
;dalej:
;inc edi
;loop ptl
;
;; console
;push liczba_znakow
;push OFFSET magazyn
;push 1
;call __write
;add esp, 12
;
;;message box
;;push 0
;;push OFFSET tytul
;;push OFFSET magazyn
;;push 0
;;call _MessageBoxA@16
;
;push 0
;call _ExitProcess@4
;
;_main ENDP
>>>>>>> initializing git
END