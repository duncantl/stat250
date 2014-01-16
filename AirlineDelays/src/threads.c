#include "readRecords.h"

#include <pthread.h>
#include <stdio.h>
#include <string.h>

#include "threads.h"

/* Work with each thread  processing multiple files. */


void *
thread_multi_readDelays(void *data)
{
    FileNames *fn = (FileNames *) data;
    int i;
    for(i = 0; i < fn->numEls; i++) {
	fprintf(stderr, "%s\n", fn->filenames[i]);
	readDelays(fn->filenames[i], fn->counts, fn->fieldNum);
    }
    return(NULL);
}

/* Thread routine for reading an entire file and filling in a table */
void *
thread_readDelays(void *data)
{
    const char *filename = (const char *) data;
    Table tt = {- MAX_NUM_VALUES/2, MAX_NUM_VALUES/2, MAX_NUM_VALUES + 1};

    memset(tt.values, 0, sizeof(int) * (MAX_NUM_VALUES + 1)); // ended up fixing this in two places!
    readDelays(filename, &tt, FIELD_NUM); /* FIX: !!! Need to specify the field number. */
    return(NULL);
}


