orlm.boothilf <- function(data,...){
    orlm(lm(data[,-1],weight=data$wt),...)$b.restr
}

orlm.forboot <- function(data, indices, ...){
    return(orlm.boothilf(data[indices,], ...))
}
