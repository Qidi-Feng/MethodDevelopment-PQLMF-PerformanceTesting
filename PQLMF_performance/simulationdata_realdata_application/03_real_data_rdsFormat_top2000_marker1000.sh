#!/bin/bash
#SBATCH --time=24:00:00
#SBATCH --job-name=DataTransformation
#SBATCH --mem=10G

#SBATCH --array=1-17%17
#SBATCH --partition=mulan,nomosix
#SBATCH --workdir=/net/mulan/home/qidif/scRNA_Method/Res_Summary/RealData_for_Clustering
#SBATCH --output=/net/mulan/home/qidif/scRNA_Method/Res_Summary/RealData_for_Clustering/test.out
#SBATCH --error=/net/mulan/home/qidif/scRNA_Method/Res_Summary/RealData_for_Clustering/test.err

bash
let i=0
for ((idata=1; idata<=17; idata++)); do
	let i=${i}+1
	if [ ${i} -eq ${SLURM_ARRAY_TASK_ID} ]; then
	Rscript /net/mulan/home/qidif/scRNA_Method/Res_Summary/DRComparison-master/mycode/03_real_data_rdsFormat_top2000_marker1000.r ${idata}
	fi
done

