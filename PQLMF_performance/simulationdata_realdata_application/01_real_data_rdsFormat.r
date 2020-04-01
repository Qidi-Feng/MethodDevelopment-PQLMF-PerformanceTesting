args<-commandArgs(T)
idata <- args[1]
if(idata==1){
	#load first dataset, Pollen
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/Pollen_et_al_marker/Pollen_count.RData")
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/Pollen_et_al_marker/Pollen_marker.RData")
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/Pollen_et_al_marker/Pollen_celltype.RData")
}else if(idata==2){
	#load second data set, Chu from NCBI
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/Chu_et_al_marker/Count_NCBI/Chu_count.RData")
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/Chu_et_al_marker/Count_NCBI/Chu_marker.RData")
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/Chu_et_al_marker/Count_NCBI/Chu_celltype.RData")
}else if(idata==3){
	#load third data set, Chu called by featureCount
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/Chu_et_al_marker/Count_callmyself/Chu_count.RData")
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/Chu_et_al_marker/Count_callmyself/Chu_marker.RData")
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/Chu_et_al_marker/Count_callmyself/Chu_celltype.RData")
}else if(idata==4){
	#load forth data set, Darmanis_et_al_marker
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/Darmanis_et_al_marker/Darmanis.count.RData")
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/Darmanis_et_al_marker/Darmanis.marker.RData")
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/Darmanis_et_al_marker/Darmanis.cell_type.RData")
}else if(idata==5){
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/Kim_et_al_lincRNA/Kim.count.RData")
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/Kim_et_al_lincRNA/Kim.marker.RData")
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/Kim_et_al_lincRNA/Kim.cell_type.RData")
}else if(idata==6){
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/Li_et_al_marker/Li.count.RData")
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/Li_et_al_marker/Li.marker.RData")
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/Li_et_al_marker/Li.cell_type.RData")
}else if(idata==7){
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/Zeisel_et_al_marker/Zeisel.count.RData")
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/Zeisel_et_al_marker/Zeisel.marker.RData")
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/Zeisel_et_al_marker/Zeisel.cell_type.RData")
}else if(idata==8){
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/Igor_et_al_marker/Igor_et_al_count.RData")
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/Igor_et_al_marker/Igor_et_al_marker.RData")
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/Igor_et_al_marker/Igor_et_al_cell_type.RData")
}else if(idata==9){
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/Sten_et_al_DatasetA_marker/Sten_et_al_DatasetA_count.RData")
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/Sten_et_al_DatasetA_marker/Sten_et_al_DatasetA_marker.RData")
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/Sten_et_al_DatasetA_marker/Sten_et_al_DatasetA_cell_type.RData")
}else if(idata==10){
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/Sten_et_al_DatasetB_marker/Sten_et_al_DatasetB_count.RData")
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/Sten_et_al_DatasetB_marker/Sten_et_al_DatasetB_marker.RData")
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/Sten_et_al_DatasetB_marker/Sten_et_al_DatasetB_cell_type.RData")
}else if(idata==11){
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/StenA_StenB/StenA_B_count.RData")
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/StenA_StenB/StenA_B_cell_type.combineNB1NB2.RData")
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/StenA_StenB/StenA_B_marker.RData")
}else if(idata==13){
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/StenA_StenB_2/StenA_B_count.RData")
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/StenA_StenB_2/StenA_B_cell_type.RData")
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/StenA_StenB_2/StenA_B_marker.RData")
}else if(idata==14){
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/Zheng_et_al_PBMCcellranger3.0/mixture.cell_type.RData")
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/Zheng_et_al_PBMCcellranger3.0/mixture.count.RData")
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/Zheng_et_al_PBMCcellranger3.0/mixture.marker.RData")
}else if(idata==15){
	load("/net/mulan/home/qidif/scRNA_Method/Data_Download/scRNA_PQLMF_datasets/GSE71858/Ramanathan_et_al.count.RData")
	load("/net/mulan/home/qidif/scRNA_Method/Data_Download/scRNA_PQLMF_datasets/GSE71858/Ramanathan_et_al.cell_type.RData")
	load("/net/mulan/home/qidif/scRNA_Method/Data_Download/scRNA_PQLMF_datasets/GSE71858/Ramanathan_et_al.marker.RData")
}else if(idata==16){
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/full_Zhengmix4uneq/sce_full_Zhengmix4uneq.count.RData")
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/full_Zhengmix4uneq/sce_full_Zhengmix4uneq.marker.RData")
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/full_Zhengmix4uneq/sce_full_Zhengmix4uneq.celltype.RData")
}else if(idata==17){
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/full_PBMC3k1/sce_full_PBMC3k1.count.RData")
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/full_PBMC3k1/sce_full_PBMC3k1.marker.RData")
	load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/full_PBMC3k1/sce_full_PBMC3k1.celltype.RData")
}
library(SingleCellExperiment)
count <- as.matrix(count)
sce <- SingleCellExperiment(assays = list(counts = count))
marker_counts <- count[which(rownames(count) %in% marker),]
marker_counts <- SummarizedExperiment(assays=list(marker_counts=marker_counts))
altExp(sce, "marker_counts") <- marker_counts
saveRDS(sce, file=paste0("/net/mulan/home/qidif/scRNA_Method/Res_Summary/RealData_for_Clustering/data",idata,".rds"))
