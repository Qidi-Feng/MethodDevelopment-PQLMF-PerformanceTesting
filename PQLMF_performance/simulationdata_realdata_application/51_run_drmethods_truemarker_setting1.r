## run dimensionality reduction
## Modified by Qidi Feng
## Date: 2019-11-19 15:13

args <- as.numeric(commandArgs(TRUE))
simu_time <- args[1]
marker_number <- args[2]
set_marker_number <- args[3]
method_indx <- args[4]
irpt <- args[5]

## library packages
library(pryr) ## to count memory usage
library(SingleCellExperiment)
num_pc <- 10
METHODS <- c("FA", "PCA", "ZINBWaVE", "pCMF", "DiffusionMap", "ICA", "NMF", "PoissonNMF", "MDS", "LLE", "Isomap", "LTSA", "GLMPCA", "PQLMF")

idata <- paste0("time",simu_time,".m_sigmag_sq0.1.nm_sigmag_sq0.001.sigmae_sq0.1.marker_number",marker_number,".set_marker_number",set_marker_number,".prop0.2.mu1.simu.rds")
imethod <- METHODS[method_indx]

data_path <- "~/scRNA_Method/Res_Summary/simulation_count/"
method_path <- "~/scRNA_Method/Res_Summary/DRComparison-master/algorithms"
param_path <- "~/scRNA_Method/Res_Summary/DRComparison-master/parameter_settings"
res_path <- "~/scRNA_Method/Res_Summary/simulation_multimethods/"
## load data set

if(!file.exists(paste0(res_path,"res.",idata,".nPC",num_pc,".rpt",irpt,".",imethod,".rds")) ){
sce <- readRDS(paste0(data_path,idata) )
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

## save results as RDS file
saveRDS(res, file=paste0(res_path,"res.",idata,".nPC",num_pc,".rpt",irpt,".",imethod,".rds") )
}# end fi
