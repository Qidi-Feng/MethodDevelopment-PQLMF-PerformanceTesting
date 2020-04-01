#!/bin/bash

#SBATCH --time=24:00:00
#SBATCH --job-name=ICA
#SBATCH --mem=100G
#SBATCH --array=1-1%1
#SBATCH --partition=mulan,nomosix
#SBATCH --workdir=/net/mulan/home/qidif/scRNA_Method/Res_Summary/RealData_for_Clustering_res
#SBATCH --output=/net/mulan/home/qidif/scRNA_Method/Res_Summary/RealData_for_Clustering_res/test.out
#SBATCH --error=/net/mulan/home/qidif/scRNA_Method/Res_Summary/RealData_for_Clustering_res/test.err

bash
let i=0
for idata in 6; do
for im in 6; do
for irpt in 1; do
	let i=${i}+1
	if [ ${i} -eq ${SLURM_ARRAY_TASK_ID} ]; then
	Rscript /net/mulan/home/qidif/scRNA_Method/Res_Summary/DRComparison-master/mycode/60_run_drmethods_realData.r ${idata} ${im} ${irpt}
	fi
done
done
done

