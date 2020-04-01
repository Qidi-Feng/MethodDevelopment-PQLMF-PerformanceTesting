#!/bin/bash

#SBATCH --time=24:00:00
#SBATCH --job-name=DR-realdata-draw
#SBATCH --mem=5G
#SBATCH --array=1-17%17
#SBATCH --partition=mulan,nomosix
#SBATCH --output=/net/mulan/home/qidif/scRNA_Method/Res_Summary/RealData_for_Clustering_res/test.out
#SBATCH --error=/net/mulan/home/qidif/scRNA_Method/Res_Summary/RealData_for_Clustering_res/test.err

bash
let i=0
for ((idata=1; idata<=17; idata++)); do
for irpt in 1; do
	let i=${i}+1
	if [ ${i} -eq ${SLURM_ARRAY_TASK_ID} ]; then
	Rscript /net/mulan/home/qidif/scRNA_Method/Res_Summary/DRComparison-master/mycode/71_draw_drmethods_realdata_TopGenes.r ${idata} ${irpt}
	fi
done
done

