#include <stdio.h>
void plus_jeden(int * a);
void liczba_przeciwna(int * x);

int main()
{
	int m, x;
	m = -5;
	x = 10;
	plus_jeden(&m);
	printf("\n x = %d\n", x);
	liczba_przeciwna(&x);
	printf("\n x = %d\n", x);
	// printf("\n m = %d\n", m);

	return 0;
}
