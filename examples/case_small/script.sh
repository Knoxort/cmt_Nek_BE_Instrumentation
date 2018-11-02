#!/bin/sh

#MSUB -q psmall
#MSUB -l nodes=1
#MSUB -l partition=vulcan
#MSUB -l walltime=3:00:00
#MSUB -V
#MSUB -l gres=lscratchv

rm -f partxyz*
rm -f partdata*
rm -f blast2d0.f*
echo sod3 > SESSION.NAME
echo `pwd`'/' >> SESSION.NAME
srun -N 1 -n 16 ./nek5000 > output.txt.10.21-2.18
