#' Skew-diagonal averaging to create a Hankel matrix
#'
#' This is a helper function for the `math5973NivProj2` package.
#'
#' @param X trajectory matrix
#'
#' @details The hankelization algorithm calculates and assigns as the value the mean of the skew-diagonal for all corresponding skew-diagonal entries.
#'

hankelize=function(X){
    m=dim(X)[1]
    n=dim(X)[2]
    N=m+n-1
    X_flat = rep(0,N)
    tempsum = 0
    for(j in 1:N){
        if (j <= m){
            for (k in 1:j){
                tempsum = tempsum + X[k,j-k+1];
            }
            X_flat[j]= tempsum/j;
        }else if( m < j && j < n){
            for(k in 1:m){
                tempsum = tempsum + X[k, j-k+1];
            }
            X_flat[j] = tempsum/m;
        }else{
            for(k in (j-n+1):m){
                tempsum = tempsum + X[k, j-k+1];
            }
            X_flat[j] = tempsum/(N-j+1);
        }
        tempsum=0
    }
    return(X_flat)
}
