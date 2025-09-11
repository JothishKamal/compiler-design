#include <stdio.h>
#include <string.h>

char grammar[8][3][10] = {
    {"E", "->", "TR"},
    {"R", "->", "+TR"},
    {"R", "->", "#"},
    {"T", "->", "FY"},
    {"Y", "->", "*FY"},
    {"Y", "->", "#"},
    {"F", "->", "(E)"},
    {"F", "->", "i"}};

char nt[] = {'E', 'R', 'T', 'Y', 'F'};
char first[5][20];
int fc[5] = {0};

int isNT(char c)
{
  for (int i = 0; i < 5; i++)
  {
    if (nt[i] == c)
      return 1;
  }
  return 0;
}

int getIndex(char c)
{
  for (int i = 0; i < 5; i++)
  {
    if (nt[i] == c)
      return i;
  }
  return -1;
}

int inSet(int idx, char c)
{
  for (int i = 0; i < fc[idx]; i++)
  {
    if (first[idx][i] == c)
      return 1;
  }
  return 0;
}

void add(int idx, char c)
{
  if (!inSet(idx, c))
  {
    first[idx][fc[idx]++] = c;
  }
}

void calcFirst(int idx)
{
  if (fc[idx] > 0)
    return;

  char symbol = nt[idx];
  for (int i = 0; i < 8; i++)
  {
    if (grammar[i][0][0] == symbol)
    {
      char *rhs = grammar[i][2];
      int len = strlen(rhs);
      int j = 0;

      while (j < len)
      {
        if (!isNT(rhs[j]))
        {
          add(idx, rhs[j]);
          break;
        }
        else
        {
          int nt_idx = getIndex(rhs[j]);
          calcFirst(nt_idx);

          int hasEps = 0;
          for (int k = 0; k < fc[nt_idx]; k++)
          {
            if (first[nt_idx][k] == '#')
            {
              hasEps = 1;
            }
            else
            {
              add(idx, first[nt_idx][k]);
            }
          }

          if (!hasEps)
            break;
          j++;
        }
      }

      if (j == len)
      {
        add(idx, '#');
      }
    }
  }
}

int main()
{
  for (int i = 0; i < 5; i++)
  {
    calcFirst(i);
  }

  for (int i = 0; i < 5; i++)
  {
    printf("First(%c)= { ", nt[i]);
    for (int j = 0; j < fc[i]; j++)
    {
      printf("%c", first[i][j]);
      if (j < fc[i] - 1)
        printf(", ");
    }
    printf(", }\n");
  }

  return 0;
}