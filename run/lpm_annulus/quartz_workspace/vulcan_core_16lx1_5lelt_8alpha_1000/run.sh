#!/bin/bash
#MSUB -q psmall
#MSUB -l nodes=1
#MSUB -l walltime=00:30:00
#MSUB -V
srun -n2 ./nek5000 part_swept > log_vulcan_core_16lx1_5lelt_8alpha_1000.txt
