#!/bin/bash

#SBATCH --time=24:00:00
#SBATCH --job-name=Draw_simulation
#SBATCH --mem=5G
#SBATCH --array=1-9%9
#SBATCH --partition=mulan,nomosix
#SBATCH --output=/net/mulan/home/qidif/scRNA_Method/Res_Summary/simulation_figures/test.out
#SBATCH --error=/net/mulan/home/qidif/scRNA_Method/Res_Summary/simulation_figures/test.err

bash
let i=0
for marker_number in 100 125 150 175 200 250 300 400 500; do
	let i=${i}+1
	if [ ${i} -eq ${SLURM_ARRAY_TASK_ID} ]; then
	Rscript /net/mulan/home/qidif/scRNA_Method/Res_Summary/DRComparison-master/mycode/74_draw_drmethods_simulation.r ${marker_number}
	fi
done

