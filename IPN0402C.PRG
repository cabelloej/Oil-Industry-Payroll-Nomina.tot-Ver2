SAVE SCRE TO SCREVAL
*********************************
* mantenimiento de valuaciones  *
*********************************
SELECT 1
USE IPNPREF  INDEX IPNPREF
SELECT 2
USE IPNVALF  INDEX IPNVALF
SELECT 3
USE IPNOMINA INDEX IPNOMINA
SELECT 4
USE IPNHISTO INDEX IPNHISTO, IPNHIST2
STORE SPACE(6) TO WCODPRE
SET COLOR TO W/N
STORE .T. TO PRE
DO WHILE PRE
   SET COLOR TO W/N
   @ 00,0 CLEAR 
   @ 00,0 SAY QQWW
   @ 01,0 SAY "               A C T U A L I Z A R     V A L U A C I O N E S                    "
   @ 02,0 SAY "+-----------+------------------------------------------------------------------+"
   @ 03,0 SAY "|OBRA:      |DESC.:                                                            |"
   @ 04,0 SAY "+-----------+---+--------------------+----------------+------------------------+"
   @ 05,0 SAY "|VAL.:          |FECHA:              |DESDE:          |HASTA:                  |"
   @ 06,0 SAY "+---------------+--------------------+------------+---+---------+--------------+"
   @ 07,0 SAY "|DESCRIPCION                         |CANT.CONTRA.| CANT.EJECUT.|CANT.ACUMULADA|"
   @ 08,0 SAY "+------------------------------------+------------+-------------+--------------+"
   @ 09,0 SAY "|1.1 DIAS/H NORMALES DE TRABAJO      |            |             |              |"
   @ 10,0 SAY "|1.2 HORAS/H DE SOBRETIEMPO          |            |             |              |"
   @ 11,0 SAY "|1.3 DIAS/H DESC.TRABAJADO (NO DOM.) |            |             |              |"
   @ 12,0 SAY "|1.4 DIAS/H DESC.TRABAJADO (DOM/FER.)|            |             |              |"
   @ 13,0 SAY "|2.1 DIAS/H NORMALES DE TRABAJO      |            |             |              |"
   @ 14,0 SAY "|2.2 HORAS/H DE SOBRETIEMPO          |            |             |              |"
   @ 15,0 SAY "|2.3 DIAS/H DESC.TRABAJADO (NO DOM.) |            |             |              |"
   @ 16,0 SAY "|2.4 DIAS/H DESC.TRABAJADO (DOM/FER.)|            |             |              |"
   @ 17,0 SAY "|3.1 DIAS/H NORMALES DE TRABAJO      |            |             |              |"
   @ 18,0 SAY "|3.2 HORAS/H DE SOBRETIEMPO          |            |             |              |"
   @ 19,0 SAY "|3.3 DIAS/H DESC.TRABAJADO (NO DOM.) |            |             |              |"
   @ 20,0 SAY "|3.4 DIAS/H DESC.TRABAJADO (DOM/FER.)|            |             |              |"
   @ 21,0 SAY "|4.  CESTA BASICA                    |            |             |              |"
   @ 22,0 SAY "+------------------------------------+------------+-------------+--------------+"
   STORE "CODIGO DE LA OBRA A EVALUAR" to mes
   do mensaje with mes
   @ 3,6 GET WCODPRE
   READ
   if wcodpre = space(6).OR.READKEY()=12.OR.READKEY()=268
      close data
      close index
      @ 0,0 CLEAR
      RESTORE SCRE FROM SCREVAL
      return
   endif
   select 1
   FIND &wcodpre
   IF EOF()
      STORE "Codigo de presupuesto no registrado, (Ù)" to mes
      do aviso with mes
      loop
   endif
   store descri   to wdescri
   store nomina   to wnomina
   @ 03,19 SAY WDESCRI
   select 2
   store space(6)         to wcodval
   store ctod("  -  -    ") to whasta
   store ctod("  -  -    ") to wdesde
   set exact off
   find &WCODPRE
   set exact ON
   do while .not. eof() .and. CODPRE = WCODPRE
      store codval     to wcodval
      store hasta+1    to wdesde
      skip
   enddo
   STORE RTRIM(LTRIM(STR(VAL(WCODVAL)+1,6)))  TO WCODVAL
   STORE WCODVAL+SPACE(6-LEN(WCODVAL))        TO WCODVAL
   store "Ingrese codigo de Valuacion a actualizar, IMP=Imprimir Valuacion, <ESC>=Salir" to mes
   do mensaje with mes
   @ 5,6 get wcodval
   read
   if WCODVAL = space(6).or.readkey()=12.or.readkey()=268
      loop
   endif
   if wcodval="IMP"
     * do ipn0404A
      LOOP
   endif
   store wcodpre+wcodval to wclaveval
   SELECT 2
   find &wclaveval
   IF EOF()
      store "Valuacion no registrada, (I)ngresar, (S)alir" to mes
      store "I" to p1
      store "S" to p2
      store " " to resp
      do pide2 with p1,p2,mes,resp
      if resp = "S"
         loop
      endif
      store wfecact to wfecha
      @ 05,23 get wfecha
      @ 05,44 get wdesde
      @ 05,61 get whasta
      READ
      STORE "Opciones: (A)ceptar, (R)echazar" to mes
      store "A" to p1
      store "R" to p2
      store " " to resp
      do pide2 with p1,p2,mes,resp
      if resp = "R"
         loop
      endif
      SELECT 2
      APPEND BLANK
      REPLACE CODPRE     WITH WCODPRE
      REPLACE CODVAL     WITH WCODVAL
      REPLACE FECHA      WITH WFECHA
      REPLACE DESDE      WITH WDESDE
      REPLACE HASTA      WITH WHASTA
   ELSE
      STORE FECHA TO WFECHA
      STORE DESDE TO WDESDE
      STORE HASTA TO WHASTA
      @ 05,23 say wfecha
      @ 05,44 say wdesde
      @ 05,61 say whasta
      STORE "OPCIONES: (M)ODIFICAR, (E)LIMINAR, (S)ALIR" TO MES
      STORE "M" TO P1
      STORE "E" TO P2
      STORE "S" TO P3
      STORE " " TO RESP
      DO PIDE3 WITH P1,P2,P3,MES,RESP
      STORE RESP TO WRESP
      IF WRESP = "S"
         LOOP
      ENDIF
      IF WRESP =  "E"
         STORE "ESTA SEGURO ? (S/N)" TO MES
         STORE "S" TO P1
         STORE "N" TO P2
         STORE " " TO RESP
         STORE RESP TO WRESP
         DO PIDE2 WITH P1,P2,MES,RESP
         IF RESP = "S"
            SELECT 2
            DELETE
            LOOP
         ELSE
            LOOP
         ENDIF
      ENDIF
      IF WRESP = "M"
         @ 05,23 get wfecha
         @ 05,44 get wdesde
         @ 05,61 get whasta
         READ
         STORE "Opciones: (A)ceptar, (R)echazar" to mes
         store "A" to p1
         store "R" to p2
         store " " to resp
         do pide2 with p1,p2,mes,resp
         if resp = "R"
            loop
         endif
         SELECT 2
         REPLACE FECHA      WITH WFECHA
         REPLACE DESDE      WITH WDESDE
         REPLACE HASTA      WITH WHASTA
      ENDIF
   ENDIF
   SELECT 2
   STORE RECNO() TO WRECVAL
   STORE "CALCULANDO VALUACION, FAVOR ESPERAR..." TO MES
   DO MENSAJE WITH MES
   SELECT 3
   FIND &WNOMINA
   IF EOF()
      STORE "ERROR, CODIGO DE NOMINA NO REGISTRADO EN EL SISTEMA, VERIFIQUE" TO MES
      DO AVISO WITH MES
      LOOP
   ENDIF
   STORE 0 TO WDNT1
   STORE 0 TO WDNT2
   STORE 0 TO WDNT3
   STORE 0 TO WHST1
   STORE 0 TO WHST2
   STORE 0 TO WHST3
   STORE 0 TO WDTND1
   STORE 0 TO WDTND2
   STORE 0 TO WDTND3
   STORE 0 TO WDTD1
   STORE 0 TO WDTD2
   STORE 0 TO WDTD3
   STORE 0 TO WCESTA
   STORE 0 TO WACDNT1
   STORE 0 TO WACDNT2
   STORE 0 TO WACDNT3
   STORE 0 TO WACHST1
   STORE 0 TO WACHST2
   STORE 0 TO WACHST3
   STORE 0 TO WACDTND1
   STORE 0 TO WACDTND2
   STORE 0 TO WACDTND3
   STORE 0 TO WACDTD1
   STORE 0 TO WACDTD2
   STORE 0 TO WACDTD3
   STORE 0 TO WACCESTA
   SELECT 4
   GO TOP
   DO WHILE .NOT. EOF()
      IF NOMINA<>WNOMINA
         SELECT 4
         SKIP
         LOOP
      ENDIF
      IF FECHA < WDESDE
         SELECT 4
         SKIP
         LOOP
      ENDIF
      IF FECHA > WHASTA
         SELECT 4
         SKIP
         LOOP
      ENDIF
      *** ACUMULADOS DE LA VALUACION
      STORE WDNT1 + (HRORDD/8)         TO WDNT1
      STORE WDNT2 + (HRORDM/8)         TO WDNT2
      STORE WDNT3 + (HRORDN/8)         TO WDNT3
      STORE WHST1 + (HRSTDA+HRSTDB)    TO WHST1
      STORE WHST2 + (HRSTMA+HRSTMB)    TO WHST2
      STORE WHST3 + (HRSTNA+HRSTNB)    TO WHST3
      IF CTDESCON = "M"
         STORE WDTND2 + (HRDESCON/8) TO WDTND2
      ELSE
         IF CTDESCON = "N"
            STORE WDTND3 + (HRDESCON/8) TO WDTND3
         ELSE
            STORE WDTND1 + (HRDESCON/8) TO WDTND1
         ENDIF
      ENDIF
      IF CTDESLEG = "M"
         STORE WDTD2 + (HRDESLEG/8) TO WDTD2
      ELSE
         IF CTDESLEG = "N"
            STORE WDTD3 + (HRDESLEG/8) TO WDTD3
         ELSE
            STORE WDTD1 + (HRDESLEG/8) TO WDTD1
         ENDIF
      ENDIF
      *** FERIADOS TRABAJADOS EN DIA NORMAL DE TRABAJO
      IF FERPRID > 0
         STORE WDTD1 + FTDNOR TO WDTD1
         STORE WDNT1 - FTDNOR TO WDNT1
      ENDIF
      IF FERPRIM > 0
         STORE WDTD2 + FTMNOR TO WDTD2
         STORE WDNT2 - FTMNOR TO WDNT2
      ENDIF
      IF FERPRIN > 0
         STORE WDTD3 + FTNNOR TO WDTD3
         STORE WDNT3 - FTNNOR TO WDNT3
      ENDIF
      IF BSCESTA > 0
         STORE WCESTA + 1 TO WCESTA
      ENDIF
      SELECT 4
      SKIP
   ENDDO
   ***
   SET EXACT OFF
   SELECT 2
   FIND &WCODPRE
   SET EXACT ON
   DO WHILE.NOT.EOF().AND.CODPRE=WCODPRE.AND.CODVAL<WCODVAL
      *** ACUMULADOS ANTES DE LA VALUACION
      STORE WACDNT1  + DNT1   TO WACDNT1
      STORE WACDNT2  + DNT2   TO WACDNT2
      STORE WACDNT3  + DNT3   TO WACDNT3
      STORE WACHST1  + HST1   TO WACHST1
      STORE WACHST2  + HST2   TO WACHST2
      STORE WACHST3  + HST3   TO WACHST3
      STORE WACDTND1 + DTND1  TO WACDTND1
      STORE WACDTND2 + DTND2  TO WACDTND2
      STORE WACDTND3 + DTND3  TO WACDTND3
      STORE WACDTD1  + DTD1   TO WACDTD1
      STORE WACDTD2  + DTD2   TO WACDTD2
      STORE WACDTD3  + DTD3   TO WACDTD3
      STORE WACCESTA + CESTA  TO WACCESTA
      SELECT 2
      SKIP
   ENDDO
   SELECT 2
   GO WRECVAL
   REPLACE ACDNT1     WITH WACDNT1
   REPLACE ACDNT2     WITH WACDNT2
   REPLACE ACDNT3     WITH WACDNT3
   REPLACE ACHST1     WITH WACHST1
   REPLACE ACHST2     WITH WACHST2
   REPLACE ACHST3     WITH WACHST3
   REPLACE ACDTND1    WITH WACDTND1
   REPLACE ACDTND2    WITH WACDTND2
   REPLACE ACDTND3    WITH WACDTND3
   REPLACE ACDTD1     WITH WACDTD1
   REPLACE ACDTD2     WITH WACDTD2
   REPLACE ACDTD3     WITH WACDTD3
   REPLACE ACCESTA    WITH WACCESTA
   REPLACE DNT1       WITH WDNT1
   REPLACE DNT2       WITH WDNT2
   REPLACE DNT3       WITH WDNT3
   REPLACE HST1       WITH WHST1
   REPLACE HST2       WITH WHST2
   REPLACE HST3       WITH WHST3
   REPLACE DTND1      WITH WDTND1
   REPLACE DTND2      WITH WDTND2
   REPLACE DTND3      WITH WDTND3
   REPLACE DTD1       WITH WDTD1
   REPLACE DTD2       WITH WDTD2
   REPLACE DTD3       WITH WDTD3
   REPLACE CESTA      WITH WCESTA
   REPLACE CUDNT1     WITH IPNPREF->CUDNT1
   REPLACE CUDNT2     WITH IPNPREF->CUDNT2
   REPLACE CUDNT3     WITH IPNPREF->CUDNT3
   REPLACE CUHST1     WITH IPNPREF->CUHST1
   REPLACE CUHST2     WITH IPNPREF->CUHST2
   REPLACE CUHST3     WITH IPNPREF->CUHST3
   REPLACE CUDTND1    WITH IPNPREF->CUDTND1
   REPLACE CUDTND2    WITH IPNPREF->CUDTND2
   REPLACE CUDTND3    WITH IPNPREF->CUDTND3
   REPLACE CUDTD1     WITH IPNPREF->CUDTD1
   REPLACE CUDTD2     WITH IPNPREF->CUDTD2
   REPLACE CUDTD3     WITH IPNPREF->CUDTD3
   REPLACE CUCESTA    WITH IPNPREF->CUCESTA

   @ 09,40 SAY IPNPREF->DNT1
   @ 10,40 SAY IPNPREF->HST1
   @ 11,40 SAY IPNPREF->DND1
   @ 12,40 SAY IPNPREF->DSD1
   @ 13,40 SAY IPNPREF->DNT2
   @ 14,40 SAY IPNPREF->HST2
   @ 15,40 SAY IPNPREF->DND2
   @ 16,40 SAY IPNPREF->DSD2
   @ 17,40 SAY IPNPREF->DNT3
   @ 18,40 SAY IPNPREF->HST3
   @ 19,40 SAY IPNPREF->DND3
   @ 20,40 SAY IPNPREF->DSD3
   @ 21,40 SAY IPNPREF->CEST

   @ 09,54 SAY IPNVALF->DNT1
   @ 10,54 SAY IPNVALF->HST1
   @ 11,54 SAY IPNVALF->DTND1
   @ 12,54 SAY IPNVALF->DTD1
   @ 13,54 SAY IPNVALF->DNT2
   @ 14,54 SAY IPNVALF->HST2
   @ 15,54 SAY IPNVALF->DTND2
   @ 16,54 SAY IPNVALF->DTD2
   @ 17,54 SAY IPNVALF->DNT3
   @ 18,54 SAY IPNVALF->HST3
   @ 19,54 SAY IPNVALF->DTND3
   @ 20,54 SAY IPNVALF->DTD3
   @ 21,54 SAY IPNVALF->CESTA

   @ 09,68 SAY IPNVALF->ACDNT1  + IPNVALF->DNT1
   @ 10,68 SAY IPNVALF->ACHST1  + IPNVALF->HST1
   @ 11,68 SAY IPNVALF->ACDTND1 + IPNVALF->DTND1
   @ 12,68 SAY IPNVALF->ACDTD1  + IPNVALF->DTD1
   @ 13,68 SAY IPNVALF->ACDNT2  + IPNVALF->DNT2
   @ 14,68 SAY IPNVALF->ACHST2  + IPNVALF->HST2
   @ 15,68 SAY IPNVALF->ACDTND2 + IPNVALF->DTND2
   @ 16,68 SAY IPNVALF->ACDTD2  + IPNVALF->DTD2
   @ 17,68 SAY IPNVALF->ACDNT3  + IPNVALF->DNT3
   @ 18,68 SAY IPNVALF->ACHST3  + IPNVALF->HST3
   @ 19,68 SAY IPNVALF->ACDTND3 + IPNVALF->DTND3
   @ 20,68 SAY IPNVALF->ACDTD3  + IPNVALF->DTD3
   @ 21,68 SAY IPNVALF->ACCESTA + IPNVALF->CESTA

   STORE "OPRIMA <ENTER> PARA CONTINUAR" TO MES
   DO AVISO WITH MES
ENDDO

