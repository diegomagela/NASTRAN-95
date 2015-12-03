      FUNCTION KOMPNT (IG,IC,IDEG,IW,ICC,JG)
C
C     THIS ROUTINE IS USED ONLY IN BANDIT MODULE
C
C     THIS FUNCTION HAS AS ITS VALUE THE NUMBER OF COMPONENTS STORED
C     IN THE CONNECTION ARRAY IG.
C     ALSO, IC AND ICC ARE SET UP.
C     IC(I) =COMPONENT INDEX FOR NODE I
C     ICC(I)=THE STARTING POSITION TO BE USED FOR LABELS IN COMPONENT I
C     THUS, ICC(I+1)-ICC(I)= THE NUMBER OF NODES IN COMPONENT I
C
C     INTEGER          BUNPK
      DIMENSION        IG(1),    IC(1),    IDEG(1),  IW(1),    ICC(1),
     1                 JG(1)
      COMMON /BANDS /  NN,       MM
C
      DO 100 I=1,NN
      ICC(I)=0
      IC(I)=0
  100 CONTINUE
      NC=0
      ICC(1)=1
  105 DO 110 I=1,NN
      IF (IC(I)) 110,120,110
  110 KOMPNT=NC
      GO TO 210
  120 NC=NC+1
      KI=0
      KO=1
      IW(1)=I
      IC(I)=NC
      IF (NC-1) 130,125,125
  125 IS=ICC(NC)+1
      ICC(NC+1)=IS
  130 KI=KI+1
      II=IW(KI)
      N =IDEG(II)
      IF (N) 140,105,140
  140 CALL BUNPAK(IG,II,N,JG)
      DO 200 I=1,N
      IA=JG(I)
      IF (IC(IA)) 200,150,200
  150 IC(IA)=NC
      KO=KO+1
      IW(KO)=IA
      IS=ICC(NC+1)+1
      ICC(NC+1)=IS
  200 CONTINUE
      IF (KO-KI) 105,105,130
  210 RETURN
      END