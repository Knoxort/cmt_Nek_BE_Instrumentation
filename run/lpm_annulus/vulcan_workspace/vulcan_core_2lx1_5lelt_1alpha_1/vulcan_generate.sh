#!/bin/bash
chmod 777 makenek
vulcan_makenek clean
vulcan_makenek uniform
	#This really needs to be a case by case variable name

FILE="nek5000"

if [ -f "$FILE" ];
then


	echo uniform > SESSION.NAME
	echo `pwd`'/' >> SESSION.NAME
	mkdir profiles
	echo "#!/bin/bash" > run.sh
	if [ $1 -gt 16384 ]
	then
	  echo "#MSUB -q pbatch" >> run.sh
	else
	  echo "#MSUB -q pdebug" >> run.sh
	fi
	var=$(expr "$1" / 16)
	echo "#MSUB -l nodes=$var" >> run.sh
	echo "#MSUB -l walltime=00:30:00" >> run.sh
		#Change this walltime measure, perhaps
	echo "#MSUB -V" >> run.sh
	echo "srun -n$1 ./nek5000 part_swept > log_${PWD##*/}.txt" >> run.sh
		#I don't put the case as an cla to nek5000; necessarY?
	chmod 777 run.sh
	echo "Batch successfully generated"

	sbatch run.sh 
	#msub run.sh $1

else
	echo " $PWD : Compilation error!! Most probably due to lack of memory!! Try with a smaller problem size"
fi
