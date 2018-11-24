#!/bin/bash

#Static Parameters
numCore="16"
#coreList="16"
alphapercore="1"		#Where does this affect? Does it need to be removed?

#Varying Parameters
lx1List="7"			#Element Size?
#lx1_list="5 7 9 11 13 15 17 21"
elmsPerCoreList="4"		#Elements per core?
#elpercore_list="4 16 32 64 256 512 1024"
partsPerProcList="10"		#Particles per Processor
#partsPerProc="10, 20, 30, 40, 50, 60, 80, 100, 500, 1000"
root=`pwd`

export PATH=/g/g19/trokon/workspace/cmt_Nek_BE_Instrumentation_repo/bin:$PATH
for lx1 in $lx1List
do
  for elmsPerCore in $elmsPerCoreList
  do
    for partsPerProc in $partsPerProcList
    do
	echo "Lx1: "$lx1
	echo "Elements per Core: "$elmsPerCore
	echo "Particles per Processor: "$partsPerProc
	let lxd=$lx1+2	
	let globalElms=$numCore*$elmsPerCore
	let numParticles=$partsPerProc*$numCore

	#This cd makes no sense to me...
	cd $root
	mkdir 'quartz_'$numCore'cores_'$lx1'lx1_'$elmsPerCore'elmsPerCore'
	cp input_SIZE uniform.* README tst18_quartz_generate.sh clean.sh 'quartz_'$numCore'cores_'$lx1'lx1_'$elmsPerCore'elmsPerCore'
	cd 'quartz_'$numCore'cores_'$lx1'lx1_'$elmsPerCore'elmsPerCore'
	cp input_SIZE SIZE
			
	lelg=160
        #lxdval=($lx1+2)
        lxd=($lx1+2)
	sed -i "s/(lx1=5/(lx1=$lx1/" SIZE
	sed -i "s/(lxd=7/(lxd=$lxd/" SIZE
	sed -i "s/(lelg = 160)/(lelg = $globalElms)/" SIZE

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
	genbox < gbox.in
	mv box.re2 uniform.re2
	echo "uniform" > gmap.in
	echo "0.2" >> gmap.in
	genmap < gmap.in
	#Shouldn't need to convert .rea to .re2 anymore
	chmod 777 tst18_quartz_generate.sh
	chmod 777 clean.sh
	echo "Running the job script"
	./tst18_quartz_generate.sh $numCore
    done
  done
done

#echo "Wrapper test script to modify the SIZE and cmtparticles.usrp file completed. Check the changes"

