#include "RreadRecords.h"
#include <pthread.h>
#include "threads.h"

#include <stdlib.h>

/* Process multiple files serially/sequentially in C code and return the table of counts. */
SEXP
R_serial_multiDelays(SEXP filenames, SEXP fieldNum)
{
    int n = Rf_length(filenames), i;
    Table *tt = makeTable(NULL);

    for(i = 0; i < n ; i++) {
	readDelays(CHAR(STRING_ELT(filenames, i)), tt, INTEGER(fieldNum)[i]);	
    }

    return(convertTableToR(tt));
}


/* This is the R entry point for processing multiple files within each thread.
   filenames is a list of character vectors.  */
SEXP 
R_threaded_multiReadDelays(SEXP filenames, SEXP numThreads, SEXP returnTable, SEXP fieldNum)
{

    int n = INTEGER(numThreads)[0];
    pthread_t thread[n];
    pthread_attr_t attr;
    
    int status, t;

    SEXP ans = R_NilValue;

    pthread_attr_init(&attr);
    pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);
    Table *tables[n];

    for(t = 0 ; t < n; t++) {
	FileNames *fn = malloc(sizeof(FileNames)); // memory will be lost unless we free() it!
	fn->numEls = Rf_length(VECTOR_ELT(filenames, t));
	fn->filenames = (const char * *) malloc(sizeof(char *) * fn->numEls);
	fn->fieldNum = INTEGER(fieldNum)[t]; /* a single integer vector which means that all of the files in the same thread have to have the same field number. We can relax this restriction. */
	for(int i = 0; i < fn->numEls; i++)
	    fn->filenames[i] = CHAR(STRING_ELT(VECTOR_ELT(filenames, t), i));
	tables[t] = fn->counts = makeTable(NULL);

	status = pthread_create(&thread[t], &attr, thread_multi_readDelays, (void *) fn); 
	if(status) {
	    PROBLEM  "Problem creating thread for %d",  t
		WARN;
	}
    }

    void *val;
    for(t = 0 ; t < n; t++) {
	status = pthread_join(thread[t], &val);
	if(status) {
	    PROBLEM  "Problem joining thread for %s",  CHAR(STRING_ELT(filenames, t))
		WARN;
	}
    }

    if(LOGICAL(returnTable)[0]) {
	Table *tmp = combineTables(tables, n, NULL/* was tables[0] */);
	ans = convertTableToR(tmp);
    }


    return(ans);
}



/* R callable/entry point for invoking the threaded version of processing several files concurrently. 
   As this stands, this doesn't return the counts at all. It is only to determine the speed of using threads.
   This is just an illustration.
*/
SEXP 
R_threaded_readDelays(SEXP filenames)
{

    int n = Rf_length(filenames);
    pthread_t thread[n];
    pthread_attr_t attr;
    
    int status, t;

    pthread_attr_init(&attr);
    pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);
    /* Start n threads simultaneously */
    for(t = 0 ; t < n; t++) {
	const char *fn = CHAR(STRING_ELT(filenames, t));
	status = pthread_create(&thread[t], &attr, thread_readDelays, (void *)fn); 
	if(status) {
	    PROBLEM  "Problem creating thread for %s",  fn
		WARN;
	}
    }

    /* wait until all the threads have completed. */
    void *val;
    for(t = 0 ; t < n; t++) {
	status = pthread_join(thread[t], &val);
	if(status) {
	    PROBLEM  "Problem joining thread for %s",  CHAR(STRING_ELT(filenames, t))
		WARN;
	}
    }
    return(R_NilValue);
}
