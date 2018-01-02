; Program gwiazdki.asm 
; Wywietlanie znaków * w takt przerwa zegarowych Uruchomienie w trybie rzeczywistym procesora x86 lub na maszynie wirtualnej 
; zakoczenie programu po naciniciu klawisza 'x' 
; asemblacja (MASM 4.0):     masm  gwiazdki.asm,,,; 
; konsolidacja (LINK 3.60):  link  gwiazdki.obj; 
 
.386 
rozkazy  SEGMENT  use16 
ASSUME  CS:rozkazy 
;============================================================ 
; procedura obs³ugi przerwania zegarowego 
 
obsluga_zegara   PROC 
	; przechowanie uywanych rejestrów 

	push   ax       
	push   bx 
	push   es 
 
	; wpisanie adresu pamici ekranu do rejestru ES - pami ekranu dla trybu tekstowego zaczyna si od adresu B8000H, jednak do rejestru ES wpisujemy warto B800H, 
	; bo w trakcie obliczenia adresu procesor kadorazowo mnoy  zawarto rejestru ES przez 16 
	mov    ax, 0B800h  ;adres pamici ekranu 
	mov    es, ax 
 
	; zmienna 'licznik' zawiera adres biecy w pamici ekranu 
	mov    bx, cs:licznik 
 
	; przes³anie do pamici ekranu kodu ASCII wywietlanego znaku i kodu koloru: bia³y na czarnym tle (do nastpnego bajtu) 
	mov    byte PTR es:[bx], '*'    ; kod ASCII 
	mov    byte PTR es:[bx+1], 00010110B ; kolor 
   
	; zwikszenie o 2 adresu biecego w pamici ekranu 
	add    bx,2  
 
	; sprawdzenie czy adres biecy osign³ koniec pamici ekranu 
	cmp    bx,4000      
	jb    wysw_dalej  ; skok gdy nie koniec ekranu 
 
	; wyzerowanie adresu biecego, gdy ca³y ekran zapisany 
	mov    bx, 0     
 
	;zapisanie adresu biecego do zmiennej 'licznik' 
wysw_dalej: 
	mov    cs:licznik, bx        
 
	; odtworzenie rejestrów 
jeszcze_nie:
	pop    es 
	pop    bx 
	pop    ax 
 
	; skok do oryginalnej procedury obs³ugi przerwania zegarowego 
	jmp    dword PTR cs:wektor8 
 
	; dane programu ze wzgldu na specyfik obs³ugi przerwa 
	; umieszczone s w segmencie kodu 
	licznik    dw  320  ; wywietlanie poczwszy od 2. wiersza
	wektor8    dd  ? 
 
obsluga_zegara          ENDP 
 
;============================================================ 
; program g³ówny - instalacja i deinstalacja procedury  obs³ugi przerwa 
 
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
	cmp    al, 'x'    ; porównanie z kodem litery 'x' 
	jne    aktywne_oczekiwanie   ; skok, gdy inny znak ; deinstalacja procedury obs³ugi przerwania zegarowego 
 
	; odtworzenie oryginalnej zawartoci wektora nr 8 
	mov    eax, cs:wektor8 
	cli 
	mov    ds:[32], eax  ; przes³anie wartoci oryginalnej do wektora 8 w tablicy wektorów przerwa 
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