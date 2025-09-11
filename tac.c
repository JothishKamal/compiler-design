#include <stdio.h>
#include <string.h>
#include <ctype.h>

int tempCount = 1;

void newTemp(char *res)
{
  sprintf(res, "t%d", tempCount++);
}

void unaryMinus(char *op, char *res)
{
  printf("%s = uminus %s\n", res, op);
}

void binaryOp(char *op1, char *op2, char op, char *res)
{
  printf("%s = %s %c %s\n", res, op1, op, op2);
}

int main()
{

  char input[] = "a = b * - c + b * - c";

  printf("Input: %s\n", input);
  printf("\nThree Address Code:\n");

  char t1[10], t2[10], t3[10], t4[10], t5[10];

  newTemp(t1);
  unaryMinus("c", t1);

  newTemp(t2);
  binaryOp("b", t1, '*', t2);

  newTemp(t3);
  unaryMinus("c", t3);

  newTemp(t4);
  binaryOp("b", t3, '*', t4);

  newTemp(t5);
  binaryOp(t2, t4, '+', t5);

  printf("a = %s\n", t5);

  return 0;
}
