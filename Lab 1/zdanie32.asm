<<<<<<< HEAD
;; program przyk�adowy (wersja 32-bitowa)
;.686
;.model flat
;extern _ExitProcess@4 : PROC
;extern __write : PROC ; (dwa znaki podkrelenia)
;public _main
;.data
;tekst db 10, 'Nazywam si' , 0a9h , ' Jacek', 10
;db 'M', 0a2h ,'j pierwszy 32-bitowy program '
;db 'asemblerowy dzia', 88h ,'a ju', 0beh ,' poprawnie!', 10
;.code
;_main PROC
;
;; obliczenie sumy wyraz�w ciagu 3 + 5 + 7 + 9 + 11
;; obliczenie bez uzycia petli rozkazowej
;mov eax, 3 ; pierwszy element ciagu
;add eax, 5 ; dodanie drugiego elementu
;add eax, 7 ; dodanie trzeciego elementu
;add eax, 9 ; dodanie czwartego elementu
;add eax, 11 ; dodanie piatego elementu
;
;; obliczenie z uzyciem ptli rozkazowej
;mov eax, 0 ; poczatkowa wartosc sumy
;mov ebx, 3 ; pierwszy element cigu
;mov ecx, 5 ; liczba obieg�w petli
;ptl: add eax, ebx ; dodanie kolejnego elementu
;add ebx, 2 ; obliczenie nastpnego elementu
;sub ecx, 1 ; zmniejszenie licznka obieg�w petli
;jnz ptl ; skok, gdy licznik obieg�w rozny od 0
;
;
;
;mov ecx, 85 ; liczba znak�w wyswietlanego tekstu
;; wywo�anie funkcji �write� z biblioteki jeezyka C
;push ecx ; liczba znak�w wywietlanego tekstu
;push dword PTR OFFSET tekst ; po�oenie obszaru
;; ze znakami
;push dword PTR 1 ; uchwyt urzadzenia wyjsciowego
;call __write ; wyswietlenie znak�w
;; (dwa znaki podkreslenia _ )
;add esp, 12 ; usuniecie parametr�w ze stosu
;; zakoczenie wykonywania programu
;push dword PTR 0 ; kod powrotu programu
;call _ExitProcess@4
;_main ENDP
=======
;; program przyk�adowy (wersja 32-bitowa)
;.686
;.model flat
;extern _ExitProcess@4 : PROC
;extern __write : PROC ; (dwa znaki podkrelenia)
;public _main
;.data
;tekst db 10, 'Nazywam si' , 0a9h , ' Jacek', 10
;db 'M', 0a2h ,'j pierwszy 32-bitowy program '
;db 'asemblerowy dzia', 88h ,'a ju', 0beh ,' poprawnie!', 10
;.code
;_main PROC
;
;; obliczenie sumy wyraz�w ciagu 3 + 5 + 7 + 9 + 11
;; obliczenie bez uzycia petli rozkazowej
;mov eax, 3 ; pierwszy element ciagu
;add eax, 5 ; dodanie drugiego elementu
;add eax, 7 ; dodanie trzeciego elementu
;add eax, 9 ; dodanie czwartego elementu
;add eax, 11 ; dodanie piatego elementu
;
;; obliczenie z uzyciem ptli rozkazowej
;mov eax, 0 ; poczatkowa wartosc sumy
;mov ebx, 3 ; pierwszy element cigu
;mov ecx, 5 ; liczba obieg�w petli
;ptl: add eax, ebx ; dodanie kolejnego elementu
;add ebx, 2 ; obliczenie nastpnego elementu
;sub ecx, 1 ; zmniejszenie licznka obieg�w petli
;jnz ptl ; skok, gdy licznik obieg�w rozny od 0
;
;
;
;mov ecx, 85 ; liczba znak�w wyswietlanego tekstu
;; wywo�anie funkcji �write� z biblioteki jeezyka C
;push ecx ; liczba znak�w wywietlanego tekstu
;push dword PTR OFFSET tekst ; po�oenie obszaru
;; ze znakami
;push dword PTR 1 ; uchwyt urzadzenia wyjsciowego
;call __write ; wyswietlenie znak�w
;; (dwa znaki podkreslenia _ )
;add esp, 12 ; usuniecie parametr�w ze stosu
;; zakoczenie wykonywania programu
;push dword PTR 0 ; kod powrotu programu
;call _ExitProcess@4
;_main ENDP
>>>>>>> initializing git
END