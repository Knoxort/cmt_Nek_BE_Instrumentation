#!/bin/bash
#MSUB -q pdebug
#MSUB -l nodes=1
#MSUB -l walltime=00:15:00
#MSUB -V
srun -n16 ./nek5000 part_swept > log_quartz_core_16lx1_25lelt_160alpha_100.txt
