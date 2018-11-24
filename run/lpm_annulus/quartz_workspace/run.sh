#!/bin/bash
#MSUB -q pdebug
<<<<<<< HEAD
#MSUB -l nodes=1
#MSUB -l walltime=00:30:00
#MSUB -V
srun -n 2 ./nek5000 part_swept > log_my_workspace.txt
=======
#MSUB -l nodes=
#MSUB -l walltime=00:15:00
#MSUB -V
srun -n ./nek5000 part_swept > log_quartz_workspace.txt
>>>>>>> 1c1ee39022ac7d43de28a1912841d88b488d74d7
