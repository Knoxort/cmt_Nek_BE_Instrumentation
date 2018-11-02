#!/bin/bash
#MSUB -q pdebug
#MSUB -l nodes=1
#MSUB -l walltime=00:30:00
#MSUB -V
srun -n 2 ./nek5000 part_swept > log_my_workspace.txt
