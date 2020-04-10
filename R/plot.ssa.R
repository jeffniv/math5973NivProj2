#' Singular Spectrum Analysis
#'
#' A \code{ssa} class object to perform a singular spectrum analysis.
#'
#' @param ssa an object of class \code{ssa}
#' @param pcs a vector of integers specifying which principal components to plot
#'
#' @return None
#' @export
#'

plot.ssa=function(ssa,pcs=1:4){
    xticks=1:ssa$series.length
    while(length(pcs)>4){
        select=1:5
        g1=lapply(pcs[select],function(i) ggplot2::qplot(x=xticks, y=reconstruct(ssa,c(i),inplace=F,plot=F)$series.recon,geom='line')+
                      ggplot2::labs(x='time', y=paste('PC',i))+ggplot2::geom_point(alpha=0))
        g1=lapply(g1,function(g) ggExtra::ggMarginal(g,margins = 'y',type = 'densigram',size = 11))
        dev.new(noRStudioGD = T)
        gridExtra::grid.arrange(grobs = g1, ncol=1)
        pcs=pcs[-select]
    }
    g1=lapply(pcs,function(i) ggplot2::qplot(x=xticks, y=reconstruct(ssa,c(i),inplace=F,plot=F)$series.recon,geom='line')+
                 ggplot2::labs(x='time', y=paste('PC',i))+ggplot2::geom_point(alpha=0))
    g1=lapply(g1,function(g) ggExtra::ggMarginal(g,margins = 'y',type = 'densigram',size = 11))
    g1=gridExtra::arrangeGrob(grobs = g1, ncol=1,nrow=length(pcs))
    g2=ggplot2::qplot(1:ssa$window.length, ssa$X.svd$d, geom='line', log='y')+
                 ggplot2::labs(x='PC', y='log(eigenvalue)')+ggplot2::geom_point()+ggplot2::geom_col(alpha=0.3)
    dev.new(noRStudioGD = T)
    gridExtra::grid.arrange(g1,g2, ncol=1, heights=c(3,1))
}
