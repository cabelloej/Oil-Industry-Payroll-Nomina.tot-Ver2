PUSH KEY CLEAR
ON KEY LABEL F1 DO PROCIMP

select 1
use ipnhisto index ipnhisto, IPNHIST2
SELECT 2
USE IPNPERSO INDEX IPNPERSO
store .t. to wliq
do while wliq
   SET COLOR TO W+/B
   @ 4,0 CLEAR
   @ 04,1 say "CEDULA   :            NOMBRE   :                      "
   @ 05,1 say "FEC.LIQ  :            FEC.ELAB.:            MOTIVO   :"
   @ 06,1 SAY "A¥OS SER.:            MESES SER:            DIAS SER.:"
   @ 08,1 SAY "CONCEPTO                SALARIO(B,N,I)  DIAS             MONTO"
   @ 09,1 SAY "---------------------   -------         ----     -------------"
   @ 10,1 SAY "PREAVISO LEGAL       "
   @ 11,1 SAY "PREAVISO ADICIONAL   "
   @ 12,1 SAY "ANTIGUEDAD LEGAL     "
   @ 13,1 SAY "ANTIGUEDAD CONTR.    "
   @ 14,1 SAY "ANTIGUEDAD ADIC.     "
   @ 15,1 SAY "VACACION             "
   @ 16,1 SAY "BONO VACACIONAL      "
   @ 17,1 SAY "INDEMNIZACION MINIMA "
   @ 18,1 SAY "EXAMEN MEDICO        "
   @ 19,1 SAY "UTILIDAD x ANTIGUEDAD"
   @ 20,1 SAY "BONO VAC.x ANTIGUEDAD"
   @ 21,1 SAY "INDEMNIZACION COMPL. "

   store space(10) to wcedula
   store "LIQUI" to wNOMINA
   STORE CTOD("  -  -    ") TO WFECHA

   @ 4,11 GET WCEDULA
   READ
   IF WCEDULA = SPACE(10)
      POP KEY
      CLOSE DATA
      CLOSE INDEX
      RETURN
   ENDIF
   SELECT 2
   FIND &WCEDULA
   IF EOF()
      STORE "CEDULA NO REGISTRADA" TO MES
      DO AVISO WITH MES
      LOOP
   ELSE
      @ 4,33 SAY RTRIM(APELLIDO)+", "+NOMBRE
      STORE RETIRO TO WFECHA
   ENDIF
   @ 5,11 GET WFECHA
   READ
   IF WFECHA = CTOD("  -  -    ")
      LOOP
   ENDIF
   STORE WCEDULA+DTOC(WFECHA)+WNOMINA TO WCLAVE
   SELECT 1
   FIND &WCLAVE
   IF EOF()
      STORE "LIQUIDACION NO REGISTRADA, INGRESAR? (S/N)" TO MES
      STORE "S" TO P1
      STORE "N" TO P2
      STORE " " TO RESP
      DO PIDE2 WITH P1,P2,MES,RESP
      IF RESP = "N"
         LOOP
      ENDIF
      SCATT MEMV BLANK
      STORE DATE() TO M.ELABORADA
      @ 05,33 GET  M.ELABORADA
      READ
      DO WHILE .T.
         @ 05,55 GET  M.MOTIVOLIQ
         READ
         IF M.MOTIVO="T".OR.M.MOTIVO="D".OR.M.MOTIVO="R"
            EXIT
         ENDIF
      ENDDO
      @ 06,11 GET  M.ANOSSER   PICT "##"
      @ 06,33 GET  M.MESESSER  PICT "##"
      @ 06,55 GET  M.DIASSER   PICT "##"
      READ
      *** PREAVISO
      DO WHILE .T.
         @ 10,28 GET  M.TSALPRE
         READ
         IF M.TSALPRE="B".OR.M.TSALPRE="N".OR.M.TSALPRE="I"
            EXIT
         ENDIF
      ENDDO
      @ 10,42 GET  M.DPRE             PICTURE "#####"
      @ 10,52 GET  M.PREAVISO         PICTURE "######.##"
      READ
      *** PREAVISO ADICIONAL
      DO WHILE .T.
         @ 10,28 GET  M.TSALPREADD
         READ
         IF M.TSALPREADD="B".OR.M.TSALPREADD="N".OR.M.TSALPREADD="I"
            EXIT
         ENDIF
      ENDDO
      @ 10,42 GET  M.DPREADD          PICTURE "#####"
      @ 10,52 GET  M.PREAVISO2        PICTURE "######.##"
      READ
      *** ANTIGUEDAD LEGAL
      DO WHILE .T.
         @ 11,28 GET  M.TSALANT
         READ
         IF M.TSALANT="B".OR.M.TSALANT="N".OR.M.TSALANT="I"
            EXIT
         ENDIF
      ENDDO
      @ 11,42 GET  M.DANT             PICTURE "#####"
      @ 11,52 GET  M.ANTIGUE          PICTURE "######.##"
      READ
      *** ANTIGUEDAD CONTRACTUAL
      DO WHILE .T.
         @ 12,28 GET  M.TSALANT2
         READ
         IF M.TSALANT2="B".OR.M.TSALANT2="N".OR.M.TSALANT2="I"
            EXIT
         ENDIF
      ENDDO
      @ 12,42 GET  M.DANT2            PICTURE "#####"
      @ 12,52 GET  M.ANTIGUE2         PICTURE "######.##"
      READ
      *** ANTIGUEDAD ADICIONAL
      DO WHILE .T.
         @ 13,28 GET  M.TSALANTADI
         READ
         IF M.TSALANTADI="B".OR.M.TSALANTADI="N".OR.M.TSALANTADI="I"
            EXIT
         ENDIF
      ENDDO
      @ 13,42 GET  M.DANTADI          PICTURE "#####"
      @ 13,52 GET  M.CESANTIA         PICTURE "######.##"
      READ
      ***  VACACIONES
      DO WHILE .T.
         @ 14,28 GET  M.TSALVAC
         READ
         IF M.TSALVAC="B".OR.M.TSALVAC="N".OR.M.TSALVAC="I"
            EXIT
         ENDIF
      ENDDO
      @ 14,42 GET  M.DVAC             PICTURE "#####"
      @ 14,52 GET  M.VACACION         PICTURE "######.##"
      READ
      ***  BONO VACACIONAL
      DO WHILE .T.
         @ 15,28 GET  M.TSALBONVAC
         READ
         IF M.TSALBONVAC="B".OR.M.TSALBONVAC="N".OR.M.TSALBONVAC="I"
            EXIT
         ENDIF
      ENDDO
      @ 15,42 GET  M.DBONVAC          PICTURE "#####"
      @ 15,52 GET  M.BONOVAC          PICTURE "######.##"
      READ
      ***  INDEMNIZACION MINIMA
      DO WHILE .T.
         @ 16,28 GET  M.TSALMIN
         READ
         IF M.TSALMIN="B".OR.M.TSALMIN="N".OR.M.TSALMIN="I"
            EXIT
         ENDIF
      ENDDO
      @ 16,42 GET  M.DMIN             PICTURE "#####"
      @ 16,52 GET  M.MINIMO           PICTURE "######.##"
      READ
      ***  EXAMEN
      DO WHILE .T.
         @ 17,28 GET  M.TSALEXA
         READ
         IF M.TSALEXA="B".OR.M.TSALEXA="N".OR.M.TSALEXA="I"
            EXIT
         ENDIF
      ENDDO
      @ 17,42 GET  M.DEXA             PICTURE "#####"
      @ 17,52 GET  M.EXAMEN           PICTURE "######.##"
      READ
      *** UTILIDAD X ANTIGUEDAD
      DO WHILE .T.
         @ 18,28 GET  M.TSUTILANT
         READ
         IF M.TSUTILANT="B".OR.M.TSUTILANT="N".OR.M.TSUTILANT="I"
            EXIT
         ENDIF
      ENDDO
      @ 18,42 GET  M.DUTILANT         PICTURE "#####"
      @ 18,52 GET  M.UTILANT          PICTURE "######.##"
      READ
      *** BONO VACA. X ANTIGUEDAD
      DO WHILE .T.
         @ 19,28 GET  M.TSBONOANT
         READ
         IF M.TSBONOANT="B".OR.M.TSBONOANT="N".OR.M.TSBONOANT="I"
            EXIT
         ENDIF
      ENDDO
      @ 19,42 GET  M.DBONOANT         PICTURE "#####"
      @ 19,52 GET  M.BONOANT          PICTURE "######.##"
      READ
      *** INDEMNIZACION COMPLEMENTARIA (PEQUIVEN) CREO
      @ 20,52 GET  WINDCOM            PICTURE "######.##"
      READ
      STORE "OPCIONES: (A)CEPTAR, (R)ECHAZAR" TO MES
      STORE "A" TO P1
      STORE "R" TO P2
      STORE " " TO RESP
      DO PIDE2 WITH P1,P2,MES,RESP
      IF RESP = "R"
         LOOP
      ENDIF
      SELECT 1
      APPEND BLANK
      GATH MEMV
      REPLACE CEDULA         WITH WCEDULA
      REPLACE FECHA          WITH WFECHA
      REPLACE NOMINA         WITH WNOMINA
      REPLACE ELABORADO      WITH WELABORADO
      REPLACE BASICO         WITH IPNPERSO.SUELDO+IPNPERSO.BONOCO
   ELSE
      @ 05,33 SAY  ELABORADA
      @ 05,55 SAY  MOTIVOLIQ
      @ 06,11 SAY  ANOSSER   PICT "##"
      @ 06,33 SAY  MESESSER  PICT "##"
      @ 06,55 SAY  DIASSER   PICT "##"
      @ 10,28 SAY  TSALPRE
      @ 10,42 SAY  DPRE             PICTURE "#####"
      @ 10,52 SAY  PREAVISO         PICTURE "######.##"
      @ 11,28 SAY  TSALPRE
      @ 11,42 SAY  DPRE             PICTURE "#####"
      @ 11,52 SAY  PREAVISO         PICTURE "######.##"
      @ 12,28 SAY  TSALANT
      @ 12,42 SAY  DANT             PICTURE "#####"
      @ 12,52 SAY  ANTIGUE          PICTURE "######.##"
      @ 13,28 SAY  TSALANT2
      @ 13,42 SAY  DANT2            PICTURE "#####"
      @ 13,52 SAY  ANTIGUE2         PICTURE "######.##"
      @ 14,28 SAY  TSALANTADI
      @ 14,42 SAY  DANTADI          PICTURE "#####"
      @ 14,52 SAY  CESANTIA         PICTURE "######.##"
      @ 15,28 SAY  TSALVAC
      @ 15,42 SAY  DVAC             PICTURE "#####"
      @ 15,52 SAY  VACACION         PICTURE "######.##"
      @ 16,28 SAY  TSALBONVAC
      @ 16,42 SAY  DBONVAC          PICTURE "#####"
      @ 16,52 SAY  BONOVAC          PICTURE "######.##"
      @ 17,28 SAY  TSALMIN
      @ 17,42 SAY  DMIN             PICTURE "#####"
      @ 17,52 SAY  MINIMO           PICTURE "######.##"
      @ 18,28 SAY  TSALEXA
      @ 18,42 SAY  DEXA             PICTURE "#####"
      @ 18,52 SAY  EXAMEN           PICTURE "######.##"
      @ 19,28 SAY  TSUTILANT
      @ 19,42 SAY  DUTILANT         PICTURE "#####"
      @ 19,52 SAY  UTILANT          PICTURE "######.##"
      @ 20,28 SAY  TSBONOANT
      @ 20,42 SAY  DBONOANT         PICTURE "#####"
      @ 20,52 SAY  BONOANT          PICTURE "######.##"
      @ 21,52 SAY  INDCOM           PICTURE "######.##"
      STORE "OPCIONES: (M)ODIFICAR, (E)LIMINAR, (R)ECHAZAR" TO MES
      STORE "M" TO P1
      STORE "E" TO P2
      STORE "R" TO P3
      STORE " " TO RESP
      DO PIDE3 WITH P1,P2,P3,MES,RESP
      IF RESP = "R"
         LOOP
      ENDIF
      IF RESP = "E"
         DELETE
         LOOP
      ENDIF
      IF RESP = "M"
         @ 05,33 GET  ELABORADA
         @ 05,55 GET  MOTIVOLIQ
         @ 06,11 GET  ANOSSER   PICT "##"
         @ 06,33 GET  MESESSER  PICT "##"
         @ 06,55 GET  DIASSER   PICT "##"
         @ 10,28 GET  TSALPRE
         @ 10,42 GET  DPRE             PICTURE "#####"
         @ 10,52 GET  PREAVISO         PICTURE "######.##"
         @ 11,28 GET  TSALPREADD
         @ 11,42 GET  DPREADD          PICTURE "#####"
         @ 11,52 GET  PREAVISO2        PICTURE "######.##"
         @ 12,28 GET  TSALANT
         @ 12,42 GET  DANT             PICTURE "#####"
         @ 12,52 GET  ANTIGUE          PICTURE "######.##"
         @ 13,28 GET  TSALANT2
         @ 13,42 GET  DANT2            PICTURE "#####"
         @ 13,52 GET  ANTIGUE2         PICTURE "######.##"
         @ 14,28 GET  TSALANTADI
         @ 14,42 GET  DANTADI          PICTURE "#####"
         @ 14,52 GET  CESANTIA         PICTURE "######.##"
         @ 15,28 GET  TSALVAC
         @ 15,42 GET  DVAC             PICTURE "#####"
         @ 15,52 GET  VACACION         PICTURE "######.##"
         @ 16,28 GET  TSALBONVAC
         @ 16,42 GET  DBONVAC          PICTURE "#####"
         @ 16,52 GET  BONOVAC          PICTURE "######.##"
         @ 17,28 GET  TSALMIN
         @ 17,42 GET  DMIN             PICTURE "#####"
         @ 17,52 GET  MINIMO           PICTURE "######.##"
         @ 18,28 GET  TSALEXA
         @ 18,42 GET  DEXA             PICTURE "#####"
         @ 18,52 GET  EXAMEN           PICTURE "######.##"
         @ 19,28 GET  TSUTILANT
         @ 19,42 GET  DUTILANT         PICTURE "#####"
         @ 19,52 GET  UTILANT          PICTURE "######.##"
         @ 20,28 GET  TSBONOANT
         @ 20,42 GET  DBONOANT         PICTURE "#####"
         @ 20,52 GET  BONOANT          PICTURE "######.##"
         @ 21,52 GET  INDCOM           PICTURE "######.##"
         READ
      ENDIF
   ENDIF
enddo
close data
close index
return

************
PROC PROCIMP
************
SAVE SCRE TO WSCREIMP
STORE "OPCIONES: (M)ONITOR, (I)MPRESORA, (S)ALIR" to mess
store "M" TO P1
STORE "I" TO P2
STORE "S" TO P3
STORE " " TO RESP
DO PIDE3 WITH P1, P2, P3, MESS, RESP
STORE "" TO WSALIDA
IF RESP = "M"
   STORE 20  TO WSALTO
   STORE "M" TO WSALIDA
   SET DEVI  TO SCRE
ELSE
   IF RESP = "I"
      STORE 55  TO WSALTO
      STORE "I" TO WSALIDA
      SET DEVI  TO PRINT
   ENDIF
ENDIF
*
IF RESP<>"S"
   STORE 100 TO WLINE
   STORE 0   TO WPAGE
   GO TOP
   DO WHILE .NOT. EOF().AND. NOMINA="LIQUI"
      STORE WLINE+1 TO WLINE
      IF WLINE>=WSALTO
         DO HEADER
      ENDIF
      @ WLINE,00 SAY CEDULA
      @ WLINE,15 SAY FECHA
      @ WLINE,30 SAY NOMINA
      SKIP
   ENDDO
ENDIF
IF WSALIDA="M"
   STORE "OPRIMA <ENTER> PARA FINALIZAR" TO MES
   DO AVISO WITH MES
ELSE
   IF WSALIDA = "I"
      EJECT
   ENDIF
ENDIF
SET DEVI TO SCRE
REST SCRE FROM WSCREIMP
RETURN
************
PROC HEADER
************
STORE WPAGE+1 TO WPAGE
IF WSALIDA="M"
   IF WPAGE>1
      STORE "OPRIMA <ENTER> PARA CONTINUAR" TO MES
      DO AVISO WITH MES
   ENDIF
   @ 0,0 CLEAR
ENDIF
IF LASTKEY()=27
   GO BOTT
ENDIF
@ 00,00 SAY QQWW
@ 00,60 SAY "FECHA  : "+DTOC(DATE())
@ 01,00 SAY "SISTEMA DE NOMINA"
@ 01,60 SAY "PAGINA : "+STR(WPAGE,2)
@ 02,00 SAY "LISTADO DE HISTORICO DE LIQUIDACION"
@ 04,00 SAY "CEDULA"
@ 04,15 SAY "FECHA"
@ 04,30 SAY "NOMINA"
@ 05,00 SAY "------------"
@ 05,15 SAY "------------"
@ 05,30 SAY "------"
STORE 06 TO WLINE
RETURN






