//
// CSU33014 Summer 2020 Additional Assignment
// Part A of a two-part assignment
//

// Please examine version each of the following routines with names
// starting partA. Where the routine can be vectorized, please
// complete the corresponding vectorized routine using SSE vector
// intrinsics. Where is cannot be vectorized...

// Note the restrict qualifier in C indicates that "only the pointer
// itself or a value directly derived from it (such as pointer + 1)
// will be used to access the object to which it points".

#include <immintrin.h>
#include <stdio.h>

#include "csu33014-annual-partA-code.h"

/****************  routine 0 *******************/

// Here is an example routine that should be vectorized
void partA_routine0(float *restrict a, float *restrict b,
                    float *restrict c)
{
  for (int i = 0; i < 1024; i++)
  {
    a[i] = b[i] * c[i];
  }
}

// here is a vectorized solution for the example above
void partA_vectorized0(float *restrict a, float *restrict b,
                       float *restrict c)
{
  __m128 a4, b4, c4;

  for (int i = 0; i < 1024; i = i + 4)
  {
    b4 = _mm_loadu_ps(&b[i]);
    c4 = _mm_loadu_ps(&c[i]);
    a4 = _mm_mul_ps(b4, c4);
    _mm_storeu_ps(&a[i], a4);
  }
}

/***************** routine 1 *********************/

// in the following, size can have any positive value
float partA_routine1(float *restrict a, float *restrict b,
                     int size)
{
  float sum = 0.0;

  for (int i = 0; i < size; i++)
  {
    sum = sum + a[i] * b[i];
  }
  return sum;
}

// insert vectorized code for routine1 here
float partA_vectorized1(float *restrict a, float *restrict b,
                        int size)
{
  __m128 a4, b4;
  __m128 tmp;
  float sum = 0.0;
  float *mul_array = (float *)malloc(size * sizeof(float));
  int size4 = size - (size % 4); //Size4 is the highest multiple of 4 that is within size

  for (int i = 0; i < size4; i = i + 4)
  {
    a4 = _mm_loadu_ps(&a[i]);          //Loads 4 float values from address at a[i] into __m128 a4
    b4 = _mm_loadu_ps(&b[i]);          //Loads 4 float values from address at b[i] into __m128 b4
    tmp = _mm_mul_ps(a4, b4);          //Multiplies each of the 4 floats in a4 by its corresponding float in b4 and loads the answers into __m128 tmp
    _mm_storeu_ps(&mul_array[i], tmp); //Stores the 4 values (answers to the multiplications) into the address at mul_array[i]

    for (int j = 0; j < 4; j++) //Loop for accessing each value in vector to add it to sum
    {
      sum = sum + mul_array[i + j];
    }
  }

  for (int k = size4; k < size; k++) //Multiplying the rest of the float values outside of size4 but within size
  {
    sum = sum + a[k] * b[k];
  }
  return sum;
}

/******************* routine 2 ***********************/

// in the following, size can have any positive value
void partA_routine2(float *restrict a, float *restrict b, int size)
{
  for (int i = 0; i < size; i++)
  {
    a[i] = 1 - (1.0 / (b[i] + 1.0));
  }
}

// in the following, size can have any positive value
void partA_vectorized2(float *restrict a, float *restrict b, int size)
{
  __m128 a4, b4, b_add_1, b_div_1;
  __m128 vect_1 = _mm_set1_ps(1.0); //Creates vector with all values set to 1.0
  int size4 = size - (size % 4);    //Size4 is the highest multiple of 4 that is within size

  for (int i = 0; i < size4; i = i + 4)
  {
    b4 = _mm_loadu_ps(&b[i]);              //Loads 4 float values from address at b[i] into __m128 b4
    b_add_1 = _mm_add_ps(b4, vect_1);      //b_add_1 = (b[i] + 1.0)
    b_div_1 = _mm_div_ps(vect_1, b_add_1); //b_div_1 = (1.0 / (b[i] + 1.0))
    a4 = _mm_sub_ps(vect_1, b_div_1);      //a4 = 1 - (1.0 / (b[i] + 1.0))
    _mm_storeu_ps(&a[i], a4);              //Stores the 4 values (answers to the equation) into the address at a[i]
  }

  //Equating the rest of the float values outside of size4 but within size
  for (int k = size4; k < size; k++)
  {
    a[k] = 1 - (1.0 / (b[k] + 1.0));
  }
}

/******************** routine 3 ************************/

// in the following, size can have any positive value
void partA_routine3(float *restrict a, float *restrict b, int size)
{
  for (int i = 0; i < size; i++)
  {
    if (a[i] < 0.0)
    {
      a[i] = b[i];
    }
  }
}

// in the following, size can have any positive value
void partA_vectorized3(float *restrict a, float *restrict b, int size)
{
  __m128 a4, b4, mask, c4;
  __m128 vect_0 = _mm_set1_ps(0.0); //Creates vector with all values set to 0.0
  int size4 = size - (size % 4);    //Size4 is the highest multiple of 4 that is within size

  for (int i = 0; i < size4; i = i + 4)
  {
    a4 = _mm_loadu_ps(&a[i]);         //Loads 4 float values from address at a[i] into __m128 a4
    b4 = _mm_loadu_ps(&b[i]);         //Loads 4 float values from address at b[i] into __m128 b4
    mask = _mm_cmplt_ps(a4, vect_0);  //Checks if 4 float values in a4 are less than 0 and creates mask
    a4 = _mm_blendv_ps(a4, b4, mask); //Blends the float values from a4 and b4 using mask and stores the result in a4
    _mm_storeu_ps(&a[i], a4);         //Stores the 4 values (answers to the equation) into the address at a[i]
  }

  //Equating the rest of the float values outside of size4 but within size
  for (int k = size4; k < size; k++)
  {
    if (a[k] < 0.0)
    {
      a[k] = b[k];
    }
  }
}

/********************* routine 4 ***********************/

// hint: one way to vectorize the following code might use
// vector shuffle operations
void partA_routine4(float *restrict a, float *restrict b,
                    float *restrict c)
{
  for (int i = 0; i < 2048; i = i + 2)
  {
    a[i] = b[i] * c[i] - b[i + 1] * c[i + 1];
    a[i + 1] = b[i] * c[i + 1] + b[i + 1] * c[i];
  }
}

void partA_vectorized4(float *restrict a, float *restrict b,
                       float *restrict c)
{
  // replace the following code with vectorized code
  __m128 a4, b4, c4, b4_plus_1, c4_plus_1, b4_hi, c4_hi, bi_times_ci, bi1_times_ci1, ai, ai_plus_1, bi_times_ci1, bi1_times_ci;
  float *sub_array = (float *)malloc(2048 * sizeof(float));
  float *add_array = (float *)malloc(2048 * sizeof(float));

  for (int i = 0; i < 2048; i = i + 4)
  {
    a4 = _mm_loadu_ps(&a[i]); //Loads 4 float values from address at a[i] into __m128 a4
    b4 = _mm_loadu_ps(&b[i]); //Loads 4 float values from address at b[i] into __m128 b4
    c4 = _mm_loadu_ps(&c[i]); //Loads 4 float values from address at c[i] into __m128 c4

    int k = i + 4;
    b4_plus_1 = _mm_loadu_ps(&b[i + 1]);
    c4_plus_1 = _mm_loadu_ps(&c[i + 1]);

    bi_times_ci = _mm_mul_ps(b4, c4);
    bi1_times_ci1 = _mm_mul_ps(b4_plus_1, c4_plus_1);
    ai = _mm_sub_ps(bi_times_ci, bi1_times_ci1);
    _mm_storeu_ps(&sub_array[i], ai); //Stores the 4 values (answers to the equation) into the address at sub_array[i]

    bi_times_ci1 = _mm_mul_ps(b4, c4_plus_1);
    bi1_times_ci = _mm_mul_ps(b4_plus_1, c4);
    ai_plus_1 = _mm_add_ps(bi_times_ci1, bi1_times_ci);
    _mm_storeu_ps(&add_array[i], ai_plus_1); //Stores the 4 values (answers to the equation) into the address at add_array[i]

    a4 = _mm_shuffle_ps(ai, ai_plus_1, _MM_SHUFFLE(2, 0, 2, 0));
    a4 = _mm_shuffle_ps(a4, a4, _MM_SHUFFLE(3, 1, 2, 0));
    _mm_storeu_ps(&a[i], a4);
  }
}

/********************* routine 5 ***********************/

// in the following, size can have any positive value
void partA_routine5(unsigned char *restrict a,
                    unsigned char *restrict b, int size)
{
  for (int i = 0; i < size; i++)
  {
    a[i] = b[i];
  }
}

void partA_vectorized5(unsigned char *restrict a,
                       unsigned char *restrict b, int size)
{
  __m128i a4, b4;
  int size4 = size - (size % 4); //Size4 is the highest multiple of 4 that is within size

  for (int i = 0; i < size4; i = i + 4)
  {
    b4 = _mm_loadu_si32(&b[i]); //Loads 4 int(char) values from address at b[i] into __m128i b4
    _mm_storeu_si32(&a[i], b4); //Stores 4 int(char) values from b4 at address at a[i]
  }
  // Performing function for values outside of size4 but inside size
  for (int k = size4; k < size; k++)
  {
    a[k] = b[k];
  }
}

/********************* routine 6 ***********************/

void partA_routine6(float *restrict a, float *restrict b,
                    float *restrict c)
{
  a[0] = 0.0;
  for (int i = 1; i < 1023; i++)
  {
    float sum = 0.0;
    for (int j = 0; j < 3; j++)
    {
      sum = sum + b[i + j - 1] * c[j];
    }
    a[i] = sum;
  }

  a[1023] = 0.0;
}

void partA_vectorized6(float *restrict a, float *restrict b,
                       float *restrict c)
{
  __m128 a4, b4, mul;
  __m128 c4 = _mm_set_ps(0.0f, c[2], c[1], c[0]); // Creates float vector with value {c[0], c[1], c[2], 0}
  float mul_array[4];

  a[0] = 0.0;

  for (int i = 0; i < 1023; i = i + 1)
  {
    b4 = _mm_loadu_ps(&b[i]);          //Loads 4 float values from address at b[i] into __m128 b4
    mul = _mm_mul_ps(b4, c4);          //Multiplies each of the 4 floats in b4 by its corresponding float in c4 and loads the answers into __m128 mul
    mul = _mm_hadd_ps(mul, mul);       //Horizontally adds values in mul i.e. mul=(A,B,C,D)  -> hadd(mul,mul) -> mul = (A+B,C+D,A+B,C+D)
    mul = _mm_hadd_ps(mul, mul);       //Horizontaly adds values in mul again i.e. mul=(A+B,C+D,A+B,C+D)  -> hadd(mul,mul) -> mul = (A+B+C+D,A+B+C+D,A+B+C+D,A+B+C+D)
    _mm_storeu_ps(&mul_array[0], mul); //Stores result of adding the mul values together at address mul_array[0]
    a[i + 1] = mul_array[0];           //Loads result of adding the mul values together into a[i+1]
  }

  a[1023] = 0;
}