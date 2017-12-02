<<<<<<< HEAD
;.686
;.model flat
;extern _ExitProcess@4 : PROC
;public _main
;
;.data
;.code
;_main PROC
;
;MOV ebx , 1 ;liczba n-2
;MOV eax , 1 ;liczba n-1 ;wynik procedury
;MOV ecx , 6 ;n+2 -ta liczba fibonacciego
;
;petla:
;
;push eax
;add eax , ebx
;pop ebx
;
;; sprawdzenie warunku
;loop petla
;
;push 0
;call _ExitProcess@4
;
;_main ENDP
END
=======
;.686
;.model flat
;extern _ExitProcess@4 : PROC
;public _main
;
;.data
;.code
;_main PROC
;
;MOV ebx , 1 ;liczba n-2
;MOV eax , 1 ;liczba n-1 ;wynik procedury
;MOV ecx , 6 ;n+2 -ta liczba fibonacciego
;
;petla:
;
;push eax
;add eax , ebx
;pop ebx
;
;; sprawdzenie warunku
;loop petla
;
;push 0
;call _ExitProcess@4
;
;_main ENDP
END
>>>>>>> initializing git
