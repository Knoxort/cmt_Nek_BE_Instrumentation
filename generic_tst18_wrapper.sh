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
cd $machineName/run 		#Absolute path or relative path?

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

	#This cd makes no sense to me...
	#cd $root
	mkdir $machineName'_'$numCore'cores_'$lx1'lx1_'$elmsPerCore'elmsPerCore_'$partsPerCore'partsPerCore'
	#vulcan_tst18_generate.sh
	cp input_SIZE uniform.* $machineName'_tst18_generate.sh' clean.sh $machineName'_'$numCore'cores_'$lx1'lx1_'$elmsPerCore'elmsPerCore_'$partsPerCore'partsPerCore'
	cd $machineName'_'$numCore'cores_'$lx1'lx1_'$elmsPerCore'elmsPerCore_'$partsPerCore'partsPerCore'
	cp input_SIZE SIZE
			
        #lxdval=($lx1+2)
        lxd=($lx1+2)
	sed -i "s/(lx1=5/(lx1=$lx1/" SIZE
	sed -i "s/(lxd=7/(lxd=$lxd/" SIZE
	sed -i "s/(lelg = 160)/(lelg = $globalElms)/" SIZE
	sed -i "s/(lelt = 10)/(lel = $elmsPerCore)/" SIZE

	sed -i "s/npart = 100/npart = $numParticles/" uniform.par

	#Is this still necessary
	#if [ $nelx -gt 900 ]
	#then
	#	nlx=$(expr "$nelx" / 16)
	#	sed -i "s/-4  -4  -4/-$nlx  -32  -32/" uniform.box
	#else
	#	sed -i "s/-4  -4  -4/-$nelx  -8  -8/" uniform.box
	#fi
	echo "uniform.box" > gbox.in
	echo "Updates Complete!!!"
	#Modules used to be loaded here; to keep consistency, for repeatability,
		#perhaps need to load that again?
	#/g/g19/trokon/workspace/tst_2018_nek5000_lpm_benchmarking_repo/$machineName/bin/genbox < gbox.in
	$nekDir/$machineName/bin/genbox < gbox.in
	mv box.re2 uniform.re2
	echo "uniform" > gmap.in
	echo "0.2" >> gmap.in
	#/g/g19/trokon/workspace/tst_2018_nek5000_lpm_benchmarking_repo/$machineName/bin/genmap < gmap.in
	$nekDir/$machineName/bin/genmap < gmap.in
	#Shouldn't need to convert .rea to .re2 anymore
	chmod 777 $machineName'_tst18_generate.sh' 
	chmod 777 clean.sh
	echo "Running the job script"
	$machineName'_tst18_generate.sh' $numCore
      done
    done
  done
done

#echo "Wrapper test script to modify the SIZE and cmtparticles.usrp file completed. Check the changes"

