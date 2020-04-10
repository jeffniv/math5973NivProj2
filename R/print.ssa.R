#' Singular Spectrum Analysis
#'
#' A \code{ssa} class object to perform a singular spectrum analysis.
#'
#' @param ssa an object of class \code{ssa}
#'
#' @return an object of class \code{ssa}
#' @export
#'

print.ssa = function(ssa){
    cat('Call:\n')
    print(ssa$call)
    cat('\nStandard deviations:\n')
    print(c('Comp.'=ssa$X.svd$d))
    cat(paste('\nSeries length:',ssa$series.length,'\n'))
    cat(paste('Window length:',ssa$window.length,'\n'))
    cat(paste('No. of frames:',ssa$nframes,'\n'))
}
