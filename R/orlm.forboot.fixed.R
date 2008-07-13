orlm.forboot.fixed <- function (data, indices, ...) 
{
    data[,1] <- data$e[indices] + data$fit
    return(orlm(lm(data[,1:(ncol(data)-2)]),...)$b.restr)
}
