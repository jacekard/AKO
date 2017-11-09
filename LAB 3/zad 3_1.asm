;.686
;.model flat
;extern _ExitProcess@4 : PROC
;extern __write : PROC
;
;public _main
;.data
;
;;deklaracja tablicy 120-bajtowej do przchowania tworzonych cyfr
;znaki db 12 dup (?)
;
;.code
;_main PROC
	;mov ebp, 1
	;mov ecx, 49
	;mov eax, 1
	;call show_eax
;ptl:
	;add eax, ebp
	;inc ebp
	;call show_eax
	;loop ptl
;
	;push 0
	;call _ExitProcess@4
;_main ENDP
;
;
;show_eax PROC
	;pusha
	;;; wyswietlenie liczby w rejestrze eax na ekranie
	;mov esi, 10 ;indeks w tablicy znaki
	;mov ebx, 10 ;dzielnik = 10
;
;konwersja:
	;mov edx, 0 ; zerowanie starszej czêœci dzielnej
	;div ebx ;reszta w edx, iloraz w eax
	;add dl, 30h ;zamiana na kod ascii (30h = 0)
	;mov znaki[esi], dl ; zapisanie cyfry w kodzie ascii
	;dec esi
	;cmp eax, 0 ;sprawdzenie czy iloraz jest rowny zero
	;jnz konwersja
;
;wypelnienie:
	;cmp esi, 0
	;jz wyswietl ;skok gdy esi = 0
	;mov znaki[esi], 20h ; znak spacji
	;dec esi
	;jmp wypelnienie
;
;wyswietl:
	;mov znaki[0], 0Ah ;kod nowego wiersza
	;mov znaki[11], 0Ah ;kod nowego wiersza
;
;wyswietlanie:
	;push 12
	;push OFFSET znaki
	;push 1
	;call __write
	;add esp, 12
;
	;popa
	;ret
;show_eax ENDP
;
END