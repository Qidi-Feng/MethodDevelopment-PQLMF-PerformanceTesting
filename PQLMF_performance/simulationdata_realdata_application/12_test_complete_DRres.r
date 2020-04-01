args <- as.numeric(commandArgs(TRUE))
irpt <- as.numeric(1)

## library packages
library(pryr) ## to count memory usage
library(SingleCellExperiment)
num_pc <- 10
res_path <- "~/scRNA_Method/Res_Summary/RealData_for_Clustering_res/"
	tryCatch({
for (method_indx in seq(1,13)){
	for (idata in seq(1,17)){
METHODS <- c("FA", "PCA", "ZINBWaVE", "pCMF", "DiffusionMap", "ICA", "NMF", "PoissonNMF", "MDS", "LLE", "Isomap", "LTSA", "PQLMF")
imethod <- METHODS[as.numeric(method_indx)]
	file <- paste0(res_path,"res.",idata,".nPC",num_pc,".rpt",irpt,".",imethod,".top2000.marker1000.rds")
	if(!file.exists(file)){
		print(paste0(imethod, ",data", idata))
	}else{
	res <- readRDS(file)
	if(is.null(res$ctime)){
		print(paste0(imethod, ",data", idata))
	}
	}
	}
	}
	}, error=function(e){cat("ERROR :",conditionMessage(e), "\n")})

