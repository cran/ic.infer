or.relimp <- function (model, ui, ci = NULL, index = 2:length(coef(model)), 
    meq = 0, tol = sqrt(.Machine$double.eps), ...) 
{
    if (!("lm" %in% class(model))) 
        stop("ERROR: model must be of class lm.")
    namen <- names(coef(model))
    aus <- Shapley.value(set.func(all.R2(model, ui, ci = ci, index = index, 
         meq = meq, tol = tol, ...)))
    names(aus) <- namen[-1]
    aus
}