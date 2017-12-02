#include <stdio.h>
void wyswietl_64(unsigned long long a);
void wyswietl_96(unsigned long long a, unsigned int b);

int main() {
	unsigned long long a = 0;
	unsigned int b = 0;
	a--;
	b--;
	//wyswietl_64(a);
	wyswietl_96(a, b);
	return 0;
}