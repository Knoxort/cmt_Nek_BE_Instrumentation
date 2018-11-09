#!/bin/bash

#uniform vs part_swept

#This really needs to be a case by case variable name

#/g/g19/trokon/workspace/tst_2018_nek5000_lpm_benchmarking_repo/vulcan/bin/makenek clean
/g/g19/trokon/workspace/tst_2018_nek5000_lpm_benchmarking_repo/vulcan/bin/makenek uniform

FILE="nek5000"

if [ -f "$FILE" ];
then
	echo uniform > SESSION.NAME
	echo `pwd`'/' >> SESSION.NAME
	echo "#!/bin/bash" > run.sh
	echo "#MSUB -l nodes=1" >> run.sh			#For TST18, only 1 node/16 cores for quartz
	echo "#MSUB -l walltime=01:00:00" >> run.sh		#Eventually 12hrs when all working
		#Change this walltime measure, perhaps
	echo "#MSUB -V" >> run.sh
	echo "srun -n$1 ./nek5000 uniform > log_${PWD##*/}.txt" >> run.sh
	chmod 777 run.sh
	echo "Batch successfully generated"

	sbatch run.sh $1

else
	echo " $PWD : Compilation error!! Most probably due to lack of memory!! Try with a smaller problem size"
fi
