#!/bin/bash
#MSUB -l nodes=1
#MSUB -l walltime=01:00:00
#MSUB -V
srun -n16 ./nek5000 uniform > log_quartz_16cores_7lx1_4elmsPerCore.txt
