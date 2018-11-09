#!/bin/bash

#Static Parameters
machineName="quartz"
alphapercore="1"		#Where does this affect? Does it need to be removed?
root=`pwd`

#Varying Parameters
lx1List="7" # 7 9"			#Element Size?
elmsPerCoreList="4" # 16 32"		#Elements per core?
partsPerCoreList="10" # 20 30"		#Particles per Processor
numCoreList="16" # 8 16"

nekDir=`pwd`
cd $machineName 		#Absolute path or relative path? In general?
machDataDir=`pwd`/data
cd run

for numCore in $numCoreList
do
  for lx1 in $lx1List
  do
    for elmsPerCore in $elmsPerCoreList
    do
      for partsPerCore in $partsPerCoreList
      do
	echo "Lx1: "$lx1
	echo "Elements per Core: "$elmsPerCore
	echo "Particles per Processor: "$partsPerCore
	let lxd=$lx1+2	
	let globalElms=$numCore*$elmsPerCore
	let numParticles=$partsPerCore*$numCore

	mkdir $machDataDir/$machineName'_'$numCore'cores_'$lx1'lx1_'$elmsPerCore'EPC_'$partsPerCore'PPC'
	cp input_SIZE uniform.* $machineName'_tst18_generate.sh' clean.sh $machDataDir/$machineName'_'$numCore'cores_'$lx1'lx1_'$elmsPerCore'EPC_'$partsPerCore'PPC'
	cd $machDataDir/$machineName'_'$numCore'cores_'$lx1'lx1_'$elmsPerCore'EPC_'$partsPerCore'PPC'
	mv input_SIZE SIZE
	
        lxd=($lx1+2)
	sed -i "s/(lx1=5/(lx1=$lx1/" SIZE
	sed -i "s/(lxd=7/(lxd=$lxd/" SIZE
	sed -i "s/(lelg = 160)/(lelg = $globalElms)/" SIZE
	sed -i "s/(lelt = 10)/(lel = $elmsPerCore)/" SIZE
	sed -i "s/npart = 100/npart = $numParticles/" uniform.par

	echo "uniform.box" > gbox.in
	echo "Updates Complete!!!"
	$nekDir/$machineName/bin/genbox < gbox.in
	mv box.re2 uniform.re2
	echo "uniform" > gmap.in
	echo "0.2" >> gmap.in
	$nekDir/$machineName/bin/genmap < gmap.in
	chmod 777 $machineName'_tst18_generate.sh' 
	chmod 777 clean.sh
	echo "Running the job script"
	$machineName'_tst18_generate.sh' $numCore
      done
    done
  done
done

#echo "Wrapper test script to modify the SIZE and cmtparticles.usrp file completed. Check the changes"

