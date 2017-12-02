<<<<<<< HEAD
;.686
;.model flat
;
;extern _ExitProcess@4 : PROC
;extern _MessageBoxA@16 : PROC 
;extern _MessageBoxW@16 : PROC
;public _main
;
;.data 
;tytul_Unicode dw 'T','e','k','s','t',' ','w',' ' 
			  ;dw 'f','o','r','m','a','c','i','e',' ' 
			  ;dw 'U','T','F','-','1','6', 0 
;tekst_Unicode dw 'K','a', 17Ch ,'d','y',' ','z','n','a','k',' ' 
			  ;dw 'z','a','j','m','u','j','e',' ' 
			  ;dw '1','6',' ','b','i','t', 0F3h ,'w', 0
;
;tytul_Win1250 db 'Tekst w standardzie Windows 1250', 0 
;tekst_Win1250 db 'Ka', 0BFh,'dy znak zajmuje 8 bit', 0F3h,'w', 0
;
;tytul_znaki dw 'Z', 'n', 'a', 'k', 'i', 0
;
;kotpies dw 'T', 'o', ' ', 'j', 'e', 's', 't', ' ', 'p', 'i', 'e', 's', ' '
	    ;db 3dh, 0d8h, 15h, 0dch
		;dw ' ', 'i', ' ','k', 'o', 't', ' '
		;db 3Dh, 0D8h, 08h, 0DCh, ' ', 0
;
;.code
;_main PROC
;
;push 0
;push OFFSET tytul_Win1250
;push OFFSET tekst_Win1250
;push 0
;call _MessageBoxA@16
;
;push 0
;push OFFSET tytul_Unicode
;push OFFSET tekst_Unicode
;push 0
;call _MessageBoxW@16
;
;push 0
;push OFFSET tytul_znaki
;push OFFSET kotpies
;push 0
;call _MessageBoxW@16
;
;push 0
;call _ExitProcess@4
;
;_main ENDP
=======
;.686
;.model flat
;
;extern _ExitProcess@4 : PROC
;extern _MessageBoxA@16 : PROC 
;extern _MessageBoxW@16 : PROC
;public _main
;
;.data 
;tytul_Unicode dw 'T','e','k','s','t',' ','w',' ' 
			  ;dw 'f','o','r','m','a','c','i','e',' ' 
			  ;dw 'U','T','F','-','1','6', 0 
;tekst_Unicode dw 'K','a', 17Ch ,'d','y',' ','z','n','a','k',' ' 
			  ;dw 'z','a','j','m','u','j','e',' ' 
			  ;dw '1','6',' ','b','i','t', 0F3h ,'w', 0
;
;tytul_Win1250 db 'Tekst w standardzie Windows 1250', 0 
;tekst_Win1250 db 'Ka', 0BFh,'dy znak zajmuje 8 bit', 0F3h,'w', 0
;
;tytul_znaki dw 'Z', 'n', 'a', 'k', 'i', 0
;
;kotpies dw 'T', 'o', ' ', 'j', 'e', 's', 't', ' ', 'p', 'i', 'e', 's', ' '
	    ;db 3dh, 0d8h, 15h, 0dch
		;dw ' ', 'i', ' ','k', 'o', 't', ' '
		;db 3Dh, 0D8h, 08h, 0DCh, ' ', 0
;
;.code
;_main PROC
;
;push 0
;push OFFSET tytul_Win1250
;push OFFSET tekst_Win1250
;push 0
;call _MessageBoxA@16
;
;push 0
;push OFFSET tytul_Unicode
;push OFFSET tekst_Unicode
;push 0
;call _MessageBoxW@16
;
;push 0
;push OFFSET tytul_znaki
;push OFFSET kotpies
;push 0
;call _MessageBoxW@16
;
;push 0
;call _ExitProcess@4
;
;_main ENDP
>>>>>>> initializing git
END