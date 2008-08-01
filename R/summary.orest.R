summary.orest <- function (x, display.unrestr = FALSE, brief = FALSE, digits = max(3, 
    getOption("digits") - 3), scientific = FALSE, ...) 
{
    cat("Order-restricted estimated mean with restrictions of coefficients of", 
        "\n")
    cat(names(x$b.restr)[x$restr.index[colSums(!x$ui == 0) > 
        0]], "\n\n")
    namen <- names(x$b.restr)
    if (is.null(namen)) 
        namen <- paste("m", 1:length(x$b.restr), sep = "")
    hilf <- x$ui
    colnames(hilf) <- namen[x$restr.index]
    aus <- cbind(hilf, rep("%*%colnames", nrow(x$ui)), c(rep(" == ", 
        x$meq), rep(" >= ", nrow(x$ui) - x$meq)), x$ci)
    rownames(aus) <- paste(1:nrow(aus), ":", sep = "")
    colnames(aus)[(ncol(hilf) + 1):ncol(aus)] <- rep(" ", ncol(aus) - 
        ncol(hilf))
    aus <- cbind(rep(" ", nrow(aus)), aus)
    aus[x$iact, 1] <- "A"
    if (!brief) {
        if (x$meq == 0) 
            cat("\n", "Inequality restrictions:\n")
        else cat("\n", "Restrictions:\n")
        print(aus, quote = FALSE, scientific = FALSE)
        cat("\n", "Note: Restrictions marked with A are active.", 
            "\n")
    }
    g <- length(x$b.restr)
    cat("\nRestricted estimate:", "\n")
    orc <- round(x$b.restr, 9)
    mark <- rep(" ", length(x$b.restr))
    mark[x$restr.index[colSums(!x$ui == 0) > 0]] <- "R"
    names(orc) <- paste(mark, names(orc), sep = " ")
    print(format(orc), quote = FALSE, digits = 4)
    cat("\n", "Note: Estimates marked with R are involved in restrictions.", 
        "\n")
    if (display.unrestr) {
        cat("\n\nUnrestricted estimate: ", "\n")
        print(x$b.unrestr)
    }
}
