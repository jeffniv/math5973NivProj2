#' Embed a series into a trajectory matrix
#'
#' This is a helper function for the `math5973NivProj2` package.
#'
#' @param series
#' @param window.length
#'
#' @return a Hankel-type, trajectory matrix X
#'

embed.ssa <- function(series,window.length=12){
    N = length(series);
    m = window.length;
    n = N - m + 1;
    X = matrix(0,m,n);
    for (i in 1:n){
        X[,i] = series[i:(i+m-1)];
    }
    return(X)
}
