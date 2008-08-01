orlm.forboot <- function(data, indices, ...){
    assign(".ind", indices, envir=.GlobalEnv)  
    assign(".dat", data, envir=.GlobalEnv)
    return(orlm(lm(.dat[.ind,-1], weights=.dat[.ind,]$wt), ...)$b.restr)
    remove(".ind", envir=.GlobalEnv)
    remove(".dat", envir=.GlobalEnv)
}
