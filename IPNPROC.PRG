PROCEDURE ERRORCON
@ 0,0 CLEAR
@ 10,5 SAY ERROR()
@ 12,5 SAY MESSAGE()
WAIT
SUSP
CLOSE DATA
CLOSE INDEX
RETURN TO MASTER
RETURN
****************************************************************************
PROCEDURE REDONDEO
 PARAMETERS VARIABLE
 STORE VARIABLE - INT(VARIABLE) TO VARB
 STORE VARB*1000 TO VARC
 STORE VARC+.001 TO VARC
 STORE INT(VARC) TO VARD
 STORE (VARD/1000) TO VARE
 STORE INT(VARIABLE)+VARE TO VARIABLE
RETURN
****************************************************************************
procedure ipnestru
store "Reorganizando indices debido a interrupcion del sistema, favor esperar..." to mes
@ 12,5 say mes
use ipnfacto index ipnfacto EXCLUSIVE
reindex
use ipnomina index ipnomina EXCLUSIVE
reindex
use ipnperso index ipnperso EXCLUSIVE
reindex
use ipnproco index ipnproco EXCLUSIVE
reindex
use ipnotcon index ipnotcon
reindex
use ipnhisto index ipnhisto, IPNHIST2 EXCLUSIVE
reindex
use ipncargos index ipncargos EXCLUSIVE
reindex
use ipnpref  index ipnpref EXCLUSIVE
reindex
use ipnparf  index ipnparf EXCLUSIVE
reindex
use ipnvalf  index ipnvalf EXCLUSIVE
reindex
use ipnprer  index ipnprer EXCLUSIVE
reindex
use ipnparr  index ipnparr EXCLUSIVE
reindex
use ipnaxp   index ipnaxp  EXCLUSIVE
reindex
close data
close index
clear
return to master
*********************************************
PROCEDURE MENSAJE
PARAMETERS MES
SET COLOR TO W+/B
@ 23,1 SAY SPACE(78)
@ 23,40-(LEN(MES)/2) SAY MES
RETURN
**************************************************
PROCEDURE AVISO
PARAMETERS MES
STORE " " TO X
SET COLOR TO W+/B
@ 23,1 SAY SPACE(78)
@ 23,40-(LEN(MES)/2) SAY MES GET X
READ
@ 23,1 SAY SPACE(78)
RETURN
**************************************************
PROCEDURE PIDE1
PARAMETERS P1,MES,RESP
SET COLOR TO W+/B
@ 23,1 SAY SPACE(78)
STORE " " TO RESP
DO WHILE RESP <> P1
   STORE " " TO RESP
   @ 23,40-(LEN(MES)/2) SAY MES GET RESP
   READ
   STORE UPPER(RESP) TO RESP
ENDDO
@ 23,1 SAY SPACE(78)
RETURN
***************************************************
PROCEDURE PIDE2
PARAMETERS P1,P2,MES,RESP
SET COLOR TO W+/B
@ 23,1 SAY SPACE(78)
STORE " " TO RESP
DO WHILE RESP <> P1 .AND. RESP <> P2
   STORE " " TO RESP
   @ 23,40-(LEN(MES)/2) SAY MES GET RESP
   READ
   STORE UPPER(RESP) TO RESP
ENDDO
@ 23,1 SAY SPACE(78)
RETURN

************************************
PROCEDURE PIDE3
PARAMETERS P1,P2,P3,MES,RESP
SET COLOR TO W+/B
@ 23,1 SAY SPACE(78)
STORE " " TO RESP
DO WHILE RESP <> P1 .AND. RESP <> P2 .AND. P3 <> RESP
   STORE " " TO RESP
   @ 23,40-(LEN(MES)/2) SAY MES GET RESP
   READ
   STORE UPPER(RESP) TO RESP
ENDDO
@ 23,1 SAY SPACE(78)
RETURN
************************************
PROCEDURE PIDE4
PARAMETERS P1,P2,P3,P4,MES,RESP
SET COLOR TO W+/B
@ 23,1 SAY SPACE(78)
STORE " " TO RESP
DO WHILE RESP <> P1 .AND. RESP <> P2 .AND. P3 <> RESP .AND. RESP <> P4
   STORE " " TO RESP
   @ 23,40-(LEN(MES)/2) SAY MES GET RESP
   READ
   STORE UPPER(RESP) TO RESP
ENDDO
@ 23,1 SAY SPACE(78)
RETURN

************************************
PROCEDURE PIDE5
PARAMETERS P1,P2,P3,P4,P5,MES,RESP
SET COLOR TO W+/B
@ 23,1 SAY SPACE(78)
STORE " " TO RESP
DO WHILE RESP <> P1 .AND. RESP <> P2 .AND. P3 <> RESP .AND. RESP <> P4 .AND. RESP <> P5
   STORE " " TO RESP
   @ 23,40-(LEN(MES)/2) SAY MES GET RESP
   READ
   STORE UPPER(RESP) TO RESP
ENDDO
@ 23,1 SAY SPACE(78)
RETURN

******************************************************************
procedure informa
parameters qqww
store " " to qw1
store " " to qw2
store " " to qw3
store " " to qw4
store " " to qw5
store " " to qw6
store " " to qw7
store " " to qw8
store "." to qw9
store "A" to qw10
store "." to qw11
store "C" to qw12
store " " to qw13
store "," to qw14
store "S" to qw15
store "E" to qw16
store "C" to qw17
store "R" to qw18
store "U" to qw19
store "O" to qw20
store "S" to qw21
store "E" to qw22
store "R" to qw23
store " " to qw24
store "N" to qw25
store "A" to qw26
store "M" to qw27
store "U" to qw28
store "H" to qw29
store " " to qw30
store "A" to qw31
store "T" to qw32
store "L" to qw33
store "E" to qw34
store "D" to qw35
STORE QW35+QW34+QW33+QW32+QW31+QW30+QW29+QW28+QW27+QW26+QW25+QW24+QW23+QW22+QW21+QW20 TO QQWW
STORE QQWW+QW19+QW18+QW17+QW16+QW15+QW14+QW13+QW12+QW11+QW10+QW9+QW8+QW7+QW6+QW5+QW4+QW3+QW2+QW1  TO QQWW
RETURN
*************************************
PROCEDURE FORMA2
STORE WLINE + 1 TO WLINE
IF WLINE > WSALTO
   STORE WPAGINA + 1 TO WPAGINA
   IF WSALIDA = "M" .AND. WPAGINA <> 1
      STORE "OPRIMA <ENTER> PARA CONTINUAR" TO MES
      DO AVISO WITH MES
   ENDIF
   IF WSALIDA = "M"
      @ 0,0 CLEAR
   ELSE
      EJECT
   ENDIF
   @ 1,0 SAY QQWW
   @ 2,00 SAY "CEDULA:"+WCEDULA
   @ 2,20 SAY "NOMBRE:"+RTRIM(WAPELLIDO)+" "+WNOMBRE
   @ 3,00 SAY "FECHA :"+DTOC(FECHA)
   @ 3,20 SAY "NOMINA:"+NOMINA
   @ 3,40 SAY "BASICO:"+STR(BASICO,10,2)
   @ 4,00 SAY "CAT CONCEPTO                            UND. CANTD.  ASIGNACIONES   DEDUCCIONES"
   @ 5,00 SAY "--- ----------------------------------- ---- ------  ------------  ------------"
   STORE 6 TO WLINE
ENDIF
RETURN
************************************
PROCEDURE FORMA3
PARAMETERS LN
DO CASE
   CASE LN = 1
@ PROW(),PCOL() SAY CHR(18)
@ 0,5 SAY  CHR(14)+QQWW
@ PROW(),PCOL() SAY CHR(18)
@ 1,5   SAY CHR(18)+"OBRA EN EJECUCION :"
@ 1,95  SAY CHR(15)+"ÚÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"+CHR(18)
@ 2,5   SAY CHR(18)+WCODNOM+" "+NOMINA->DESNOM
@ 2,95  SAY CHR(15)+"³COD³BONIFICABLES      ³COD³NO BONIFICABLE  ³COD³ DEDUCCIONES   ³"+CHR(18)
@ 3,94  SAY CHR(15)+"ÃÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"+CHR(18)
@ 4,5   SAY CHR(18)+"CONTRATO U ORDEN DE SERVICIO:"
@ 4,95  SAY CHR(15)+"³BC ³BONO COMPENSATORIO³ANI³ACC. NO INDUST. ³SV ³SEGURO DE VIDA ³"+CHR(18)
@ 5,5   SAY CHR(18)+NOMINA->CONTRATO
@ 5,95  SAY CHR(15)+"³DC ³DIA  COMPENSATORIO³ENP³ENFER. NO PROF. ³CCO³CTAS.x C. OTROS³"+CHR(18)
@ 6,94  SAY CHR(15)+"³F  ³FERIADOS          ³BA ³BONO ALIMENTICIO³I  ³INAVI          ³"+CHR(18)
@ 7,5   SAY CHR(18)+"PERIODO"
@ 7,95  SAY CHR(15)+"³M  ³MANUTENCION       ³EMP³EXA.MED.PRE EMP.³D1 ³               ³"+CHR(18)
@ 8,5   SAY CHR(18)+"DEL "+DTOC(FEC1)+" AL "+DTOC(FEC2)
@ 8,95  SAY CHR(15)+"³MTP³MEZCLA TETRAPLOMO ³BV ³BONO VAC.PRORAT.³D2 ³               ³"+CHR(18)
@ 9,94  SAY CHR(15)+"³PA ³PRIMA DE ALTURA   ³NB2³                ³AH ³AHORRO HABITAC.³"+CHR(18)
@ 10,94  SAY CHR(15)+"³B1 ³                  ³   ³                ³   ³               ³"+CHR(18)
@ 11,94  SAY CHR(15)+"ÀÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"+CHR(18)

STORE "H I S T O R I C O    P O R    N O M I N A" TO TITULO

@ 12,50-(LEN(TITULO)/2) SAY CHR(18)+CHR(14)+TITULO+CHR(18)
@ PROW(),PCOL() SAY CHR(15)
@ 13,0 SAY   "ÚÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿"
@ 14,0 SAY   "³   ³     FECHA DEL PAGO        ³ CEDULA   ³D   ³                        R  E  M  U  N  E  R  A  C  I  O  N  E  S                              ³  TOTAL  ³CONCEPTOS NO BONIF. ³  TOTAL  ³   D E D U C C I O N E S    ³ TOTAL  ³         ³"
@ 15,0 SAY   "³   ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´I   ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ BONIFIC.ÃÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ´   NO    ÃÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ´ DEDUC .³P A G O  ³"
@ 16,0 SAY   "³No.³     NOMBRES Y APELLIDOS              ³A   ³ T.O. DIURNO  ³S.T. DIURNO  ³TV. DIURNO  ³ DESCANSO  ³ACC. INDUST.³AYUDA CIUDAD³    OTROS     ³         ³VIVIENDA³  OTROS    ³BONIFIC. ³I.S.L.R.³S.S.O. ³   OTRAS   ³        ³         ³"
@ 17,0 SAY   "³   ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ´S   ³ T.O. MIXTO   ³S.T. MIXTO   ³TV. MIXTO   ³DES.CON.TR.³B.NOCT.VIAJE³ BONO NOCT. ³  CONCEPTOS   ³         ³B.TRANS.³CONCEPTOS  ³         ³PRES.PE.³SINDIC.³DEDUCCIONES³        ³N E T O  ³"
@ 18,0 SAY   "³   ³       CLASIFICACION        ³SALARIO  ³    ³ T.O. NOCTURNO³S.T. NOCTURNO³TV. NOCTURNO³DES.LEG.TR.³   COMIDA   ³ BONO DOMI. ³ BONIFICABLES ³         ³CESTA B.³NO BONIF.  ³         ³S.P.F.  ³CAJA A.³           ³        ³         ³"
@ 19,0 SAY   "³   ³                            ³         ³    ³ Hr ³  Bs.    ³Hr  ³  Bs.   ³ Hr ³   Bs. ³Hr³  Bs    ³Hr ³  Bs    ³Hr ³  Bs    ³CD³Hr³  Bs    ³   Bs    ³   Bs   ³CD³  Bs    ³   Bs    ³   Bs   ³  Bs   ³CD³  Bs    ³   Bs   ³   Bs    ³"

   CASE LN = 2
@ LINE,0 SAY "³   ³                           ³          ³    ³    ³         ³    ³        ³    ³       ³  ³        ³   ³        ³   ³        ³  ³  ³        ³         ³        ³  ³        ³         ³        ³       ³  ³        ³        ³         ³"

   CASE LN = 3
@ LINE,0 SAY "³   ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÅÄÄÄÄÅÄÄÄÄÄÄÄÄÄÅÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÅÄÄÄÄÄÄÄÅÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÅÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÅÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄ´"

   CASE LN = 4
@ LINE,0 SAY "³   ³                                      ³    ³    ³         ³    ³        ³    ³       ³  ³        ³   ³        ³   ³        ³  ³  ³        ³         ³        ³  ³        ³         ³        ³       ³  ³        ³        ³         ³"

   CASE LN = 5
@ LINE,0 SAY "³   ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÅÄÄÄÄÅÄÄÄÄÅÄÄÄÄÄÄÄÄÄÅÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÅÄÄÄÄÄÄÄÅÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÅÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÅÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄ´"

   CASE LN = 6
@ LINE,0 SAY "³   ³                            ³         ³    ³    ³         ³    ³        ³    ³       ³  ³        ³   ³        ³   ³        ³  ³  ³        ³         ³        ³  ³        ³         ³        ³       ³  ³        ³        ³         ³"

   CASE LN = 7
@ LINE,0 SAY "ÃÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÁÄÄÄÄÄÄÄÄÄÅÄÄÄÄÅÄÄÄÄÅÄÄÄÄÄÄÄÄÄÅÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÅÄÄÄÄÄÄÄÅÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÅÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÅÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄ´"

   CASE LN = 8
@ LINE,0 SAY "ÀÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÁÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÙ"

ENDCASE
**************************************
PROCEDURE HEAD0211
@ 1,0 say chr(18)
@ 1,0 SAY CHR(14)+qqww
@ 3,0 SAY "CONTRATO U ORDEN DE SERVICIO: "+IPNOMINA->CONTRATO
@ 5,0 SAY "NOMBRE DE LA OBRA O SERVICIO: "+IPNOMINA->DESNOM
@ 7,0 SAY "RESUMEN DE PAGO POR CONCEPTOS BONIFICABLES - PERIODO COMPRENDIDO DESDE "+DTOC(WDESDE)+ " HASTA "+DTOC(WHASTA)
@ 09,0 SAY CHR(15)
@ 09,0 say  "+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+"
@ 10,0 say  "| N O M B R E                            |  DIAS  |  DESC. |  DESC. | PRIMA  |FERIADO|  TOTAL |A PAGAR  |  AYUDA CIUDAD  |   VIVIENDA     |  HORAS EXTRAS   | BONO NOCT/GUARD.| TIEMPO VIAJE   |     COMIDA      |  OTRAS  |  TOTAL   |"
@ 11,0 SAY  "|----------------------------------------+TRABAJA.| NORMAL | TRABAJ.|DOM/FER.|       |No. DIAS|  Bs.    |----------------|----------------|-----------------|-----------------|----------------|-----------------| BONIFIC.|   Bs.    |"
@ 12,0 SAY  "|  CEDULA    | SALARIO |  CLASIFICACION  |        |        |        |        |       |        |         |DIAS       Bs.  |DIAS       Bs.  |Hrs.        Bs.  |Hrs.       Bs.   |Hrs.       Bs.  | No.        Bs.  |         |          |"
@ 13,0 SAY  "|----------------------------------------|        |        |        |        |       |        |         |                |                |                 |                 |                |                 |         |          |"
@ 14,0 SAY  "|   INGRESO  | TERMINO |                 |        |        |        |        |       |        |         |                |                |                 |                 |                |                 |         |          |"
@ 15,0 SAY  "|----------------------------------------+        |        |        |        |       |        |         |                |                |                 |                 |                |                 |         |          |"
@ 16,0 SAY  "|             F I R M A                  |        |        |        |        |       |        |         |                |                |                 |                 |                |                 |         |          |"
@ 17,0 SAY  "|----------------------------------------+--------+--------+--------+--------+-------+--------+---------+----------------+----------------+-----------------+-----------------+----------------+-----------------+---------+----------+"
RETURN
*************************************
PROCEDURE RU0307B
*** TOMA INF. PERSONAL
select 2
find &WRUPCED
if eof()
   STORE space(1) to  wnacion,sexo,wnombre
   store ctod("  -  -    ") to wnatal,wingreso,WRETIRO,WFLAGAH
else
   STORE NACION    TO WNACION
   STORE SEXO      TO WSEXO
   STORE NATALDATE TO WNATAL
   STORE RTRIM(NOMBRE)+" "+APELLIDO TO WNOMBRE
   STORE INGRESO   TO WINGRESO
   STORE RETIRO    TO WRETIRO
   STORE FLAGAH    TO WFLAGAH
endif
STORE 0 TO WQUEFUE
STORE 0 TO VAMOS
IF (WRETIRO >= FEC1 .AND. WRETIRO <=FEC2)
   STORE 1 TO VAMOS
   STORE 1 TO WQUEFUE
ENDIF
IF (WINGRESO >= FEC1 .AND. WINGRESO <=FEC2)
   STORE 1 TO VAMOS
   STORE 2 TO WQUEFUE
ENDIF
***
*** GRABA INFORMACION EN DISCO PARA LA PERSONA
SELECT 10
APPEND BLANK
REPLACE RIF1 WITH "J"
REPLACE RIF2 WITH VAL(SUBSTR(QQWWRIF,1,8))
REPLACE RIF3 WITH VAL(SUBSTR(QQWWRIF,10,1))
REPLACE ENTIDAD WITH 2
REPLACE CEDULA1 WITH WNACION

STORE SPACE(1) TO WCEDULAX
STORE LEN(WRUPCED) TO WLONG
STORE 1 TO WCONTEO
DO WHILE WCONTEO <= WLONG
   STORE SUBSTR(WRUPCED,WCONTEO,1) TO WCAR
   IF WCAR = "0" .OR. WCAR = "1" .OR. WCAR = "2" .OR. WCAR = "3" .OR. WCAR = "4";
      .OR. WCAR = "5" .OR. WCAR = "6" .OR. WCAR = "7" .OR. WCAR = "8" .OR. WCAR = "9"
      STORE WCEDULAX+WCAR TO WCEDULAX
   ENDIF
   STORE WCONTEO + 1 TO WCONTEO
ENDDO

REPLACE CEDULA2 WITH VAL(WCEDULAX)
REPLACE NOMBRE WITH WNOMBRE
REPLACE YEAR WITH YEAR(WNATAL)
REPLACE MONTH WITH MONTH(WNATAL)
REPLACE DAY WITH DAY(WNATAL)
if wsexo = "M"
   REPLACE SEXO WITH  1
endif
if wsexo = "F"
   REPLACE SEXO WITH  2
endif
*REPLACE MOVIMIENTO WITH WQUEFUE
REPLACE MOVIMIENTO WITH 0
REPLACE APORTE WITH TOTAL2
REPLACE MES_RETENC WITH MONTH(FEC2)
STORE YEAR(FEC2) TO WERT
REPLACE ANO_RETENC WITH WERT
REPLACE EAP WITH 3416
STORE 0 TO TOTAL2
SELECT 1
STORE CEDULA TO WRUPCED
RETURN
*************************************
PROCEDURE HEAD0309
SET DEVI TO PRINT
@ 0,0 SAY CHR(18)
@ 1,0 SAY CHR(14)+qqww
@ 2,0 SAY WSELECCION
@ 3,0 SAY "CONTRATO U ORDEN DE SERVICIO: "+IPNOMINA->CONTRATO
@ 5,0 SAY "NOMBRE DE LA OBRA O SERVICIO: "+IPNOMINA->DESNOM
@ 7,0 SAY "PAGO RETROACTIVO- PERIODO COMPRENDIDO DESDE "+DTOC(WDESDE-WDIRR)+ " HASTA "+DTOC(WHASTA)
@ 09,0 SAY CHR(15)
@ 09,0 say  "+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+"
@ 10,0 say  "| N O M B R E                            |  DIAS  |  DESC. |  DESC. | PRIMA  |FERIADO|  TOTAL |A PAGAR  |A.U.E. / VIVIEN.|  CESTA BASICA  |  HORAS EXTRAS   | BONO NOCTURNO   | TIEMPO VIAJE   |     COMIDA      |UTILIDAD |  TOTAL   |"
@ 11,0 SAY  "|----------------------------------------+TRABAJA.| NORMAL | TRABAJ.|DOMINIC.|       |No. DIAS|  Bs.    |----------------|----------------|-----------------|-----------------|----------------|-----------------|   Bs.   |   Bs.    |"
@ 12,0 SAY  "|  CEDULA    | SALARIO |  CLASIFICACION  |        |        |        |        |       |        |         |DIAS       Bs.  |UND.       Bs.  |Hrs.        Bs.  |Hrs.       Bs.   |Hrs.       Bs.  |  REPOSO/COMIDA  |         |          |"
@ 13,0 SAY  "|----------------------------------------|        |        |        |        |       |        |         |                |                |                 |                 |                |-----------------|         |          |"
@ 14,0 SAY  "|   INGRESO  | TERMINO |   DIFERENCIA    |        |        |        |        |       |        |         |                |                |                 |                 |                |Hrs.         Bs. |         |          |"
@ 15,0 SAY  "|----------------------------------------+        |        |        |        |       |        |         |                |                |                 |                 |                |                 |         |          |"
@ 16,0 SAY  "|             F I R M A                  |        |        |        |        |       |        |         |                |                |                 |                 |                |                 |         |          |"
@ 17,0 SAY  "|----------------------------------------+--------+--------+--------+--------+-------+--------+---------+----------------+----------------+-----------------+-----------------+----------------+-----------------+---------+----------+"
STORE 17 TO LINE
RETURN
****************************************
PROCEDURE PAR0401
set devi to print
@ 01,01 say chr(14)+qqww
@ 02,01 say "ESTIMACION DE LABOR CONTRATADA POR GASTOS REEMBOLSABLES"
@ 03,01 SAY "PRESUPUESTO: "+CODPRE+" "+WDESCRI
@ 04,01 SAY "PARTIDA    : "+CODPAR
@ 05,01 say "TITULO:"+WCARGODES
@ 05,40 say "MESES :"+STR(MESES,8,2)
@ 06,0  say "+---+-----------------------------+------+--------+------------+--------------+"
@ 07,0  say "|No.| DESCRIPCION                 |UNIDAD|CANTIDAD|PRE.UNITARIO|  PRECIO TOTAL|"
@ 08,0  SAY "|---+-----------------------------+------+--------+------------+--------------+"
@ 09,1  SAY " 01 SALARIO BASICO POR DIAS        Bs/D"
@ 09,42 SAY STR(CASALBAS,8,2)
@ 09,54 SAY STR(CUSALBAS,8,2)
@ 09,67 SAY STR(BSSALBAS,11,2)
@ 09,0  say "|   |                             |      |        |            |              |"
@ 10,0  SAY "|---+-----------------------------+------+--------+------------+--------------+"
@ 11,1  SAY " 02 BONO COMPENSATORIO MENSUAL     Bs/M"
@ 11,42 SAY STR(CABONOCO,8,2)
@ 11,54 SAY STR(CUBONOCO,8,2)
@ 11,67 SAY STR(BSBONOCO,11,2)
@ 11,0  say "|   |                             |      |        |            |              |"
@ 12,0  SAY "|---+-----------------------------+------+--------+------------+--------------+"
@ 13,1  SAY " 03 AYUDA ESPECIAL DE CIUDAD       Bs/M"
@ 13,42 SAY STR(CAAYUDA,8,2)
@ 13,54 SAY STR(CUAYUDA,8,2)
@ 13,67 SAY STR(BSAYUDA,11,2)
@ 13,0  say "|   |                             |      |        |            |              |"
@ 14,0  SAY "|---+-----------------------------+------+--------+------------+--------------+"
       
@ 15,1  SAY " 04 ESTIMACION DE TIEMPO DE VIAJE  Hrs"
@ 15,42 SAY STR(CATV,8,2)
@ 15,54 SAY STR(CUTV,8,2)
@ 15,67 SAY STR(BSTV,11,2)
@ 15,0  say "|   |                             |      |        |            |              |"
@ 16,0  SAY "|---+-----------------------------+------+--------+------------+--------------+"
       
@ 17,1  SAY " 05 ESTIMACION DE LABOR EXTRA      Hrs"
@ 17,42 SAY STR(CAST,8,2)
@ 17,54 SAY STR(CUST,8,2)
@ 17,67 SAY STR(BSST,11,2)
@ 17,0  say "|   |                             |      |        |            |              |"
@ 18,0  SAY "|---+-----------------------------+------+--------+------------+--------------+"
       
@ 19,1  SAY " 06 BONO DE TRANSPORTE             Bs/M"
@ 19,42 SAY STR(CABT,8,2)
@ 19,54 SAY STR(CUBT,8,2)
@ 19,67 SAY STR(BSBT,11,2)
@ 19,0  say "|   |                             |      |        |            |              |"
@ 20,0  SAY "|---+-----------------------------+------+--------+------------+--------------+"
       
@ 21,1  SAY " 07 BONO ALIMENTICIO               Bs/M"
@ 21,42 SAY STR(CABA,8,2)
@ 21,54 SAY STR(CUBA,8,2)
@ 21,67 SAY STR(BSBA,11,2)
@ 21,0  say "|   |                             |      |        |            |              |"
@ 22,0  SAY "|---+-----------------------------+------+--------+------------+--------------+"
       
@ 23,1  SAY " 08 EXAMEN MEDICO PRE-EMPLEO       Bs/M"
@ 23,42 SAY STR(CAEXA1,8,2)
@ 23,54 SAY STR(CUEXA1,8,2)
@ 23,67 SAY STR(BSEXA1,11,2)
@ 23,0  say "|   |                             |      |        |            |              |"
@ 24,0  SAY "|---+-----------------------------+------+--------+------------+--------------+"
       
@ 25,1  SAY " 09 SALARIO EXAMEN MED.PRE-EMPLEO  Bs/M"
@ 25,42 SAY STR(CASALEXA1,8,2)
@ 25,54 SAY STR(CUSALEXA1,8,2)
@ 25,67 SAY STR(BSSALEXA1,11,2)
@ 25,0  say "|   |                             |      |        |            |              |"
@ 26,0  SAY "|---+-----------------------------+------+--------+------------+--------------+"
       
@ 27,1  SAY " 10 EXAMEN MEDICO PRE-RETIRO       Bs/M"
@ 27,42 SAY STR(CAEXA2,8,2)
@ 27,54 SAY STR(CUEXA2,8,2)
@ 27,67 SAY STR(BSEXA2,11,2)
@ 27,0  say "|   |                             |      |        |            |              |"
@ 28,0  SAY "|---+-----------------------------+------+--------+------------+--------------+"
       
@ 29,1  SAY " 11 SALARIO EXAMEN MED.PRE-RETIRO  Bs/M"
@ 29,42 SAY STR(CASALEXA2,8,2)
@ 29,54 SAY STR(CUSALEXA2,8,2)
@ 29,67 SAY STR(BSSALEXA2,11,2)
@ 29,0  say "|   |                             |      |        |            |              |"
@ 30,0  SAY "|---+-----------------------------+------+--------+------------+--------------+"
       
@ 31,1  SAY " 12 BONO VACACIONAL                Bs/A "
@ 31,42 SAY STR(CABV,8,2)
@ 31,54 SAY STR(CUBV,8,2)
@ 31,67 SAY STR(BSBV,11,2)
@ 31,0  Say "|   |                             |      |        |            |              |"
@ 32,0  SAY "|---+-----------------------------+------+--------+------------+--------------+"
       
@ 33,1 SAY  " 13 UTILIDADES "+STR(FACUTIL,5,2)+"               Bs/A "
@ 33,67 SAY STR(BSUTIL,11,2)
@ 33,0 say  "|   |                             |      |        |            |              |"
@ 34,0  SAY "|---+-----------------------------+------+--------+------------+--------------+"
       
@ 35,1  SAY " 14 PREAVISO                       Bs/D "
@ 35,42 SAY STR(CAPREAVI,8,2)
@ 35,54 SAY STR(CUPREAVI,8,2)
@ 35,67 SAY STR(BSPREAVI,11,2)
@ 35,0  say "|   |                             |      |        |            |              |"
@ 36,0  SAY "|---+-----------------------------+------+--------+------------+--------------+"
       
@ 37,1  SAY " 15 INDEMNIZACION DE ANTIGUEDAD    Bs/D "
@ 37,42 SAY STR(CAINDEM,8,2)
@ 37,54 SAY STR(CUINDEM,8,2)
@ 37,67 SAY STR(BSINDEM,11,2)
@ 37,0  say "|   |                             |      |        |            |              |"
@ 38,0  SAY "|---+-----------------------------+------+--------+------------+--------------+"
       
@ 39,1  SAY " 16 CAUSALES APARTES CLA.22,23y24  Bs/D "
@ 39,42 SAY STR(CACAUSA,8,2)
@ 39,54 SAY STR(CUCAUSA,8,2)
@ 39,67 SAY STR(BSCAUSA,11,2)
@ 39,0  say "|   |                             |      |        |            |              |"
@ 40,0  SAY "|---+-----------------------------+------+--------+------------+--------------+"
       
@ 41,1  SAY " 17 VACACIONES                     Bs/D "
@ 41,42 SAY STR(CAVACA,8,2)
@ 41,54 SAY STR(CUVACA,8,2)
@ 41,67 SAY STR(BSVACA,11,2)
@ 41,0  say "|   |                             |      |        |            |              |"
@ 42,0  SAY "|---+-----------------------------+------+--------+------------+--------------+"
       
@ 43,1 SAY " 18 INDEMNIZACION MINIMA           Bs/D "
@ 43,67 SAY STR(BSMINI,11,2)
@ 43,0  say "|   |                             |      |        |            |              |"
@ 44,0  SAY "|---+-----------------------------+------+--------+------------+--------------+"

@ 45,1  SAY "    SUB-TOTAL (A)"
@ 45,67 SAY STR(SUBTOTA,11,2)
@ 45,0 say "|   |                             |      |        |            |              |"
       
@ 46,1  SAY " 19 IMPREVISTOS        ("+STR(FACIMP,5,2)+"%)"
@ 46,67 SAY STR(BSIMP,11,2)
@ 46,0 say "|   |                             |      |        |            |              |"
       
@ 47,1  SAY "    SUB-TOTAL (B)"
@ 47,67 SAY STR(SUBTOTB,11,2)
@ 47,0  say "|   |                             |      |        |            |              |"
       
@ 48,1  SAY " 20 CESTA BASICA                   Bs/M"
@ 48,42 SAY STR(CACESTA,8,2)
@ 48,54 SAY STR(CUCESTA,8,2)
@ 48,67 SAY STR(BSCESTA,11,2)
@ 48,0  say "|   |                             |      |        |            |              |"
       
@ 49,1  SAY " 21 EQUIPOS DE SEGURIDAD           Bs/Tr"
@ 49,42 SAY STR(CAEQUIP,8,2)
@ 49,54 SAY STR(CUEQUIP,8,2)
@ 49,67 SAY STR(BSEQUIP,11,2)
@ 49,0 say "|   |                             |      |        |            |              |"
       
@ 50,1  SAY " 22 LEY DE POLITICA HABITACIONAL   Bs/M"
@ 50,42 SAY STR(CALAH,8,2)
@ 50,54 SAY STR(CULAH,8,2)
@ 50,67 SAY STR(BSLAH,11,2)
@ 50,0  say "|   |                             |      |        |            |              |"
       
@ 51,1  SAY " 23 I.N.C.E.                       Bs/M"
@ 51,42 SAY STR(CAINCE,8,2)
@ 51,54 SAY STR(CUINCE,8,2)
@ 51,67 SAY STR(BSINCE,11,2)
@ 51,0  say "|   |                             |      |        |            |              |"
       
@ 52,1  SAY " 24 SEGURO DE PARO FORZOSO         Bs/M"
@ 52,42 SAY STR(CASPF,8,2)
@ 52,54 SAY STR(CUSPF,8,2)
@ 52,67 SAY STR(BSSPF,11,2)
@ 52,0  say "|   |                             |      |        |            |              |"
       
@ 53,1  SAY " 25 SEGURO SOCIAL OBLIGATORIO      Bs/M"
@ 53,42 SAY STR(CASSO,8,2)
@ 53,54 SAY STR(CUSSO,8,2)
@ 53,67 SAY STR(BSSSO,11,2)
@ 53,0  say "|   |                             |      |        |            |              |"
@ 54,0  SAY "+---+-----------------------------+------+--------+------------+--------------+"
       
@ 55,0  SAY "     TOTAL  LABOR"
@ 55,67 SAY STR(BSTOTLAB,11,2)
@ 57,0  SAY "     ADMINISTRACION    ("+STR(FACADM,5,2)+"%)"
@ 57,67 SAY STR(BSADM,11,2)
@ 59,0  SAY "     SUB-TOTAL (C)"
@ 59,67 SAY STR(SUBTOTC,11,2)
       
@ 61,0  SAY "     UTILIDAD          ("+STR(FACUTI,5,2)+"%)"
@ 61,67 SAY STR(BSUTI,11,2)
@ 63,0 SAY "     TOTAL PARA "+STR(MESES,7,2)+" MESES"
@ 63,0 SAY "     TOTAL PARA "+STR(MESES,7,2)+" MESES"
@ 63,67 SAY STR(BSTOTPAR,11,2)
@ 63,67 SAY STR(BSTOTPAR,11,2)
EJECT
SET DEVI TO SCRE
RETURN
***************************
PROCEDURE HEAD0507
@ 00,00 SAY QQWW
@ 00,00 SAY QQWW
@ 01,00 SAY "RESUMEN DE CONCEPTOS BONIFICABLES"
IF WNOMINA<> SPACE(5)
   @ 02,00 SAY "NOMINA: "+WNOMINA+"  "+IPNOMINA->DESNOM
ELSE
   IF WCEDULA <> SPACE(10)
      @ 02,00 SAY "CEDULA: "+WCEDULA+"  "+RTRIM(IPNPERSO->APELLIDO)+", "+RTRIM(IPNPERSO->NOMBRE)
   ENDIF
ENDIF
@ 03,00 SAY "DESDE EL :"+DTOC(WDESDE)+" HASTA EL :"+DTOC(WHASTA)
@ 05,00 SAY "CONCEPTO                          UNIDAD  CANTIDAD     BOLIVARES"
@ 05,00 SAY "CONCEPTO                          UNIDAD  CANTIDAD     BOLIVARES"
@ 06,00 SAY "--------------------------------  ------  --------   -----------"
@ 06,00 SAY "--------------------------------  ------  --------   -----------"
STORE 7 TO WLINE
RETURN
****************************
PROCEDURE JUMP0507
IF WLINE>=WSALTO
   STORE WPAGINA + 1 TO WPAGINA
   IF WMI = "M" .AND. WPAGINA > 1
      STORE "OPRIMA <ENTER> PARA CONTINUAR" TO MES
      DO AVISO WITH MES
      @ 0,0 CLEAR
   ENDIF
   DO HEAD0507
ENDIF
RETURN
*******************************************************************
*****************      RUTINAS DE DESGLOSE     ********************
*******************************************************************
**************
PROC INIDESFIL
**************
STORE RECNO() TO START
REPLACE ALL D20000  WITH 0
REPLACE ALL D10000  WITH 0
REPLACE ALL D5000   WITH 0
REPLACE ALL D2000   WITH 0
REPLACE ALL D1000   WITH 0
REPLACE ALL D500    WITH 0
REPLACE ALL D100    WITH 0
REPLACE ALL D50     WITH 0
REPLACE ALL D20     WITH 0
REPLACE ALL D10     WITH 0
REPLACE ALL D5      WITH 0
REPLACE ALL D2      WITH 0
REPLACE ALL D1      WITH 0
REPLACE ALL D05     WITH 0
REPLACE ALL D025    WITH 0
REPLACE ALL D005    WITH 0
GO START
RETURN
**************
PROC CALDESPER
**************
store wnetopagar to wbilletes

store int(wbilletes/20000) to neto20000
store wbilletes-neto20000*20000 to wbilletes

store int(wbilletes/10000) to neto10000
store wbilletes-neto10000*10000 to wbilletes

store int(wbilletes/5000) to neto5000
store wbilletes-neto5000*5000 to wbilletes

store int(wbilletes/2000) to neto2000
store wbilletes-neto2000*2000 to wbilletes

store int(wbilletes/1000) to neto1000
store wbilletes-neto1000*1000 to wbilletes

store int(wbilletes/500) to neto500
store wbilletes-neto500*500 to wbilletes

store int(wbilletes/100) to neto100
store wbilletes-neto100*100 to wbilletes

store int(wbilletes/50) to neto50
store wbilletes-neto50*50 to wbilletes

store int(wbilletes/20) to neto20
store wbilletes-neto20*20 to wbilletes

store int(wbilletes/10) to neto10
store wbilletes-neto10*10 to wbilletes

store int(wbilletes/5) to neto5
store wbilletes-neto5*5 to wbilletes

store int(wbilletes/2) to neto2
store wbilletes-neto2*2 to wbilletes

store int(wbilletes/1) to neto1
store wbilletes-neto1*1 to wbilletes

store int(wbilletes/.5) to neto050
store wbilletes-neto050*.5 to wbilletes

store int(wbilletes/.25) to neto025
store wbilletes-neto025*.25 to wbilletes

store int(wbilletes/.05) to neto005
store wbilletes-neto005*.005 to wbilletes
RETURN
**************
PROC TOTDESNOM
**************
STORE TOT20000 +  NETO20000  TO TOT20000
STORE TOT10000 +  NETO10000  TO TOT10000
STORE TOT5000  +  NETO5000   TO TOT5000
STORE TOT2000  +  NETO2000   TO TOT2000
STORE TOT1000  +  NETO1000   TO TOT1000
STORE TOT500   +  NETO500    TO TOT500
STORE TOT100   +  NETO100    TO TOT100
STORE TOT50    +  NETO50     TO TOT50
STORE TOT20    +  NETO20     TO TOT20
STORE TOT10    +  NETO10     TO TOT10
STORE TOT5     +  NETO5      TO TOT5
STORE TOT2     +  NETO2      TO TOT2
STORE TOT1     +  NETO1      TO TOT1
STORE TOT050   +  NETO050    TO TOT050
STORE TOT025   +  NETO025    TO TOT025
STORE TOT005   +  NETO005    TO TOT005
RETURN
**************
PROC DISDESNOM
**************
SET DEVI TO SCREE
save scre to s5
@ 04,55 CLEAR TO 21,78
@ 04,55 TO 21,78 DOUBLE
@ 04,56 SAY "DESGLOSE DE LA NOMINA"
@ 05,56 SAY "BILLETES DE 20000:"+LTRIM(RTRIM(STR(TOT20000)))
@ 06,56 SAY "BILLETES DE 10000:"+LTRIM(RTRIM(STR(TOT10000)))
@ 07,56 SAY "BILLETES DE 5000 :"+LTRIM(RTRIM(STR(TOT5000)))
@ 08,56 SAY "BILLETES DE 2000 :"+LTRIM(RTRIM(STR(TOT2000)))
@ 09,56 SAY "BILLETES DE 1000 :"+LTRIM(RTRIM(STR(TOT1000)))
@ 10,56 SAY "BILLETES DE 500  :"+LTRIM(RTRIM(STR(TOT500)))
@ 11,56 SAY "BILLETES DE 100  :"+LTRIM(RTRIM(STR(TOT100)))
@ 12,56 SAY "BILLETES DE 50   :"+LTRIM(RTRIM(STR(TOT50)))
@ 13,56 SAY "BILLETES DE 20   :"+LTRIM(RTRIM(STR(TOT20)))
@ 14,56 SAY "BILLETES DE 10   :"+LTRIM(RTRIM(STR(TOT10)))
@ 15,56 SAY "MONEDAS DE 5     :"+LTRIM(RTRIM(STR(TOT5)))
@ 16,56 SAY "MONEDAS DE 2     :"+LTRIM(RTRIM(STR(TOT2)))
@ 17,56 SAY "MONEDAS DE 1     :"+LTRIM(RTRIM(STR(TOT1)))
@ 18,56 SAY "MONEDAS DE 0.50  :"+LTRIM(RTRIM(STR(TOT050)))
@ 19,56 SAY "MONEDAS DE 0.25  :"+LTRIM(RTRIM(STR(TOT025)))
@ 20,56 SAY "MONEDAS DE 0.05  :"+LTRIM(RTRIM(STR(TOT005)))
STORE "OPCIONES: (C)ONTINUAR, (I)MPRIMIR" TO MES
STORE "C" TO P1
STORE "I" TO P2
STORE " " TO RESP
DO PIDE2 WITH P1,P2,MES,RESP
IF RESP = "I"
   SET DEVI TO PRINT
   @ 00,00 SAY CHR(14)+QQWW+CHR(18)
   @ 01,00 SAY "SISTEMA DE NOMINA"
   @ 01,60 SAY "FECHA :"+DTOC(WFECACT)
   @ 03,10 SAY "DESGLOSE DE LA NOMINA  "+WDESNOM
   @ 05,10 SAY "BILLETES DE 20000:"+LTRIM(RTRIM(STR(TOT20000))) + " x 20000 = "+STR((TOT20000*20000),12,2)
   @ 06,10 SAY "BILLETES DE 10000:"+LTRIM(RTRIM(STR(TOT10000))) + " x 10000 = "+STR((TOT10000*10000),12,2)
   @ 07,10 SAY "BILLETES DE 5000 :"+LTRIM(RTRIM(STR(TOT5000)))  + " x 5000  = "+STR((TOT5000*5000),12,2)
   @ 08,10 SAY "BILLETES DE 2000 :"+LTRIM(RTRIM(STR(TOT2000)))  + " x 2000  = "+STR((TOT2000*2000),12,2)
   @ 09,10 SAY "BILLETES DE 1000 :"+LTRIM(RTRIM(STR(TOT1000)))  + " x 1000  = "+STR((TOT1000*1000),12,2)
   @ 10,10 SAY "BILLETES DE 500  :"+LTRIM(RTRIM(STR(TOT500)))   + " x 500   = "+STR((TOT500*500),12,2)
   @ 11,10 SAY "BILLETES DE 100  :"+LTRIM(RTRIM(STR(TOT100)))   + " x 100   = "+STR((TOT100*100),12,2)
   @ 12,10 SAY "BILLETES DE 50   :"+LTRIM(RTRIM(STR(TOT50)))    + " x 50    = "+STR((TOT50*50),12,2)
   @ 13,10 SAY "BILLETES DE 20   :"+LTRIM(RTRIM(STR(TOT20)))    + " x 20    = "+STR((TOT20*20),12,2)
   @ 14,10 SAY "BILLETES DE 10   :"+LTRIM(RTRIM(STR(TOT10)))    + " x 10    = "+STR((TOT10*10),12,2)
   @ 15,10 SAY "MONEDAS DE 5     :"+LTRIM(RTRIM(STR(TOT5)))     + " x 5     = "+STR((TOT5*5),12,2)
   @ 16,10 SAY "MONEDAS DE 2     :"+LTRIM(RTRIM(STR(TOT2)))     + " x 2     = "+STR((TOT2*2),12,2)
   @ 17,10 SAY "MONEDAS DE 1     :"+LTRIM(RTRIM(STR(TOT1)))     + " x 1     = "+STR((TOT1*1),12,2)
   @ 18,10 SAY "MONEDAS DE 0.50  :"+LTRIM(RTRIM(STR(TOT050)))    + " x 0,5   = "+STR((TOT050*.5),12,2)
   @ 19,10 SAY "MONEDAS DE 0.25  :"+LTRIM(RTRIM(STR(TOT025)))   + " x 0,25  = "+STR((TOT025*.25),12,2)
   @ 20,10 SAY "MONEDAS DE 0.05  :"+LTRIM(RTRIM(STR(TOT005)))   + " x 0,05  = "+STR((TOT005*.05),12,2)
   STORE TOT20000*20000 TO QAZ0
   STORE TOT10000*10000 TO QAZ1
   STORE TOT5000*5000   TO QAZ2
   STORE TOT2000*2000   TO QAZ3
   STORE TOT1000*1000   TO QAZ4
   STORE TOT500*500     TO QAZ5
   STORE TOT100*100     TO QAZ6
   STORE TOT50*50       TO QAZ7
   STORE TOT20*20       TO QAZ8
   STORE TOT10*10       TO QAZ9
   STORE TOT5*5         TO QAZ10
   STORE TOT2*2         TO QAZ11
   STORE TOT1*1         TO QAZ12
   STORE TOT050*.5       TO QAZ13
   STORE TOT025*.25     TO QAZ14
   STORE TOT005*.05     TO QAZ15
   STORE QAZ0+QAZ1+QAZ2+QAZ3+QAZ4+QAZ5+QAZ6+QAZ7+QAZ8+QAZ9+QAZ10+QAZ11+QAZ12+QAZ13+QAZ14+QAZ15 TO QAZTOT
   @ 21,10 SAY "TOTAL BOLIVARES =          "+STR(QAZTOT,12,2)
   EJECT
   SET DEVI TO SCRE
ENDIF
RETURN
**************
PROC ACTDESFIL
**************
select 1
replace d20000 with 0
replace d10000 with 0
replace d5000  with 0
replace d2000  with 0
replace d1000  with 0
replace d500   with 0
replace d100   with 0
replace d50    with 0
replace d20    with 0
replace d10    with 0
replace d5     with 0
replace d2     with 0
replace d1     with 0
replace d05    with 0
replace d025   with 0
replace d005   with 0

replace d20000 with d20000+tot20000
replace d10000 with d10000+tot10000
replace d5000  with d5000+tot5000
replace d2000  with d2000+tot2000
replace d1000  with d1000+tot1000
replace d500   with d500+tot500
replace d100   with d100+tot100
replace d50    with d50 +tot50
replace d20    with d20 +tot20
replace d10    with d10 +tot10
replace d5     with d5  +tot5
replace d2     with d2  +tot2
replace d1     with d1  +tot1
replace d05    with d05 +tot050
replace d025   with d025+tot025
replace d005   with d005+tot005
RETURN
**************
PROC DISDESACU
**************
SELECT 1
GO TOP
DO WHILE .NOT. EOF()
   STORE FF20000 + D20000 TO FF20000
   STORE FF10000 + D10000 TO FF10000
   STORE FF5000  + D5000  TO FF5000
   STORE FF2000  + D2000  TO FF2000
   STORE FF1000  + D1000  TO FF1000
   STORE FF500   + D500   TO FF500
   STORE FF100   + D100   TO FF100
   STORE FF50    + D50    TO FF50
   STORE FF20    + D20    TO FF20
   STORE FF10    + D10    TO FF10
   STORE FF5     + D5     TO FF5
   STORE FF2     + D2     TO FF2
   STORE FF1     + D1     TO FF1
   STORE FF05    + D05    TO FF05
   STORE FF025   + D025   TO FF025
   STORE FF005   + D005   TO FF005
   SKIP
ENDDO
@ 04,55 CLEAR TO 21,78
@ 04,55 TO 21,78 DOUBLE
@ 04,57 SAY "DESGLOSE  ACUMULADO"
@ 05,56 SAY "BILLETES DE 20000:"+LTRIM(RTRIM(STR(FF20000)))
@ 06,56 SAY "BILLETES DE 10000:"+LTRIM(RTRIM(STR(FF10000)))
@ 07,56 SAY "BILLETES DE 5000 :"+LTRIM(RTRIM(STR(FF5000)))
@ 08,56 SAY "BILLETES DE 2000 :"+LTRIM(RTRIM(STR(FF2000)))
@ 09,56 SAY "BILLETES DE 1000 :"+LTRIM(RTRIM(STR(FF1000)))
@ 10,56 SAY "BILLETES DE 500  :"+LTRIM(RTRIM(STR(FF500)))
@ 11,56 SAY "BILLETES DE 100  :"+LTRIM(RTRIM(STR(FF100)))
@ 12,56 SAY "BILLETES DE 50   :"+LTRIM(RTRIM(STR(FF50)))
@ 13,56 SAY "BILLETES DE 20   :"+LTRIM(RTRIM(STR(FF20)))
@ 14,56 SAY "BILLETES DE 10   :"+LTRIM(RTRIM(STR(FF10)))
@ 15,56 SAY "MONEDAS DE 5     :"+LTRIM(RTRIM(STR(FF5)))
@ 16,56 SAY "MONEDAS DE 2     :"+LTRIM(RTRIM(STR(FF2)))
@ 17,56 SAY "MONEDAS DE 1     :"+LTRIM(RTRIM(STR(FF1)))
@ 18,56 SAY "MONEDAS DE 0.50  :"+LTRIM(RTRIM(STR(FF05)))
@ 19,56 SAY "MONEDAS DE 0.25  :"+LTRIM(RTRIM(STR(FF025)))
@ 20,56 SAY "MONEDAS DE 0.05  :"+LTRIM(RTRIM(STR(FF005)))
STORE "OPCIONES: (C)ONTINUAR, (I)MPRIMIR" TO MES
STORE "C" TO P1
STORE "I" TO P2
STORE " " TO RESP
DO PIDE2 WITH P1,P2,MES,RESP
IF RESP = "I"
   SET DEVI TO PRINT
   @ 00,00 SAY CHR(14)+QQWW+CHR(18)
   @ 01,00 SAY "SISTEMA DE NOMINA"
   @ 01,60 SAY "FECHA :"+DTOC(WFECACT)
   @ 03,10 SAY "DESGLOSE ACUMULADO"
   @ 05,10 SAY "BILLETES DE 20000:"+LTRIM(RTRIM(STR(FF20000))) + " x 20000 = "+STR((FF20000*20000),12,2)
   @ 06,10 SAY "BILLETES DE 10000:"+LTRIM(RTRIM(STR(FF10000))) + " x 10000 = "+STR((FF10000*10000),12,2)
   @ 07,10 SAY "BILLETES DE 5000 :"+LTRIM(RTRIM(STR(FF5000)))  + " x 5000  = "+STR((FF5000*5000),12,2)
   @ 08,10 SAY "BILLETES DE 2000 :"+LTRIM(RTRIM(STR(FF2000)))  + " x 2000  = "+STR((FF2000*2000),12,2)
   @ 09,10 SAY "BILLETES DE 1000 :"+LTRIM(RTRIM(STR(FF1000)))  + " x 1000  = "+STR((FF1000*1000),12,2)
   @ 10,10 SAY "BILLETES DE 500  :"+LTRIM(RTRIM(STR(FF500)))   + " x 500   = "+STR((FF500*500),12,2)
   @ 11,10 SAY "BILLETES DE 100  :"+LTRIM(RTRIM(STR(FF100)))   + " x 100   = "+STR((FF100*100),12,2)
   @ 12,10 SAY "BILLETES DE 50   :"+LTRIM(RTRIM(STR(FF50)))    + " x 50    = "+STR((FF50*50),12,2)
   @ 13,10 SAY "BILLETES DE 20   :"+LTRIM(RTRIM(STR(FF20)))    + " x 20    = "+STR((FF20*20),12,2)
   @ 14,10 SAY "BILLETES DE 10   :"+LTRIM(RTRIM(STR(FF10)))    + " x 10    = "+STR((FF10*10),12,2)
   @ 15,10 SAY "MONEDAS DE 5     :"+LTRIM(RTRIM(STR(FF5)))     + " x 5     = "+STR((FF5*5),12,2)
   @ 16,10 SAY "MONEDAS DE 2     :"+LTRIM(RTRIM(STR(FF2)))     + " x 2     = "+STR((FF2*2),12,2)
   @ 17,10 SAY "MONEDAS DE 1     :"+LTRIM(RTRIM(STR(FF1)))     + " x 1     = "+STR((FF1*1),12,2)
   @ 18,10 SAY "MONEDAS DE 0.50  :"+LTRIM(RTRIM(STR(FF05)))    + " x 0,5   = "+STR((FF05*.5),12,2)
   @ 19,10 SAY "MONEDAS DE 0.25  :"+LTRIM(RTRIM(STR(FF025)))   + " x 0,25  = "+STR((FF025*.25),12,2)
   @ 20,10 SAY "MONEDAS DE 0.05  :"+LTRIM(RTRIM(STR(FF005)))   + " x 0,05  = "+STR((FF005*.05),12,2)
   STORE FF20000*20000 TO QAZ0
   STORE FF10000*10000 TO QAZ1
   STORE FF5000*5000   TO QAZ2
   STORE FF2000*2000   TO QAZ3
   STORE FF1000*1000   TO QAZ4
   STORE FF500*500     TO QAZ5
   STORE FF100*100     TO QAZ6
   STORE FF50*50       TO QAZ7
   STORE FF20*20       TO QAZ8
   STORE FF10*10       TO QAZ9
   STORE FF5*5         TO QAZ10
   STORE FF2*2         TO QAZ11
   STORE FF1*1         TO QAZ12
   STORE FF05*.5       TO QAZ13
   STORE FF025*.25     TO QAZ14
   STORE FF005*.05     TO QAZ15
   STORE QAZ0+QAZ1+QAZ2+QAZ3+QAZ4+QAZ5+QAZ6+QAZ7+QAZ8+QAZ9+QAZ10+QAZ11+QAZ12+QAZ13+QAZ14+QAZ15 TO QAZTOT
   @ 21,10 SAY "TOTAL BOLIVARES =          "+STR(QAZTOT,12,2)
   EJECT
   SET DEVI TO SCRE
ENDIF
RETURN
