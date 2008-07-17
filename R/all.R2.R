all.R2 <- function (model, ui, ci = NULL, index = 2:length(coef(model)), 
    meq = 0, tol = sqrt(.Machine$double.eps), ...) 
{
    so <- summary(model)
    if (!("lm" %in% class(model))) 
        stop("ERROR: model must be of class lm.")
    if (any(c("glm", "mlm", "rlm") %in% class(model))) 
        stop("all.R2 does not work on classes glm, mlm or rlm.")

    if (length(model$xlevels)>0) stop("model must not contain any factors!")
    if (max(attr(model$terms,"order")) != 1) stop ("model must not contain higher order terms")
    
    g <- length(coef(model))
    if (!(is.vector(index))) 
        stop("index must be a vector.")
    if (is.vector(ui)) 
        ui <- matrix(ui, 1, length(ui))
    if (!is.matrix(ui)) 
        stop("ui must be a matrix.")
    if (!length(index) == ncol(ui)) 
        stop("mismatch between number of columns for ui and length of index")
    if (is.null(ci)) 
        ci <- rep(0, nrow(ui))
    if (!is.vector(ci)) 
        stop("ci must be a vector.")
    if (!nrow(ui) == length(ci)) 
        stop("mismatch between number of rows in ui and elements in ci")
    hilf <- RREF(t(ui))
    if (hilf$rank < nrow(ui)) 
        stop(paste("Matrix ui must have full row-rank (choose e.g. rows", 
            paste(hilf$pivot, collapse = " "), ")."))
    
    if (!is.numeric(try(R2s <- rep(0, 2^(g-1)))))
       stop("too many regressors in model, function all.R2 needs more storage than is available" )

    R2s[1] <- 0
    R2s[2^(g-1)] <- orlm(model, ui, ci=ci, index=index, meq=meq, tol=tol)$R2

    resp <- attr(model$terms, "response")
    xcol <- which(rowSums(attr(model$terms, "factors")) > 0)
    DATA <- as.data.frame(model$model[, c(resp, xcol)])
    wt <- weights(model)

    lauf <- 1  ## initialize running index
    for (j in 1:(g-2))
       {sets <- nchoosek(g-1,j)
        for (k in 1:ncol(sets)) {
        ## reduce model to these j regressors 
        ## reduce matrix ui accordingly
        ## run orlm on reduced model for R2
        lauf <- lauf + 1
        datj <- DATA[,c(1,sets[,k]+1)]
        if (length(which((index-1) %in% sets[,k]))>0) {
               uij <- matrix(ui[,which((index-1) %in% sets[,k])],nrow(ui),length(which((index-1) %in% sets[,k])))
               indexj <- index[which((index-1) %in% sets[,k])]  ## ändern, muss sich auf die neuen Spalten-Nummern beziehen!
               indexj <- which(sets[,k] %in% (indexj-1))+1
               meqj <- 0
               if (meq>0) meqj <- length(which((index[1:meq]-1) %in% sets[,k]))
               hilf <- RREF(t(uij))
               if (hilf$rank>0) {
                        uij <- matrix(uij[hilf$pivot,],hilf$rank,ncol(uij))     
                        cij <- ci[hilf$pivot]
                        R2s[lauf] <- orlm(lm(datj),uij,ci=cij,index=indexj,meq=meqj,tol=tol)$R2
               }
               else R2s[lauf] <- summary(lm(datj))$r.squared
        }   
        else R2s[lauf] <- summary(lm(datj))$r.squared
        }
   }
   R2s
}
