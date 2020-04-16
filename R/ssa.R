#' Singular Spectrum Analysis
#'
#' This functon constructs an \code{ssa} class object to perform a singular spectrum analysis.
#'
#' @param series a time-series or spatial-series
#' @param window.length the interval length to consider within series
#'
#' @details Singular Spectrum Analysis (SSA) is a model-free technique to analyze a 1-D series and extract signal components from noise components. The four basic steps of SSA are: 1. embedding, 2. singular value decomposition, 3. grouping, 4. reconstruction. This constructor function effectively executes steps 1 and 2. The function \code{windowtest} serves as a diagnostic aid for parameter selection. The \code{plot}, \code{print}, \code{summary}, and \code{combinepatterns} functions aid the user in step 3. Finally, step 4 is accomplished via the \code{reconstruct} function.
#'
#' @return an object of class \code{ssa}
#' @export
#'
#' @examples
#' obj=ssa(co2,18)
#' plot(obj)
#' print(obj)
#' summary(obj)

ssa <- function(series,window.length=12) {
    N = length(series)
    n = N - window.length + 1
    X = embed.ssa(series,window.length)
    X_svd = svd(X)
    obj=list(call=match.call(),X=X, X.svd=X_svd, X.recon=X, series=series, series.recon=series,
             pct.var=list('cumulative'=c('Comp.'=cumsum(X_svd$d^2)/sum(X_svd$d^2)),'total'=c('Comp.'=X_svd$d^2/sum(X_svd$d^2))),
             window.length=window.length, nframes=n, series.length=N)
    class(obj)="ssa"
    return(obj)
}
