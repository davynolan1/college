#include <stdio.h>
#include <string.h>
int main() {
	int * pc;
	int c;

	c = 22;

	printf("Address of c: %u \n", &c);
	printf("Value of c: %d \n\n", c);

	pc = &c;
	printf("Content of pointer pc: %d \n", *pc);
	return 0;
}