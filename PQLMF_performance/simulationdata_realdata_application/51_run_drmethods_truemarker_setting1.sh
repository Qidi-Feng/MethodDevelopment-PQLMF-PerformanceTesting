#!/bin/bash

#SBATCH --time=24:00:00
#SBATCH --job-name=simulation
#SBATCH --mem=500M
#SBATCH --array=1-40%40
#SBATCH --partition=mulan,nomosix
#SBATCH --workdir=/net/mulan/home/qidif/scRNA_Method/Res_Summary/simulation_multimethods
#SBATCH --output=/net/mulan/home/qidif/scRNA_Method/Res_Summary/simulation_multimethods/test.out
#SBATCH --error=/net/mulan/home/qidif/scRNA_Method/Res_Summary/simulation_multimethods/test.err

bash
let i=0
for ((simu_time=1; simu_time<=10; simu_time++)); do
for marker_number in 150; do
for set_marker_number in 150 200 300 600; do
for im in 14; do
for irpt in 1; do
	let i=${i}+1
	if [ ${i} -eq ${SLURM_ARRAY_TASK_ID} ]; then
	Rscript /net/mulan/home/qidif/scRNA_Method/Res_Summary/DRComparison-master/mycode/run_drmethods_truemarker_setting1.R ${simu_time} ${marker_number} ${set_marker_number} ${im} ${irpt}
	fi
done
done
done
done
done

