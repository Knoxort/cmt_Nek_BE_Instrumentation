#!/bin/bash
#MSUB -q pdebug
#MSUB -l nodes=1
#MSUB -l walltime=00:15:00
#MSUB -V
srun -n2 ./nek5000 part_swept > curr_logfile
