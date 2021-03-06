library(ic.infer)

arcorr <- function(rho,p) {
  erg <- diag(rep(1,p))
  for (i in 1:(p-1))
    for (j in (i+1):p)
    erg[i,j] <- erg[j,i] <- rho^(j-i)
  erg
}

ic.weights(arcorr(0.9,2))
ic.weights(arcorr(0,2))
ic.weights(arcorr(-0.9,2))
ic.weights(arcorr(0.9,3))
ic.weights(arcorr(0,3))
ic.weights(arcorr(-0.9,3))
ic.weights(arcorr(0.9,4))
ic.weights(arcorr(0,4))
ic.weights(arcorr(-0.9,4))
ic.weights(arcorr(0.9,5))
ic.weights(arcorr(0,5))
ic.weights(arcorr(-0.9,5))
ic.weights(arcorr(0.9,6))
ic.weights(arcorr(0,6))
ic.weights(arcorr(-0.9,6))
ic.weights(arcorr(0.9,7))
ic.weights(arcorr(0,7))
ic.weights(arcorr(-0.9,7))
ic.weights(arcorr(0.9,8))
ic.weights(arcorr(0,8))
ic.weights(arcorr(-0.9,8))
ic.weights(arcorr(0.9,9))
ic.weights(arcorr(0,9))
ic.weights(arcorr(-0.9,9))
ic.weights(arcorr(0.9,10))
ic.weights(arcorr(0,10))
ic.weights(arcorr(-0.9,10))