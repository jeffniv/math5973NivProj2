#' Reconstruct a series from an \code{ssa} object
#'
#' Projects the series onto chosen principal components, and performs skew-diagonal averaging on projected data.
#'
#' @param ssa object created from \code{ssa()} function.
#' @param pcs a vector of integers specifying the projection bases of principal components.
#' @param pct.var (optional) a number in (0.0,1.0] specifying the desired reconstruction accuracy.
#' @param inplace \code{logical} indicating whether the reconstructed series should modify the \code{ssa} object. \code{FALSE} returns the reconstructed series.
#' @param plot \code{logical} \code{TRUE} generates a plot of the reconstructed series with residuals for comparison.
#'
#' @return if \code{inplace=FALSE}, returns a list of the reconstructed trajectory matrix and series.
#'
#' @export
#' @import ggplot2
#' @import gridExtra
#' @import ggExtra
#'
#' @examples
#' obj=ssa(co2,18)
#' reconstruct(obj,1:5,plot=T)


reconstruct <- function(ssa, pcs=c(1,2), pct.var=NULL, inplace=T, plot=T){
    if(!is.element('ssa',class(ssa))){
        stop('Not an object of class "ssa"')
    }
    selector = diag(ssa$X.svd$d)
    if(!is.null(pct.var)){
        gtpctvar = which(ssa$pct.var$cumulative >= pct.var)
        diag(selector)[gtpctvar[2:length(gtpctvar)]] = 0 #unselect with zeros
        pcs=(diag(selector)!=0)
    }else{
        diag(selector)[-pcs] = 0 #unselect with zeros
    }
    recon=ssa$X.svd$u%*%selector%*%t(ssa$X.svd$v) #project onto selected pcs
    flat=hankelize(recon) #diagonal averaging;"Russian method"
    residual=ssa$series-flat
    if(plot){
        xticks=1:ssa$series.length
        if(is.element(1,pcs) | !is.null(pct.var)){
            suppressMessages({
            g1=qplot(xticks,ssa$series, geom='line',aes(color='black'))+geom_line(aes(y=flat,color='blue'))+
                scale_color_manual(name=NULL,values=c('black','blue'),labels=c('orig.','recon.'))+
                labs(x='time',y='series',title=paste('# of PCs =', sum(pcs),', recon. error=', round((1-sum(ssa$pct.var$total[pcs]))*100,4) ,'%'))
            })
        }else{
            suppressMessages({
                g1=qplot(xticks, flat, geom='line',aes(color='blue'))+theme(legend.position = 'none')+
                    labs(x='time',y='series',title=paste('# of PCs =', length(pcs),', recon. error=', round((1-sum(ssa$pct.var$total[pcs]))*100,4) ,'%'))
            })
        }
        suppressMessages({
            g2=qplot(xticks,residual,geom='line',color='red')+labs(x='time',y='residual')+theme(legend.position = 'none')+geom_point(alpha=0)
            g2=ggExtra::ggMarginal(g2,margins = 'y',type = 'densigram',size=11)
        })
        dev.new(noRStudioGD = T)
        suppressMessages({gridExtra::grid.arrange(g1,g2,ncol=1,heights=c(7,4))
        })
    }
    if(inplace){
        eval.parent(substitute(ssa[['X.recon']]<-recon))
        eval.parent(substitute(ssa[['series.recon']]<-flat))
        eval.parent(substitute(ssa[['resid.recon']]<-residual))
    }else{
        return(list(X.recon=recon, series.recon=flat, resid.recon=residual))
    }
}
