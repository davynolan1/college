
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <time.h>
#include <unistd.h>
#include "cond.c"

int pnum;  // number updated when producer runs.
int csum;  // sum computed using pnum when consumer runs.

#define OVERFLOW_CEILING 10
#define NUMTHREADS 2
pthread_mutex_t dataMutex = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t dataPresentCondition = PTHREAD_COND_INITIALIZER;
pthread_cond_t dataConsumedCondition = PTHREAD_COND_INITIALIZER;

int (*pred)(int); // predicate indicating number to be consumed

int produceT() {
  printf("Producer locking dataMutex... \n");
  pthread_mutex_lock(&dataMutex);
  scanf("%d",&pnum);
  pthread_cond_signal(&dataConsumedCondition);
  if(pnum!=0)
    pthread_cond_wait(&dataPresentCondition, &dataMutex);
  printf("Producer unlocking dataMutex... \n");
  pthread_mutex_unlock(&dataMutex);
  return pnum;
}

void *Produce(void *a) {
  int p;

  p=1;
  while (p) {
    
    printf("producer thinking...\n");
    sleep(1);
    printf("..done!\n");
    p = produceT();
    printf("PRODUCED %d\n",p);
  }
  printf("EXIT-P\n");
  //pthread_cond_signal(&dataPresentCondition);
}


int consumeT() {
  printf("Consumer locking dataMutex... \n");
  pthread_mutex_lock(&dataMutex);
  pthread_cond_signal(&dataPresentCondition);
  pthread_cond_wait(&dataConsumedCondition, &dataMutex);

  printf("pnum = %d, csum = %d \n",pnum,csum);
  printf("%d \n", pred(pnum));
  if ( pred(pnum) == 1) { csum += pnum; }
  //printf("pred %d = %d \n",pnum,pred(pnum));
  //printf("%d + %d = %d \n", csum, pnum, (pnum+csum));
  //printf("Consumer unlocking dataMutex... \n");
  pthread_mutex_unlock(&dataMutex);
  return pnum;
}

void *Consume(void *a) {
  int p;

  p=1;
  while (p) {
    printf("consumer thinking...\n");
    //pthread_cond_wait(&dataPresentCondtion, &dataMutex);
    sleep(rand()%3);
    printf("..done!\n");
    p = consumeT();
    printf("CONSUMED %d\n",csum);
  }
  printf("EXIT-C\n");
}


int main (int argc, const char * argv[]) {
  
  // the current number predicate
  static pthread_t prod,cons;
	long rc;

  pred = &cond1;
  if (argc>1) {
    if      (!strncmp(argv[1],"2",10)) { pred = &cond2; }
    else if (!strncmp(argv[1],"3",10)) { pred = &cond3; }
  }


  pnum = 999;
  csum=0;
  srand(time(0));

  printf("Creating Producer:\n");
 	rc = pthread_create(&prod,NULL,Produce,(void *)0);
	if (rc) {
			printf("ERROR return code from pthread_create(prod): %ld\n",rc);
			exit(-1);
		}
  sleep(1);
  printf("Creating Consumer:\n");
 	rc = pthread_create(&cons,NULL,Consume,(void *)0);
	if (rc) {
			printf("ERROR return code from pthread_create(cons): %ld\n",rc);
			exit(-1);
		}

	pthread_join( prod, NULL);
	pthread_join( cons, NULL);


  printf("csum=%d.\n",csum);

  return 0;
}
