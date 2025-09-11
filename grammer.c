#include <stdio.h>
#include <string.h>

int checkGrammar(char str[])
{
  int i = 0, n = strlen(str);

  while (str[i] == 'a')
  {
    i++;
  }

  if (str[i] != 'c')
    return 0;
  i++;

  while (str[i] == 'b')
  {
    i++;
  }

  if (str[i] != 'd')
    return 0;
  i++;

  if (i == n)
    return 1;
  return 0;
}

int main()
{
  char input[100];

  printf("Enter input string: ");
  scanf("%s", input);

  if (checkGrammar(input))
    printf("String is Accepted\n");
  else
    printf("String is Rejected\n");

  return 0;
}
