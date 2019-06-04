#include <stdlib.h>
#include <stdio.h>
#include "bloom.h"
#include <malloc.h>


const int BLOOM_HASH1 = 17;
const int BLOOM_HASH2 = 29;

// compute a hash of a string using a seed value, where the result
// falls between zero and range-1
int hash_string(char * string, int seed, int range)
{
	int i;
	int hash = 0;

	// simple loop for mixing the input string
	for (i = 0; string[i] != '\0'; i++) {
		hash = hash * seed + string[i];
	}
	// check for unlikely case that hash is negative
	if (hash < 0) {
		hash = -hash;
	}
	// bring the hash within the range 0..range-1
	hash = hash % range;

	return hash;
}

// create a new, empty Bloom filter with 'size' slots
struct bloom * bloom_new(int size)
{
	bloom *new_bloom = (bloom *) malloc(sizeof(bloom));
	new_bloom->size = size;
	//new_bloom->bit_vector->data = calloc(size / MEMORYSIZE + 1, sizeof(unsigned) * size / MEMORYSIZE);
	new_bloom->bit_vector = bitset_new(size);
	return new_bloom;
}
//new_bloom->bit_vector->data = calloc(size / MEMORYSIZE + 1, sizeof(unsigned) * size / MEMORYSIZE);

// check to see if a string is in the set
int bloom_lookup(struct bloom * this, char * item)
{
	int hash1 = hash_string(item, BLOOM_HASH1, this->size);
	int hash2 = hash_string(item, BLOOM_HASH2, this->size);

	int i = hash1 / MEMORYSIZE;
	int j = hash2 / MEMORYSIZE;

	int iPos = hash1 % MEMORYSIZE;
	int jPos = hash2 % MEMORYSIZE;

	unsigned int flag = 1;
	unsigned int iFlag = flag << iPos;
	unsigned int jFlag = flag << jPos;

	int count = 0;

	if (this->bit_vector->data[i] & iFlag)
		count++;
	if (this->bit_vector->data[j] & jFlag)
		count++;

	return (count == 2);
}

// add a string to the set has no effect if the item is already in the
// set; note that you cannot safely remove items from a Bloom filter
void bloom_add(struct bloom * this, char * item)
{
	int hash1 = hash_string(item, BLOOM_HASH1, this->size);
	int hash2 = hash_string(item, BLOOM_HASH2, this->size);

	int i = hash1 / MEMORYSIZE;
	int j = hash2 / MEMORYSIZE;
	int iPos = hash1 % MEMORYSIZE;
	int jPos = hash2 % MEMORYSIZE;

	unsigned int flag = 1;
	unsigned int iFlag = flag << iPos;
	unsigned int jFlag = flag << jPos;

	this->bit_vector->data[i] = this->bit_vector->data[i] | iFlag;
	this->bit_vector->data[j] = this->bit_vector->data[j] | jFlag;
}

// place the union of src1 and src2 into dest
void bloom_union(struct bloom * dest, struct bloom * src1, struct bloom * src2)
{
	int i = dest->size / MEMORYSIZE;

	while (i > 0)
	{
		dest->bit_vector->data[i] = src1->bit_vector->data[i] | src2->bit_vector->data[i];
		i--;
	}
}

// place the intersection of src1 and src2 into dest
void bloom_intersect(struct bloom * dest, struct bloom * src1,
	struct bloom * src2)
{
	int i = dest->size / MEMORYSIZE;

	while (i > 0)
	{
		dest->bit_vector->data[i] = src1->bit_vector->data[i] & src2->bit_vector->data[i];
		i--;
	}
}

// print out the bits that are 1 in the bit vector of
// a bloom filter
void bloom_print(struct bloom * this)
{
	bitset_print(this->bit_vector);	
}
