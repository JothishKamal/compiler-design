#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <stdlib.h>

#define MAX 100

char opStack[MAX];
int top = -1;

void push(char c)
{
  opStack[++top] = c;
}

char pop()
{
  return opStack[top--];
}

int precedence(char op)
{
  if (op == '+' || op == '-')
    return 1;
  if (op == '*' || op == '/')
    return 2;
  return 0;
}

void infixToPostfix(char infix[], char postfix[])
{
  int i = 0, k = 0;
  while (infix[i] != '\0')
  {
    if (isdigit(infix[i]))
    {

      while (isdigit(infix[i]))
      {
        postfix[k++] = infix[i++];
      }
      postfix[k++] = ' ';
      continue;
    }
    else if (isalpha(infix[i]))
    {
      postfix[k++] = infix[i++];
      postfix[k++] = ' ';
      continue;
    }
    else if (infix[i] == '(')
    {
      push(infix[i]);
    }
    else if (infix[i] == ')')
    {
      while (top != -1 && opStack[top] != '(')
      {
        postfix[k++] = pop();
        postfix[k++] = ' ';
      }
      if (top != -1 && opStack[top] == '(')
        pop();
    }
    else
    {
      while (top != -1 && precedence(opStack[top]) >= precedence(infix[i]))
      {
        postfix[k++] = pop();
        postfix[k++] = ' ';
      }
      push(infix[i]);
    }
    i++;
  }
  while (top != -1)
  {
    postfix[k++] = pop();
    postfix[k++] = ' ';
  }
  postfix[k] = '\0';
}

int evaluatePostfix(char postfix[])
{
  int st[MAX], t = -1;
  char *token = strtok(postfix, " ");
  while (token != NULL)
  {
    if (isdigit(token[0]))
    {
      st[++t] = atoi(token);
    }
    else
    {
      int val2 = st[t--];
      int val1 = st[t--];
      switch (token[0])
      {
      case '+':
        st[++t] = val1 + val2;
        break;
      case '-':
        st[++t] = val1 - val2;
        break;
      case '*':
        st[++t] = val1 * val2;
        break;
      case '/':
        st[++t] = val1 / val2;
        break;
      }
    }
    token = strtok(NULL, " ");
  }
  return st[t];
}

int main()
{
  char infix[MAX], postfix[MAX];

  printf("Enter infix expression: ");
  scanf("%[^\n]", infix);

  infixToPostfix(infix, postfix);

  printf("Postfix: %s\n", postfix);

  int isNumeric = 1;
  for (int i = 0; i < strlen(infix); i++)
  {
    if (!isdigit(infix[i]) && strchr("+-*/() ", infix[i]) == NULL)
    {
      isNumeric = 0;
      break;
    }
  }

  if (isNumeric)
  {

    char temp[MAX];
    strcpy(temp, postfix);
    int result = evaluatePostfix(temp);
    printf("Result: %d\n", result);
  }

  return 0;
}
