#include <stdio.h>
#include <stdlib.h>


int isPrime(int candidate){
    int i;
    for(i = 2; i <= candidate/2; ++i)
    {
        // condition for nonprime number
        if(candidate%i == 0)
        {
            return 0;
        }
    }
    return 1;
}

int checkprime(int candidate){
   
    if (candidate == 1) 
    {
      printf("1 is neither a prime nor a composite number.\n");
    }
    else 
    {
        if (isPrime(candidate) == 1)
          printf("%d is a prime number.\n", candidate);
        else{
          int i;
          while(!isPrime(candidate)){
              printf("%d is not a prime number.\n", candidate);
              candidate++;
          }
          printf("%d is a prime number.\n", candidate);

        }
    }
    
    return candidate;
}

int main(int argc, char **argv){
    if(argc > 2){
        printf("Too many arguments supplied.\n");
        exit(1);
    }
    else if(argc ==2){
        printf("The argument supplied is: %s\n", argv[1]);
        int input = atoi(argv[1]);
        input = checkprime(input);

    }
}


