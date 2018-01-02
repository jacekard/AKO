#include <stdio.h>
#include <math.h>
float srednia_harm(float* tablica, unsigned int n); //zad 1
float nowy_exp(float x); //zad 2
void sumowanie(char* liczby_A, char* liczby_B, char* wynik);
void int2float(int * calkowite, float * zmienno_przec);
void pm_jeden(float * tabl);
void dodawanie_SSE(float * a);

int main() {
	//zad 1
	//unsigned int n;
	//printf("Podaj ilosc elementow tablicy typu float: \n");
	//scanf_s("%u", &n);
	//
	//float *tab = malloc(sizeof(float) * n);

	//for (int i = 0; i < n; i++) {
	//	printf("\n%d:", i);
	//	scanf_s("%f", &tab[i]);
	//}
	//float wynik = srednia_harm(tab, n);
	//printf("\n%.4f", wynik);

	//zad 2
	//float x;
	//printf("\nPodaj liczbe x typu float: ");
	//scanf_s("%f", &x);
	//printf("\n%f", nowy_exp(x));
	//double y = 2.0;


	//zad 3
	//char liczby_A[16] = { -128, -127, -126, -125, -124, -123, -122,
	//	-121, 120, 121, 122, 123, 124, 125, 126, 127 };
	//char liczby_B[16] = { -3, -3, -3, -3, -3, -3, -3, -3,
	//	3, 3, 3, 3, 3, 3, 3, 3 };
	//char wynik[16];

	//sumowanie(liczby_A, liczby_B, wynik);
	//for (int i = 0; i < 16; i++) {
	//	printf("%d ", wynik[i]);
	//}

	//zad 4
	//int a[2] = { -17, 24 };
	//float r[4];
	//// podany rozkaz zapisuje w pamiêci od razu 128 bitów,
	//// wiêc musz¹ byæ 4 elementy w tablicy
	//int2float(a, r);
	//printf("\nKonwersja = %f %f\n", r[0], r[1]);

	//zad 5
	//float tablica[4] = { 27.5, 143.57, 2100.0, -3.51 };
	//printf("\n%f %f %f %f\n", tablica[0], tablica[1], tablica[2], tablica[3]);
	//pm_jeden(tablica);
	//printf("\n%f %f %f %f\n", tablica[0], tablica[1], tablica[2], tablica[3]);

	//zad 6
	/*float wyniki[4];
	dodawanie_SSE(wyniki);
	printf("\nWyniki = %f %f %f %f\n", wyniki[0], wyniki[1], wyniki[2], wyniki[3]);*/

	return 0;
}

int silnia(int x) {
	int wynik = 1;
	for (int i = 1; i <= x; i++) {
		wynik *= i;
	}

	return wynik;
}

double test(double x) {
	double wynik = 1;
	for (int i = 1; i < 20; i++) {
		wynik += pow(x, i) / silnia(i);
	}
	return wynik;
}