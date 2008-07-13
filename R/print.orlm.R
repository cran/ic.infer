print.orlm <- function (x, digits = max(3, getOption("digits") - 3), ...) 
{
    cat("\nConstrained linear model:\n")
    if (length(coef(x))) {
        cat("Coefficients:\n")
        print.default(format(coef(x), digits = digits), print.gap = 2, 
            quote = FALSE)
    }
    else cat("No coefficients\n")
    cat("\n")
    invisible(x)
}
