#' Singular Spectrum Analysis
#'
#' A \code{ssa} class object to perform a singular spectrum analysis.
#'
#' @param ssa an object of class \code{ssa}
#'
#' @return an object of class \code{ssa}
#' @export
#'

summary.ssa = function(ssa){
    cat('Proportion of Variance:\n')
    out=rbind('Total'=ssa$pct.var$total,'Cumulative'=ssa$pct.var$cumulative)
    ncols=dim(out)[2]
    if(ncols>19){
        print(out[,1:19])
        cat(paste('...',ncols-19,' components emitted.\n'))
    }else{
        print(out)
    }
}
