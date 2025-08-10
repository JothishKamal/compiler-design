#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main(void)
{
  char input[100], left[10], right[50], *token, alpha[10][20], beta[10][20];
  int i, ac = 0, bc = 0;

  printf("Enter production (e.g. E->E+T/T): ");
  scanf("%s", input);

  char *arrow = strstr(input, "->");
  if (!arrow)
  {
    printf("Invalid production\n");
    return 1;
  }

  strncpy(left, input, arrow - input);
  left[arrow - input] = '\0';

  strcpy(right, arrow + 2);

  token = strtok(right, "/");
  while (token)
  {
    if (token[0] == left[0])

      strcpy(alpha[ac++], token + 1);
    else
      strcpy(beta[bc++], token);
    token = strtok(NULL, "/");
  }

  if (ac == 0)
  {
    printf("No Left Recursion\n");
    printf("%s -> %s\n", left, right);
    return 0;
  }

  printf("%s ->", left);
  for (int i = 0; i < bc; i++)
  {
    printf(" %s%s", beta[i], left);
    if (i < bc - 1)
      printf(" |");
  }
  printf("\n");

  printf("%s' ->", left);
  for (int i = 0; i < ac; i++)
  {
    printf(" %s%s", alpha[i], left);
    if (i < ac - 1)
      printf(" |");
  }
  printf(" | e\n");

  return 0;
}