#' Singular Spectrum Analysis
#'
#' Given an \code{ssa} class object, the cumulative and total proportion of variance accounted for by each principal component is printed to the command line in descending order.
#'
#' @param ssa an object of class \code{ssa}
#'
#' @details The sum of the eigenvalues of a covariance matrix is equal to the total variance in the data. The proportion of variance accounted for by a principal component is its eigenvalue divided by the sum of all eigenvalues.
#'
#' @return an object of class \code{ssa}
#' @export
#'
#' @examples
#' obj=ssa(co2,18)
#' summary(obj)

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
