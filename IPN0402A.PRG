SAVE SCRE TO WSCREPRE1
select 1
use ipncargos index ipncargos
select 2
use ipncarfb
select 3
use ipnpref  index ipnpref
select 4
use ipnparf  index ipnparf
STORE SPACE(6) TO WCODPRE
STORE SPACE(6) TO WCODPAR
STORE SPACE(6) TO WCODCAR
STORE .T. TO WELABORA
DO WHILE WELABORA
   STORE .F. TO WFLAGPRE
   @ 00,00 clear
   @ 00,00 SAY QQWW
   @ 01,00 SAY "PRESUPUESTO DE SUMINISTRO DE PERSONAL POR GASTOS FIJOS"
   @ 02,00 say "PRESUPUESTO:"
   @ 03,00 SAY "NOMINA     :"
   @ 04,00 SAY "+------------------------------------------+-----------+-----------+-----------+"
   @ 05,00 SAY "|DESCRIPCION                               |     DIURNO|      MIXTO|   NOCTURNO|"
   @ 06,00 SAY "+------------------------------------------+-----------+-----------+-----------+"
   @ 07,00 SAY "|DIAS/H NORMALES DE TRABAJO                |           |           |           |"
   @ 08,00 SAY "|HORAS/H DE SOBRETIEMPO                    |           |           |           |"
   @ 09,00 SAY "|DIAS/H DESCANSO TRABAJADO (NO DOMINGO)    |           |           |           |"
   @ 10,00 SAY "|DIAS/H DESCANSO TRABAJADO DOMINGO-FERIADO |           |           |           |"
   @ 11,00 SAY "|PAGO DE CESTA BASICA                      |           |           |           |"
   @ 12,00 SAY "+-------+------+---------------------------+-----------+-----------+-----------+"
   @ 13,00 SAY "|PARTIDA|CARGO |DESCRIPCION                |   CANTIDAD|     SUELDO|       BONO|"
   @ 14,00 SAY "+-------+------+---------------------------+-----------+-----------+-----------+"
   STORE "INGRESE CODIGO DEL PRESUP. (IMP)=LISTADO DE PRESUPUESTOS, <ESC>=SALIR" TO MES
   DO MENSAJE WITH MES
   @ 02,12 GET WCODPRE
   READ
   IF READKEY()=12.OR.READKEY()=268.OR.WCODPRE=SPACE(6)
      CLOSE DATA
      CLOSE INDEX
      RESTORE SCRE FROM WSCREPRE1
      RETURN
   ENDIF
   IF WCODPRE = "IMP"
     * DO IPN0402A
      LOOP
   ENDIF
   SELECT 3
   FIND &WCODPRE
   IF EOF()
      STORE "PRESUPUESTO NO REGISTRADO, DESEA INGRESAR ? (S/N)" TO MES
      STORE "S" TO P1
      STORE "N" TO P2
      STORE " " TO RESP
      DO PIDE2 WITH P1,P2,MES,RESP
      STORE RESP TO WSN
      IF WSN = "N"
         LOOP
      ENDIF
      STORE SPACE(60) TO WDESCRI
      STORE SPACE(5)  TO WNOMINA
      @ 2,20 GET WDESCRI
      @ 3,12 GET WNOMINA
      READ
      STORE 0 TO WDNT1,WDNT2,WDNT3,WHST1,WHST2,WHST3,WDND1,WDND2,WDND3,WDSD1,WDSD2,WDSD3,WCEST
      STORE "INGRESE LAS CANTIDADES A CONTRATAR" TO MES
      DO MENSAJE WITH MES
      @ 07,45 GET WDNT1 PICTURE "#######.##"
      @ 08,45 GET WHST1 PICTURE "#######.##"
      @ 09,45 GET WDND1 PICTURE "#######.##"
      @ 10,45 GET WDSD1 PICTURE "#######.##"
      @ 07,57 GET WDNT2 PICTURE "#######.##"
      @ 08,57 GET WHST2 PICTURE "#######.##"
      @ 09,57 GET WDND2 PICTURE "#######.##"
      @ 10,57 GET WDSD2 PICTURE "#######.##"
      @ 07,69 GET WDNT3 PICTURE "#######.##"
      @ 08,69 GET WHST3 PICTURE "#######.##"
      @ 09,69 GET WDND3 PICTURE "#######.##"
      @ 10,69 GET WDSD3 PICTURE "#######.##"
      @ 11,25 GET WCEST PICTURE "#######.##"
      READ
      STORE "CONFORME CON DESCRIPCION Y UNIDADES A CONTRATAR ? (S/N)" TO MES
      STORE "S" TO P1
      STORE "N" TO P2
      STORE " " TO RESP
      DO PIDE2 WITH P1,P2,MES,RESP
      STORE RESP TO WC
      IF WC = "N"
         LOOP
      ENDIF
      APPEND BLANK
      REPLACE CODPRE WITH WCODPRE
      REPLACE DESCRI WITH WDESCRI
      REPLACE NOMINA WITH WNOMINA
      REPLACE DNT1   WITH WDNT1
      REPLACE HST1   WITH WHST1
      REPLACE DND1   WITH WDND1
      REPLACE DSD1   WITH WDSD1
      REPLACE DNT2   WITH WDNT2
      REPLACE HST2   WITH WHST2
      REPLACE DND2   WITH WDND2
      REPLACE DSD2   WITH WDSD2
      REPLACE DNT3   WITH WDNT3
      REPLACE HST3   WITH WHST3
      REPLACE DND3   WITH WDND3
      REPLACE DSD3   WITH WDSD3
      REPLACE CEST   WITH WCEST
   ELSE
      STORE DESCRI   TO WDESCRI
      STORE NOMINA   TO WNOMINA
      STORE DNT1     TO WDNT1
      STORE HST1     TO WHST1
      STORE DND1     TO WDND1
      STORE DSD1     TO WDSD1
      STORE DNT2     TO WDNT2
      STORE HST2     TO WHST2
      STORE DND2     TO WDND2
      STORE DSD2     TO WDSD2
      STORE DNT3     TO WDNT3
      STORE HST3     TO WHST3
      STORE DND3     TO WDND3
      STORE DSD3     TO WDSD3
      STORE CEST     TO WCEST
      @ 02,20 SAY WDESCRI
      @ 03,12 SAY WNOMINA
      @ 07,45 SAY WDNT1 PICTURE "#######.##"
      @ 08,45 SAY WHST1 PICTURE "#######.##"
      @ 09,45 SAY WDND1 PICTURE "#######.##"
      @ 10,45 SAY WDSD1 PICTURE "#######.##"
      @ 07,57 SAY WDNT2 PICTURE "#######.##"
      @ 08,57 SAY WHST2 PICTURE "#######.##"
      @ 09,57 SAY WDND2 PICTURE "#######.##"
      @ 10,57 SAY WDSD2 PICTURE "#######.##"
      @ 07,69 SAY WDNT3 PICTURE "#######.##"
      @ 08,69 SAY WHST3 PICTURE "#######.##"
      @ 09,69 SAY WDND3 PICTURE "#######.##"
      @ 10,69 SAY WDSD3 PICTURE "#######.##"
      @ 11,25 SAY WCEST PICTURE "#######.##"
      STORE "OPCIONES: (M)ODIFICAR, (E)LIMINAR, (C)ONTINUAR, (S)ALIR" TO MES
      STORE "M" TO P1
      STORE "E" TO P2
      STORE "C" TO P3
      STORE "S" TO P4
      STORE " " TO RESP
      DO PIDE4 WITH P1,P2,P3,P4,MES,RESP
      STORE RESP TO WMECS
      IF WMECS = "S"
         LOOP
      ENDIF
      IF WMECS = "E"
         STORE "ESTA SEGURO ? (S/N)" TO MES
         STORE "S" TO P1
         STORE "N" TO P2
         STORE " " TO RESP
         DO PIDE2 WITH P1,P2,MES,RESP
         IF RESP = "N"
            LOOP
         ENDIF
         SELECT 3
         DELETE
         SELECT 4
         STORE .T. TO WDEL
         DO WHILE WDEL
            SET EXACT OFF
            FIND &WCODPRE
            SET EXACT ON
            IF EOF()
               EXIT
            ELSE
               DELETE
            ENDIF
         ENDDO
         LOOP
      ENDIF
      IF WMECS = "M"
         STORE "INGRESE LA DESCRIPCION DEL CONTRATO" TO MES
         DO MENSAJE WITH MES
         @ 02,20 GET WDESCRI
         @ 03,12 GET WNOMINA
         READ
         STORE "INGRESE LAS CANTIDADES A CONTRATAR" TO MES
         DO MENSAJE WITH MES
         @ 07,45 GET WDNT1 PICTURE "#######.##"
         @ 08,45 GET WHST1 PICTURE "#######.##"
         @ 09,45 GET WDND1 PICTURE "#######.##"
         @ 10,45 GET WDSD1 PICTURE "#######.##"
         @ 07,57 GET WDNT2 PICTURE "#######.##"
         @ 08,57 GET WHST2 PICTURE "#######.##"
         @ 09,57 GET WDND2 PICTURE "#######.##"
         @ 10,57 GET WDSD2 PICTURE "#######.##"
         @ 07,69 GET WDNT3 PICTURE "#######.##"
         @ 08,69 GET WHST3 PICTURE "#######.##"
         @ 09,69 GET WDND3 PICTURE "#######.##"
         @ 10,69 GET WDSD3 PICTURE "#######.##"
         @ 11,25 GET WCEST PICTURE "#######.##"
         READ
         STORE "CONFORME CON DESCRIPCION Y UNIDADES A CONTRATAR ? (S/N)" TO MES
         STORE "S" TO P1
         STORE "N" TO P2
         STORE " " TO RESP
         DO PIDE2 WITH P1,P2,MES,RESP
         STORE RESP TO WC
         IF WC = "N"
            LOOP
         ENDIF
         REPLACE DESCRI WITH WDESCRI
         REPLACE NOMINA WITH WNOMINA
         REPLACE DNT1   WITH WDNT1
         REPLACE HST1   WITH WHST1
         REPLACE DND1   WITH WDND1
         REPLACE DSD1   WITH WDSD1
         REPLACE DNT2   WITH WDNT2
         REPLACE HST2   WITH WHST2
         REPLACE DND2   WITH WDND2
         REPLACE DSD2   WITH WDSD2
         REPLACE DNT3   WITH WDNT3
         REPLACE HST3   WITH WHST3
         REPLACE DND3   WITH WDND3
         REPLACE DSD3   WITH WDSD3
         REPLACE CEST   WITH WCEST
      ENDIF
   ENDIF
   *** PARTIDAS
   STORE .T. TO WVERPAR
   DO WHILE WVERPAR
      STORE 100 TO WLINE
      STORE 0 TO WPAGE
      SELECT 4
      SET EXACT OFF
      FIND &WCODPRE
      SET EXACT ON
      DO WHILE .NOT. EOF() .AND. CODPRE = WCODPRE
         STORE WLINE + 1 TO WLINE
         IF WLINE >=22
            STORE WPAGE + 1 TO WPAGE
            IF WPAGE > 1
               STORE "OPRIMA <ENTER> PARA CONTINUAR VISULIZANDO PARTIDAS, <ESC> PARA TERMINAR" TO MES
               DO AVISO WITH MES
               IF READKEY()=12.OR.READKEY()=268
                  EXIT
               ENDIF
            ENDIF
            @ 15,0 CLEAR
            STORE 15 TO WLINE
         ENDIF
         @ WLINE,01 SAY CODPAR
         @ WLINE,09 SAY CODCAR
         STORE CODCAR TO WCODCAR
         SELECT 1
         FIND &WCODCAR
         IF EOF()
            STORE "NO DEFINIDO EN CARGOS" TO WCARGODES
         ELSE
            STORE DESCRI                  TO WCARGODES
         ENDIF
         SELECT 4
         @ WLINE,16 SAY WCARGODES
         @ WLINE,45 SAY CANTIDAD  PICTURE "#######.##"
         @ WLINE,57 SAY FACBASICO PICTURE "#######.##"
         @ WLINE,69 SAY FACBONOCO PICTURE "#######.##"
         SELECT 4
         SKIP
      ENDDO
      STORE "INGRESE EL CODIGO DE PARTIDA A PROCESAR, <ESC> PARA SALIR" TO MES
      DO MENSAJE WITH MES
      @ 22,1 GET WCODPAR
      READ
      IF WCODPAR = SPACE(6) .OR. READKEY()=12.OR.READKEY()=268
         EXIT
      ENDIF
      STORE WCODPRE+WCODPAR TO WCLAVEPAR
      SELECT 4
      FIND &WCLAVEPAR
      IF EOF()
         *** NO EXISTE LA PARTIDA
         STORE "PARTIDA NO REGISTRADA EN PRESUPUESTO, INGRESAR ? (S/N)" TO MES
         STORE "S" TO P1
         STORE "N" TO P2
         STORE " " TO RESP
         DO PIDE2 WITH P1,P2,MES,RESP
         STORE RESP TO WC
         IF WC = "N"
            LOOP
         ENDIF
         STORE SPACE(6)     TO WCODCAR
         STORE 0            TO WCANTIDAD
         STORE 0            TO WFACBASICO
         STORE 0            TO WFACBONOCO
         SELECT 2
         STORE FACAYU       TO WFACAYU
         STORE FACTV        TO WFACTV
         STORE FACHORTV     TO WFACHORTV
         STORE FACBN        TO WFACBN
         STORE FACRCD       TO WFACRCD
         STORE FACRCM       TO WFACRCM
         STORE FACRCN       TO WFACRCN
         STORE FACSTG       TO WFACSTG
         STORE DESCOM       TO WDESCOM
         STORE FACUTIPER    TO WFACUTIPER
         STORE FACLIQ       TO WFACLIQ
         STORE FACPRE       TO WFACPRE
         STORE FACVAC       TO WFACVAC
         STORE FACIMPEMP    TO WFACIMPEMP
         STORE FACSSO       TO WFACSSO
         STORE FACSPF       TO WFACSPF
         STORE FACINCE      TO WFACINCE
         STORE FACLPA       TO WFACLPA
         STORE FACBT        TO WFACBT
         STORE FACBA        TO WFACBA
         STORE FACES        TO WFACES
         STORE FACCESTA     TO WFACCESTA
         STORE FACADMEMP    TO WFACADMEMP
         STORE FACUTIEMP    TO WFACUTIEMP
         STORE FACDESNOR    TO WFACDESNOR
         STORE .T. TO WGETCAR
         DO WHILE WGETCAR
            @ 22,9 GET WCODCAR
            READ
            IF WCODCAR = SPACE(6).OR.READKEY()=12.OR.READKEY()=268
               STORE .F. TO WGETCAR
               EXIT
            ENDIF
            SELECT 1
            FIND &WCODCAR
            IF EOF()
               STORE "CARGO NO REGISTRADO, VERIFIQUE" TO MES
               DO AVISO WITH MES
               LOOP
            ENDIF
            STORE DESCRI TO WCARGODES
            STORE SUELDO TO WFACBASICO
            STORE BONOCO TO WFACBONOCO
            @ 22,16 SAY WCARGODES
            @ 22,45 GET WCANTIDAD PICTURE "#######.##"
            READ
            IF WCANTIDAD=0.OR.READKEY()=12.OR.READKEY()=268
               LOOP
            ENDIF
            @ 22,57 GET WFACBASICO PICTURE "#######.##"
            READ
            IF WFACBASICO = 0
               LOOP
            ENDIF
            @ 22,69 GET WFACBONOCO  PICTURE "#######.##"
            READ
            EXIT
         ENDDO
         IF .NOT. WGETCAR
            LOOP
         ENDIF
         SAVE SCRE TO WSCREPRE2
         @ 01,00 CLEAR
         @ 01,00 SAY "FACTORES DE LA PARTIDA "+WCODPAR
         @ 03,5 SAY " AYUDA DE CIUDAD PERSONAL         :" GET WFACAYU
         @ 04,5 SAY " FACTOR Y HORAS DE TIEMPO DE VIAJE:"
         @ 04,41 GET WFACTV    PICTURE "###.##"
         @ 04,51 GET WFACHORTV PICTURE "######.##"
         @ 05,5 SAY " FACTOR BONO NOCTURNO PERSONAL    :" GET WFACBN
         @ 06,5 SAY " FACTOR 1/2 REPOSO/COMIDA D,M,N   :"
         @ 06,41 GET WFACRCD PICTURE "###.##"
         @ 06,51 GET WFACRCM PICTURE "###.##"
         @ 06,61 GET WFACRCN PICTURE "###.##"
         @ 07,5 SAY " FACTOR SOBRE TIEMPO              :" GET WFACSTG
         @ 08,5 SAY " PAGAR DESC.COMP x DESC.LEG.TRAB.?:" GET WDESCOM
         @ 09,5 SAY " FACTOR UTILIDADES PERSONAL       :" GET WFACUTIPER
         @ 10,5 SAY " FACTOR LIQUIDACION PERSONAL      :" GET WFACLIQ
         @ 11,5 SAY " FACTOR PREAVISO PERSONAL         :" GET WFACPRE
         @ 12,5 SAY " FACTOR VACACIONES PERSONAL       :" GET WFACVAC
         @ 13,5 SAY " FACTOR IMPREVISTOS EMPRESA       :" GET WFACIMPEMP
         @ 14,5 SAY " FACTOR S.S.O. EMPRESA            :" GET WFACSSO
         @ 15,5 SAY " FACTOR S.P.F. EMPRESA            :" GET WFACSPF
         @ 16,5 SAY " FACTOR I.N.C.E. EMPRESA          :" GET WFACINCE
         @ 17,5 SAY " FACTOR LEY POLITICA HAB. EMPRESA :" GET WFACLPA
         @ 18,5 SAY " BONO DE TRANSPORTE               :" GET WFACBT
         @ 19,5 SAY " BONO ALIMENTICIO                 :" GET WFACBA
         @ 20,5 SAY " EQUIPOS DE SEGURIDAD             :" GET WFACES
         @ 21,5 SAY " CESTA BASICA MENSUAL             :" GET WFACCESTA
         READ
         ***************************
         STORE "COLOQUE CERO (0) EN AMBOS FACTORES SI DESEA MONTOS DIRECTOS" TO MES
         DO MENSAJE WITH MES
         @ 21,5 SAY " GASTOS ADMINISTRACION Y UTILIDAD :"
         @ 21,41 GET WFACADMEMP
         @ 21,51 GET WFACUTIEMP
         READ
         IF WFACADMEMP = 0 .AND. WFACUTIEMP = 0
            SAVE SCRE TO WSCREPAR1
            STORE 0  TO WGASTADM1
            STORE 0  TO WGASTADM2
            STORE 0  TO WGASTADM3
            STORE 0  TO WHRSTADM1
            STORE 0  TO WHRSTADM2
            STORE 0  TO WHRSTADM3
            STORE 0  TO WDTNDADM1
            STORE 0  TO WDTNDADM2
            STORE 0  TO WDTNDADM3
            STORE 0  TO WDTDADM1
            STORE 0  TO WDTDADM2
            STORE 0  TO WDTDADM3
            STORE 0  TO WUTIEMP1
            STORE 0  TO WUTIEMP2
            STORE 0  TO WUTIEMP3
            STORE 0  TO WHRSTUTI1
            STORE 0  TO WHRSTUTI2
            STORE 0  TO WHRSTUTI3
            STORE 0  TO WDTNDUTI1
            STORE 0  TO WDTNDUTI2
            STORE 0  TO WDTNDUTI3
            STORE 0  TO WDTDUTI1
            STORE 0  TO WDTDUTI2
            STORE 0  TO WDTDUTI3
            STORE 0  TO WCESTAADM
            STORE 0  TO WCESTAUTI
            @ 08,0 CLEAR TO 21,79
            @ 08,0 TO 21,79 DOUBLE
            @ 09,1 SAY "GASTOS DE ADMINISTRACION        DIURNO     MIXTO   NOCTURNO"
            @ 10,1 SAY "1- TOTAL GASTOS                                            "
            @ 11,1 SAY "2- HORAS DE SOBRE TIEMPO                                   "
            @ 12,1 SAY "3- DESC.TRABAJADO NO DOMINGO                               "
            @ 13,1 SAY "4- DESC.TRAB.DOMINGO O FER.                                "
            @ 14,1 SAY "5- CESTA BASICA                                            "
            @ 15,1 SAY "UTILIDADES                      DIURNO     MIXTO   NOCTURNO"
            @ 16,1 SAY "1- TOTAL GASTOS                                            "
            @ 17,1 SAY "2- HORAS DE SOBRE TIEMPO                                   "
            @ 18,1 SAY "3- DESC.TRABAJADO NO DOMINGO                               "
            @ 19,1 SAY "4- DESC.TRAB.DOMINGO O FER.                                "
            @ 20,1 SAY "5- CESTA BASICA                                            "
            @ 10,30 GET WGASTADM1 PICTURE "#######.##"
            @ 10,45 GET WGASTADM2 PICTURE "#######.##"
            @ 10,60 GET WGASTADM3 PICTURE "#######.##"
            @ 11,30 GET WHRSTADM1 PICTURE "#######.##"
            @ 11,45 GET WHRSTADM2 PICTURE "#######.##"
            @ 11,60 GET WHRSTADM3 PICTURE "#######.##"
            @ 12,30 GET WDTNDADM1 PICTURE "#######.##"
            @ 12,45 GET WDTNDADM2 PICTURE "#######.##"
            @ 12,60 GET WDTNDADM3 PICTURE "#######.##"
            @ 13,30 GET WDTDADM1  PICTURE "#######.##"
            @ 13,45 GET WDTDADM2  PICTURE "#######.##"
            @ 13,60 GET WDTDADM3  PICTURE "#######.##"
            @ 14,30 GET WCESTAADM PICTURE "#######.##"
            READ
            @ 16,30 GET WUTIEMP1  PICTURE "#######.##"
            @ 16,45 GET WUTIEMP2  PICTURE "#######.##"
            @ 16,60 GET WUTIEMP3  PICTURE "#######.##"
            @ 17,30 GET WHRSTUTI1 PICTURE "#######.##"
            @ 17,45 GET WHRSTUTI2 PICTURE "#######.##"
            @ 17,60 GET WHRSTUTI3 PICTURE "#######.##"
            @ 18,30 GET WDTNDUTI1 PICTURE "#######.##"
            @ 18,45 GET WDTNDUTI2 PICTURE "#######.##"
            @ 18,60 GET WDTNDUTI3 PICTURE "#######.##"
            @ 19,30 GET WDTDUTI1  PICTURE "#######.##"
            @ 19,45 GET WDTDUTI2  PICTURE "#######.##"
            @ 19,60 GET WDTDUTI3  PICTURE "#######.##"
            @ 20,30 GET WCESTAUTI PICTURE "#######.##"
            READ
            RESTORE SCRE FROM WSCREPAR1
         ENDIF
         STORE SPACE(78) TO MES
         DO MENSAJE WITH MES
         *******************
         @ 22,5 SAY " FACTOR DESCANSO NORMAL           :" GET WFACDESNOR
         READ
         STORE "CONFORME CON LA INFORMACION DE LA PARTIDA ? (S/N)" TO MES
         STORE "S" TO P1
         STORE "N" TO P2
         STORE " " TO RESP
         DO PIDE2 WITH P1,P2,MES,RESP
         STORE RESP TO WC
         IF WC = "N"
            RESTORE SCRE FROM WSCREPRE2
            LOOP
         ENDIF
         SELECT 4
         APPEND BLANK
         REPLACE CODPRE      WITH WCODPRE
         REPLACE CODPAR      WITH WCODPAR
         REPLACE CODCAR      WITH WCODCAR
         REPLACE CANTIDAD    WITH WCANTIDAD
         REPLACE FACBASICO   WITH WFACBASICO
         REPLACE FACBONOCO   WITH WFACBONOCO
         REPLACE FACAYU      WITH WFACAYU
         REPLACE FACTV       WITH WFACTV
         REPLACE FACHORTV    WITH WFACHORTV
         REPLACE FACBN       WITH WFACBN
         REPLACE FACRCD      WITH WFACRCD
         REPLACE FACRCM      WITH WFACRCM
         REPLACE FACRCN      WITH WFACRCN
         REPLACE FACSTG      WITH WFACSTG
         REPLACE DESCOM      WITH WDESCOM
         REPLACE FACUTIPER   WITH WFACUTIPER
         REPLACE FACLIQ      WITH WFACLIQ
         REPLACE FACPRE      WITH WFACPRE
         REPLACE FACVAC      WITH WFACVAC
         REPLACE FACIMPEMP   WITH WFACIMPEMP
         REPLACE FACSSO      WITH WFACSSO
         REPLACE FACSPF      WITH WFACSPF
         REPLACE FACINCE     WITH WFACINCE
         REPLACE FACLPA      WITH WFACLPA
         REPLACE FACBT       WITH WFACBT
         REPLACE FACBA       WITH WFACBA
         REPLACE FACES       WITH WFACES
         REPLACE FACCESTA    WITH WFACCESTA
         REPLACE FACADMEMP   WITH WFACADMEMP
         REPLACE FACUTIEMP   WITH WFACUTIEMP
         REPLACE FACDESNOR   WITH WFACDESNOR
         RESTORE SCRE FROM WSCREPRE2
      ELSE
         STORE "OPCIONES : (M)ODIFICAR, (E)LIMINAR, (S)ALIR" TO MES
         STORE "M" TO P1
         STORE "E" TO P2
         STORE "S" TO P3
         STORE " " TO RESP
         DO PIDE3 WITH P1,P2,P3,MES,RESP
         STORE RESP TO WMES
         IF WMES = "S"
            LOOP
         ENDIF
         IF WMES = "E"
            STORE "ESTA SEGURO ? (S/N)" TO MES
            STORE "S" TO P1
            STORE "N" TO P2
            STORE " " TO RESP
            DO PIDE2 WITH P1,P2,MES,RESP
            STORE RESP TO WSN3
            IF WSN3 = "S"
               DELETE
            ENDIF
            STORE .T. TO WFLAGPRE
            LOOP
         ENDIF
         *** EXISTE LA PARTIDA
         STORE CODCAR       TO WCODCAR
         STORE CANTIDAD     TO WCANTIDAD
         STORE FACBASICO    TO WFACBASICO
         STORE FACBONOCO    TO WFACBONOCO
         STORE FACAYU       TO WFACAYU
         STORE FACTV        TO WFACTV
         STORE FACHORTV     TO WFACHORTV
         STORE FACBN        TO WFACBN
         STORE FACRCD       TO WFACRCD
         STORE FACRCM       TO WFACRCM
         STORE FACRCN       TO WFACRCN
         STORE FACSTG       TO WFACSTG
         STORE DESCOM       TO WDESCOM
         STORE FACUTIPER    TO WFACUTIPER
         STORE FACLIQ       TO WFACLIQ
         STORE FACPRE       TO WFACPRE
         STORE FACVAC       TO WFACVAC
         STORE FACIMPEMP    TO WFACIMPEMP
         STORE FACSSO       TO WFACSSO
         STORE FACSPF       TO WFACSPF
         STORE FACINCE      TO WFACINCE
         STORE FACLPA       TO WFACLPA
         STORE FACBT        TO WFACBT
         STORE FACBA        TO WFACBA
         STORE FACES        TO WFACES
         STORE FACCESTA     TO WFACCESTA
         STORE FACADMEMP    TO WFACADMEMP
         STORE FACUTIEMP    TO WFACUTIEMP
         STORE FACDESNOR    TO WFACDESNOR

         STORE WCODCAR TO WLATCODCAR
         STORE .T. TO WGETCAR
         DO WHILE WGETCAR
            @ 22,9 GET WCODCAR
            READ
            IF WCODCAR = SPACE(6).OR.READKEY()=12.OR.READKEY()=268
               STORE .F. TO WGETCAR
               EXIT
            ENDIF
            SELECT 1
            FIND &WCODCAR
            IF EOF()
               STORE "CARGO NO REGISTRADO, VERIFIQUE" TO MES
               DO AVISO WITH MES
               LOOP
            ENDIF
            STORE DESCRI TO WCARGODES
            IF WCODCAR <> WLATCODCAR
               STORE SUELDO TO WFACBASICO
               STORE BONOCO TO WFACBONOCO
            ENDIF
            @ 22,16 SAY WCARGODES
            @ 22, 45 GET WCANTIDAD PICTURE "#######.##"
            READ
            IF WCANTIDAD=0.OR.READKEY()=12.OR.READKEY()=268
               LOOP
            ENDIF
            @ 22,57 GET WFACBASICO PICTURE "#######.##"
            READ
            IF WFACBASICO = 0
               LOOP
            ENDIF
            @ 22,69 GET WFACBONOCO PICTURE "#######.##"
            READ
            EXIT
         ENDDO
         IF .NOT. WGETCAR
            LOOP
         ENDIF
         SAVE SCRE TO WSCREPRE2
         @ 01,00 CLEAR
         @ 01,00 SAY "FACTORES DE LA PARTIDA "+WCODPAR
         @ 03,5 SAY " AYUDA DE CIUDAD PERSONAL         :" GET WFACAYU
         @ 04,5 SAY " FACTOR Y HORAS DE TIEMPO DE VIAJE:"
         @ 04,41 GET WFACTV    PICTURE "###.##"
         @ 04,51 GET WFACHORTV PICTURE "######.##"
         @ 05,5 SAY " FACTOR BONO NOCTURNO PERSONAL    :" GET WFACBN
         @ 06,5 SAY " FACTOR 1/2 REPOSO/COMIDA D,M,N   :"
         @ 06,41 GET WFACRCD PICTURE "###.##"
         @ 06,51 GET WFACRCM PICTURE "###.##"
         @ 06,61 GET WFACRCN PICTURE "###.##"
         @ 07,5 SAY " FACTOR SOBRE TIEMPO              :" GET WFACSTG
         @ 08,5 SAY " PAGAR DES.COM x DES.LEGAL TRAB. ?:" GET WDESCOM
         @ 09,5 SAY " FACTOR UTILIDADES PERSONAL       :" GET WFACUTIPER
         @ 10,5 SAY " FACTOR LIQUIDACION PERSONAL      :" GET WFACLIQ
         @ 11,5 SAY " FACTOR PREAVISO PERSONAL         :" GET WFACPRE
         @ 12,5 SAY " FACTOR VACACIONES PERSONAL       :" GET WFACVAC
         @ 13,5 SAY " FACTOR IMPREVISTOS EMPRESA       :" GET WFACIMPEMP
         @ 14,5 SAY " FACTOR S.S.O. EMPRESA            :" GET WFACSSO
         @ 15,5 SAY " FACTOR S.P.F. EMPRESA            :" GET WFACSPF
         @ 16,5 SAY " FACTOR I.N.C.E. EMPRESA          :" GET WFACINCE
         @ 17,5 SAY " FACTOR LEY POLITICA HAB. EMPRESA :" GET WFACLPA
         @ 18,5 SAY " BONO DE TRANSPORTE               :" GET WFACBT
         @ 19,5 SAY " BONO ALIMENTICIO                 :" GET WFACBA
         @ 20,5 SAY " EQUIPOS DE SEGURIDAD             :" GET WFACES
         @ 21,5 SAY " CESTA BASICA MENSUAL             :" GET WFACCESTA
         READ
         ***************************
         STORE "COLOQUE CERO (0) EN AMBOS FACTORES SI DESEA MONTOS DIRECTOS" TO MES
         DO MENSAJE WITH MES
         @ 21,5 SAY " GASTOS ADMINISTRACION Y UTILIDAD :"
         @ 21,41 GET WFACADMEMP
         @ 21,51 GET WFACUTIEMP
         READ
         IF WFACADMEMP = 0 .AND. WFACUTIEMP = 0
            SAVE SCRE TO WSCREPAR1
            SELECT 4
            STORE  BSGASTADM1       TO WGASTADM1
            STORE  BSGASTADM2       TO WGASTADM2
            STORE  BSGASTADM3       TO WGASTADM3
            STORE  BSSTADM1         TO WHRSTADM1
            STORE  BSSTADM2         TO WHRSTADM2
            STORE  BSSTADM3         TO WHRSTADM3
            STORE  BSDTNDADM1       TO WDTNDADM1
            STORE  BSDTNDADM2       TO WDTNDADM2
            STORE  BSDTNDADM3       TO WDTNDADM3
            STORE  BSDTDADM1        TO WDTDADM1
            STORE  BSDTDADM2        TO WDTDADM2
            STORE  BSDTDADM3        TO WDTDADM3
            STORE  BSUTIEMP1        TO WUTIEMP1
            STORE  BSUTIEMP2        TO WUTIEMP2
            STORE  BSUTIEMP3        TO WUTIEMP3
            STORE  BSSTUTI1         TO WHRSTUTI1
            STORE  BSSTUTI2         TO WHRSTUTI2
            STORE  BSSTUTI3         TO WHRSTUTI3
            STORE  BSDTNDUTI1       TO WDTNDUTI1
            STORE  BSDTNDUTI2       TO WDTNDUTI2
            STORE  BSDTNDUTI3       TO WDTNDUTI3
            STORE  BSDTDUTI1        TO WDTDUTI1
            STORE  BSDTDUTI2        TO WDTDUTI2
            STORE  BSDTDUTI3        TO WDTDUTI3
            STORE  BSCESTAADM       TO WCESTAADM
            STORE  BSCESTAUTI       TO WCESTAUTI
            @ 08,0 CLEAR TO 21,79
            @ 08,0 TO 21,79 DOUBLE
            @ 09,1 SAY "GASTOS DE ADMINISTRACION        DIURNO     MIXTO   NOCTURNO"
            @ 10,1 SAY "1- TOTAL GASTOS                                            "
            @ 11,1 SAY "2- HORAS DE SOBRE TIEMPO                                   "
            @ 12,1 SAY "3- DESC.TRABAJADO NO DOMINGO                               "
            @ 13,1 SAY "4- DESC.TRAB.DOMINGO O FER.                                "
            @ 14,1 SAY "5- CESTA BASICA                                            "
            @ 15,1 SAY "UTILIDADES                      DIURNO     MIXTO   NOCTURNO"
            @ 16,1 SAY "1- TOTAL GASTOS                                            "
            @ 17,1 SAY "2- HORAS DE SOBRE TIEMPO                                   "
            @ 18,1 SAY "3- DESC.TRABAJADO NO DOMINGO                               "
            @ 19,1 SAY "4- DESC.TRAB.DOMINGO O FER.                                "
            @ 20,1 SAY "5- CESTA BASICA                                            "
            @ 10,30 GET WGASTADM1 PICTURE "#######.##"
            @ 10,45 GET WGASTADM2 PICTURE "#######.##"
            @ 10,60 GET WGASTADM3 PICTURE "#######.##"
            @ 11,30 GET WHRSTADM1 PICTURE "#######.##"
            @ 11,45 GET WHRSTADM2 PICTURE "#######.##"
            @ 11,60 GET WHRSTADM3 PICTURE "#######.##"
            @ 12,30 GET WDTNDADM1 PICTURE "#######.##"
            @ 12,45 GET WDTNDADM2 PICTURE "#######.##"
            @ 12,60 GET WDTNDADM3 PICTURE "#######.##"
            @ 13,30 GET WDTDADM1  PICTURE "#######.##"
            @ 13,45 GET WDTDADM2  PICTURE "#######.##"
            @ 13,60 GET WDTDADM3  PICTURE "#######.##"
            @ 14,30 GET WCESTAADM PICTURE "#######.##"
            READ
            @ 16,30 GET WUTIEMP1  PICTURE "#######.##"
            @ 16,45 GET WUTIEMP2  PICTURE "#######.##"
            @ 16,60 GET WUTIEMP3  PICTURE "#######.##"
            @ 17,30 GET WHRSTUTI1 PICTURE "#######.##"
            @ 17,45 GET WHRSTUTI2 PICTURE "#######.##"
            @ 17,60 GET WHRSTUTI3 PICTURE "#######.##"
            @ 18,30 GET WDTNDUTI1 PICTURE "#######.##"
            @ 18,45 GET WDTNDUTI2 PICTURE "#######.##"
            @ 18,60 GET WDTNDUTI3 PICTURE "#######.##"
            @ 19,30 GET WDTDUTI1  PICTURE "#######.##"
            @ 19,45 GET WDTDUTI2  PICTURE "#######.##"
            @ 19,60 GET WDTDUTI3  PICTURE "#######.##"
            @ 20,30 GET WCESTAUTI PICTURE "#######.##"
            READ
            RESTORE SCRE FROM WSCREPAR1
         ENDIF
         STORE SPACE(78) TO MES
         DO MENSAJE WITH MES
         *******************
         @ 22,5 SAY " FACTOR DESCANSO NORMAL           :" GET WFACDESNOR
         READ
         STORE "CONFORME CON LA INFORMACION DE LA PARTIDA ? (S/N)" TO MES
         STORE "S" TO P1
         STORE "N" TO P2
         STORE " " TO RESP
         DO PIDE2 WITH P1,P2,MES,RESP
         STORE RESP TO WC
         IF WC = "N"
            RESTORE SCRE FROM WSCREPRE2
            LOOP
         ENDIF
         SELECT 4
         REPLACE CODCAR      WITH WCODCAR
         REPLACE CANTIDAD    WITH WCANTIDAD
         REPLACE FACBASICO   WITH WFACBASICO
         REPLACE FACBONOCO   WITH WFACBONOCO
         REPLACE FACAYU      WITH WFACAYU
         REPLACE FACTV       WITH WFACTV
         REPLACE FACHORTV    WITH WFACHORTV
         REPLACE FACBN       WITH WFACBN
         REPLACE FACRCD      WITH WFACRCD
         REPLACE FACRCM      WITH WFACRCM
         REPLACE FACRCN      WITH WFACRCN
         REPLACE FACSTG      WITH WFACSTG
         REPLACE DESCOM      WITH WDESCOM
         REPLACE FACUTIPER   WITH WFACUTIPER
         REPLACE FACLIQ      WITH WFACLIQ
         REPLACE FACPRE      WITH WFACPRE
         REPLACE FACVAC      WITH WFACVAC
         REPLACE FACIMPEMP   WITH WFACIMPEMP
         REPLACE FACSSO      WITH WFACSSO
         REPLACE FACSPF      WITH WFACSPF
         REPLACE FACINCE     WITH WFACINCE
         REPLACE FACLPA      WITH WFACLPA
         REPLACE FACBT       WITH WFACBT
         REPLACE FACBA       WITH WFACBA
         REPLACE FACES       WITH WFACES
         REPLACE FACCESTA    WITH WFACCESTA
         REPLACE FACADMEMP   WITH WFACADMEMP
         REPLACE FACUTIEMP   WITH WFACUTIEMP
         REPLACE FACDESNOR   WITH WFACDESNOR
         RESTORE SCRE FROM WSCREPRE2
      ENDIF
      IF WFACADMEMP=0.AND.WFACUTIEMP=0
         STORE .F. TO WFLAGREC
      ELSE
         STORE .T. TO WFLAGREC
      ENDIF
      *** CALCULA LA PARTIDA PROCESADA
      store WFACBASICO      to wsalbas,wsalbas1,wsalbas2,wsalbas3
      store WFACBASICO/8    to wsuelhor1
      store WFACBASICO/7.5  to wsuelhor2
      store WFACBASICO/7    to wsuelhor3
      store WFACBONOCO      to wbonoco,wbonoco1,wbonoco2,wbonoco3
      store WFACbonoco/8.00 to wbonohr1
      store WFACbonoco/7.50 to wbonohr2
      store WFACbonoco/7.00 to wbonohr3
      store Wfacayu         to wayuda,wayuda1,wayuda2,wayuda3
      store (wsuelhor1+wbonohr1)*WFAChortv*(Wfactv/100) to wtmpvia1
      store (wsuelhor2+wbonohr2)*WFAChortv*(Wfactv/100) to wtmpvia2
      store (wsuelhor3+wbonohr3)*WFAChortv*(Wfactv/100) to wtmpvia3
      store 0.5*(wsuelhor1+wbonohr1)*(wfacrcd/100)   to wrepcom1
      store 0.5*(wsuelhor2+wbonohr2)*(wfacrcm/100)   to wrepcom2
      store 0.5*(wsuelhor3+wbonohr3)*(wfacrcn/100)   to wrepcom3
      store (0*(wsalbas1+wbonoco1+wayuda1+wrepcom1)/8.00)*(wfacbn/100)     to wbononoct1
      store (4*(wsalbas2+wbonoco2+wayuda2+wrepcom2)/8.00)*(wfacbn/100)     to wbononoct2
      store (6*(wsalbas3+wbonoco3+wayuda3+wrepcom3)/8.00)*(wfacbn/100)     to wbononoct3
      store (0.0*(wsalbas1+wbonoco1+wayuda1+wrepcom1+wbononoct1)/8.00)*(wfacstg/100)     to wstg1
      store (0.5*(wsalbas2+wbonoco2+wayuda2+wrepcom2+wbononoct2)/7.50)*(wfacstg/100)     to wstg2
      store (1.0*(wsalbas3+wbonoco3+wayuda3+wrepcom3+wbononoct3)/7.00)*(wfacstg/100)     to wstg3

      store wsalbas1+wbonoco1+wayuda1+wtmpvia1+wbononoct1+wrepcom1+wstg1 to Wtotbon1
      store wsalbas2+wbonoco2+wayuda2+wtmpvia2+wbononoct2+wrepcom2+wstg2 to Wtotbon2
      store wsalbas3+wbonoco3+wayuda3+wtmpvia3+wbononoct3+wrepcom3+wstg3 to Wtotbon3

      store (2.5/30)*(wsalbas1+wbonoco1) to wbonovac1
      store (2.5/30)*(wsalbas2+wbonoco2) to wbonovac2
      store (2.5/30)*(wsalbas3+wbonoco3) to wbonovac3

      store (wtotbon1+wbonovac1)*(wfacutiper/100) to wutiper1
      store (wtotbon2+wbonovac2)*(wfacutiper/100) to wutiper2
      store (wtotbon3+wbonovac3)*(wfacutiper/100) to wutiper3

      store (wtotbon1+wbonovac1+wutiper1)*(wfacliq/100) to wliqui1
      store (wtotbon2+wbonovac2+wutiper2)*(wfacliq/100) to wliqui2
      store (wtotbon3+wbonovac3+wutiper3)*(wfacliq/100) to wliqui3

      store wtotbon1*(wfacpre/100) to wpreavi1
      store wtotbon2*(wfacpre/100) to wpreavi2
      store wtotbon3*(wfacpre/100) to wpreavi3

      store wtotbon1*(wfacvac/100) to wvaca1
      store wtotbon2*(wfacvac/100) to wvaca2
      store wtotbon3*(wfacvac/100) to wvaca3

      store (wtotbon1+wbonovac1+wutiper1+wliqui1+wpreavi1+wvaca1)*(wfacimpemp/100) to wimprevi1
      store (wtotbon2+wbonovac2+wutiper2+wliqui2+wpreavi2+wvaca2)*(wfacimpemp/100) to wimprevi2
      store (wtotbon3+wbonovac3+wutiper3+wliqui3+wpreavi3+wvaca3)*(wfacimpemp/100) to wimprevi3

      store (wsalbas+wbonoco+wayuda)*(wfacsso/100) to wsso
     *store (wsalbas1+wbonoco1+wayuda1)*(wfacsso/100) to wsso1
     *store (wsalbas2+wbonoco2+wayuda2)*(wfacsso/100) to wsso2
     *store (wsalbas3+wbonoco3+wayuda3)*(wfacsso/100) to wsso3

      store (wsalbas+wbonoco+wayuda)*(wfacspf/100) to wspf
     *store (wsalbas1+wbonoco1+wayuda1)*(wfacspf/100) to wspf1
     *store (wsalbas2+wbonoco2+wayuda2)*(wfacspf/100) to wspf2
     *store (wsalbas3+wbonoco3+wayuda3)*(wfacspf/100) to wspf3

      store wtotbon1*(wfacince/100) to wince1
      store wtotbon2*(wfacince/100) to wince2
      store wtotbon3*(wfacince/100) to wince3

      store (wsalbas+wbonoco)*(wfaclpa/100) to wlah
     *store (wsalbas1+wbonoco1)*(wfaclpa/100) to wlah1
     *store (wsalbas2+wbonoco2)*(wfaclpa/100) to wlah2
     *store (wsalbas3+wbonoco3)*(wfaclpa/100) to wlah3

      store facbt to wbonotran,wbonotran1,wbonotran2,wbonotran3
      store facba to wbonoalim,wbonoalim1,wbonoalim2,wbonoalim3
      store faces to wequipo,wequipo1,wequipo2,wequipo3

      store wtotbon1+wbonovac1+wutiper1+wliqui1+wpreavi1+wvaca1+wimprevi1+wsso+wspf+wince1+wlah+wbonotran1+wbonoalim1+wequipo1 to wtotgast1
      store wtotbon2+wbonovac2+wutiper2+wliqui2+wpreavi2+wvaca2+wimprevi2+wsso+wspf+wince2+wlah+wbonotran2+wbonoalim2+wequipo2 to wtotgast2
      store wtotbon3+wbonovac3+wutiper3+wliqui3+wpreavi3+wvaca3+wimprevi3+wsso+wspf+wince3+wlah+wbonotran3+wbonoalim3+wequipo3 to wtotgast3

      IF WFLAGREC
         store wtotgast1*(wfacadmemp/100) to wgastadm1
         store wtotgast2*(wfacadmemp/100) to wgastadm2
         store wtotgast3*(wfacadmemp/100) to wgastadm3
      ENDIF

      store wtotgast1+wgastadm1 to wsubtot11
      store wtotgast2+wgastadm2 to wsubtot12
      store wtotgast3+wgastadm3 to wsubtot13

      IF WFLAGREC
         store wsubtot11*(wfacutiemp/100) to wutiemp1
         store wsubtot12*(wfacutiemp/100) to wutiemp2
         store wsubtot13*(wfacutiemp/100) to wutiemp3
      ENDIF

      store wsubtot11+wutiemp1 to wsubtot21
      store wsubtot12+wutiemp2 to wsubtot22
      store wsubtot13+wutiemp3 to wsubtot23

      store wsubtot21*(wfacdesnor/100) to wdesnor1
      store wsubtot22*(wfacdesnor/100) to wdesnor2
      store wsubtot23*(wfacdesnor/100) to wdesnor3

      store wsubtot21+wdesnor1 to wcosto1
      store wsubtot22+wdesnor2 to wcosto2
      store wsubtot23+wdesnor3 to wcosto3

      STORE WTOTBON1/8.00 TO WSALNORHR1
      STORE WTOTBON2/7.50 TO WSALNORHR2
      STORE WTOTBON3/7.00 TO WSALNORHR3

      STORE WSALNORHR1*(WFACSTG/100)           TO WHORST1
      STORE WHORST1+(WHORST1*(WFACUTIPER/100)) TO WHORST1
      STORE WHORST1+(WHORST1*(WFACLIQ/100))    TO WHORST1
      STORE WSALNORHR2*(WFACSTG/100)           TO WHORST2
      STORE WHORST2+(WHORST2*(WFACUTIPER/100)) TO WHORST2
      STORE WHORST2+(WHORST2*(WFACLIQ/100))    TO WHORST2
      STORE WSALNORHR3*(WFACSTG/100)           TO WHORST3
      STORE WHORST3+(WHORST3*(WFACUTIPER/100)) TO WHORST3
      STORE WHORST3+(WHORST3*(WFACLIQ/100))    TO WHORST3
      IF WFLAGREC
         STORE WHORST1*(WFACADMEMP/100)        TO WHRSTADM1
         STORE WHORST2*(WFACADMEMP/100)        TO WHRSTADM2
         STORE WHORST3*(WFACADMEMP/100)        TO WHRSTADM3
      ENDIF
      STORE WHORST1+WHRSTADM1                  TO WHRSTSUB1
      STORE WHORST2+WHRSTADM2                  TO WHRSTSUB2
      STORE WHORST3+WHRSTADM3                  TO WHRSTSUB3
      IF WFLAGREC
         STORE WHRSTSUB1*(WFACUTIEMP/100)      TO WHRSTUTI1
         STORE WHRSTSUB2*(WFACUTIEMP/100)      TO WHRSTUTI2
         STORE WHRSTSUB3*(WFACUTIEMP/100)      TO WHRSTUTI3
      ENDIF
      STORE WHRSTSUB1+WHRSTUTI1                TO WHORST1
      STORE WHRSTSUB2+WHRSTUTI2                TO WHORST2
      STORE WHRSTSUB3+WHRSTUTI3                TO WHORST3
      
      STORE WTOTBON1+WSALBAS1+WBONOCO1       TO WDTND1
      STORE WDTND1+(WDTND1*(WFACUTIPER/100)) TO WDTND1
      STORE WDTND1+(WDTND1*(WFACLIQ/100))    TO WDTND1
      STORE WTOTBON2+WSALBAS2+WBONOCO2       TO WDTND2
      STORE WDTND2+(WDTND2*(WFACUTIPER/100)) TO WDTND2
      STORE WDTND2+(WDTND2*(WFACLIQ/100))    TO WDTND2
      STORE WTOTBON3+WSALBAS3+WBONOCO3       TO WDTND3
      STORE WDTND3+(WDTND3*(WFACUTIPER/100)) TO WDTND3
      STORE WDTND3+(WDTND3*(WFACLIQ/100))    TO WDTND3
      IF WFLAGREC
         STORE WDTND1*(WFACADMEMP/100)       TO WDTNDADM1
         STORE WDTND2*(WFACADMEMP/100)       TO WDTNDADM2
         STORE WDTND3*(WFACADMEMP/100)       TO WDTNDADM3
      ENDIF
      STORE WDTND1+WDTNDADM1                 TO WDTNDSUB1
      STORE WDTND2+WDTNDADM2                 TO WDTNDSUB2
      STORE WDTND3+WDTNDADM3                 TO WDTNDSUB3
      IF WFLAGREC
         STORE WDTNDSUB1*(WFACUTIEMP/100)    TO WDTNDUTI1
         STORE WDTNDSUB2*(WFACUTIEMP/100)    TO WDTNDUTI2
         STORE WDTNDSUB3*(WFACUTIEMP/100)    TO WDTNDUTI3
      ENDIF
      STORE WDTNDSUB1+WDTNDUTI1              TO WDTND1
      STORE WDTNDSUB2+WDTNDUTI2              TO WDTND2
      STORE WDTNDSUB3+WDTNDUTI3              TO WDTND3

      STORE (WSALBAS1+WBONOCO1)/2 TO WPRIDOM1
      STORE (WSALBAS2+WBONOCO2)/2 TO WPRIDOM2
      STORE (WSALBAS3+WBONOCO3)/2 TO WPRIDOM3
      IF UPPER(WDESCOM)="S"
         STORE WTOTBON1+WSALBAS1+WBONOCO1+WPRIDOM1 TO WDTD1
      ELSE
         STORE WTOTBON1+WPRIDOM1                   TO WDTD1
      ENDIF
      STORE WDTD1+(WDTD1*(WFACUTIPER/100))         TO WDTD1
      STORE WDTD1+(WDTD1*(WFACLIQ/100))            TO WDTD1
      IF UPPER(WDESCOM)="S"
         STORE WTOTBON2+WSALBAS2+WBONOCO2+WPRIDOM2 TO WDTD2
      ELSE
         STORE WTOTBON2+WPRIDOM2                   TO WDTD2
      ENDIF
      STORE WDTD2+(WDTD2*(WFACUTIPER/100))         TO WDTD2
      STORE WDTD2+(WDTD2*(WFACLIQ/100))            TO WDTD2
      IF UPPER(WDESCOM)="S"
         STORE WTOTBON3+WSALBAS3+WBONOCO3+WPRIDOM3 TO WDTD3
      ELSE
         STORE WTOTBON3+WPRIDOM3                   TO WDTD3
      ENDIF
      STORE WTOTBON3+WSALBAS3+WBONOCO3+WPRIDOM3    TO WDTD3
      STORE WDTD3+(WDTD3*(WFACUTIPER/100))         TO WDTD3
      STORE WDTD3+(WDTD3*(WFACLIQ/100))            TO WDTD3
      IF WFLAGREC
         STORE WDTD1*(WFACADMEMP/100)        TO WDTDADM1
         STORE WDTD2*(WFACADMEMP/100)        TO WDTDADM2
         STORE WDTD3*(WFACADMEMP/100)        TO WDTDADM3
      ENDIF
      STORE WDTD1+WDTDADM1                   TO WDTDSUB1
      STORE WDTD2+WDTDADM2                   TO WDTDSUB2
      STORE WDTD3+WDTDADM3                   TO WDTDSUB3
      IF WFLAGREC
         STORE WDTDSUB1*(WFACUTIEMP/100)     TO WDTDUTI1
         STORE WDTDSUB2*(WFACUTIEMP/100)     TO WDTDUTI2
         STORE WDTDSUB3*(WFACUTIEMP/100)     TO WDTDUTI3
      ENDIF
      STORE WDTDSUB1+WDTDUTI1                TO WDTD1
      STORE WDTDSUB2+WDTDUTI2                TO WDTD2
      STORE WDTDSUB3+WDTDUTI3                TO WDTD3

      *** FUERA DE USO
      STORE WTOTBON1 TO WFT1
      STORE WTOTBON2 TO WFT2
      STORE WTOTBON3 TO WFT3
      STORE (WFT1+(WFT1*(WFACADMEMP/100)))     TO WFT1
      STORE (WFT1+(WFT1*(WFACUTIEMP/100)))     TO WFT1
      STORE (WFT2+(WFT2*(WFACADMEMP/100)))     TO WFT2
      STORE (WFT2+(WFT2*(WFACUTIEMP/100)))     TO WFT2
      STORE (WFT3+(WFT3*(WFACADMEMP/100)))     TO WFT3
      STORE (WFT3+(WFT3*(WFACUTIEMP/100)))     TO WFT3
      ***

      STORE WFACCESTA*(WFACADMEMP/100)         TO WCESTAADM
      STORE WFACCESTA+WCESTAADM                TO WCESTASUB
      STORE WCESTASUB*(WFACUTIEMP/100)         TO WCESTAUTI
      STORE WCESTASUB+WCESTAUTI                TO WCESTA

      *** GRABAR LOS RESULTADOS EN LA PARTIDA
      SELECT 4
      REPLACE  BSTMPVIA1    WITH WTMPVIA1
      REPLACE  BSTMPVIA2    WITH WTMPVIA2
      REPLACE  BSTMPVIA3    WITH WTMPVIA3
      REPLACE  BSBONONOC1   WITH WBONONOCT1
      REPLACE  BSBONONOC2   WITH WBONONOCT2
      REPLACE  BSBONONOC3   WITH WBONONOCT3
      REPLACE  BSREPCOM1    WITH WREPCOM1
      REPLACE  BSREPCOM2    WITH WREPCOM2
      REPLACE  BSREPCOM3    WITH WREPCOM3
      REPLACE  BSSTG1       WITH WSTG1
      REPLACE  BSSTG2       WITH WSTG2
      REPLACE  BSSTG3       WITH WSTG3
      REPLACE  BSTOTBON1    WITH WTOTBON1
      REPLACE  BSTOTBON2    WITH WTOTBON2
      REPLACE  BSTOTBON3    WITH WTOTBON3
      REPLACE  BSBONOVAC1   WITH WBONOVAC1
      REPLACE  BSBONOVAC2   WITH WBONOVAC2
      REPLACE  BSBONOVAC3   WITH WBONOVAC3
      REPLACE  BSUTIPER1    WITH WUTIPER1
      REPLACE  BSUTIPER2    WITH WUTIPER2
      REPLACE  BSUTIPER3    WITH WUTIPER3
      REPLACE  BSLIQUI1     WITH WLIQUI1
      REPLACE  BSLIQUI2     WITH WLIQUI2
      REPLACE  BSLIQUI3     WITH WLIQUI3
      REPLACE  BSPREAVI1    WITH WPREAVI1
      REPLACE  BSPREAVI2    WITH WPREAVI2
      REPLACE  BSPREAVI3    WITH WPREAVI3
      REPLACE  BSVACA1      WITH WVACA1
      REPLACE  BSVACA2      WITH WVACA2
      REPLACE  BSVACA3      WITH WVACA3
      REPLACE  BSIMPREVI1   WITH WIMPREVI1
      REPLACE  BSIMPREVI2   WITH WIMPREVI2
      REPLACE  BSIMPREVI3   WITH WIMPREVI3
      REPLACE  BSSSO        WITH WSSO
      REPLACE  BSSPF        WITH WSPF
      REPLACE  BSINCE1      WITH WINCE1
      REPLACE  BSINCE2      WITH WINCE2
      REPLACE  BSINCE3      WITH WINCE3
      REPLACE  BSLAH        WITH WLAH
      REPLACE  BSBONOTRA    WITH WBONOTRAN
      REPLACE  BSBONOALI    WITH WBONOALIM
      REPLACE  BSEQUIPO     WITH WEQUIPO
      REPLACE  BSTOTGAST1   WITH WTOTGAST1
      REPLACE  BSTOTGAST2   WITH WTOTGAST2
      REPLACE  BSTOTGAST3   WITH WTOTGAST3
      REPLACE  BSGASTADM1   WITH WGASTADM1
      REPLACE  BSGASTADM2   WITH WGASTADM2
      REPLACE  BSGASTADM3   WITH WGASTADM3
      REPLACE  BSSUBTOT11   WITH WSUBTOT11
      REPLACE  BSSUBTOT12   WITH WSUBTOT12
      REPLACE  BSSUBTOT13   WITH WSUBTOT13
      REPLACE  BSUTIEMP1    WITH WUTIEMP1
      REPLACE  BSUTIEMP2    WITH WUTIEMP2
      REPLACE  BSUTIEMP3    WITH WUTIEMP3
      REPLACE  BSSUBTOT21   WITH WSUBTOT21
      REPLACE  BSSUBTOT22   WITH WSUBTOT22
      REPLACE  BSSUBTOT23   WITH WSUBTOT23
      REPLACE  BSDESNOR1    WITH WDESNOR1
      REPLACE  BSDESNOR2    WITH WDESNOR2
      REPLACE  BSDESNOR3    WITH WDESNOR3
      REPLACE  BSCOSTO1     WITH WCOSTO1
      REPLACE  BSCOSTO2     WITH WCOSTO2
      REPLACE  BSCOSTO3     WITH WCOSTO3
      REPLACE  BSST1        WITH WHORST1
      REPLACE  BSSTADM1     WITH WHRSTADM1
      REPLACE  BSSTUTI1     WITH WHRSTUTI1
      REPLACE  BSST2        WITH WHORST2
      REPLACE  BSSTADM2     WITH WHRSTADM2
      REPLACE  BSSTUTI2     WITH WHRSTUTI2
      REPLACE  BSST3        WITH WHORST3
      REPLACE  BSSTADM3     WITH WHRSTADM3
      REPLACE  BSSTUTI3     WITH WHRSTUTI3
      REPLACE  BSDTND1      WITH WDTND1
      REPLACE  BSDTNDADM1   WITH WDTNDADM1
      REPLACE  BSDTNDUTI1   WITH WDTNDUTI1
      REPLACE  BSDTND2      WITH WDTND2
      REPLACE  BSDTNDADM2   WITH WDTNDADM2
      REPLACE  BSDTNDUTI2   WITH WDTNDUTI2
      REPLACE  BSDTND3      WITH WDTND3
      REPLACE  BSDTNDADM3   WITH WDTNDADM3
      REPLACE  BSDTNDUTI3   WITH WDTNDUTI3
      REPLACE  BSDTD1       WITH WDTD1
      REPLACE  BSDTDADM1    WITH WDTDADM1
      REPLACE  BSDTDUTI1    WITH WDTDUTI1
      REPLACE  BSDTD2       WITH WDTD2
      REPLACE  BSDTDADM2    WITH WDTDADM2
      REPLACE  BSDTDUTI2    WITH WDTDUTI2
      REPLACE  BSDTD3       WITH WDTD3
      REPLACE  BSDTDADM3    WITH WDTDADM3
      REPLACE  BSDTDUTI3    WITH WDTDUTI3
      REPLACE  BSCESTA      WITH WCESTA
      REPLACE  BSCESTAADM   WITH WCESTAADM
      REPLACE  BSCESTAUTI   WITH WCESTAUTI
      STORE .T. TO WFLAGPRE
   ENDDO
   IF .NOT. WFLAGPRE
      LOOP
   ENDIF
   STORE "CALCULANDO COSTOS UNITARIOS DEL PRESUPUESTO, FAVOR ESPERAR..." TO MES
   DO MENSAJE WITH MES
   STORE 0 TO WTBSDNT1
   STORE 0 TO WTBSDNT2
   STORE 0 TO WTBSDNT3
   STORE 0 TO WTBSHST1
   STORE 0 TO WTBSHST2
   STORE 0 TO WTBSHST3
   STORE 0 TO WTBSDTND1
   STORE 0 TO WTBSDTND2
   STORE 0 TO WTBSDTND3
   STORE 0 TO WTBSDTD1
   STORE 0 TO WTBSDTD2
   STORE 0 TO WTBSDTD3
   STORE 0 TO WTBSCESTA
   STORE 0 TO WTOTPERSON
   SELECT 4
   SET EXACT OFF
   FIND &WCODPRE
   SET EXACT ON
   DO WHILE .NOT. EOF() .AND. CODPRE = WCODPRE
      *** ACUMULADORES DE MONTOS POR PARTIDA
      STORE WTBSDNT1   + BSCOSTO1*CANTIDAD  TO WTBSDNT1
      STORE WTBSDNT2   + BSCOSTO2*CANTIDAD  TO WTBSDNT2
      STORE WTBSDNT3   + BSCOSTO3*CANTIDAD  TO WTBSDNT3
      STORE WTBSHST1   + BSST1*CANTIDAD     TO WTBSHST1
      STORE WTBSHST2   + BSST2*CANTIDAD     TO WTBSHST2
      STORE WTBSHST3   + BSST3*CANTIDAD     TO WTBSHST3
      STORE WTBSDTND1  + BSDTND1*CANTIDAD   TO WTBSDTND1
      STORE WTBSDTND2  + BSDTND2*CANTIDAD   TO WTBSDTND2
      STORE WTBSDTND3  + BSDTND3*CANTIDAD   TO WTBSDTND3
      STORE WTBSDTD1   + BSDTD1*CANTIDAD    TO WTBSDTD1
      STORE WTBSDTD2   + BSDTD2*CANTIDAD    TO WTBSDTD2
      STORE WTBSDTD3   + BSDTD3*CANTIDAD    TO WTBSDTD3
      STORE WTBSCESTA  + BSCESTA*CANTIDAD   TO WTBSCESTA
      STORE WTOTPERSON + CANTIDAD           TO WTOTPERSON
      SELECT 4
      SKIP
   ENDDO
   *** PROMEDIO DE MONTOS PARA EL PRESUPUESTO (COSTOS UNITARIOS)
   SELECT 3
   REPLACE CUDNT1  WITH ROUND(WTBSDNT1   / WTOTPERSON,2)
   REPLACE CUDNT2  WITH ROUND(WTBSDNT2   / WTOTPERSON,2)
   REPLACE CUDNT3  WITH ROUND(WTBSDNT3   / WTOTPERSON,2)
   REPLACE CUHST1  WITH ROUND(WTBSHST1   / WTOTPERSON,2)
   REPLACE CUHST2  WITH ROUND(WTBSHST2   / WTOTPERSON,2)
   REPLACE CUHST3  WITH ROUND(WTBSHST3   / WTOTPERSON,2)
   REPLACE CUDTND1 WITH ROUND(WTBSDTND1  / WTOTPERSON,2)
   REPLACE CUDTND2 WITH ROUND(WTBSDTND2  / WTOTPERSON,2)
   REPLACE CUDTND3 WITH ROUND(WTBSDTND3  / WTOTPERSON,2)
   REPLACE CUDTD1  WITH ROUND(WTBSDTD1   / WTOTPERSON,2)
   REPLACE CUDTD2  WITH ROUND(WTBSDTD2   / WTOTPERSON,2)
   REPLACE CUDTD3  WITH ROUND(WTBSDTD3   / WTOTPERSON,2)
   REPLACE CUCESTA WITH ROUND(WTBSCESTA  / WTOTPERSON,2)
ENDDO

