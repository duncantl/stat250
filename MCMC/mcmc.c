#include <Rmath.h> // for log()

#define MIN(a, b)  ((a) < (b) ? (a) : (b))

double 
sumYs(double *Y, int start, int end)
{
    double ans = 0;
    int i;

    for(i = start; i < end; i++)
	ans += Y[i];

    return(ans);
}


int
riunif(int min, int max)
{
    return((int) runif(min, max));
}

/* 
   Pass the arrays for each of the parameters. This routine will fill in these arrays.
   return the acceptance rate */
double
mcmc(int numIterations, int n, double *theta, double *lambda, 
     int *k, double *b1, double *b2, double *Y)
{
    int numAccepted;
    int i;

    double currTheta = theta[0], currLambda = lambda[0], curr_b1 = b1[0], curr_b2 = b2[0];
    double currK = k[0]; // make this a double rather than an integer.
    double proposedK, logMHratio;

    for(i = 1; i < numIterations; i++) {
	currTheta = rgamma( sumYs(Y, 0, currK) + .5, curr_b1/(currK * curr_b1 + 1.));
	currLambda = rgamma( sumYs(Y, currK, n),  curr_b2 / ( ((double) n - currK)*curr_b2 + 1)  );

	proposedK = riunif(2, n-1);

	double a = sumYs(Y, 0, proposedK);
	double b = sumYs(Y, proposedK, n);
	logMHratio = a * log(currTheta) + b * log(currLambda) -
	              proposedK*currTheta - (n - proposedK) * currLambda -
      	              (sumYs(Y, 0, currK) * log(currTheta) + sumYs(Y, currK, n)* log(currLambda) -
		          currK * currTheta - (n - currK) * currLambda);

	double logAlpha = MIN(0, logMHratio);
	double u = log(runif(0, 1));
	if(u < logAlpha) {
	    numAccepted++;
	    currK = proposedK;
	}

	curr_b1 = 1/rgamma(.5,  1/(currTheta + 1.));
	curr_b2 = 1/rgamma(.5,  1/(currLambda + 1.));

	theta[i]= currTheta;
	lambda[i]= currLambda;
	k[i]= currK;
	b1[i] = curr_b1;
	b2[i] = curr_b2;
    }

    return( ((double)numAccepted)/ ((double) numIterations ));
}


/* Call from R using the .C() rather than .Call() just to keep this simpler for
   a first go. */
void
R_mcmc(int *numIterations, int *n, double *theta, double *lambda, int *k, double *b1, double *b2, double *Y)
{
    mcmc(numIterations[0], n[0], theta, lambda, k, b1, b2, Y);
}
