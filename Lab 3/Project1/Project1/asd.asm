.686
.model flat
extern _ExitProcess@4 : PROC
extern __write : PROC
extern __read : PROC
public _main
.data

;deklaracja tablicy 120-bajtowej do przchowania tworzonych cyfr
obszar db 12 dup (?)
dziesiec dd 10 ;mnoznik\
dekoder db '0123456789ABCDEF'

.code

_main PROC

	;call Wczytaj_do_eax_hex

	mov eax, 10000000H

	call wyswietl_eax


	push 0
	call _ExitProcess@4
_main ENDP

wczytaj_do_eax_hex PROC
	add esp, 4
	push ebx
	push ecx
	push edx
	push esi
	push edi
	push ebp
	; rezerwacja 12 bajt�w na stosie przeznaczonych na tymczasowe
	; przechowanie cyfr szesnastkowych wywietlanej liczby
	sub esp, 12 ; rezerwacja poprzez zmniejszenie ESP
	mov esi, esp ; adres zarezerwowanego obszaru pamici
	push dword PTR 10 ; max ilo znak�w wczytyw. liczby
	push esi ; adres obszaru pamici
	push dword PTR 0; numer urzdzenia (0 dla klawiatury)
	call __read ; odczytywanie znak�w z klawiatury
	; (dwa znaki podkrelenia przed read)
	add esp, 12 ; usunicie parametr�w ze stosu
	mov eax, 0 ; dotychczas uzyskany wynik
pocz_konw:
	mov dl, [esi] ; pobranie kolejnego bajtu
	inc esi ; inkrementacja indeksu
	cmp dl, 10 ; sprawdzenie czy nacinito Enter
	je gotowe ; skok do koca podprogramu
	; sprawdzenie czy wprowadzony znak jest cyfr 0, 1, 2 , ..., 9
	cmp dl, '0'
	jb pocz_konw ; inny znak jest ignorowany
	cmp dl, '9'
	ja sprawdzaj_dalej
	sub dl, '0' ; zamiana kodu ASCII na warto cyfry
dopisz:
	shl eax, 4 ; przesunicie logiczne w lewo o 4 bity
	or al, dl ; dopisanie utworzonego kodu 4-bitowego
	; na 4 ostatnie bity rejestru EAX
	jmp pocz_konw ; skok na pocztek ptli konwersji
	; sprawdzenie czy wprowadzony znak jest cyfr A, B, ..., F
sprawdzaj_dalej:
	cmp dl, 'A'
	jb pocz_konw ; inny znak jest ignorowany
	cmp dl, 'F'
	ja sprawdzaj_dalej2
	sub dl, 'A' - 10 ; wyznaczenie kodu binarnego
	jmp dopisz
	; sprawdzenie czy wprowadzony znak jest cyfr a, b, ..., f
sprawdzaj_dalej2:
	cmp dl, 'a'
	jb pocz_konw ; inny znak jest ignorowany
	cmp dl, 'f'
	ja pocz_konw ; inny znak jest ignorowany
	sub dl, 'a' - 10
	jmp dopisz
gotowe:
	; zwolnienie zarezerwowanego obszaru pamici
	add esp, 12
	pop ebp
	pop edi
	pop esi
	pop edx
	pop ecx
	pop ebx
	ret
wczytaj_do_eax_hex ENDP


Wyswietl_eax_hex PROC
	; wywietlanie zawartoci rejestru EAX
	; w postaci liczby szesnastkowej

	pusha ; przechowanie rejestr�w
	; rezerwacja 12 bajt�w na stosie (poprzez zmniejszenie
	; rejestru ESP) przeznaczonych na tymczasowe przechowanie
	; cyfr szesnastkowych wywietlanej liczby
	sub esp, 12
	mov edi, esp ; adres zarezerwowanego obszaru
	; pamici
	; przygotowanie konwersji
	mov ecx, 8 ; liczba obieg�w ptli konwersji
	mov esi, 1 ; indeks pocztkowy uywany przy
	; zapisie cyfr
	; ptla konwersji
ptl3hex:
	; przesunicie cykliczne (obr�t) rejestru EAX o 4 bity w lewo
	; w szczeg�lnoci, w pierwszym obiegu ptli bity nr 31 - 28
	; rejestru EAX zostan przesunite na pozycje 3 - 0
	rol eax, 4
	; wyodrbnienie 4 najm�odszych bit�w i odczytanie z tablicy
	; 'dekoder' odpowiadajcej im cyfry w zapisie szesnastkowym
	mov ebx, eax ; kopiowanie EAX do EBX
	and ebx, 0000000FH ; zerowanie bit�w 31 - 4 rej.EBX
	mov dl, dekoder[ebx] ; pobranie cyfry z tablicy
	; przes�anie cyfry do obszaru roboczego
	mov [edi][esi], dl
	inc esi ;inkrementacja modyfikatora
	loop ptl3hex ; sterowanie ptl

	mov esi, 1
	mov dl, 20h
ptl4hex:
	cmp byte PTR [edi][esi], 30h
	jne cyfra_znaczaca
	mov byte PTR [edi][esi], 20h
	inc esi
	cmp esi, 9
	jne ptl4hex
cyfra_znaczaca:

	; wpisanie znaku nowego wiersza przed i po cyfrach
	mov byte PTR [edi][0], 10
	mov byte PTR [edi][9], 10
	; wywietlenie przygotowanych cyfr
	push 10 ; 8 cyfr + 2 znaki nowego wiersza
	push edi ; adres obszaru roboczego
	push 1 ; nr urzdzenia (tu: ekran)
	call __write ; wywietlenie
	; usunicie ze stosu 24 bajt�w, w tym 12 bajt�w zapisanych
	; przez 3 rozkazy push przed rozkazem call
	; i 12 bajt�w zarezerwowanych na pocztku podprogramu
	add esp, 24
	popa ; odtworzenie rejestr�w
	ret ; powr�t z podprogramu



Wyswietl_eax_hex ENDP

Wczytaj_do_eax PROC
	push ebx
	push ecx
	push edx
	pushf

	mov ebx, OFFSET obszar
	mov edx, 0

	push 12
	push ebx ; adres obszaru pamici
	push 0; numer urzdzenia (0 dla klawiatury)
	call __read ; odczytywanie znak�w z klawiatury
	; (dwa obszar podkrelenia przed read)
	add esp, 12 ; usunicie parametr�w ze stosu

	mov eax, 0
ptl:
	mov cl, [ebx]
	inc ebx
	cmp cl, 10
	je wcisnieto_enter
	sub cl, 30h
	movzx ecx, cl

	mul dziesiec
	add eax, ecx
	jmp ptl


wcisnieto_enter:

	popf
	pop edx
	pop ecx
	pop ebx

	ret
Wczytaj_do_eax ENDP

Wyswietl_eax PROC
	pusha

	;; wyswietlenie liczby w rejestrze eax na ekranie
	mov esi, 10 ;indeks w tablicy obszar
	mov ebx, 10 ;dzielnik = 10

	sub esp, 12
	mov edi, esp

konwersja:
	mov edx, 0 ; zerowanie starszej cz�ci dzielnej
	div ebx ;reszta w edx, iloraz w eax
	add dl, 30h ;zamiana na kod ascii (30h = 0)
	mov [edi], dl ; zapisanie cyfry w kodzie ascii
	
	cmp eax, 0 ;sprawdzenie czy iloraz jest rowny zero
	jnz konwersja

wypelnienie:
	cmp esi, 0
	jz wyswietl ;skok gdy esi = 0
	mov obszar[esi], 20h ; znak spacji
	dec esi
	jmp wypelnienie

wyswietl:
	mov obszar[0], 0Ah ;kod nowego wiersza
	mov obszar[11], 0Ah ;kod nowego wiersza

wyswietlanie:
	push 12
	push OFFSET obszar
	push 1
	call __write
	add esp, 12

	popa
	ret
Wyswietl_eax ENDP

END