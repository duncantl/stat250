#include "RreadRecords.h"


/* R entry point for a single file */

SEXP
R_getFileDelayTable(SEXP filename, SEXP returnTable, SEXP fieldNum)
{
    Table tt = {- MAX_NUM_VALUES/2, MAX_NUM_VALUES/2, MAX_NUM_VALUES + 1};

    SEXP ans = R_NilValue;


    memset(tt.values, 0, sizeof(int) * (MAX_NUM_VALUES + 1)); // ended up fixing this in two places!
    readDelays(CHAR(STRING_ELT(filename, 0)), &tt, INTEGER(fieldNum)[0]);

    if(LOGICAL(returnTable)[0]) 
	ans = convertTableToR(&tt);

    return(ans);
}


/* Convert a Table to an R vector. Use numeric() in R in case of overflow. */
SEXP
convertTableToR(Table *tt)
{
    SEXP ans = R_NilValue, names;
    int i;

    PROTECT(ans = NEW_NUMERIC(tt->numValues));
    PROTECT(names = NEW_CHARACTER(tt->numValues));
    for(i = 0; i < tt->numValues; i++) {
	char buf[20];
	sprintf(buf, "%d", tt->min + i);
	REAL(ans)[i] = tt->values[i];
	SET_STRING_ELT(names, i, mkChar(buf));
    }
    SET_NAMES(ans, names);
    UNPROTECT(2);
    return(ans);
}
