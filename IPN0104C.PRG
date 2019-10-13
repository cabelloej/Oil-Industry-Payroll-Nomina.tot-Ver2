*************************************************************************
*                     Actualizador de datos de deducciones              *
*************************************************************************
SELECT 1
USE IPNPERSO INDEX IPNPERSO
STORE 0 TO ACTLOC
DO WHILE ACTLOC = 0
   STORE "CEDULA DESEADA, F1=VER, <ENTER>=SALIR" TO MES
   DO MENSAJE WITH MES
   SET COLOR TO W+/B
   @ 5,0 CLEAR TO 21,79
   @ 5,0 TO 21,79
   @ 5,22 SAY "DEDUCCIONES LEGALES Y CONTRATUALES"
   @ 06,1 SAY "CEDULA:"
   @ 08,1 SAY "I.S.L.R. .......:"
   @ 09,1 SAY "S.S.O. .........:"
   @ 10,1 SAY "S.P.F. .........:"
   @ 11,1 SAY "AHORRO HABIT. ..:"
   @ 12,1 SAY "CAJA DE AHORROS :"
   @ 13,1 SAY "CUOTA SINDICAL  :"
   @ 14,1 SAY "CTA.AHORRO HAB. :"
   @ 15,1 SAY "CODIGO SINDICATO:"
   @ 16,1 SAY "S.S.O. MAXIMO   :"
   @ 17,1 SAY "S.P.F. MAXIMO   :"
   STORE SPACE(10) TO WCEDULA
   @ 6,8 GET WCEDULA
   READ
   IF WCEDULA = SPACE(10)
      STORE 1 TO ACTLOC
      LOOP
   ENDIF
   SELECT 1
   FIND &WCEDULA
   IF EOF()
      STORE "CEDULA NO REGISTRADA, FAVOR INGRESAR" TO MES
      DO AVISO WITH MES
      LOOP
   ELSE
      STORE ISLR      TO WISLR
      STORE SSO       TO WSSO
      STORE SPF       TO WSPF
      STORE HAB       TO WHAB
      STORE SINDI     TO WSINDI
      STORE CAJA      TO WCAJA
      STORE CTA       TO WCTA
      STORE SINDICATO TO WSINDICATO
      STORE SSOMAX    TO WSSOMAX
      STORE SPFMAX    TO WSPFMAX
      @ 06,20 SAY RTRIM(NOMBRE)+" "+APELLIDO
      @ 08,18 SAY WISLR        PICTURE "9999.99"
      @ 09,18 SAY WSSO         PICTURE "9999.99"
      @ 10,18 SAY WSPF         PICTURE "9999.99"
      @ 11,18 SAY WHAB         PICTURE "9999.99"
      @ 12,18 SAY WCAJA        PICTURE "9999.99"
      @ 13,18 SAY WSINDI       PICTURE "9999.99"
      @ 14,18 SAY WCTA
      @ 15,18 SAY WSINDICATO
      @ 16,18 SAY WSSOMAX      PICTURE "999999.99"
      @ 17,18 SAY WSPFMAX      PICTURE "999999.99"

      STORE "OPCIONES: (M)ODIFICAR, (S)ALIR" TO MES
      STORE " " TO RESP
      STORE "M" TO P1
      STORE "S" TO P2
      DO PIDE2 WITH P1,P2,MES,RESP
      IF RESP = "S"
         LOOP
      ENDIF
      IF RESP = "M"
         @ 08,18 GET WISLR        PICTURE "9999.99"
         @ 09,18 GET WSSO         PICTURE "9999.99"
         @ 10,18 GET WSPF         PICTURE "9999.99"
         @ 11,18 GET WHAB         PICTURE "9999.99"
         @ 12,18 GET WCAJA        PICTURE "9999.99"
         @ 13,18 GET WSINDI       PICTURE "9999.99"
         @ 14,18 GET WCTA
         @ 15,18 GET WSINDICATO
         @ 16,18 GET WSSOMAX      PICTURE "999999.99"
         @ 17,18 GET WSPFMAX      PICTURE "999999.99"
         READ
         STORE "CORFORME ? (S/N)" TO MES
         STORE " " TO RESP
         STORE "S" TO P1
         STORE "N" TO P2
         DO PIDE2 WITH P1,P2,MES,RESP
         IF RESP = "S"
            REPLACE ISLR         WITH  WISLR
            REPLACE SSO          WITH  WSSO
            REPLACE SPF          WITH  WSPF
            REPLACE HAB          WITH  WHAB
            REPLACE SINDI        WITH  WSINDI
            REPLACE CAJA         WITH  WCAJA
            REPLACE CTA          WITH  WCTA
            REPLACE SINDICATO    WITH  WSINDICATO
            REPLACE SSOMAX       WITH WSSOMAX
            REPLACE SPFMAX       WITH WSPFMAX
         ENDIF
      ELSE
         LOOP
      ENDIF
   ENDIF
ENDDO
CLOSE DATA
CLOSE INDEX
SET COLOR TO
RETURN
