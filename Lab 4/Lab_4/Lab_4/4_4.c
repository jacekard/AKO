#include <stdio.h>
void przestaw(int tab[], int size);

int main() {

	int tab[] = { 9, 7, 5, 2 };
	int n = 4;

	for (int i = 0; i < n; i++) {
		if (n - i == 1)
			break;
		przestaw(tab, n - i);
	}
	for (int i = 0; i < 4; i++)
		printf("%d ", tab[i]);

	return 0;
}