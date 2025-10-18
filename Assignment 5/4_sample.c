#include <stdio.h>

int main()
{
  int a, b, sum;
  float x = 10.5;

  a = 5;
  b = 10;
  sum = a + b;

  if (sum > 10)
  {
    printf("Sum is greater than 10\n");
  }
  else
  {
    printf("Sum is less than or equal to 10\n");
  }

  for (int i = 0; i < 5; i++)
  {
    x += 2.5;
  }

  while (a < 20)
  {
    a++;
  }

  int result = (a > b) ? a : b;

  return 0;
}