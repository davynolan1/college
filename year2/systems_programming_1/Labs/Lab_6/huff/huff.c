// code for a huffman coder


#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <ctype.h>

#include "huff.h"


// create a new huffcoder structure
struct huffcoder *  huffcoder_new()
{
    huffcoder * new_huffcoder = (huffcoder *)malloc(sizeof(huffcoder));
    return new_huffcoder;
}

// count the frequency of characters in a file; set chars with zero
// frequency to one
void huffcoder_count(struct huffcoder * this, char * filename)
{
    //counts freq of chars in file
    int count[NUM_CHARS] = {0};
    int k;
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
            count[zeroCount] = 1;
        zeroCount++;
    }

    this->freqs = count;
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
    }
}

// using the character frequencies build the tree of compound
// and simple characters that are used to compute the Huffman codes
void huffcoder_build_tree(struct huffcoder * this)
{

}


// recursive function to convert the Huffman tree into a table of
// Huffman codes
void tree2table_recursive(struct huffcoder * this, struct huffchar * node,
		 int * path, int depth)
{

}

// using the Huffman tree, build a table of the Huffman codes
// with the huffcoder object
void huffcoder_tree2table(struct huffcoder * this)
{

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
