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
	//new_huffcoder->freqs;
	//new_huffcoder->codes;
	//new_huffcoder->code_lengths;
	//new_huffcoder->tree;
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

void quickSortSimple(int *a, int size)
{
  int pivot, i, j, temp;

  if ( size <= 1 ) {
    return;
  }

  pivot = a[0];
  /* partition the array */
  i = 0;
  j = size;
  while (i < j ) {
    if ( a[i] < pivot ) {
      i++;
    }
    else {
      temp = a[i];
      j--;
      a[i] = a[j];
      a[j] = temp;
    }
  }
  a[size-1] = a[j];
  a[j] = pivot;

  quickSortSimple(a, i);
  quickSortSimple(a+i+1, size-i-1);
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
	//bubbleSort(char_list, 256);
	quickSortSimple(char_list, 256);
	int comSeqNo = 256;
	for (i = 0; i < NUM_CHARS; i++)
	{
		//bubbleSort(char_list, 256);
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
		 int * path, int depth)
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
