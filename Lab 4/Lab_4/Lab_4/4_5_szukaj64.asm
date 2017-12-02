public szukaj64_max 
 
.code 
 
szukaj64_max PROC  
	push  rbx  ; przechowanie rejestr�w  
	push  rsi 
	mov  rbx, rcx ; adres tablicy  
	mov  rcx, rdx ; liczba element�w tablicy  
	mov  rsi, 0 ; indeks biezacy w tablicy 
 
; w rejestrze RAX przechowywany bedzie najwiekszy dotychczas 
; znaleziony element tablicy - na razie przyjmujemy,ze jest 
; to pierwszy element tablicy  
	mov  rax, [rbx + rsi*8] 
 
; zmniejszenie o 1 liczby obieg�w petli, bo ilosc por�wnan
; jest mniejsza o 1 od iloci element�w tablicy  
	dec  rcx     
ptl: 
	inc  rsi  ; inkrementacja indeksu   

; por�wnanie najwiekszego, dotychczas znalezionego elementu 
; tablicy z elementem biezacym  
	cmp  rax, [rbx + rsi*8]  
	jge  dalej; skok, gdy element biecy jest     
			; niewikszy od dotychczas znalezionego      
			
; przypadek, gdy element biezacy jest wiekszy 
; od dotychczas znalezionego  
	mov rax, [rbx+rsi*8] 
 
dalej: 
	loop ptl ; organizacja ptli 
 
; obliczona wartosc maksymalna pozostaje w rejestrze RAX 
; i bedzie wykorzystana przez kod programu napisany w jezyku C 
 
	pop rsi  
	pop rbx  
	ret 

szukaj64_max ENDP 
 
END 