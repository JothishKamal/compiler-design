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
char follow[5][20];
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
    if (follow[idx][i] == c)
      return 1;
  }
  return 0;
}

void add(int idx, char c)
{
  if (!inSet(idx, c))
  {
    follow[idx][fc[idx]++] = c;
  }
}

int hasEpsilon(char c)
{
  for (int i = 0; i < 8; i++)
  {
    if (grammar[i][0][0] == c && grammar[i][2][0] == '#')
      return 1;
  }
  return 0;
}

void getFirst(char c, char first[], int *count)
{
  *count = 0;
  if (!isNT(c))
  {
    if (c != '#')
      first[(*count)++] = c;
    return;
  }
  for (int i = 0; i < 8; i++)
  {
    if (grammar[i][0][0] == c)
    {
      if (grammar[i][2][0] == '#')
        continue;
      if (!isNT(grammar[i][2][0]))
      {
        int found = 0;
        for (int j = 0; j < *count; j++)
        {
          if (first[j] == grammar[i][2][0])
          {
            found = 1;
            break;
          }
        }
        if (!found)
          first[(*count)++] = grammar[i][2][0];
      }
      else
      {
        char temp[20];
        int tc;
        getFirst(grammar[i][2][0], temp, &tc);
        for (int j = 0; j < tc; j++)
        {
          int found = 0;
          for (int k = 0; k < *count; k++)
          {
            if (first[k] == temp[j])
            {
              found = 1;
              break;
            }
          }
          if (!found)
            first[(*count)++] = temp[j];
        }
      }
    }
  }
}

void calcFollow()
{
  add(0, '$');
  int changed = 1;
  while (changed)
  {
    changed = 0;
    for (int i = 0; i < 8; i++)
    {
      char *rhs = grammar[i][2];
      int len = strlen(rhs);
      for (int j = 0; j < len; j++)
      {
        if (isNT(rhs[j]))
        {
          int idx = getIndex(rhs[j]);
          int old = fc[idx];
          if (j == len - 1)
          {
            int lhs_idx = getIndex(grammar[i][0][0]);
            for (int k = 0; k < fc[lhs_idx]; k++)
            {
              add(idx, follow[lhs_idx][k]);
            }
          }
          else
          {
            int k = j + 1;
            int allEps = 1;
            while (k < len && allEps)
            {
              if (!isNT(rhs[k]))
              {
                if (rhs[k] != '#')
                  add(idx, rhs[k]);
                allEps = 0;
              }
              else
              {
                char first[20];
                int count;
                getFirst(rhs[k], first, &count);
                for (int l = 0; l < count; l++)
                {
                  add(idx, first[l]);
                }
                if (!hasEpsilon(rhs[k]))
                  allEps = 0;
              }
              k++;
            }
            if (allEps)
            {
              int lhs_idx = getIndex(grammar[i][0][0]);
              for (int l = 0; l < fc[lhs_idx]; l++)
              {
                add(idx, follow[lhs_idx][l]);
              }
            }
          }
          if (fc[idx] > old)
            changed = 1;
        }
      }
    }
  }
}

int main()
{
  calcFollow();

  for (int i = 0; i < 5; i++)
  {
    printf("Follow(%c) = { ", nt[i]);
    for (int j = 0; j < fc[i]; j++)
    {
      printf("%c", follow[i][j]);
      if (j < fc[i] - 1)
        printf(", ");
    }
    printf(",  }\n");
  }

  return 0;
}