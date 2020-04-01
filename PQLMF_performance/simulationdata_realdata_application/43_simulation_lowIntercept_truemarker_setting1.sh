#!/bin/bash
#SBATCH --time=24:00:00
#SBATCH --job-name=simulation
#SBATCH --mem=10M

#SBATCH --array=1-40%40
#SBATCH --partition=mulan,nomosix
#SBATCH --workdir=/net/mulan/home/qidif/scRNA_Method/Res_Summary/simulation_count
#SBATCH --output=/net/mulan/home/qidif/scRNA_Method/Res_Summary/simulation_count/test.out
#SBATCH --error=/net/mulan/home/qidif/scRNA_Method/Res_Summary/simulation_count/test.err

bash
let i=0
for ((time=1; time<=10; time++)); do
for m_sigmag_sq in 0.1; do
for nm_sigmag_sq in 0.001; do
for sigmae_sq in 0.1; do
for prop in 0.2; do
for marker_number in 150; do
for set_marker_number in 150 200 300 600; do
	let i=${i}+1
	if [ ${i} -eq ${SLURM_ARRAY_TASK_ID} ]; then
	Rscript /net/mulan/home/qidif/scRNA_Method/Res_Summary/DRComparison-master/mycode/43_simulation_lowIntercept_truemarker_setting1.r ${time} ${m_sigmag_sq} ${nm_sigmag_sq} ${sigmae_sq} ${marker_number} ${prop} ${set_marker_number}
	fi
done
done
done
done
done
done
done

