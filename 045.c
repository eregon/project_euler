#define TRIANGLE(n) (n*n + n)/2
#define PENTAGONAL(n) (3*n*n-n)/2
#define HEXAGONAL(n) 2*n*n - n

#include <stdio.h>
#include <math.h>

int main (int argc, char const *argv[])
{
  long triangle_i = 0;
  long pentagonal_i = 0;
  long hexagonal_i = 0;
  long triangle = TRIANGLE(++triangle_i);
  long pentagonal = PENTAGONAL(++pentagonal_i);
  long hexagonal = HEXAGONAL(++hexagonal_i);

  long n;
  const long max = pow(10, 10);
  for(n = 40755+1; n < max; ++n)
  {
    while(triangle < n) {
      triangle_i++;
      triangle = TRIANGLE(triangle_i);
    }
    while(pentagonal < n) {
      pentagonal_i++;
      pentagonal = PENTAGONAL(pentagonal_i);
    }
    while(hexagonal < n) {
      hexagonal_i++;
      hexagonal = HEXAGONAL(hexagonal_i);
    }
    if(n == triangle && n == pentagonal && n == hexagonal)
    {
      break;
    }
  }
  printf("%ld\n", n); // 1533776805, 8.23s

  return 0;
}
