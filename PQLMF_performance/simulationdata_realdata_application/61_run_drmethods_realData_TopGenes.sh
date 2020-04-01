#!/bin/bash

#SBATCH --time=48:00:00
#SBATCH --job-name=DR_real
#SBATCH --mem=10G
#SBATCH --array=1-13%13
#SBATCH --partition=mulan,nomosix
#SBATCH --workdir=/net/mulan/home/qidif/scRNA_Method/Res_Summary/RealData_for_Clustering_res
#SBATCH --output=/net/mulan/home/qidif/scRNA_Method/Res_Summary/RealData_for_Clustering_res/test.out
#SBATCH --error=/net/mulan/home/qidif/scRNA_Method/Res_Summary/RealData_for_Clustering_res/test.err

bash
let i=0
for idata in 9; do
for ((imethod=1; imethod<=13; imethod++)); do
for irpt in 1; do
	let i=${i}+1
	if [ ${i} -eq ${SLURM_ARRAY_TASK_ID} ]; then
	Rscript /net/mulan/home/qidif/scRNA_Method/Res_Summary/DRComparison-master/mycode/61_run_drmethods_realData_TopGenes.r ${idata} ${imethod} ${irpt}
	fi
done
done
done

