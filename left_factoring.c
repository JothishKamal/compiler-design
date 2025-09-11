#include <stdio.h>
#include <string.h>

#define MAX 100

void lcp(char p[][MAX], int n, char pre[])
{
  int i, j, min = strlen(p[0]), k = 0;
  for (i = 1; i < n; i++)
    if ((int)strlen(p[i]) < min)
      min = strlen(p[i]);
  for (j = 0; j < min; j++)
  {
    char c = p[0][j];
    for (i = 1; i < n; i++)
      if (p[i][j] != c)
      {
        pre[k] = '\0';
        return;
      }
    pre[k++] = c;
  }
  pre[k] = '\0';
}

void trim(char *s)
{
  int i = 0, j = 0;
  while (s[i] == ' ')
    i++;
  while (s[i])
    s[j++] = s[i++];
  s[j] = '\0';
  j--;
  while (j >= 0 && s[j] == ' ')
    s[j--] = '\0';
}

int main()
{
  char in[MAX], l, p[10][MAX], pre[MAX];
  int n = 0, i;
  fgets(in, MAX, stdin);
  in[strcspn(in, "\n")] = '\0';
  l = in[0];
  char *t = strchr(in, '>') + 1;
  char *tok = strtok(t, "|");
  while (tok)
  {
    trim(tok);
    strcpy(p[n++], tok);
    tok = strtok(NULL, "|");
  }
  lcp(p, n, pre);
  if (!strlen(pre))
  {
    printf("No left factoring\n");
    return 0;
  }
  printf("%c -> %s%c'\n", l, pre, l);
  printf("%c' -> ", l);
  for (i = 0; i < n; i++)
  {
    if (strlen(p[i]) == strlen(pre))
      printf("ε");
    else
      printf("%s", p[i] + strlen(pre));
    if (i != n - 1)
      printf(" | ");
  }
  printf("\n");
}
