#include <stdio.h>
#include <string.h>

#define MAX 100

int reduce(char stack[][MAX], int *top)
{

  if (*top >= 1 && strcmp(stack[*top], "id") == 0)
  {
    strcpy(stack[*top], "S");
    printf("Reduce S -> id\n");
    return 1;
  }

  if (*top >= 2 && strcmp(stack[*top - 2], "S") == 0 &&
      strcmp(stack[*top - 1], "+") == 0 &&
      strcmp(stack[*top], "S") == 0)
  {
    strcpy(stack[*top - 2], "S");
    *top -= 2;
    printf("Reduce S -> S+S\n");
    return 1;
  }

  if (*top >= 2 && strcmp(stack[*top - 2], "S") == 0 &&
      strcmp(stack[*top - 1], "*") == 0 &&
      strcmp(stack[*top], "S") == 0)
  {
    strcpy(stack[*top - 2], "S");
    *top -= 2;
    printf("Reduce S -> S*S\n");
    return 1;
  }

  return 0;
}

void join_tokens(char arr[][MAX], int start, int end, char *out)
{
  out[0] = '\0';
  for (int i = start; i <= end; i++)
  {
    strcat(out, arr[i]);
  }
}

int main()
{
  char input[MAX] = "id + id + id $";
  char tokens[MAX][MAX];
  char stack[MAX][MAX];

  int n = 0;

  char *tok = strtok(input, " ");
  while (tok != NULL)
  {
    strcpy(tokens[n++], tok);
    tok = strtok(NULL, " ");
  }

  int top = 0;
  strcpy(stack[0], "$");

  int i = 0;

  printf("%-20s %-20s %-20s\n", "Stack", "Input Buffer", "Action");

  while (1)
  {
    char stack_str[200], input_str[200];

    join_tokens(stack, 0, top, stack_str);
    join_tokens(tokens, i, n - 1, input_str);

    printf("%-20s %-20s ", stack_str, input_str);

    if (top == 1 && strcmp(stack[0], "$") == 0 &&
        strcmp(stack[1], "S") == 0 &&
        strcmp(tokens[i], "$") == 0)
    {
      printf("Accept\n");
      break;
    }

    if (reduce(stack, &top))
    {
      continue;
    }

    strcpy(stack[++top], tokens[i]);
    printf("Shift\n");
    i++;
  }

  return 0;
}
