c-----------------------------------------------------------------------
      subroutine lpm_usr_f
      include 'SIZE'
      include 'TOTAL'
      include 'LPM'
      parameter(rgrav = 9.8) ! gravitational acceleration

      ! uncoupled gravity in -y direction and buoyancy 
      lpmforce(1) = 0.0  
      lpmforce(2) = -rgrav*lpmvol_p*(lpmdens_p-lpmdens_f)
      lpmforce(3) = 0.0

      ! coupled user forces
      lpmforcec(1) = 0.0
      lpmforcec(2) = 0.0
      lpmforcec(3) = 0.0

c     if (lpmx_p(2)+lpmdiam_p/2.0 .gt. 0.03) lpmx_p(2) = -1

      return
      end
c-----------------------------------------------------------------------
      subroutine uservp (ix,iy,iz,eg)
      include 'SIZE'
      include 'TOTAL'   ! this is not
      include 'NEKUSE'
      integer e,eg

      e = gllel(eg)

      udiff=0.0
      utrans=0.

      return
      end
c-----------------------------------------------------------------------
      subroutine userf  (ix,iy,iz,eg)
      include 'SIZE'
      include 'TOTAL'
      include 'NEKUSE'
      integer e,eg

      ffx = 0.
      ffy = 0.
      ffz = 0.

      return
      end
c-----------------------------------------------------------------------
      subroutine userq  (ix,iy,iz,eg)
      include 'SIZE'
      include 'TOTAL'
      include 'NEKUSE'
      integer e,eg

      qvol   = 0.0

      return
      end
c-----------------------------------------------------------------------
      subroutine userchk
      include 'SIZE'
      include 'TOTAL'
      include 'LPM'
      integer  e,f

      common /bed_measures/ rpavg,ruy
      real pm1(lx1,ly1,lz1,lelt,3)

      nlxyze = nx1*ny1*nz1*nelt
      if (lx2 .ne. lx1) then
         call mappr(pm1(1,1,1,1,1),pr,pm1(1,1,1,1,2),pm1(1,1,1,1,3))
      else
         call copy(pm1(1,1,1,1,1),pr(1,1,1,1),nlxyze)
      endif

      rval = 0.0
      rpavg = 0.0
      rphiavg = 0.0
      icount = 0.0

      do i=1,nlxyze
         if (abs(ym1(i,1,1,1)-rval) .lt. 1E-12) then
            rpavg = rpavg + pm1(i,1,1,1,1)
            rphiavg = rphiavg + (1.0 - ptw(i,1,1,1,4))
            icount = icount + 1
          endif
      enddo

      icount = iglsum(icount,1)
      rpavg = glsum(rpavg,1)
      rphiavg = glsum(rphiavg,1)
      rpavg = rpavg/icount
      rphiavg = rphiavg/icount

      if (nid .eq. 0) then
      if(mod(istep,iostep).eq.0.or. istep.eq.1) then
         write(6,*) 'Bed_inlet_velocity', istep, ruy
         write(6,*) 'Bed_inlet_pressure', istep, rpavg
         write(6,*) 'Bed_inlet_fvolfrac', istep, rphiavg
      endif
      endif

      ifxyo=.true.
      if (istep.gt.1) ifxyo=.false.

      return
      end
c-----------------------------------------------------------------------
      subroutine userbc (ix,iy,iz,iside,eg)
      include 'SIZE'
      include 'TSTEP'
      include 'NEKUSE'
      include 'INPUT'
      include 'GEOM' 

      common /bed_measures/ rpavg,ruy

      ux = 0.0
      uy = ruy
      uz = 0.0

      return
      end
c-----------------------------------------------------------------------

      subroutine useric (ix,iy,iz,eg)
      include 'SIZE'
      include 'TOTAL'
      include 'NEKUSE'
      integer e,eg, eqnum

      common /bed_measures/ rpavg,ruy

      ruy = 1.23

      ux = 0.0
      uy = 0.0
      uz = 0.0

      return
      end
c-----------------------------------------------------------------------
      subroutine usrdat
      include 'SIZE'
      include 'TOTAL'

      return
      end
c-----------------------------------------------------------------------
      subroutine usrdat2
      include 'SIZE'
      include 'TOTAL'

      return
      end
!-----------------------------------------------------------------------
      subroutine usrdat3
      return
      end
c-----------------------------------------------------------------------

c automatically added by makenek
      subroutine usrsetvert(glo_num,nel,nx,ny,nz) ! to modify glo_num
      integer*8 glo_num(1)

      return
      end

c automatically added by makenek
      subroutine userqtl

      call userqtl_scig

      return
      end
