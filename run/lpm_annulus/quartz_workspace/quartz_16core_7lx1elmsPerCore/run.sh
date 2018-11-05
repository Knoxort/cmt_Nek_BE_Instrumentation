#!/bin/bash
#MSUB -l nodes=1
#MSUB -l walltime=00:15:00
#MSUB -V
srun -n16 ./nek5000 uniform > log_quartz_16core_7lx1elmsPerCore.txt
