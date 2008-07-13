print.ict <- function (x, digits = max(3, getOption("digits") - 3), scientific=FALSE, ...) 
{
    cat("\nOrder-related hypothesis test:\n")
        hilf <- c(x$TP, x$T, x$p.value)
        names(hilf) <- c("Test problem", "Test statistic", "p.value")
        print.default(c(format(hilf[1], scientific=FALSE),
            format(hilf[2], digits = digits),
            format(hilf[3], digits = 3)), 
            print.gap = 2, quote = FALSE, ...)
    cat("\n")
    invisible(x)
}
