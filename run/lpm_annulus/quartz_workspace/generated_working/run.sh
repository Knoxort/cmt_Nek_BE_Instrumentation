#!/bin/bash
#MSUB -q pdebug
#MSUB -l nodes=0
#MSUB -l walltime=00:15:00
#MSUB -V
srun -n2 ./nek5000 uniform > log_quartz_core_2lx1_5lelt_4alpha_1.txt
