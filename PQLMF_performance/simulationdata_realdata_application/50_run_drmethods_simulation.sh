#!/bin/bash

#SBATCH --time=24:00:00
#SBATCH --job-name=simulation
#SBATCH --mem=500M
#SBATCH --array=1-980%400
#SBATCH --partition=mulan,nomosix
#SBATCH --workdir=/net/mulan/home/qidif/scRNA_Method/Res_Summary/simulation_multimethods
#SBATCH --output=/net/mulan/home/qidif/scRNA_Method/Res_Summary/simulation_multimethods/test.out
#SBATCH --error=/net/mulan/home/qidif/scRNA_Method/Res_Summary/simulation_multimethods/test.err

bash
let i=0
for ((simu_time=1; simu_time<=10; simu_time++)); do
for marker_number in 100 125 150 175 200 250 300; do
for ((im=1; im<=14; im++)); do
for irpt in 1; do
	let i=${i}+1
	if [ ${i} -eq ${SLURM_ARRAY_TASK_ID} ]; then
	Rscript /net/mulan/home/qidif/scRNA_Method/Res_Summary/DRComparison-master/reproducibility/run_drmethods.R ${simu_time} ${marker_number} ${im} ${irpt}
	fi
done
done
done
done

