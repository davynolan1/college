#include <stdlib.h>
#include <stdio.h>
#include "bitset.h"

struct bitset * bitset_new(int size) 
{
	//bitset * new_bitset = calloc(size / MEMORYSIZE + 1, sizeof(unsigned int));
	//return new_bitset;
	
	bitset * new_bitset = (bitset *)malloc(sizeof(bitset));
	new_bitset->size_in_bits = size;
	new_bitset->size_in_words = size / MEMORYSIZE;
	new_bitset->bits_in_word = MEMORYSIZE;
	//new_bitset->keys = calloc(size / MEMORYSIZE + 1,sizeof(unsigned) * size / MEMORYSIZE);
	new_bitset->keys = malloc(sizeof(unsigned) * size / MEMORYSIZE);
	for (int i = 0; i < size / MEMORYSIZE; i++)
	{
		new_bitset->keys[i] = 0;
	}
	
	return new_bitset;
	
}

// get the size of the universe of items that could be stored in the set
int bitset_size(struct bitset * this)
{
	return this->size_in_bits;
}

// check to see if an item is in the set
int bitset_lookup(struct bitset * this, int item)
{
	int i = item / MEMORYSIZE;
	int pos = item % MEMORYSIZE;

	unsigned int flag = 1;
	flag = flag << pos;

	if (this->keys[i] & flag)
		return 1;
	else
		return 0;
}

// get the number of items that are stored in the set
int bitset_cardinality(struct bitset * this)
{
	int count = 0;
	for (int i = 0; i < this->size_in_words; i++)
	{
		if (bitset_lookup(this, i) == 1)
		{
			count++;
		}
	}
	return count;
}




// add an item, with number 'item' to the set
// has no effect if the item is already in the set
void bitset_add(struct bitset * this, int item)
{
	int i = item / MEMORYSIZE;
	int pos = item % MEMORYSIZE;

	unsigned int flag = 1;
	flag = flag << pos;

	this->keys[i] = this->keys[i] | flag;
}

// remove an item with number 'item' from the set
void bitset_remove(struct bitset * this, int item)
{
	int i = item / MEMORYSIZE;
	int pos = item % MEMORYSIZE;

	unsigned int flag = 1;
	flag = flag << pos;
	flag = ~flag;

	this->keys[i] = this->keys[i] & flag;
}

// place the union of src1 and src2 into dest;
// all of src1, src2, and dest must have the same size universe
void bitset_union(struct bitset * dest, struct bitset * src1, struct bitset * src2)
{
	int i = dest->size_in_bits / MEMORYSIZE;
	
	while (i > 0)
	{
		dest->keys[i] = src1->keys[i] | src2->keys[i];
		i--;
	}
}

// place the intersection of src1 and src2 into dest
// all of src1, src2, and dest must have the same size universe
void bitset_intersect(struct bitset * dest, struct bitset * src1, struct bitset * src2)
{
	int i = dest->size_in_bits / MEMORYSIZE;

	while (i > 0)
	{
		dest->keys[i] = src1->keys[i] & src2->keys[i];
		i--;
	}
}

