#include <stdio.h>
#include <string.h>
#include <ctype.h>

#define MAX_SYMBOLS 100

typedef struct
{
  char name[10];
  int address;
  char type[10];
  char token[15];
} Symbol;

Symbol symbolTable[MAX_SYMBOLS];
int symbolCount = 0;
int nextAddress = 5000;

char currentType[10] = "";

int findSymbolIndex(char *name)
{
  for (int i = 0; i < symbolCount; i++)
    if (strcmp(symbolTable[i].name, name) == 0)
      return i;

  return -1;
}

void addSymbol(char *name, char *type, char *token)
{
  if (findSymbolIndex(name) == -1)
  {
    strcpy(symbolTable[symbolCount].name, name);
    symbolTable[symbolCount].address = nextAddress;
    strcpy(symbolTable[symbolCount].type, type);
    strcpy(symbolTable[symbolCount].token, token);
    symbolCount++;
    nextAddress += 1000;
  }
}

int isOperator(char c)
{
  return c == '+' || c == '=' || c == '-' || c == '*';
}

int isKeyword(char *word)
{
  char *keywords[] = {"int", "float", "char", "double", "long", "short", "bool"};
  for (int i = 0; i < 7; i++)
    if (strcmp(word, keywords[i]) == 0)
      return 1;

  return 0;
}

int main(void)
{
  char input[] = "int C = A + B + C;";
  int i = 0;

  while (i < strlen(input))
  {
    if (isspace(input[i]))
    {
      i++;
      continue;
    }

    if (isalpha(input[i]))
    {
      char word[20];
      int j = 0;
      while (isalnum(input[i]))
        word[j++] = input[i++];
      word[j] = '\0';

      if (isKeyword(word))
      {
        strcpy(currentType, word);
      }
      else
      {
        addSymbol(word, currentType, "identifier");
      }
    }
    else if (isOperator(input[i]))
    {
      char op[2] = {input[i], '\0'};
      addSymbol(op, "-", "operator");
      i++;
    }
    else if (input[i] == ';')
    {
      char sym[2] = {input[i], '\0'};
      addSymbol(sym, "-", "Special symbol");
      currentType[0] = '\0';
      i++;
    }
    else
    {
      i++;
    }
  }

  printf("\n%-10s %-10s %-10s %-15s\n", "Symbol", "Address", "Type", "Token");
  for (int i = 0; i < symbolCount; i++)
  {
    printf("\n%-10s %-10d %-10s %-15s\n", symbolTable[i].name, symbolTable[i].address, symbolTable[i].type, symbolTable[i].token);
  }

  return 0;
}