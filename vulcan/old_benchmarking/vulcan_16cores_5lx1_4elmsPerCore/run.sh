#!/bin/bash
#MSUB -l nodes=1
#MSUB -l walltime=01:00:00
#MSUB -V
srun -n16 ./nek5000 uniform > log_vulcan_16cores_5lx1_4elmsPerCore.txt
