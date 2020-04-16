#' Singular Spectrum Analysis
#'
#' Given an object of class \code{ssa}, the \code{print} function prints to the command line in descending order the standard deviations accounted for by each principal component.
#'
#' @param ssa an object of class \code{ssa}
#'
#' @return None
#' @export
#'
#' @examples
#' obj=ssa(co2,18)
#' print(obj)

print.ssa = function(ssa){
    cat('Call:\n')
    print(ssa$call)
    cat('\nStandard deviations:\n')
    print(c('Comp.'=ssa$X.svd$d))
    cat(paste('\nSeries length:',ssa$series.length,'\n'))
    cat(paste('Window length:',ssa$window.length,'\n'))
    cat(paste('No. of frames:',ssa$nframes,'\n'))
}
