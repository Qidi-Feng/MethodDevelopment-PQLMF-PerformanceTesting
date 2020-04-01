## run dimensionality reduction
## Modified by Qidi Feng
## Date: 2019-8-3 07:56:04

args <- as.numeric(commandArgs(TRUE))
idata <- args[1]
method_indx <- args[2]
irpt <- args[3]

## library packages
library(pryr) ## to count memory usage
library(SingleCellExperiment)
num_pc <- 10
METHODS <- c("FA", "PCA", "ZINBWaVE", "pCMF", "DiffusionMap", "ICA", "NMF", "PoissonNMF", "MDS", "LLE", "Isomap", "LTSA", "GLMPCA", "PQLMF")

imethod <- METHODS[method_indx]

data_path <- "~/scRNA_Method/Res_Summary/RealData_for_Clustering/"
method_path <- "~/scRNA_Method/Res_Summary/DRComparison-master/algorithms"
param_path <- "~/scRNA_Method/Res_Summary/DRComparison-master/parameter_settings"
res_path <- "~/scRNA_Method/Res_Summary/RealData_for_Clustering_res/"
## load data set

#if(!file.exists(paste0(res_path,"res.",idata,".nPC",num_pc,".rpt",irpt,".",imethod,".rds")) ){
sce <- readRDS(paste0(data_path,"data",idata,".top2000.marker1000.rds") )
total_counts <- counts(sce)
libsizes <- colSums(total_counts)
logcounts(sce) <- log10(t(t(total_counts)/libsizes)*1000000 + 1)
## source method
source(paste0(method_path,"/call_",imethod,".R") )
source(paste0(param_path,"/params_settings.R") )

params <- params_settings(imethod)

cat(paste0("run = ", irpt, "; data set: ",idata,"...\n"))
res_method <- get(paste0("call_",imethod))(sce=sce, num_pc=num_pc, params=params)
	
res <- list(dataset=idata, 
	method=imethod, 
	num_repeat=irpt, 
	res=res_method$res, 
	ctime=res_method$ctimes )
print(paste0("method", imethod))
## save results as RDS file
saveRDS(res, file=paste0(res_path,"res.",idata,".nPC",num_pc,".rpt",irpt,".",imethod,".top2000.marker1000.rds") )
#}# end fi
