args<-commandArgs(T)
library(igraph)
library(Matrix)
library(adaptiveGPCA)
library(ggplot2)
library(phyloseq)
library(mvtnorm)
library(Rcpp)
library(doParallel)
library(foreach)
idata <- args[1]
irpt <- args[2]
if(idata==1){
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/Pollen_et_al_marker/Pollen_celltype.RData")
}else if(idata==2){
	#load second data set, Chu from NCBI
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/Chu_et_al_marker/Count_NCBI/Chu_celltype.RData")
}else if(idata==3){
	#load third data set, Chu called by featureCount
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/Chu_et_al_marker/Count_callmyself/Chu_celltype.RData")
}else if(idata==4){
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/Darmanis_et_al_marker/Darmanis.cell_type.RData")
}else if(idata==5){
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/Kim_et_al_lincRNA/Kim.cell_type.RData")
}else if(idata==6){
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/Li_et_al_marker/Li.cell_type.RData")
}else if(idata==7){
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/Zeisel_et_al_marker/Zeisel.cell_type.RData")
}else if(idata==8){
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/Igor_et_al_marker/Igor_et_al_cell_type.RData")
}else if(idata==9){
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/Sten_et_al_DatasetA_marker/Sten_et_al_DatasetA_cell_type.RData")
}else if(idata==10){
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/Sten_et_al_DatasetB_marker/Sten_et_al_DatasetB_cell_type.RData")
}else if(idata==11){
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/StenA_StenB/StenA_B_cell_type.combineNB1NB2.RData")
}else if(idata==13){
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/StenA_StenB_2/StenA_B_cell_type.RData")
}else if(idata==14){
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/Zheng_et_al_PBMCcellranger3.0/mixture.cell_type.RData")
}else if(idata==15){
	load("/net/mulan/home/qidif/scRNA_Method/Data_Download/scRNA_PQLMF_datasets/GSE71858/Ramanathan_et_al.cell_type.RData")
}else if(idata==16){
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/full_Zhengmix4uneq/sce_full_Zhengmix4uneq.celltype.RData")
}else if(idata==17){
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/full_PBMC3k1/sce_full_PBMC3k1.celltype.RData")
}
k <- length(unique(cell_type))
figure_path="/net/mulan/home/qidif/scRNA_Method/Res_Summary/RealData_for_Clustering_res/"

total_value <- c()
total_compare <- c()
total_method <- c()
res_path <- "~/scRNA_Method/Res_Summary/RealData_for_Clustering_res/"
source("~/scRNA_Method/Res_Summary/DRComparison-master/algorithms/ExtractW.R")
	tryCatch({
for (method_indx in seq(1,10)){
#METHODS <- c("FA", "PCA", "NMF", "PoissonNMF", "MDS", "LLE", "LTSA", "PQLMF")
METHODS <- c("FA", "PCA", "ZINBWaVE", "pCMF", "NMF", "PoissonNMF", "MDS", "LLE", "LTSA", "PQLMF")
#METHODS <- c("FA", "PCA", "DiffusionMap", "ICA", "NMF", "PoissonNMF", "MDS", "LLE", "Isomap", "LTSA", "PQLMF")
imethod <- METHODS[method_indx]
print(imethod)
num_pc <- 10
	file <- paste0(res_path,"res.",idata,".nPC",num_pc,".rpt",irpt,".",imethod,".rds")
	if(file.exists(file)){
	res <- readRDS(file)
		W <- ExtractW(res, imethod)
		res_clust <- kmeans(W, k, nstart=10000, iter.max=100000000)
		total_value <- c(total_value, compare(as.numeric(as.factor(cell_type)), res_clust$cluster, method="nmi"))
		total_value <- c(total_value, compare(as.numeric(as.factor(cell_type)), res_clust$cluster, method="adjusted.rand"))
		total_compare <- c(total_compare, "nmi", "adjusted.rand")
		total_method <- c(total_method, imethod, imethod)
	}
	}
	}, error=function(e){cat("ERROR :",conditionMessage(e), "\n")})

data <- data.frame(VALUE=as.numeric(total_value), COMPARE=total_compare, METHOD=total_method)
save(data, file=paste0(figure_path, "res.",idata,".nPC",num_pc,".rpt",irpt,".allDRmethods.RData"))
library(ggplot2)
pngfile=paste0(figure_path,"res.",idata,".nPC",num_pc,".rpt",irpt,".allDRmethods.png")

png(pngfile)
ggplot(data=data, aes(x=METHOD, y=VALUE, fill=COMPARE)) + geom_bar(stat="identity", position=position_dodge()) + coord_flip() +scale_fill_manual( values=c("lightcoral", "lightblue"))
dev.off()
