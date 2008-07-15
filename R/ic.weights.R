ic.weights <- function (corr, algorithm = GenzBretz()) 
{
    if (!(is.matrix(corr) & nrow(corr)==ncol(corr)))
         stop("corr must be a square matrix.")
    if (!(all(eigen(corr)$value>0)))
         stop("corr must be positive definite.")
    g <- nrow(corr)
    liste <- 1:g
## weights in the order of highest to lowest dimension for variable with correlation or cov corr
    weights <- rep(0,g+1)
    names(weights) <- rev(0:g)
    weights[1] <- pmvnorm(lower=rep(0,g),upper=rep(Inf,g),sigma=corr, algorithm=algorithm)
    weights[g+1] <- pmvnorm(lower=rep(0,g),upper=rep(Inf,g),sigma=solve(corr), algorithm=algorithm)
## prevent lengthy calculations if longest vector too long for available storage
    if (!is.numeric(try(matrix(0, floor(g/2),choose(g,floor(g/2))), silent=TRUE)))
           stop(paste("ic.weights will not work, corr too large, \n",
                "interim matrix with ", floor(g/2)*choose(g,floor(g/2)), 
                " elements cannot be created.",sep=""))
    if (g>2) {
    for (k in 1:floor((g-1)/2)) {
        ### fill weights simultaneously from top and bottom
        ### for even g, fill middle by difference to 1
        jetzt <- nchoosek(g, k)
        wjetzt <- matrix(0, choose(g, k), 2)
        for (j in 1:(choose(g, k))) {
                diese <- jetzt[, j]
                andere <- setdiff(liste, diese)
            hilf <- corr[andere, andere] - corr[andere,diese] %*% solve(corr[diese, diese], matrix(corr[diese, 
                andere], k, g - k))  ## matrix necessary, because vector otherwise wrong direction
            wjetzt[j,1] <- pmvnorm(lower=rep(0,k),upper=rep(Inf,k),sigma=solve(corr[diese,diese]),algorithm=algorithm)*
                  pmvnorm(lower=rep(0,g-k),upper=rep(Inf,g-k), sigma=hilf,algorithm=algorithm) 
            hilf <- corr[diese, diese] - corr[diese,andere] %*% solve(corr[andere, andere], matrix(corr[andere, 
                diese], g-k, k))  ## matrix necessary, because vector otherwise wrong direction
            wjetzt[j,2] <- pmvnorm(lower=rep(0,g-k),upper=rep(Inf,g-k),sigma=solve(corr[andere,andere]),algorithm=algorithm)*
                  pmvnorm(lower=rep(0,k),upper=rep(Inf,k), sigma=hilf,algorithm=algorithm) 
        }
        weights[k + 1] <- sum(wjetzt[,1])
        weights[g+1-k] <- sum(wjetzt[,2])
    } 
    }
    if (g/2==floor(g/2)) weights[g/2+1] <- 1-sum(weights)
    weights
}