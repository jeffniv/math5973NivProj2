
#' Window length tests
#'
#' Plots Lag-correlation, Autocorrelation, and Partial Autocorrelation as
#' a heuristic for determining optimal window length.
#'
#' @param ssa
#'
#' @return None
#' @export
#'
#' @examples
#' obj=ssa(co2,18)
#' windowtest(obj)
#'
#' @import ggplot2
#' @import gridExtra
#'
windowtest<- function(ssa) {
    if(!is.element('ssa',class(ssa))){
        stop('Not an object of class "ssa"')
    }
    dev.new(noRStudioGD = T)
    xticks=0:(ssa$window.length-1)
    cor.x = cor(ssa$X)
    g1=ggplot2::qplot(xticks,cor.x[1,1:ssa$window.length],xlab='Lag', ylab='Frame Correlation')+
        ggplot2::geom_hline(yintercept = 0,lty='dashed',col='red')+
        ggplot2::scale_x_continuous(breaks=xticks)
    acf.x = acf(ssa$series, lag.max = ssa$window.length-1,plot = F)
    pacf.x = pacf(ssa$series, lag.max = ssa$window.length, plot = F)
    g2=ggplot2::qplot(xticks,c(acf.x$acf), ylab='Autocorrelation', xlab='Lag')+ggplot2::scale_x_continuous(breaks=xticks)
    g3=ggplot2::qplot(xticks,c(pacf.x$acf), ylab='Partial Autocorrelation',xlab='Lag')+
        ggplot2::geom_hline(yintercept = 0,lty='dashed',col='red')+
        ggplot2::scale_x_continuous(breaks=xticks)
    gridExtra::grid.arrange(g1,g2,g3,nrow=3,ncol=1)
}
