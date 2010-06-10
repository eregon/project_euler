#include <stdio.h>

long long next_n(long long n) {
  return (n%2==0) ? n/2 : 3*n+1;
}

int main (int argc, char const *argv[])
{
  long best_n;
  long best_i = 0;
  long MAX = 1000000;
  long i, n, my_n;
  for(n = 1; n <= MAX; ++n)
  {
    i = 1;
    my_n = n;
    while(my_n != 1) {
      my_n = (my_n%2==0) ? my_n/2 : 3*my_n+1;//next_n(my_n);
      i++;
    }
    if(i > best_i)
    {
      best_i = i;
      best_n = n;
    }
  }
  printf("%d", (int) best_n); // 1.43s -> 1.27s
  
  return 0;
}