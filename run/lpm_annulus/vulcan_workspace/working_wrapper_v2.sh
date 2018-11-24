#!/bin/bash

#core_list="256 1024 2048 4096 8192"
core_list="2 4"
lx1_list="6 9"
#elpercore_list="8 16 32 64"
elpercore_list="8 16"
alphapercore=" 1000 10000"
#alphapercore="0.33 1"
root=`pwd`

#export PATH=$PATH:/g/g90/chenna1/bin/ 
export PATH=/g/g19/trokon/workspace/nek_4way/Nek5000-lpm_stable/bin/:$PATH
for core in $core_list
do
  for lx1 in $lx1_list
  do
    for elpercore in $elpercore_list
    do
      for alpha in $alphapercore
      do
                        cd $root
			mkdir 'core_'$core'lx1_'$lx1'lelt_'$elpercore'alpha_'$alpha
			cp SIZE './core_'$core'lx1_'$lx1'lelt_'$elpercore'alpha_'$alpha
                        cp README './core_'$core'lx1_'$lx1'lelt_'$elpercore'alpha_'$alpha
		       
                        cp uniform.* './core_'$core'lx1_'$lx1'lelt_'$elpercore'alpha_'$alpha
                        #cp cmtparticles.usrp './core_'$core'lx1_'$lx1'lelt_'$elpercore'alpha_'$alpha
                        cp my_generate.sh './core_'$core'lx1_'$lx1'lelt_'$elpercore'alpha_'$alpha
                        #cp clean.sh './core_'$core'lx1_'$lx1'lelt_'$elpercore'alpha_'$alpha
                        #cp makenek './core_'$core'lx1_'$lx1'lelt_'$elpercore'alpha_'$alpha
		        cd './core_'$core'lx1_'$lx1'lelt_'$elpercore'alpha_'$alpha
			
			#lelg=$core*$elpercore
			lelg=160
                        #lxdval=($lx1+2)
                        lxdval=($lx1)
		        sed -i "s/(lx1=6/(lx1=$lx1/" SIZE
			sed -i "s/(lxd=6/(lxd=$lxdval/" SIZE
			#sed -i "s/,lelt=100,/,lelt=$elpercore,/" SIZE
				#Note: This is derived in current size, so leaving alone
				#Technically need to change structure
			sed -i "s/(lelg = 160)/(lelg = $lelg)/" SIZE
				#Doesn't seem to work...
			#sed -i "s/(lp = 1000)/(lp =$core)/" SIZE
				#Not in this size file
#                        lpart=$(($alpha * $lx1 * $lx1 * $lx1 * $elpercore ))
		#	lpart=`echo "$alpha * $lx1 * $lx1 * $lx1 * $elpercore" |bc`
			sed -i "s/lpart = 10000/lpart = $alpha/" SIZE
                        nelt=$(($elpercore * $core))
			nelx=$(expr "$nelt" / 64)
#			nw=$lpart
#	 		sed -i "s;nw = 2000;nw = int(lpart/7);" cmtparticles.usrp
				#Not in this size file
				


			if [ $nelx -gt 900 ]
			then
				nlx=$(expr "$nelx" / 16)
				sed -i "s/-4  -4  -4/-$nlx  -32  -32/" part_swept.box
			else
				sed -i "s/-4  -4  -4/-$nelx  -8  -8/" part_swept.box
			fi
			echo "uniform.box" > gbox.in
			echo "Updates Complete!!!"
			#module load intel/2016.0.109 openmpi/1.10.2
				#Haven't been loading modules for this run
			genbox < gbox.in
			mv box.re2 uniform.re2
			echo "uniform" > gmap.in
			echo "0.2" >> gmap.in
			genmap < gmap.in
			#echo "part_swept" > reto2.in
			#echo "part_swept_new" >> reto2.in
			#reatore2 < reto2.in
			#mv part_swept_new.rea part_swept.rea
			#mv part_swept_new.re2 part_swept.re2
			#chmod 777 generate.sh
			#chmod 777 clean.sh
			echo "Running the job script"
			./my_generate.sh $core

		
		   
      done
    done
  done
done

#echo "Wrapper test script to modify the SIZE and cmtparticles.usrp file completed. Check the changes"

