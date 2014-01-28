dyn.load("mcmc.so")

mcmc =
function(Y, k = 10L, theta = 1, lambda = 1, b1 = 1, b2 = 1, niter = 1e5)
{
  thetav = lambdav = b1v = b2v = numeric(niter)
  kv = integer(niter)
  kv[1] = as.integer(k)
  thetav[1] = theta
  lambdav[1] = lambda
  b1v[1] = b1
  b2v[1] = b2  
  
  tmp = .C("R_mcmc", as.integer(niter), length(Y), theta = thetav, lambda = lambdav, 
                 k = kv, b1 = b1v, b2 = b2v, as.numeric(Y))

   as.data.frame(tmp[c("theta", "lambda", "k", "b1", "b2")])
}


if(FALSE) {
source("mcmc.R")
chptdat = read.table("http://www.stat.psu.edu/~mharan/MCMCtut/COUP551_rates.dat",skip=1) 
Y=chptdat[,2] # store data in Y
runif(1)
ans = mcmc(Y)
system.time({ans = mcmc(Y, niter = 1e6)})


source("template.R")
system.time({a = mhsampler(1e6)})


}
