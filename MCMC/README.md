
See Notes for the background and credit.

You can run the R version of the code via some of the commands in
run.R.  

You can compile the C code with
 R CMD SHLIB mcmc.c

You can then us it in an R by source()'ing the mcmc.R file.

Invoke the the function with
 ans = mcmc(Y)

Then compare the distributions of the results.


It would be much easier if this was an R package and then we could
install, with the data accessible via data() and the two functions
exported and the C code compiled automatically.

For  1e6 iterations, we see a speed up of a factor of approximately 60.


