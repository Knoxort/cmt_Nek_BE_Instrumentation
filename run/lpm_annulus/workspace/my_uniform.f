      program main

      call lpm_usr_f
      call uservp
      call userf  (ix,iy,iz,eg)
      call userq  (ix,iy,iz,eg)
      call userchk
      call userbc (ix,iy,iz,iside,eg)
      call useric (ix,iy,iz,eg)
      call usrdat
      call usrdat3
      call usrdat3
      call usrsetvert(glo_num,nel,nx,ny,nz) ! to modify glo_num
      call userqtl

      end

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

      ifxyo=.true.
      if (istep.gt.1) ifxyo=.false.

! get mean particle velocity
      rvsum = 0.0
      do i=1,n
         rvsum = rvsum + rpart(jv0+1,i)
      enddo
      rvsum = glsum(rvsum,1)
      nptot = iglsum(n,1)
      rvsum = rvsum/nptot
! particle time scale with stokes drag and weight/buoyancy
!   here particle density was set so that the settling velocity is 1.0
      rtau_p = dp(1)**2*(rho_p - param(1))/18.0d+0/mu_0
      rtrat  = time/rtau_p
      rvrat  = rvsum/(-1.0d+0)

      if (nid .eq. 0) write(6,100) rtrat, rvrat
 100  format('t/tau_p = ', E14.7, ', |v|/|v_settle| = ', E14.7)

      return
      end
c-----------------------------------------------------------------------
      subroutine userbc (ix,iy,iz,iside,eg)
      include 'SIZE'
      include 'TSTEP'
      include 'NEKUSE'
      include 'INPUT'
      include 'GEOM' 

      return
      end
c-----------------------------------------------------------------------

      subroutine useric (ix,iy,iz,eg)
      include 'SIZE'
      include 'TOTAL'
      include 'NEKUSE'
      integer e,eg, eqnum

      ux = 0.
      uy = 0.
      uz = 0.
      temp = 292.

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
