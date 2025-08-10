#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdlib.h>

char keywords[][10] = {
    "auto", "break", "case", "char", "const", "continue", "default", "do",
    "double", "else", "enum", "extern", "float", "for", "goto", "if",
    "int", "long", "register", "return", "short", "signed", "sizeof",
    "static", "struct", "switch", "typedef", "union", "unsigned", "void",
    "volatile", "while", "main"};

int isKeyword(const char *word)
{
  for (int i = 0; i < sizeof(keywords) / sizeof(keywords[0]); i++)
  {
    if (strcmp(keywords[i], word) == 0)
      return 1;
  }
  return 0;
}

int isOperator(char ch)
{
  return ch == '+' || ch == '-' || ch == '*' || ch == '/' || ch == '=' || ch == '%';
}

int isSpecialSymbol(char ch)
{
  return ch == '(' || ch == ')' || ch == '{' || ch == '}' || ch == ';' || ch == ',';
}

int main()
{
  FILE *fp = fopen("prog.c", "r");
  if (fp == NULL)
  {
    printf("Failed to open file.\n");
    return 1;
  }

  char ch, buffer[100];
  int i = 0;

  while ((ch = fgetc(fp)) != EOF)
  {
    if (isalnum(ch) || ch == '_')
    {
      buffer[i++] = ch;
    }
    else
    {
      if (i > 0)
      {
        buffer[i] = '\0';
        if (isKeyword(buffer))
          printf("%s is keyword\n", buffer);
        else
          printf("%s is identifier\n", buffer);
        i = 0;
      }

      if (isOperator(ch))
      {
        printf("%c is operator\n", ch);
      }
      else if (isSpecialSymbol(ch))
      {
        printf("%c is special symbol\n", ch);
      }
    }
  }

  if (i > 0)
  {
    buffer[i] = '\0';
    if (isKeyword(buffer))
      printf("%s is keyword\n", buffer);
    else
      printf("%s is identifier\n", buffer);
  }

  fclose(fp);
  return 0;
}
