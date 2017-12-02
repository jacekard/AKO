#include <stdio.h>
int szukaj_max(int a, int b, int c, int w);


int main() {
	int x, y, z, w, wynik;
	printf("\nPodaj cztery liczby calkowite ze znakiem: ");
	scanf_s("%d %d %d %d", &x, &y, &z, &w, 32);
	
	wynik = szukaj_max(x, y, z, w);
	printf("\nSposrod podanych liczb %d, %d, %d, %d, \
	liczba %d jest najwieksza\n", x, y, z, w, wynik);

	return 0;
}