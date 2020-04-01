args <- commandArgs(T)
SimCountData <- function(real_counts, m_sigmag_sq, nm_sigmag_sq, sigmae_sq, marker_number, nonmarker_number, prop){
	Nj <- apply(real_counts, 2, sum)
	Nmean <- mean(Nj)
	#creating Kinship matrix
	library(Matrix)
	K <- as.matrix(bdiag(matrix(rep(1, 100*100),100), matrix(rep(1, 300*300),300),matrix(rep(1,600*600),600)))
	I <- diag(1000)

	#creating lambda
	library(MASS)
	g_m <- mvrnorm(marker_number,rep(0,1000),m_sigmag_sq*K)
	g_nm <- mvrnorm(as.integer(nonmarker_number*prop),rep(0,1000),nm_sigmag_sq*K)
	g_nm_noinfo <- mvrnorm(as.integer(nonmarker_number-nonmarker_number*prop),rep(0,1000),0*K)

	e_m <- mvrnorm(marker_number,rep(0,1000),sigmae_sq*I)
	e_nm <- mvrnorm(as.integer(nonmarker_number*prop),rep(0,1000),sigmae_sq*I)
	e_nm_noinfo <- mvrnorm(as.integer(nonmarker_number-nonmarker_number*prop),rep(0,1000),sigmae_sq*I)
	
	mu = log(1/Nmean) #intercept, read count per gene per cell is 1; averaged total read count is 5000.

	lambda_m <- exp(mu + g_m + e_m)
	lambda_nm <- exp(mu + g_nm + e_nm)
	lambda_nm_noinfo <- exp(mu + g_nm_noinfo + e_nm_noinfo)

	#producing real count
	y_m <- matrix(NA,marker_number,1000)
	y_nm <- matrix(NA,nonmarker_number*prop,1000)
	y_nm_noinfo <- matrix(NA,nonmarker_number-nonmarker_number*prop,1000)
	for (i in 1:marker_number){
		for (j in 1:1000){
			y_m[i,j] <- rpois(1, Nj[j]*lambda_m[i,j])
		}
	}
	for (i in 1:nonmarker_number*prop){
		for (j in 1:1000){
			y_nm[i,j] <- rpois(1, Nj[j]*lambda_nm[i,j])
		}
	}
	for (i in 1:(nonmarker_number-nonmarker_number*prop)){
		for (j in 1:1000){
			y_nm_noinfo[i,j] <- rpois(1, Nj[j]*lambda_nm_noinfo[i,j])
		}
	}
	
	simcounts <- rbind(y_m, y_nm, y_nm_noinfo)
	simcounts[is.na(simcounts)] <- as.numeric(0)
	rownames(simcounts) <- 1:nrow(simcounts)
	colnames(simcounts) <- 1:ncol(simcounts)
	return(simcounts)
} # end func
args <- commandArgs(T)

load("/net/mulan/home/qidif/scRNA_Method/Res_Summary/simulation_count/10x_b_cell_1000cells.RData")
count <- as.matrix(count)
itime <- args[1]
m_sigmag_sq <- args[2]
nm_sigmag_sq <- args[3]
sigmae_sq <- args[4]
marker_number <- as.numeric(args[5])
nonmarker_number <- 5000 - as.numeric(marker_number)
prop <- as.numeric(args[6])
marker_start <- as.numeric(args[7])

simcount <- SimCountData(real_counts=count, m_sigmag_sq=as.numeric(m_sigmag_sq), nm_sigmag_sq=as.numeric(nm_sigmag_sq), sigmae_sq=as.numeric(sigmae_sq), marker_number=as.numeric(marker_number), nonmarker_number=as.numeric(nonmarker_number), prop=prop)
library(SingleCellExperiment)
sce <- SingleCellExperiment(assays = list(counts = simcount))
marker <- marker_start:as.numeric(marker_start+marker_number)
marker_counts <- simcount[which(rownames(simcount) %in% marker),]
marker_counts <- SummarizedExperiment(assays=list(marker_counts=marker_counts))
altExp(sce, "marker_counts") <- marker_counts
saveRDS(sce, file=paste0("/net/mulan/home/qidif/scRNA_Method/Res_Summary/simulation_count/time",itime,".m_sigmag_sq",m_sigmag_sq,".nm_sigmag_sq",nm_sigmag_sq, ".sigmae_sq", sigmae_sq,".marker_number",marker_number,".marker_start",marker_start,".prop",prop,".mu1.simu.rds"))
