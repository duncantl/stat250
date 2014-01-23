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
  
 .C("R_mcmc", as.integer(niter), length(Y), thetav, lambdav, kv, b1v, b2v, as.numeric(Y))
}
