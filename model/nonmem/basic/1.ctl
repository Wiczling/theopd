$PROBLEM 1-CMT Linear Model with 1st-Order Absorption

$INPUT ID BW DOSE TIME DV AMT MDV CMT NUM

$DATA ../nonmemdata.csv
      IGNORE="

$SUBROUTINE ADVAN2 TRANS2

$PK
TVCL = THETA(1)           ; Typical Value of Clearance
CL   = TVCL * EXP(ETA(1)) ; Individual Clearance (L/h)

TVV = THETA(2)          ; Typical Value of Volume
V   = TVV * EXP(ETA(2)) ; Individual value of Volume (L)

TVKA = THETA(3)           ; Typical Value of absorption rate
KA   = TVKA * EXP(ETA(3)) ; Individual value of Ka (1/h)

F1 = 1 ; Bioavailability
S2 = V ;

$ERROR (OBSERVATION ONLY)
IPRED = F
Y=IPRED + EPS(1) ; Additive Error

$THETA
(0, 1)   ; [L/day] CL/F
(0, 20)  ; [L] V/F
(0, 1)   ; [1/h] KA

$OMEGA
0.1      ;[P] CL/F
0.1      ;[P] V/F
0.1      ;[P] KA

$SIGMA
1       ;[P] additive

$EST MAXEVAL=9999 METHOD=1 INTER SIGL=6 NSIG=3 PRINT=1 MSFO=./1.msf
$COV PRINT=E MATRIX=R

$TABLE NUM ID TIME EVID MDV CMT PRED IPRED CWRES WRES NPDE NOPRINT NOAPPEND ONEHEADERALL
FILE=sdtab1.tab
$TABLE NUM ID ETAS(1:LAST) KA CL V NOPRINT NOAPPEND ONEHEADERALL
FILE=patab1.tab
