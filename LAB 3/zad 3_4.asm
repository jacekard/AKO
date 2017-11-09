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
;dziesiec dd 10 ;mnoznik\
;dekoder db '0123456789ABCDEF'
;
;.code
;_main PROC
	;call Wczytaj_do_eax
	;call wyswietl_eax_hex
;
;
	;push 0
	;call _ExitProcess@4
;_main ENDP
;
;Wyswietl_eax_hex PROC
	;; wywietlanie zawartoci rejestru EAX
	;; w postaci liczby szesnastkowej
;
	;pusha ; przechowanie rejestrów
	;; rezerwacja 12 bajtów na stosie (poprzez zmniejszenie
	;; rejestru ESP) przeznaczonych na tymczasowe przechowanie
	;; cyfr szesnastkowych wywietlanej liczby
	;sub esp, 12
	;mov edi, esp ; adres zarezerwowanego obszaru
	;; pamici
	;; przygotowanie konwersji
	;mov ecx, 8 ; liczba obiegów ptli konwersji
	;mov esi, 1 ; indeks pocztkowy uywany przy
	;; zapisie cyfr
	;; ptla konwersji
	;ptl3hex:
	;; przesunicie cykliczne (obrót) rejestru EAX o 4 bity w lewo
	;; w szczególnoci, w pierwszym obiegu ptli bity nr 31 - 28
	;; rejestru EAX zostan przesunite na pozycje 3 - 0
	;rol eax, 4
	;; wyodrbnienie 4 najm³odszych bitów i odczytanie z tablicy
	;; 'dekoder' odpowiadajcej im cyfry w zapisie szesnastkowym
	;mov ebx, eax ; kopiowanie EAX do EBX
	;and ebx, 0000000FH ; zerowanie bitów 31 - 4 rej.EBX
	;mov dl, dekoder[ebx] ; pobranie cyfry z tablicy
	;; przes³anie cyfry do obszaru roboczego
	;mov [edi][esi], dl
	;inc esi ;inkrementacja modyfikatora
	;loop ptl3hex ; sterowanie ptl
	;; wpisanie znaku nowego wiersza przed i po cyfrach
	;mov byte PTR [edi][0], 10
	;mov byte PTR [edi][9], 10
	;; wywietlenie przygotowanych cyfr
	;push 10 ; 8 cyfr + 2 znaki nowego wiersza
	;push edi ; adres obszaru roboczego
	;push 1 ; nr urzdzenia (tu: ekran)
	;call __write ; wywietlenie
	;; usunicie ze stosu 24 bajtów, w tym 12 bajtów zapisanych
	;; przez 3 rozkazy push przed rozkazem call
	;; i 12 bajtów zarezerwowanych na pocztku podprogramu
	;add esp, 24
	;popa ; odtworzenie rejestrów
	;ret ; powrót z podprogramu
;
;
;
;Wyswietl_eax_hex ENDP
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
	;call __read ; odczytywanie znaków z klawiatury
	;; (dwa obszar podkrelenia przed read)
	;add esp, 12 ; usunicie parametrów ze stosu
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
	;mov edx, 0 ; zerowanie starszej czêœci dzielnej
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