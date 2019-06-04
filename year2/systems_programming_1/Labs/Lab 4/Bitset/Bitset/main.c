#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include "bitset.h"

// print the contents of the bitset
void bitset_print(struct bitset * this)
{
	int i;
	int size = bitset_size(this);
	for (i = 0; i < size; i++) {
		if (bitset_lookup(this, i) == 1) {
			printf("%d ", i);
		}
	}
	printf("\n");
	for (i = 0; i < size; i++) {
		if (bitset_lookup(this, i) == 1) {
			printf("%c ", i);
		}
	}
	printf("\n");
}


// add the characters from a string to a bitset
void add_chars_to_set(struct bitset * this, char * s)
{
	int i;
	for (i = 0; s[i] != 0; i++) {
		unsigned char temp = s[i];
		bitset_add(this, temp);
	}
}

// small routine to test a bitset
void mytest()
{
	struct bitset * a = bitset_new(256);
	struct bitset * b = bitset_new(256);
	struct bitset * c = bitset_new(256);
	char * string1 = "ar meisce cha deim nios mobraon leanna go dteo ni bhlaisfidh me";
	char * string2 = "The gods themselves do trembleThe glorified bricklayer picks up a spare";

	add_chars_to_set(a, string1);
	add_chars_to_set(b, string2);

	// print the contents of the sets
	bitset_print(a);
	bitset_print(b);

	// compute and print the union of sets
	//bitset_union(c, a, b);
	//bitset_print(c);

	// compute and print the intersection of sets
	//bitset_intersect(c, a, b);
	//bitset_print(c);
}


int main() {
	mytest();

	system("pause");
	return 0;
}