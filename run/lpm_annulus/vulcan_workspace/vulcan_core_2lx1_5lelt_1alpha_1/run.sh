#!/bin/bash
#MSUB -q pdebug
#MSUB -l nodes=1
#MSUB -l walltime=00:30:00
#MSUB -V
srun -n2 ./nek5000 part_swept > log_vulcan_core_2lx1_5lelt_1alpha_1.txt
