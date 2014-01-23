#include <Rdefines.h>

SEXP
R_foo(SEXP obj)
{
    REAL(obj)[0] = 10;
    return(R_NilValue);
}
