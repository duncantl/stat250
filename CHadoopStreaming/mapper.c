#include <stdio.h>

#define MAX_NUM_CHARS 10000

int readRecord(char *line, int fieldNum);

int
main(int argc, char *argv[])
{
  char line[MAX_NUM_CHARS];
  while( fgets(line, MAX_NUM_CHARS, stdin) ) {
    int val = readRecord(line, 14);
    fprintf(stdout, "%d 1\n", val);
  }

  return(0);
}


/* Taken from AirlineDelays/src/readRecords.c */
/* Read an individual record in a file, returning the value of the ARR_DELAY variable. */
int
readRecord(char *line, int fieldNum)
{
    int i = 0, field;
    char *val;

    for(i = 0, field = 0; i < MAX_NUM_CHARS; i++) {
	if(line[i] == ',') { // used = rather than ==
	    field++;
	    if(field == fieldNum) {
		val = line + i + 1;
	    } else if(field == fieldNum + 1) {
		line[i] = '\0';
		break;
	    }
	}
    }


    return(atoi(val));
}
