#!/bin/bash
#MSUB -q pdebug
#MSUB -l nodes=
#MSUB -l walltime=00:15:00
#MSUB -V
srun -n16 ./nek5000 part_swept > log_quartz_workspace.txt
