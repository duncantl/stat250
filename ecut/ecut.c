#include <stdio.h>
#include <stdlib.h>  // for exit().


    /* Declarations of routines defined below. */
long processLines(FILE *stream, int fieldNum, char delim);
int processLine(char * const line, int fieldNum, char delim);


typedef char * string;
int
main(int argc, string argv[])
{
    /* For now, assume the first argument is the field, second is the delimeter and the third is the name of the file.
       If the third argument is not present, then read from standard input. We can relax these assumptions later by processing the command 
       line options. We might use getopt for this. */

    int field;
    char delimeter;
    FILE *input = NULL;

    field = atoi(argv[1]) - 1;
    if(field < 0) {
	fprintf(stderr, "require a positive field number, got %d\n", field);
	exit(2);
    }
    
    delimeter = argv[2][0];

    if(argc <= 3)
	input = stdin;
    else {
	if( ! (input = fopen(argv[3], "r"))) {
	    fprintf(stderr, "cannot open %s\n", argv[3]);
	    exit(1);
	}
    }

    processLines(input, field, delimeter);
    return(0);
}

#define MAX_CHARS 2000

typedef FILE *  myFile;

long
processLines(myFile stream, int fieldNum, char delim)
{
    char line[MAX_CHARS];
    long ctr = 0;
    while( fgets(line,  MAX_CHARS, stream) ) {
	processLine(line, fieldNum, delim);
	ctr++;
    }
    return(ctr);
}

int
processLine(char * const line, int fieldNum, char delim)
{
    int i = 0, field = 0;
    const char * val = 0;
    int inQuotes = 0;

    while( i < MAX_CHARS && line[i] != '\0') {

	if(line[i] == '"') {
	    inQuotes = inQuotes ? 0 : 1; 
	} else if(line[i] == delim && !inQuotes) { 
	    field++;
	    if(field == fieldNum) {
		val = line + i + 1;
	    } else if(field == fieldNum + 1) {
		line[i] = '\0';  //changing line.
		fprintf(stdout, "%s\n", val);
		break;
	    }
	}
	i++;
    }
}
