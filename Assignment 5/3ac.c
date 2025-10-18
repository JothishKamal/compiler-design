#include <stdio.h>

int main()
{
  printf("Quadruples\n\n");
  printf("     op\t arg1\t arg2\t result\n");
  printf("0\t+\t b\t c\t t1\n");
  printf("1\tU-\t t1\t\t t2\n");
  printf("2\t+\t a\t t2\t t3\n\n");

  printf("Triples\n\n");
  printf("   op\t arg1\t arg2\n");
  printf("0\t+\t b\t c\n");
  printf("1\tU-\t (0)\n");
  printf("2\t+\t a\t (1)\n\n");

  printf("Indirect Triples\n\n");
  printf("   op\t arg1\t arg2\n");
  printf("100\t+\t b\t c\n");
  printf("101\tU-\t (100)\n");
  printf("102\t+\t a\t (101)\n");

  return 0;
}
