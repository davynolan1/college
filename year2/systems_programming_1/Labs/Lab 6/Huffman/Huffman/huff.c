// code for a huffman coder

#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <ctype.h>

#include "huff.h"


// create a new huffcoder structure
struct huffcoder *  huffcoder_new()
{
    huffcoder * new_huffcoder = (huffcoder *)malloc(sizeof(huffcoder));
	new_huffcoder->freqs;
	new_huffcoder->codes;
	new_huffcoder->code_lengths;
	new_huffcoder->tree;
    return new_huffcoder;
}

// count the frequency of characters in a file; set chars with zero
// frequency to one
void huffcoder_count(struct huffcoder * this, char * filename)
{
    //counts freq of chars in file
    int count[NUM_CHARS] = {0};
    FILE *fp = fopen(filename, "r");
    int c;

    while((c = fgetc(fp)))
    {
        if(c == EOF)
            break;
        count[c] ++;
    }

    //sets chars with zero freq to one
    int zeroCount = 0;
    while(zeroCount <= 256)
    {
		if (count[zeroCount] == 0)
		{
			count[zeroCount] = 1;
		}
		this->freqs[zeroCount] = count[zeroCount]; //moving freqs from count into actual spot for freqs
        zeroCount++;
    }

    fclose(fp);
}

int findSmaller(struct huffcoder * this, int differentFrom)
{
    int smaller;
    int i = 0;

    while(this->freqs[i] == -1)
        i++;

    smaller = i;
    if(i == differentFrom)
    {
        i++;
        while(this->freqs[i] == -1)
            i++;
		smaller = i;
    }
	
	for (i = 0; i <= NUM_CHARS; i++)
	{
		if (this->freqs[i] == -1)
			continue;
		if (i == differentFrom)
			continue;
		if (this->freqs[i] < this->freqs[smaller])
			smaller = i;
	}

	return smaller;
}

struct huffchar * huffsort(struct huffcoder * this) {
	struct huffhcar * huffList[NUM_CHARS] = malloc(sizeof(struct huffchar) * NUM_CHARS);
	int i;
	for (i = 32; i < 127; i++) {
		struct huffchar * newchar = malloc(sizeof(struct huffchar));
		newchar->u.c = i;
		newchar->freq = this->freqs[i - 32];
		newchar->is_compound = 0;
		huffList[i] = newchar;
	}

	for (i = 32; i < 127; i++) {
		int j;
		for (j = 32; j < 127; j++) {
			if (this->freqs[j - 32] > this->freqs[i - 32]) {
				int tmp = this->freqs[i - 32];
				this->freqs[i - 32] = this->freqs[j - 32];
				this->freqs[i - 32] = tmp;
				struct huffchar * temp = huffList[i - 32];

				huffList[i - 32] = huffList[j - 32];
				huffList[j - 32] = temp;
			}
		}
	}
	return huffList;
}



void swap(struct huffchar *xp, struct huffchar *yp)
{
	struct huffchar temp = *xp;
	*xp = *yp;
	*yp = temp;
}
void bubbleSort(struct huffchar **arr, int n)
{
	int i, j;
	for (i = 0; i < n - 1; i++)
	{
		for (j = 0; j < n - i - 1; j++)
		{
			if(arr[j]->freq > arr[j+1]->freq)
				swap(&arr[j], &arr[j + 1]);
		}
	}
}

huffchar * make_compound(struct huffchar * smallest, struct huffchar * smallest2)
{
	huffchar * compound = malloc(sizeof(huffchar));
	compound->is_compound = 1;
	compound->u.compound.left = smallest;
	compound->u.compound.right = smallest2;
	compound->freq = smallest->freq + smallest2->freq;
	return compound;
}

// using the character frequencies build the tree of compound
// and simple characters that are used to compute the Huffman codes
void huffcoder_build_tree(struct huffcoder * this)
{
	huffchar * char_list[NUM_CHARS];
	int i;
	for (i = 0; i < NUM_CHARS; i++)
	{
		char_list[i] = malloc(sizeof(huffchar));
		char_list[i]->freq = this->freqs[i];
		char_list[i]->is_compound = 0;
		char_list[i]->u.c = i;
		char_list[i]->seqno = i;
	}
	char_list = huffsort(this);
	int comSeqNo = 256;
	for (i = 0; i < NUM_CHARS; i++)
	{
		//bubbleSort(char_list, 256);
		//quickSortSimple(char_list, 256);
		
		huffchar * smallest = char_list[0];
		huffchar * smallest2 = char_list[1];
		huffchar * compound;
		compound = make_compound(smallest, smallest2);
		compound->seqno = comSeqNo;
		comSeqNo++;
		char_list[0] = compound;
		char_list[1] = NULL;
	}
	this->tree = char_list;
}


// recursive function to convert the Huffman tree into a table of
// Huffman codes
void tree2table_recursive(struct huffcoder * this, struct huffchar * node,
		 int path, int depth)
{
	if (node->is_compound == 1) {
		path = path << 1;
		tree2table_recursive(this, node->u.compound.left, path, depth + 1);
		path = path | 1;
		tree2table_recursive(this, node->u.compound.right, path, depth + 1);

	}
	else {
		unsigned char index = node->u.c;
		this->codes[index] = path;
		this->code_lengths[index] = depth;
	}
}



// using the Huffman tree, build a table of the Huffman codes
// with the huffcoder object
void huffcoder_tree2table(struct huffcoder * this)
{
	unsigned int path = 0;
	int depth = 0;
	if (this->tree != NULL) {
		tree2table_recursive(this, this->tree, path, depth);
	}
	
	/*
	if (!this->tree) {
		return;
	}
	if (!this->tree->u.compound.left && !this->tree->u.compound.right) {
		int depth = getLevel(this->tree->u.compound,)
	}

	if (this->tree->u.compound.left) {
		huffcoder_tree2table(this->tree->u.compound.left);
	}
	if (this->tree->u.compound.right) {
		huffcoder_tree2table(this->tree->u.compound.right);
	}
	*/
}


// print the Huffman codes for each character in order
void huffcoder_print_codes(struct huffcoder * this)
{
  int i, j;
  char buffer[NUM_CHARS];

  for ( i = 0; i < NUM_CHARS; i++ ) {
    // put the code into a string
    for ( j = this->code_lengths[i]-1; j >= 0; j--) {
      buffer[j] = (this->codes[i] >> j) & 1 + '0';
    }
    // don't forget to add a zero to end of string
    buffer[this->code_lengths[i]] = '\0';

    // print the code
    printf("char: %d, freq: %d, code: %s\n", i, this->freqs[i], buffer);;
  }
}
