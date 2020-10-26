#include <immintrin.h>
#include <stdio.h>
#include <stdlib.h>

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

void partA_vectorized3(float *restrict a, float *restrict b, int size)
{
  // replace the following code with vectorized code
  __m128 a4, b4, mask, c4;
  __m128 vect_0 = _mm_set1_ps(0.0); //Creates vector with all values set to 0.0
  int size4 = size - (size % 4);    //Size4 is the highest multiple of 4 that is within size
  //printf("\nsize = %d", size);
  //printf("\nsize4 = %d", size4);
  for (int i = 0; i < size4; i = i + 4)
  {
    a4 = _mm_loadu_ps(&a[i]); //Loads 4 float values from address at a[i] into __m128 a4
    b4 = _mm_loadu_ps(&b[i]); //Loads 4 float values from address at b[i] into __m128 b4
    mask = _mm_cmplt_ps(a4, vect_0);
    a4 = _mm_blendv_ps(a4,b4,mask);
    //a4 = _mm_and_ps(mask, a4);
    //c4 = _mm_xor_ps(a4, b4);
    //a4 = _mm_add_ps(a4, c4);
    _mm_storeu_ps(&a[i], a4); //Stores the 4 values (answers to the equation) into the address at a[i]
  }

  for (int k = size4; k < size; k++) //Equating the rest of the float values outside of size4 but within size
  {
    if (a[k] < 0.0)
    {
      a[k] = b[k];
    }
  }
}

int func4()
{
  __m128 a = _mm_set_ps(0.0, 1.0, 2.0, 3.0);
  __m128 b = _mm_set_ps(4.0, 5.0, 6.0, 7.0);
  __m128 c;
  float *c_arr = (float *)malloc(4 * sizeof(float));

  c = _mm_shuffle_ps(a, b, _MM_SHUFFLE(1, 2, 3, 4));
  _mm_storeu_ps(&c_arr[0], c);

  printf("\nc: %f %f %f %f", c_arr[0], c_arr[1], c_arr[2], c_arr[3]);
  return 0;
}

void partA_routine4(float *restrict a, float *restrict b,
                    float *restrict c)
{
  for (int i = 0; i < 8; i = i + 2)
  {
    a[i] = b[i] * c[i] - b[i + 1] * c[i + 1];
    a[i + 1] = b[i] * c[i + 1] + b[i + 1] * c[i];
    printf("\n %f %f", a[i], a[i + 1]);
  }
}

void partA_vectorized4(float *restrict a, float *restrict b,
                       float *restrict c)
{
  // replace the following code with vectorized code
  __m128 a4, b4, c4, b4_plus_1, c4_plus_1, b4_hi, c4_hi, bi_times_ci, bi1_times_ci1, ai, ai_plus_1, bi_times_ci1, bi1_times_ci;
  float *sub_array = (float *)malloc(2048 * sizeof(float));
  float *add_array = (float *)malloc(2048 * sizeof(float));

  for (int i = 0; i < 8; i = i + 4)
  {
    a4 = _mm_loadu_ps(&a[i]); //Loads 4 float values from address at a[i] into __m128 a4
    b4 = _mm_loadu_ps(&b[i]); //Loads 4 float values from address at b[i] into __m128 b4
    c4 = _mm_loadu_ps(&c[i]); //Loads 4 float values from address at c[i] into __m128 c4

    int k = i + 4;
    b4_plus_1 = _mm_loadu_ps(&b[i + 1]);
    c4_plus_1 = _mm_loadu_ps(&c[i + 1]);
    //b4_plus_1 = _mm_shuffle_ps(b4, b4_hi, _MM_SHUFFLE(1,1,2,2));
    //c4_plus_1 = _mm_shuffle_ps(c4, c4_hi, _MM_SHUFFLE(1,2,3,4));

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

  for (int i = 0; i < 8; i++)
  {
    printf("\n %f", a[i]);
  }
}

void partA_vectorized5(unsigned char *restrict a,
                       unsigned char *restrict b, int size)
{
  // replace the following code with vectorized code
  __m128i a4, b4;
  int size4 = size - (size % 4); //Size4 is the highest multiple of 4 that is within size

  for (int i = 0; i < size4; i = i + 4)
  {
    b4 = _mm_loadu_si32(&b[i]); //Loads 4 float values from address at b[i] into __m128 b4
    _mm_storeu_si32(&a[i], b4);
  }

  for (int k = size4; k < size; k++)
  {
    a[k] = b[k];
  }
}
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
  // replace the following code with vectorized code
  __m128 a4, b4, c4, mul;

  int size = 1024;
  float *mul_array = (float *)malloc(1280 * sizeof(float));
  a[0] = 0.0;
  //float sum = 0.0;
  c4 = _mm_set_ps(0.0f, c[2], c[1], c[0]);
  int k = 0;
  for (int i = 0; i < size - 1; i = i + 1)
  {
    b4 = _mm_loadu_ps(&b[i]);
    mul = _mm_mul_ps(b4, c4);
    mul = _mm_hadd_ps(mul, mul);
    mul = _mm_hadd_ps(mul, mul);
    _mm_storeu_ps(&mul_array[0], mul);
    a[i + 1] = mul_array[0];
    //_mm_storeu_ps(&mul_array[i],mul);
    /*
    //b4 = _mm_loadu_ps(&b[i]);
    b4 = _mm_set_ps(0.0f,b[i+2],b[i+1],b[i]);
    //c4 = _mm_loadu_ps(&c[0]);
    c4 = _mm_set_ps(0.0f,c[2],c[1],c[0]);
    mul = _mm_mul_ps(b4,c4);

    mul = _mm_hadd_ps(mul,mul);
    mul = _mm_hadd_ps(mul,mul);
    _mm_storeu_ps(&sum[0],mul);

    a[i+1] = sum[0];
    */
  }
  /*
  float sum = 0.0;
  for (int j = 0; j < 3; j++)
  {
    sum = sum + b[1022 + j - 1] * c[j];
  }
  a[1022] = sum;
  */
  a[1023] = 0;
}

double diff_square(float *a, float *b, int size)
{
  double sum = 0.0;
  for (int i = 0; i < size; i++)
  {
    double diff = a[i] - b[i];
    //fprintf(stderr, "a[%d]: %f, b[%d]: %f\n", i, a[i], i, b[i]);
    sum = sum + diff * diff;
  }
  return sum;
}
float *new_random_float_array(int size, int is_signed)
{
  int range = 1024;
  float *out = malloc(sizeof(float) * size);

  for (int i = 0; i < size; i++)
  {
    out[i] = get_random(range, is_signed);
  }
  return out;
}

int get_random(int range, int is_signed)
{
  int num = random();
  int sign = random();

  num = num % range;
  // if signed, then 50% should be negative
  if (is_signed && (sign % 2 == 1))
  {
    num = -num;
  }
  return num;
}

void gen_test_arrays(float **out_correct, float **out_vectorized,
                     float **b, float **c, int size)
{
  *out_correct = malloc(sizeof(float) * size);
  *out_vectorized = malloc(sizeof(float) * size);
  *b = new_random_float_array(size, 1);
  *c = new_random_float_array(size, 1);
}

// create a copy of an existing array
float * clone_float_array(float * src, int size) {
  float * dest = malloc(sizeof(float)*size);
  for ( int i = 0; i < size; i++ ) {
    dest[i] = src[i];
  }
  return dest;
}

int main()
{
  //float *a = (float *)malloc(8 * sizeof(float));
  //float c[] = {0.0f,1.0f,2.0f,3.0f,4.0f,5.0f,6.0f,7.0f};
  //float a[10];
  //float a1[10];
  //float b[] = {0.0f,1.0f,2.0f,3.0f,4.0f,5.0f,6.0f,7.0f,8.0f,9.0f};

  int size = 8;
  //float * out_correct = new_random_float_array(size, 1);
  float out_correct[] = {485.0f,-213.0f,1.0f,939.0f,2.0f,3.0f,4.0f,5.0f,};
  float * out_vectorized = clone_float_array(out_correct, size);
    float * copy = clone_float_array(out_correct, size);
  float * b = new_random_float_array(size, 1);
  double diff;

  partA_routine3(out_correct, b, size);
  partA_vectorized3(out_vectorized, b, size);

  diff = diff_square(out_correct, out_vectorized, size);
  //char b[] = "my name is davy";
  //char a[16];
  //partA_vectorized5(a, b, 16);
  //partA_vectorized6(a, b, c);
  //partA_vectorized3(a,b,9);
  //partA_routine6(a1,b,c);
  //partA_vectorized6(a,b,c);
  //double diff = diff_square(a,a1,8);
  return 0;
}