## PQLMF
## 2019-11-25 21:08:49
## loading packages
suppressPackageStartupMessages({
library(SingleCellExperiment)
library(BiocParallel)
library(igraph)
library(Matrix)
library(adaptiveGPCA)
library(ggplot2)
library(phyloseq)

library(mvtnorm)
library(Rcpp)
sourceCpp("/net/mulan/disk2/qidif/PQLMF_Simulation/Code/PQLMF.cpp")
source("/net/mulan/disk2/qidif/PQLMF_Simulation/Code/PQLMF.R")
library(doParallel)
library(foreach)
})

# main function
call_PQLMF <- function(sce, num_pc, params){
	## other parameter in PCA method
	#num_clust <- params$num_clust
	filtering_method <- params$filtering_method
	norm_method <- params$norm_method
	## normalized counts
		norm_counts <- counts(sce)
	
	if(filtering_method=="nonzeros"){
		norm_counts <- norm_counts[which(rowSums(norm_counts>0)>5),]
		norm_counts <- norm_counts[, which(colSums(norm_counts>0)>10)]
	}# end fi
	
load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/simulation_count/10x_b_cell_1000cells.RData")
count <- as.matrix(count)
count <- count[rowSums(count)>0,]
total_counts_real <- apply(count,2,sum)
marker_counts <- altExp(sce, "marker_counts")
marker_counts <- assays(marker_counts)$marker_counts
reduced_counts <- norm_counts[-which(rownames(norm_counts) %in% rownames(marker_counts)),]
marker_counts <- marker_counts[rowSums(marker_counts)>0,colSums(marker_counts)>0]
marker_lcpm <- log10(t(t(marker_counts)/total_counts_real)*1000000+1)
marker_kinship <- as.matrix(cor(as.matrix(marker_lcpm), method = "pearson"))
reduced_counts <- reduced_counts[,colnames(marker_counts)]


	tryCatch({
		ct <- system.time({
		res_pqlmf <- pqlmf(as.matrix(reduced_counts),RelatednessMatrix=marker_kinship, numPC=num_pc, filtering=FALSE,numCore=10)
		res_pqlmf <- res_pqlmf$PCA$QV[, seq_len(num_pc), drop = FALSE]
		})	
		# count time
		ct <- c(user.self = ct[["user.self"]], sys.self = ct[["sys.self"]], 
            user.child = ct[["user.child"]], sys.child = ct[["sys.child"]],
            elapsed = ct[["elapsed"]])
		list(res = res_pqlmf, ctimes = ct)
	},
	error = function(e) {
    list(res = structure(rep(NA, 1), ctimes = c(user.self = NA, sys.self = NA, user.child = NA, sys.child = NA,
                elapsed = NA), name_col = colnames(sce)))
	})
}# end func
	
