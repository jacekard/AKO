;.686
;.model flat
;extern _ExitProcess@4 : PROC
;extern __write : PROC
;extern __read : PROC
;public _main
;.data
;
;;deklaracja tablicy 120-bajtowej do przchowania tworzonych cyfr
;obszar db 12 dup (?)
;dziesiec dd 10 ;mnoznik
;
;.code
;_main PROC
;
	;call Wczytaj_do_eax
	;mul eax
	;call wyswietl_eax
;
;
	;push 0
	;call _ExitProcess@4
;_main ENDP
;
;Wczytaj_do_eax PROC
	;push ebx
	;push ecx
	;push edx
	;pushf
;
	;mov ebx, OFFSET obszar
	;mov edx, 0
;
	;push 12
	;push ebx ; adres obszaru pamici
	;push 0; numer urzdzenia (0 dla klawiatury)
	;call __read ; odczytywanie znak�w z klawiatury
	;; (dwa obszar podkrelenia przed read)
	;add esp, 12 ; usunicie parametr�w ze stosu
;
	;mov eax, 0
;ptl:
	;mov cl, [ebx]
	;inc ebx
	;cmp cl, 10
	;je wcisnieto_enter
	;sub cl, 30h
	;movzx ecx, cl
;
	;mul dziesiec
	;add eax, ecx
	;jmp ptl
;
;
;wcisnieto_enter:
;
	;popf
	;pop edx
	;pop ecx
	;pop ebx
;
	;ret
;Wczytaj_do_eax ENDP
;
;Wyswietl_eax PROC
	;pusha
	;;; wyswietlenie liczby w rejestrze eax na ekranie
	;mov esi, 10 ;indeks w tablicy obszar
	;mov ebx, 10 ;dzielnik = 10
;
;konwersja:
	;mov edx, 0 ; zerowanie starszej cz�ci dzielnej
	;div ebx ;reszta w edx, iloraz w eax
	;add dl, 30h ;zamiana na kod ascii (30h = 0)
	;mov obszar[esi], dl ; zapisanie cyfry w kodzie ascii
	;dec esi
	;cmp eax, 0 ;sprawdzenie czy iloraz jest rowny zero
	;jnz konwersja
;
;wypelnienie:
	;cmp esi, 0
	;jz wyswietl ;skok gdy esi = 0
	;mov obszar[esi], 20h ; znak spacji
	;dec esi
	;jmp wypelnienie
;
;wyswietl:
	;mov obszar[0], 0Ah ;kod nowego wiersza
	;mov obszar[11], 0Ah ;kod nowego wiersza
;
;wyswietlanie:
	;push 12
	;push OFFSET obszar
	;push 1
	;call __write
	;add esp, 12
;
	;popa
	;ret
;Wyswietl_eax ENDP
;
END