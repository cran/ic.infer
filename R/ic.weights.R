ic.weights <- function (corr, algorithm = GenzBretz()) 
{
    if (!(is.matrix(corr) & nrow(corr)==ncol(corr)))
         stop("corr must be a square matrix.")
    if (!(all(eigen(corr)$value>0)))
         stop("corr must be positive definite.")
    g <- nrow(corr)
    liste <- 1:g
## weights in the order of highest to lowest dimension for variable with correlation or cov corr
    weights <- as.list(rep(0,g+1))
    weights[[1]] <- pmvnorm(lower=rep(0,g),upper=rep(Inf,g),sigma=corr, algorithm=algorithm)
    weights[[g+1]] <- pmvnorm(lower=rep(0,g),upper=rep(Inf,g),sigma=solve(corr), algorithm=algorithm)
    for (k in liste[-g]) {
        jetzt <- nchoosek(g, k)
        wjetzt <- matrix(0, 1, choose(g, k))
        for (j in 1:(choose(g, k))) {
                diese <- jetzt[, j]
                andere <- setdiff(liste, diese)
            hilf <- corr[andere, andere] - corr[andere,diese] %*% solve(corr[diese, diese], matrix(corr[diese, 
                andere], k, g - k))  ## matrix necessary, because vector otherwise wrong direction
            wjetzt[j] <- pmvnorm(lower=rep(0,k),upper=rep(Inf,k),sigma=solve(corr[diese,diese]),algorithm=algorithm)*
                  pmvnorm(lower=rep(0,g-k),upper=rep(Inf,g-k), sigma=hilf,algorithm=algorithm) 
        }
        weights[[k + 1]] <- wjetzt
    }
    erg <- sapply(weights,FUN="sum")
    names(erg) <- rev(0:g)
    erg
}