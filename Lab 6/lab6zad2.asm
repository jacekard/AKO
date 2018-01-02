.386 
rozkazy  SEGMENT  use16 
ASSUME  CS:rozkazy 

obsluga_zegara   PROC 
	; przechowanie uywanych rejestrów 

	push   ax       
	push   bx 
	push   es 

 
	; zmienna 'licznik' zawiera adres biecy w pamici ekranu 
	mov    bx, cs:licznik 
 
	; przes³anie do pamici ekranu kodu ASCII wywietlanego znaku i kodu koloru: bia³y na czarnym tle (do nastpnego bajtu) 
	mov    byte PTR es:[bx], '*'    ; kod ASCII 
	mov    byte PTR es:[bx+1], 00010110B ; kolor 
   

	mov ah, cs:kierunek

	cmp ah, cs:lewo
	je w_lewo
	cmp ah, cs:prawo
	je w_prawo
	cmp ah, cs:gora
	je w_gore
	cmp ah, cs:dol
	je w_dol
	jmp dalej

w_lewo:
	sub bx, 2
	jmp dalej
w_prawo:
	add bx, 2  
	jmp dalej
w_gore:
	sub bx, 160
	jmp dalej
w_dol:
	add bx, 160
	jmp dalej
dalej:
	;; sprawdzenie czy adres biecy osign³ koniec pamici ekranu 
;	cmp    bx,4000      
;	jb    wysw_dalej  ; skok gdy nie koniec ekranu 
 
;	; wyzerowanie adresu biecego, gdy ca³y ekran zapisany 
;	mov    bx, 0     
 
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
	lewo db 1
	prawo db 2
	gora db 3
	dol db 4

	kierunek db 2
 
obsluga_zegara          ENDP 


obsluga_klawiatury PROC	
	in al, 60H
	
	cmp al, 17
	je ustaw_wgore
	cmp al, 30
	je ustaw_lewo
	cmp al, 32
	je ustaw_prawo
	cmp al, 31
	je ustaw_wdol

	jmp nic

ustaw_lewo:
	mov cs:kierunek, byte PTR 1
	jmp nic

ustaw_prawo:
	mov cs:kierunek, byte PTR 2
	jmp nic

ustaw_wdol:
	mov cs:kierunek, byte PTR 4
	jmp nic

ustaw_wgore:
	mov cs:kierunek, byte PTR 3
	jmp nic
nic:
	jmp dword PTR cs:wektor9
	wektor9 dd ?
obsluga_klawiatury ENDP
 
;============================================================ 
; program g³ówny 
 
zacznij: 
	push bx
	push cx
	push es
	mov al, 0
	mov ah, 5
	int 10
	mov ax, 0
	mov ds, ax

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

	; odczytanie zawartoci wektora nr 8 i zapisanie go w zmiennej 'wektor8' (wektor nr 8 zajmuje w pamici 4 bajty poczwszy od adresu fizycznego 8 * 4 = 32) 
	mov    eax,ds:[36]  ; adres fizyczny 0*16 + 32 = 32 
	mov    cs:wektor9, eax   


	; wpisanie do wektora nr 8 adresu procedury 'obsluga_zegara' 
	mov    ax, SEG obsluga_klawiatury ; cz segmentowa adresu 
	mov    bx, OFFSET obsluga_klawiatury ; offset adresu 
 
	cli    ; zablokowanie przerwa  
 
	; zapisanie adresu procedury do wektora nr 8 
	mov    ds:[36], bx   ; OFFSET           
	mov    ds:[38], ax   ; cz. segmentowa 
 
	sti      ;odblokowanie przerwa 

    mov cx, 0B800h ;adres pamieci ekranu
	mov es, cx
	mov bx, 0
aktywne_oczekiwanie: 
	mov ah,1       
	int 16H              
	; funkcja INT 16H (AH=1) BIOSu ustawia ZF=1 jeli nacinito jaki klawisz 
	jz    aktywne_oczekiwanie 
 
	; odczytanie kodu ASCII nacinitego klawisza (INT 16H, AH=0)  do rejestru AL 
	mov    ah, 0 
	int    16H 
	cmp    al, 1BH    ; porównanie z kodem klawisza esc
	je    koniec   ; skok, gdy esc

	mov bx, 0
	jmp aktywne_oczekiwanie
koniec:
	; zakoczenie programu 


	; odtworzenie oryginalnej zawartoci wektora nr 8 
	mov    eax, cs:wektor8 
	cli 
	mov    ds:[32], eax  ; przes³anie wartoci oryginalnej do wektora 8 w tablicy wektorów przerwa 
	sti 
 

	; odtworzenie oryginalnej zawartoci wektora nr 8 
	mov    eax, cs:wektor9
	cli 
	mov    ds:[36], eax  ; przes³anie wartoci oryginalnej do wektora 8 w tablicy wektorów przerwa 
	sti 

	pop es
	pop cx
	pop bx
	mov    al, 0 
	mov    ah, 4CH 
	int    21H 

rozkazy    ENDS 
   
nasz_stos   SEGMENT  stack 
	db    128 dup (?) 
nasz_stos   ENDS 
 
END  zacznij 