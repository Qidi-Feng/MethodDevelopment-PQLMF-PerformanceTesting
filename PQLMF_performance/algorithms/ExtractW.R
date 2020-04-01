
suppressPackageStartupMessages({
  library(pCMF)
  library(SingleCellExperiment)
  library(BiocParallel)
  library(matrixStats)
})
ExtractW <- function(res, method){
  if(method %in% c("ZIFA","scScope","DCA","umap","scvis")){
    W = res
  }else if (method == "FA"){
    W = res$res$loadings[, 1:ncol(res$res$loadings)]
  }else if(method %in% c("PCA", "MDS","DiffusionMap","tSNE","PQLMF")){
    W = res$res
  }else if(method == "pCMF"){
    W = res$res$factor$U
  }else if(method == "SIMLR"){
    eigs = eigen(res$res$S)
    W = eigs$vectors
  }else if(method == "ZINBWaVE"){
    W = reducedDim(res$res)
  }else if (method == "ICA"){
    W = res$res$ica_comp
  }else if (method %in% c("NMF", "nNMF", "PoissonNMF")){
    W = res$res$W
  }else if (method %in% c("GLMPCA")){
    W = res$res$factors
  }else if (method %in% c("Isomap", "LLE", "LTSA")){
    W = res$res$Y
  }# end func
  return(W)
}
# main function
