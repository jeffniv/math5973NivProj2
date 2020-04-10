#' Singular Spectrum Analysis
#'
#' This functon constructs an \code{ssa} class object to perform a singular spectrum analysis.
#'
#' @param series a time-series or spatial-series
#' @param window.length the interval length to consider within series
#'
#' @return an object of class \code{ssa}
#' @export
#'
#' @examples
#' ssa(co2,18)

ssa <- function(series,window.length=12) {
    N = length(series)
    n = N - window.length + 1
    X = embed.ssa(series,window.length)
    X_svd = svd(X)
    obj=list(call=match.call(),X=X, X.svd=X_svd, X.recon=X, series=series, series.recon=series,
             pct.var=list('cumulative'=c('Comp.'=cumsum(X_svd$d)/sum(X_svd$d)),'total'=c('Comp.'=X_svd$d/sum(X_svd$d))),
             window.length=window.length, nframes=n, series.length=N)
    class(obj)="ssa"
    return(obj)
}
