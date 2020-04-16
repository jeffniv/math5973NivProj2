#' Plot combined eigenvectors
#'
#' A useful technique in Singular Spectrum Analysis is to look at the summed groupings
#' of eigenvectors. These groupings can usually reveal the interframe signal.
#'
#' @param ssa an `ssa` class object
#' @param pcs a vector specifying which eigenvectors to group
#'
#' @details Oscillating patterns that are close in eigenvalue magnitude usually represent a signal component that cannot be represented by a single sinusoid.
#'
#' @return None
#' @export
#'
#' @examples
#' obj=ssa(co2,18)
#' combinepatterns(obj,2:3)

combinepatterns=function(ssa, pcs){
    if(!is.element('ssa',class(ssa))){
        stop('Not an object of class "ssa"')
    }
    xticks=1:ssa$window.length
    if((length(pcs)<2) & is.numeric(pcs)){
        pattern=ssa$X.svd$u[,pcs]
    }else{
        pattern=apply(ssa$X.svd$u[,pcs],1,sum)
    }
    print(pattern)
    g1=qplot(x=xticks, y=pattern, geom='line')+theme(legend.position = 'none')+
        labs(x='time (in window)',y='series',title=paste('PCs =[', Reduce(paste,pcs),'], recon. error=', round((1-sum(ssa$pct.var$total[pcs]))*100,4) ,'%'))
    dev.new(noRStudioGD = TRUE)
    print(g1)
}
