bodyfat <- function(){ 
    assign("bodyfat", 
        as.data.frame(scan(file="http://www.ats.ucla.edu/stat/sas/examples/alsm/alsmsasch7.htm", 
            skip=56,nlines=20,what=list(Triceps=0,Thigh=0,Midarm=0,BodyFat=0 ))),envir=.GlobalEnv)
    message("data courtesy of http://www.ats.ucla.edu from Table 7.1 \nof McGraw-Hill book Applied Linear Statistical Models by Neter et al. 1996")
    }