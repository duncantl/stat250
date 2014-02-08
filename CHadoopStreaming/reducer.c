#include <stdio.h>

#define MAX_NUM_CHARS 1000

int
main(int argc, char *argv[])
{
  char line[MAX_NUM_CHARS];

  int value = 0, curValue = 0;
  int count = 0;
  int doneOne = 0;
  while( fgets(line, MAX_NUM_CHARS, stdin) ) {
    // sscanf(line, "%d", &value) ;
   if(sscanf(line, "%d", &value) != 1)
     continue;

    if(value != curValue && doneOne) {
      fprintf(stdout, "%d %d\n", curValue, count);
      count = 0;
    }
    doneOne = 1;

    count++;
    curValue = value;
  }
  return(0);
}
