
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "readRecords.h"

void showTable(Table *t);


/* Stand-alone entry point. */
int 
main(int nargs, char *argv[])
{
    /* Currently symmetric, but really there are fewer possible negative values than positive delays. */
    Table tt = {- MAX_NUM_VALUES/2, MAX_NUM_VALUES/2, MAX_NUM_VALUES + 1};
    memset(tt.values, 0, sizeof(int) * (MAX_NUM_VALUES + 1));
    readDelays(argv[1], &tt, FIELD_NUM);
    showTable(&tt);
    return(0);
}



/* Initialize a Table object, allocating it if necessary or filling in an existing instance.  */
Table *
makeTable(Table *tt)
{
    if(!tt)
	tt = (Table *) malloc(sizeof(Table));

    tt->min = - MAX_NUM_VALUES/2;
    tt->max = MAX_NUM_VALUES/2;
    tt->numValues = MAX_NUM_VALUES + 1;

    memset(tt->values, 0, sizeof(int) * (MAX_NUM_VALUES + 1));
    return(tt);
}

/* Increment the count for the specified value in the given table */
void 
insertValue(int value, Table *t)
{
    if(value < t->min || value > t->max) {
	fprintf(stderr, "%d is outside of the range of the table\n", value);
    } else {
	int i;
	i = value - t->min;
	t->values[i] ++;
    }
}

/* Display a table on the console/terminal. 
   This is used in the standalone version. 
   So it doesn't use's R's print routines.
  */
void 
showTable(Table *t)
{
    int i;
    for(i = 0; i < MAX_NUM_VALUES; i++) {
	if(t->values[i] > 0)
	    fprintf(stderr, "%d: %ld\n", t->min + i, t->values[i]);
    }
}

/* Generic version of inserting a value, originally used in the standalone version. 
   We could probably just cast and use insertValue() directly. */
void
storeValue(int value, void *data)
{
    Table *t = (Table *) data;
    insertValue(value, t);
}

/* process a file, line by line.  */
double
readDelays(const char *filename, void *data, int fieldNum)
{
    FILE *f;
    char line[MAX_NUM_CHARS];

    f = fopen(filename, "r");
    if(!f) 
	exit(1);  // if we run this in R, don't use exit(), but PROBLEM-ERROR.

    // header line
    fgets(line, MAX_NUM_CHARS, f);

    int val;
    while(fgets(line, MAX_NUM_CHARS, f)) {
	val = readRecord(line, fieldNum);
	storeValue(val, data);
    }

    return((double) val);
}


/* Read an individual record in a file, returning the value of the ARR_DELAY variable. */
int
readRecord(char *line, int fieldNum)
{
    int i = 0, field;
    char *val;

#if 0
    char *tmp;
    for(i = 0; i < 43; i++)
	val = strtok_r(val, ",", &tmp);

#else

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

#endif

    return(atoi(val));
}







/* 
  Merge several tables into a single table. This sums counts from the different tables
  for the same value.
  Could do this with threads, but probably not worth the overhead. */
Table*
combineTables(Table **tables, int num, Table *out)
{
    if(!out)
	out = makeTable(NULL);

    int i, j;

    for(i = 0; i < num; i++) {
	for(j = 0; j < out->numValues; j++) 
	    out->values[j] += tables[i]->values[j];
    }

    return(out);
}

