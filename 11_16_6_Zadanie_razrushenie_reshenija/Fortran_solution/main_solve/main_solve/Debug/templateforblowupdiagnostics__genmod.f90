        !COMPILER-GENERATED INTERFACE MODULE: Mon Nov 20 21:22:59 2017
        MODULE TEMPLATEFORBLOWUPDIAGNOSTICS__genmod
          INTERFACE 
            SUBROUTINE TEMPLATEFORBLOWUPDIAGNOSTICS(P_EFF_FOREVERYLAYER,&
     &P_EFF_FORPARTICULARLAYER,U,M_0,N_0,SGU)
              INTEGER(KIND=4) :: SGU
              INTEGER(KIND=4) :: N_0
              INTEGER(KIND=4) :: M_0
              REAL(KIND=16) :: P_EFF_FOREVERYLAYER(1:SGU-2,1:M_0)
              REAL(KIND=16) :: P_EFF_FORPARTICULARLAYER(1:SGU-2,1:N_0+1,&
     &1:M_0+1)
              REAL(KIND=16) :: U(1:M_0+1,1:N_0+1,1:SGU)
            END SUBROUTINE TEMPLATEFORBLOWUPDIAGNOSTICS
          END INTERFACE 
        END MODULE TEMPLATEFORBLOWUPDIAGNOSTICS__genmod
