class MyClass
{
  public static void main(String[] args) {
    long best_n = 0;
    long best_i = 0;
    long max = 1000000;
    long i, n, my_n;
    for(n = 1; n <= max; n++)
    {
      i = 1;
      my_n = n;
      while(my_n != 1) {
        my_n = (my_n%2==0) ? my_n/2 : 3*my_n+1;
        i++;
      }
      if(i > best_i)
      {
        best_i = i;
        best_n = n;
      }
    }
    System.out.println(best_n); //1.2s
  }
}