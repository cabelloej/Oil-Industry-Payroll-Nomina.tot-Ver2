*********************************************
*          informe de deposito habitacional *
*********************************************
select 1 
use ipnhisto INDEX IPNHISTO, IPNHIST2
select 2
use ipnperso INDEX IPNPERSO
SELECT 10
USE IPNDISK
store ctod("  -  -    ") to fec1
store ctod("  -  -    ") to fec2
STORE SPACE(8) TO WARCHIVO
set color to w/n
@ 05,1 clear to 10,50
@ 05,1 to 10,50 double
@ 05,2 say "DEPOSITO DE AHORRO HABITACIONAL (DISKETTE)"
@ 07,3 SAY "FECHA INICIAL     :" GET FEC1
@ 08,3 SAY "FECHA FINAL       :" GET FEC2
@ 09,3 SAY "NOMBRE DEL ARCHIVO:" GET WARCHIVO
READ
IF WARCHIVO = SPACE(8)
   CLOSE DATA
   CLOSE INDEX
   RETURN
ENDIF
STORE LTRIM(RTRIM(WARCHIVO)) TO WARCHIVO

IF FEC1 >= FEC2
   CLOSE DATA
   CLOSE INDEX
   RETURN
ENDIF
STORE "OPCIONES: (C)ONTINUAR, (S)ALIR" TO MES
STORE "C" TO P1
STORE "S" TO P2
STORE " " TO RESP
DO PIDE2 WITH P1,P2,MES,RESP
IF RESP = "S"
   CLOSE DATA
   CLOSE INDEX
   RETURN
ENDIF
STORE "A:"+WARCHIVO+".DBF" TO WARCHIVO
STORE "INSERTE DISKETTE FORMATEADO EN A: Y OPRIMA ENTER" TO MES
DO AVISO WITH MES
SELECT 10
COPY STRU TO &WARCHIVO
SELECT 10
USE &WARCHIVO
store "Procesando informacion, favor esperar" to mes
do mensaje with mes
select 1
copy stru to ipntemp9
select 1
use ipntemp9
index on cedula to ipntemp9
Append from ipnhisto for FECHA >=FEC1 .AND. FECHA <= FEC2 .AND. NOMINA <> "UTLDA" .AND. NOMINA <> "LIQUI"
STORE 0 TO TOTAL1
STORE 0 TO TOTAL2
SELECT 1
GO TOP
store CEDULA to wrupced
STORE 0 TO VAMOS
DO WHILE .NOT. EOF()
   *** CONTROL DE RUPTURA POR PERSONA
   IF CEDULA <> WRUPCED
      DO RU0307B
   ENDIF
   ***
   select 1
   STORE BSAHRHAB + TOTAL1 TO TOTAL1
   STORE BSAHRHAB + TOTAL2 TO TOTAL2
   skip
ENDDO
DO RU0307B
CLOSE DATA
CLOSE INDEX
delete file ipntemp9.dbf
delete file ipntemp9.idx
SET DEVI TO SCRE
STORE "Retire el diskette de la unidada A: y oprima <ENTER>" to mes
do aviso with mes
RETURN

