        !COMPILER-GENERATED INTERFACE MODULE: Fri Mar 30 11:11:12 2018
        MODULE TEMPLATEFORBLOWUPDIAGNOSTICS__genmod
          INTERFACE 
            SUBROUTINE TEMPLATEFORBLOWUPDIAGNOSTICS(P_EFF_FOREVERYLAYER,&
     &P_EFF_FORPARTICULARLAYER,U,M_0,N_0,SGU,R_R)
              INTEGER(KIND=4) :: SGU
              INTEGER(KIND=4) :: N_0
              INTEGER(KIND=4) :: M_0
              REAL(KIND=16) :: P_EFF_FOREVERYLAYER(1:SGU-2,1:M_0)
              REAL(KIND=16) :: P_EFF_FORPARTICULARLAYER(1:SGU-2,1:N_0-1,&
     &1:M_0+1)
              REAL(KIND=16) :: U(1:M_0+1,1:N_0+1,1:SGU)
              REAL(KIND=16) :: R_R(1:SGU-2,1:N_0+1,1:M_0+1)
            END SUBROUTINE TEMPLATEFORBLOWUPDIAGNOSTICS
          END INTERFACE 
        END MODULE TEMPLATEFORBLOWUPDIAGNOSTICS__genmod
