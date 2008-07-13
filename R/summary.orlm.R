summary.orlm <- function(object, display.unrestr=FALSE, 
           digits = max(3, getOption("digits") - 3), 
           scientific=FALSE, overall.tests=TRUE, 
           bootCIs=TRUE, bty="perc", level=0.95, ...){
     if (bootCIs & !is.null(object$bootout) & !bty %in% c("perc","basic","norm","bca"))
         stop("bty is invalid.") 
     if (bootCIs & !is.null(object$bootout) & (level < 0.5  | level>1)) stop("invalid confidence level")

     cat("Order-restricted linear model with restrictions of coefficients of", "\n")
     cat(names(coef(object))[object$restr.index[colSums(!object$ui==0)>0]],"\n\n")
     namen <- names(object$b.restr)
     if (is.null(namen)) namen <- paste("m",1:length(object$b.restr),sep="")
     hilf <- object$ui
     colnames(hilf) <- namen[object$restr.index]
     aus <- cbind(hilf,rep("%*%colnames",nrow(object$ui)),
                  c(rep(" == ",object$meq),rep(" >= ", nrow(object$ui)-object$meq)),object$ci)
     rownames(aus) <- paste(1:nrow(aus),":",sep="")
     colnames(aus)[(ncol(hilf)+1):ncol(aus)] <- rep(" ",ncol(aus)-ncol(hilf))
     aus <- cbind(rep(" ",nrow(aus)),aus)
     aus[object$iact,1] <- "A"

     if (object$meq==0) cat("\n","Inequality restrictions:\n") else cat("\n","Restrictions:\n") 
     print(aus,quote=FALSE,scientific=FALSE)
     cat("\n","Note: Restrictions marked with A are active.","\n")
     cat("\n\nRestricted model: R2 reduced from", object$orig.R2, "to", object$R2,"\n\n")

     g <- length(object$b.restr)

     ### add results from bootstrap testing here,
     ### once implemented
     if (bootCIs & !is.null(object$bootout)) {
     cis <- matrix(0,length(object$b.restr),2)
     colnames(cis) <- c("lower", "upper")
     for (i in 1:length(object$b.restr)) {
        if (!bty%in% c("norm","perc")) cis[i,] <- boot.ci(object$bootout,conf=level,type=bty,index=i)[[bty]][4:5] 
        if (bty=="perc") cis[i,] <- boot.ci(object$bootout,conf=level,type=bty,index=i)[["percent"]][4:5] 
        if (bty=="norm") cis[i,] <- boot.ci(object$bootout,conf=level,type=bty,index=i)[["normal"]][2:3] 
                 }
                 }
     if (bootCIs & !is.null(object$bootout)) cat("\nCoefficients from order-restricted model\nwith", 100*level,
                    "pct bootstrap confidence intervals(",bty,"):", "\n")
     else cat("\nCoefficients from order-restricted model:", "\n")
     orc <- round(coef(object),9)
     mark <- rep(" ",length(coef(object))); mark[object$restr.index[colSums(!object$ui==0)>0]]<-"R"
     names(orc) <- paste(mark, names(orc),sep=" ")
     if (bootCIs & !is.null(object$bootout)) orc <- cbind(orc,round(cis,9)) else orc <- cbind(orc)
     if (bootCIs & !is.null(object$bootout)) colnames(orc) <- c("Coeff.", "Lower", "Upper") 
            else colnames(orc)<-"coefficients"
     
     print(format(orc), quote=FALSE, digits=4)
     cat("\n","Note: Coefficients marked with R are involved in restrictions.","\n")

     if (overall.tests) {
     cat("\n\nHypothesis Tests (", object$df.error, "error degrees of freedom):","\n")
     cat("Overall model test under the order restrictions:","\n")
         ### Exceptions for models without intercept to be implemented
         hilf1 <- ic.test(object,TP=11,ui0.11=cbind(rep(0,(g-1)),diag(rep(1,g-1))),ci0.11=rep(0,g-1),df.error=object$df.error, s2=object$s2)
         cat("Test statistic:", round(hilf1$T,9), ", p-value:", round(hilf1$p.value,4), "\n\n")
     cat("Type 1 Test: H0: all restrictions active(=)    vs. H1: at least one restriction strictly true (>)","\n")
     cat("Type 2 Test: H0: all restrictions true    vs. H1: at least one restriction false","\n")
     if (!object$meq>0) cat("Type 3 Test: H0: at least one restriction false or active (=)    vs. H1: all restrictions strictly true (>)","\n")
         hilf1 <- ic.test(object,df.error=object$df.error, s2=object$s2, wt=hilf1$wt.bar)
         hilf2 <- ic.test(object,TP=2,wt=hilf1$wt.bar,df.error=object$df.error, s2=object$s2)
         if (!object$meq>0) hilf3 <- ic.test(object,TP=3,df.error=object$df.error, s2=object$s2)
         if (!object$meq>0) {
               aus <- cbind(Test.statistic=round(c(hilf1$T,hilf2$T,hilf3$T),9), p.value=round(c(hilf1$p.value,hilf2$p.value,hilf3$p.value),4))
               rownames(aus) <- c("Type 1:", "Type 2:", "Type 3:")
               cat("\n")
               print(format(aus),quote=FALSE,digits=4)
               cat("\nType 3 test based on t-distribution (one-sided), \nall other tests based on mixture of beta distributions\n" )
               }
         else {
              aus <- cbind(Test.statistic=c(hilf1$T,hilf2$T), p.value=c(hilf1$p.value,hilf2$p.value))
              rownames(aus) <- c("Type 1:", "Type 2:")
              cat("\n")
              print(format(aus,scientific=FALSE),quote=FALSE,digits=4)
              cat("\nAll tests based on mixture of beta distributions \n(Type 3 test not applicable because of equality restrictions)\n\n" )
              }
     }     
     if (display.unrestr) {
          if (is.null(object$origmodel)) cat("\n\nResults from unrestricted model not available in object","\n")
          else {
          cat("\n\nResults from the unrestricted model: ","\n")
          print(summary(object$origmodel))}}
}
