; Program gwiazdki.asm 
; Wywietlanie znak�w * w takt przerwa zegarowych Uruchomienie w trybie rzeczywistym procesora x86 lub na maszynie wirtualnej 
; zakoczenie programu po naciniciu klawisza 'x' 
; asemblacja (MASM 4.0):     masm  gwiazdki.asm,,,; 
; konsolidacja (LINK 3.60):  link  gwiazdki.obj; 
 
.386 
rozkazy  SEGMENT  use16 
ASSUME  CS:rozkazy 
 
;============================================================ 
; procedura obs�ugi przerwania zegarowego 
 
obsluga_zegara   PROC 
	; przechowanie uywanych rejestr�w 

	push   ax       
	push   bx 
	push   es 

	add cs:czasomierz, 1
	cmp cs:czasomierz, 19
	jb jeszcze_nie
	mov cs:czasomierz, 0
 
	; wpisanie adresu pamici ekranu do rejestru ES - pami ekranu dla trybu tekstowego zaczyna si od adresu B8000H, jednak do rejestru ES wpisujemy warto B800H, 
	; bo w trakcie obliczenia adresu procesor kadorazowo mnoy  zawarto rejestru ES przez 16 
	mov    ax, 0B800h  ;adres pamici ekranu 
	mov    es, ax 
 
	; zmienna 'licznik' zawiera adres biecy w pamici ekranu 
	mov    bx, cs:licznik 
 
	; przes�anie do pamici ekranu kodu ASCII wywietlanego znaku i kodu koloru: bia�y na czarnym tle (do nastpnego bajtu) 
	mov    byte PTR es:[bx], '*'    ; kod ASCII 
	mov    byte PTR es:[bx+1], 00010110B ; kolor 
   
	; zwikszenie o 2 adresu biecego w pamici ekranu 
	add    bx,2  
 
	; sprawdzenie czy adres biecy osign� koniec pamici ekranu 
	cmp    bx,4000      
	jb    wysw_dalej  ; skok gdy nie koniec ekranu 
 
	; wyzerowanie adresu biecego, gdy ca�y ekran zapisany 
	mov    bx, 0     
 
	;zapisanie adresu biecego do zmiennej 'licznik' 
wysw_dalej: 
	mov    cs:licznik, bx        
 
	; odtworzenie rejestr�w 
jeszcze_nie:
	pop    es 
	pop    bx 
	pop    ax 
 
	; skok do oryginalnej procedury obs�ugi przerwania zegarowego 
	jmp    dword PTR cs:wektor8 
 
	; dane programu ze wzgldu na specyfik obs�ugi przerwa 
	; umieszczone s w segmencie kodu 
	licznik    dw  320  ; wywietlanie poczwszy od 2. wiersza
	wektor8    dd  ? 
	czasomierz db 0
 
obsluga_zegara          ENDP 
 
;============================================================ 
; program g��wny - instalacja i deinstalacja procedury  obs�ugi przerwa 
 
	; ustalenie strony nr 0 dla trybu tekstowego 
zacznij: 
	mov    al, 0   
	mov    ah, 5                 
	int    10                  
 
	mov    ax, 0 
	mov    ds,ax    ; zerowanie rejestru DS 
 
 
	; odczytanie zawartoci wektora nr 8 i zapisanie go w zmiennej 'wektor8' (wektor nr 8 zajmuje w pamici 4 bajty poczwszy od adresu fizycznego 8 * 4 = 32) 
	mov    eax,ds:[32]  ; adres fizyczny 0*16 + 32 = 32 
	mov    cs:wektor8, eax   
     
	; wpisanie do wektora nr 8 adresu procedury 'obsluga_zegara' 
	mov    ax, SEG obsluga_zegara ; cz segmentowa adresu 
	mov    bx, OFFSET obsluga_zegara  ; offset adresu 
 
	cli    ; zablokowanie przerwa  
 
	; zapisanie adresu procedury do wektora nr 8 
	mov    ds:[32], bx   ; OFFSET           
	mov    ds:[34], ax   ; cz. segmentowa 
 
	sti      ;odblokowanie przerwa 
 
   
	; oczekiwanie na nacinicie klawisza 'x' 
aktywne_oczekiwanie: 
	mov ah,1       
	int 16H              
	; funkcja INT 16H (AH=1) BIOSu ustawia ZF=1 jeli nacinito jaki klawisz 
	jz    aktywne_oczekiwanie 
 
	; odczytanie kodu ASCII nacinitego klawisza (INT 16H, AH=0)  do rejestru AL 
	mov    ah, 0 
	int    16H 
	cmp    al, 'x'    ; por�wnanie z kodem litery 'x' 
	jne    aktywne_oczekiwanie   ; skok, gdy inny znak ; deinstalacja procedury obs�ugi przerwania zegarowego 
 
	; odtworzenie oryginalnej zawartoci wektora nr 8 
	mov    eax, cs:wektor8 
	cli 
	mov    ds:[32], eax  ; przes�anie wartoci oryginalnej do wektora 8 w tablicy wektor�w przerwa 
	sti 
 
	; zakoczenie programu 
	mov    al, 0 
	mov    ah, 4CH 
	int    21H 
rozkazy    ENDS 
   
nasz_stos   SEGMENT  stack 
	db    128 dup (?) 
nasz_stos   ENDS 
 
END  zacznij 