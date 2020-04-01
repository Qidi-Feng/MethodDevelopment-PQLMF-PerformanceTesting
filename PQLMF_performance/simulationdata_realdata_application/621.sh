#!/bin/bash

#SBATCH --time=48:00:00
#SBATCH --job-name=DR_real
#SBATCH --mem=20G
#SBATCH --array=1-11%11
#SBATCH --partition=mulan,nomosix
#SBATCH --workdir=/net/mulan/home/qidif/scRNA_Method/Res_Summary/DRComparison-master/mycode/
#SBATCH --output=/net/mulan/home/qidif/scRNA_Method/Res_Summary/DRComparison-master/mycode/test.out
#SBATCH --error=/net/mulan/home/qidif/scRNA_Method/Res_Summary/DRComparison-master/mycode/test.err

bash
let i=0
for idata in 2 3 7 9 10 11 12 13 14 16 17; do
for imethod in 3; do
for irpt in 1; do
	let i=${i}+1
	if [ ${i} -eq ${SLURM_ARRAY_TASK_ID} ]; then
	Rscript /net/mulan/home/qidif/scRNA_Method/Res_Summary/DRComparison-master/mycode/62_run_drmethods_realData_TopGenes_1000Markers.r ${idata} ${imethod} ${irpt}
	fi
done
done
done

