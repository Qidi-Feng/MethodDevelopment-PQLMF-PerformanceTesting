#!/bin/bash

#SBATCH --time=48:00:00
#SBATCH --job-name=DR_real_PQLMF
#SBATCH --mem=20G
#SBATCH --array=1-3%3
#SBATCH --partition=mulan,nomosix
#SBATCH --workdir=/net/mulan/home/qidif/scRNA_Method/Res_Summary/DRComparison-master/mycode/
#SBATCH --output=/net/mulan/home/qidif/scRNA_Method/Res_Summary/DRComparison-master/mycode/test.out
#SBATCH --error=/net/mulan/home/qidif/scRNA_Method/Res_Summary/DRComparison-master/mycode/test.err

bash
let i=0
for idata in 9 14 16; do
for imethod in 14; do
for irpt in 1; do
	let i=${i}+1
	if [ ${i} -eq ${SLURM_ARRAY_TASK_ID} ]; then
	Rscript /net/mulan/home/qidif/scRNA_Method/Res_Summary/DRComparison-master/mycode/62_run_drmethods_realData_TopGenes_1000Markers.r ${idata} ${imethod} ${irpt}
	fi
done
done
done

