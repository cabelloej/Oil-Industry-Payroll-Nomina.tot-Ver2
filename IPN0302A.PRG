******************************************************************************
*               pago de utilidades                                           *
******************************************************************************
store "INSTALACION NO AUTORIZADA" TO WARNING
SELECT 1
USE IPNPERSO INDEX IPNPERSO ALIAS PERSONAL
SELECT 2
USE IPNHISTO index ipnhisto, IPNHIST2 ALIAS HISTORICO
SELECT 3
USE IPNUTILI ALIAS UTILIDAD
SELECT 10
USE IPNOMINA INDEX IPNOMINA
STORE .T. TO UTIL
DO WHILE UTIL
   SET COLOR TO W+/B
   @ 5,0 CLEAR TO 16,50
   @ 5,0 TO 16,50 DOUBLE
   STORE "PAGO DE UTILIDADES" TO HEADING
   @ 5,25-(LEN(HEADING)/2) SAY HEADING
   STORE SPACE(10) TO WCEDULA
   STORE "INGRESE LA CEDULA A PROCESAR" TO MES
   DO MENSAJE WITH MES
   @ 8,2 SAY "CEDULA :" GET WCEDULA
   READ
   IF WCEDULA = SPACE(10)
      STORE .F. TO UTIL
      LOOP
   ENDIF
   SELECT PERSONAL
   SEEK WCEDULA
   IF .NOT. FOUND()
      STORE "CEDULA NO REGISTRADA" TO MES
      DO AVISO WITH MES
      LOOP
   ENDIF
   store sueldo     to wbasico
   store BONOCO     to wbONOCO
   STORE NOMINA     TO WNOMINA
   STORE UTILIDAD+1 TO INIDATE
   STORE CONTRATO   TO WCONTRATO
   STORE INGRESO    TO WINGRESO
   store nombre     to wnombre
   store apellido   to wapellido
   store tipo       to wtipo
   STORE SINDICATO  TO WSIND
   SELECT IPNOMINA
   SEEK WNOMINA
   IF .NOT. FOUND()
      STORE "NOMINA NO REGISTRADA " TO MES
      DO AVISO WITH MES
      LOOP
   ENDIF
    
   IF INIDATE = CTOD("  -  -    ")
      STORE WINGRESO TO INIDATE
   ENDIF
   STORE "FECHA INICIAL DE LAS UTILIDADES, (  -  -    ) para regresar)" TO MES
   DO MENSAJE WITH MES
   @ 10,2 SAY "FECHA DE INICIO:" GET INIDATE
   READ
   if INIDATE = CTOD("  -  -    ")
      loop
   endif

   store wfecact to wfindate
   STORE "FECHA DE CIERRE DE LAS UTILIDADES, (  -  -    ) para regresar)" TO MES
   DO MENSAJE WITH MES
   @ 12,2 SAY "FECHA DE CIERRE:" GET WFINDATE
   READ
   if wFINDATE = CTOD("  -  -    ")
      loop
   endif
   if wfindate < inidate
      store "ERROR, la fecha de pago de su ultima utilidad es mayor a la solicitadad" to mes
      do aviso with mes
      loop
   endif
   if wfindate = inidate
      store "ERROR, cedula ya procesada en este a¤o. desea repetir operacion (S/N)" to mes
      store "S" to p1
      store "N" to p2
      store " " to resp
      do pide2 with p1,p2,mes,resp
      if resp = "N"
         loop
      else
         replace utilidad with lastutil
         if utilidad= ctod("  -  -    ")
            store wingreso to inidate
         else
            store utilidad to inidate
         endif
      endif
   endif

   store DATE() to WFECSEEK
   STORE "FECHA DE CIERRE DEL ULTIMO PAGO VALIDO, (  -  -    ) para regresar)" TO MES
   DO MENSAJE WITH MES
   @ 14,2 SAY "A FECHA DE PAGO:" GET WFECSEEK
   READ
   if WFECSEEK = CTOD("  -  -    ")
      loop
   endif
   STORE "OPCIONES: (C)ONTINUAR,  (S)ALIR" to mes
   store "C" to p1
   store "S" to p2
   store " " to resp
   do pide2 with p1,p2,mes,resp
   if resp = "S"
      close data
      close index
      return
   endif

   store "PROCESANDO INFORMACION, FAVOR ESPERAR..." to mes
   do mensaje with mes

   STORE ((WFINDATE - INIDATE)+1)/30 TO WMESES
   STORE ROUND(WMESES,1) TO WMESES

   STORE SPACE(35) TO QQWW
   DO INFORMA WITH QQWW
   IF QQWW <> t3
      STORE 1 TO POSI
      else
      STORE 0 TO POSI
   ENDIF

   SELECT UTILIDAD
   LOCATE FOR CONTRATO = WCONTRATO
   IF .NOT. FOUND()
      STORE "ERROR, cedula con contrato invalido" to mes
      do aviso with mes
      loop
   endif

   STORE "NINGUNA" TO WFORMAPAGO
   IF DIAS > 0 .AND. PORCENTAJE = 0
      STORE "DIAS" TO WFORMAPAGO
   ENDIF
   IF PORCENTAJE > 0 .AND. DIAS = 0
      STORE "PORCENTAJE" TO WFORMAPAGO
      STORE PORCENTAJE TO WPORCIENTO
   ENDIF
   IF WFORMAPAGO = "NINGUNA"
      STORE "ERROR, archivo de formas de pago de utilidades a sido alterado" to mes
      do aviso with mes
      loop
   endif

***************************************************************************

   if wformapago = "DIAS"
      if WCONTRATO = "PETROLERO"
         STORE "IPNPETRO.DBF" TO WLIQUIDA
      ENDIF
      IF WCONTRATO = "LDT"
         STORE "IPNLDT.DBF" TO WLIQUIDA
      ENDIF
      IF WCONTRATO = "CONSTRUCCION"
         STORE "IPNCONST.DBF" TO WLIQUIDA
      ENDIF
      IF WCONTRATO = "PEQUIVEN"
         STORE "IPNPEQUI.DBF" TO WLIQUIDA
      ENDIF

      SELECT 4
      USE &WLIQUIDA
      LOCATE FOR MESES > WMESES
      IF .NOT. FOUND()
         STORE "ERROR, NO SE ENCONTRO REGISTRO DE MESES A PAGAR" TO MES
         DO AVISO WITH MES
         LOOP
      ENDIF
      GO RECNO() - 1
      STORE UTILIDAD TO WDIASUTIL

      store " "+ltrim(rtrim(str(WDIASUTIL)))+" dias del sueldo diario basico devengado durante" to forma
      *store wbasico+wbonoco to wsalbas
      *store wsalbas*wdiasutil to wutilidad

   * BUSQUEDA DE HISTORICO
   SELECT historico
   SORT TO IPNTEMP2 ON FECHA /D FOR CEDULA = WCEDULA .AND. FECHA <= WFINDATE  .AND. NOMINA <> "LIQUI"
   SELECT 4
   USE IPNTEMP2
   PACK
   IF WTIPO = "E"
      STORE 2 TO BUSCAR
      STORE 30 TO DIVIDIR
   ELSE
      STORE 4 TO BUSCAR
      STORE 28 TO DIVIDIR
   ENDIF
   * CALCULO DEL TOTAL BONIFICABLE
   STORE 0 TO CONTEO
   STORE 0 TO ACUMULADO
   STORE 0 TO UTILIDADES
   STORE 0 TO WULTBASICO
   STORE 10 TO ZX
   DO WHILE .NOT. EOF() .AND. CONTEO < BUSCAR
      IF NOMINA<>"UTLDA".AND.DESOCB1<>"V "
         STORE ACUMULADO + BSTOTBON TO ACUMULADO
         STORE CONTEO +1 TO CONTEO
         STORE BASICO               TO WULTBASICO
      ELSE
         STORE BSTOTBON             TO UTILIDADES
      ENDIF
      SKIP
   ENDDO
   STORE ACUMULADO/DIVIDIR TO PROMEDI
   STORE PROMEDI TO VARIABLE
   DO REDONDEO WITH VARIABLE
   STORE VARIABLE TO PROMEDI
   STORE ROUND(PROMEDI,2) TO PROMEDI

      *STORE PROMEDI*WDIASUTIL TO WUTILIDAD
      STORE WULTBASICO*WDIASUTIL TO WUTILIDAD
      STORE WUTILIDAD TO VARIABLE
      DO REDONDEO WITH VARIABLE
      STORE VARIABLE TO WUTILIDAD
      STORE ROUND(WUTILIDAD,2) TO WUTILIDAD

      STORE (WUTILIDAD*.5)/100 TO WINCE
      STORE WINCE TO VARIABLE
      DO REDONDEO WITH VARIABLE
      STORE VARIABLE TO WINCE
      STORE ROUND(WINCE,2) TO WINCE

      STORE WUTILIDAD*(PERSONAL->ISLR/100) TO WISLR
      STORE WISLR TO VARIABLE
      DO REDONDEO WITH VARIABLE
      STORE VARIABLE TO WISLR
      STORE ROUND(WISLR,2) TO WISLR
      
      STORE 0 TO WDECSIND

      store wutilidad-wince-wislr-wdecsind to wneto
      select 9
      use ipnince
      locate for cedula = wcedula .and. fecha = wfindate
      if found()
         replace monto with wince
      else
         append blank
         replace cedula with wcedula
         replace fecha with wfindate
         replace monto with wince
      endif
      *********** CALCULO DEL MONTO ESCRITO
      STORE WNETO TO WMONTO
      STORE INT(WMONTO/1000000) TO MILLONES
      STORE WMONTO-MILLONES*1000000 TO WMONTO
      STORE INT(WMONTO/1000) TO MILES
      STORE WMONTO-MILES*1000 TO WMONTO
      STORE INT(WMONTO/100) TO CIENTOS
      STORE WMONTO-CIENTOS*100 TO WMONTO
      STORE INT(WMONTO/10) TO DECENAS
      STORE WMONTO-DECENAS*10 TO WMONTO
      STORE INT(WMONTO/1) TO UNIDADES
      STORE WMONTO-UNIDADES*1 TO WMONTO
      STORE (WNETO-INT(WNETO))*100 TO CENTIMOS
      SELECT 9
      USE IPNMONTO
      store space(50) to escrito
      ***** MILLONES ******
      GO TOP
      LOCATE FOR VALOR > MILLONES
      IF .NOT. FOUND()
         STORE "ERROR, NO ENCONTRE LOS MILLONES APROPIADOS" TO MES
         DO AVISO WITH MES
      ENDIF
      GO RECNO()-1
      IF VALOR > 0
         STORE RTRIM(escrito)+" "+DES TO escrito
      ENDIF
      STORE MILLONES-VALOR TO RESTO
      STORE .T. TO CHECKREST
      DO WHILE CHECKREST
         GO TOP
         IF RESTO = 0
            STORE .F. TO CHECKREST
            LOOP
         ENDIF
         LOCATE FOR VALOR > RESTO
         IF .NOT. FOUND()
            STORE "ERROR, NO ENCONTRE EL RESTO DE LOS MILLONES APROPIADOS" TO MES
            DO AVISO WITH MES
         ENDIF
         GO RECNO()-1
         STORE RTRIM(escrito)+" Y "+DES TO escrito
         STORE RESTO-VALOR TO RESTO
      ENDDO
      IF MILLONES = 1
         STORE RTRIM(escrito)+" MILLON " TO escrito
      ELSE
         IF MILLONES > 1
            STORE RTRIM(escrito)+" MILLONES " TO escrito
         ENDIF
      ENDIF
      ***** MILES ******
      GO TOP
      LOCATE FOR VALOR > MILES
      IF .NOT. FOUND()
         STORE "ERROR, NO ENCONTRE LOS MILES APROPIADOS" TO MES
         DO AVISO WITH MES
      ENDIF
      GO RECNO()-1
      IF VALOR > 0
         STORE RTRIM(escrito)+" "+DES TO escrito
      ENDIF
      STORE MILES-VALOR TO RESTO
      IF MILES >= 100 .AND. MILES < 200 .AND. RESTO > 0
         STORE RTRIM(escrito)+"TO" TO escrito
      ENDIF
      STORE .T. TO CHECKREST
      DO WHILE CHECKREST
         GO TOP
         IF RESTO = 0
            STORE .F. TO CHECKREST
            LOOP
         ENDIF
         LOCATE FOR VALOR > RESTO
         IF .NOT. FOUND()
            STORE "ERROR, NO ENCONTRE EL RESTO DE LOS MILES APROPIADOS" TO MES
            DO AVISO WITH MES
         ENDIF
         GO RECNO()-1
         STORE RTRIM(escrito)+" "+DES TO escrito
         STORE RESTO-VALOR TO RESTO
      ENDDO
      IF MILES > 0
         STORE RTRIM(escrito)+" MIL " TO escrito
      ENDIF

      ***** CIENTOS ****
      GO TOP
      LOCATE FOR VALOR > CIENTOS*100
      IF .NOT. FOUND()
         STORE "ERROR, NO ENCONTRE LOS CIENTOS APROPIADOS" TO MES
         DO AVISO WITH MES
      ENDIF
      GO RECNO()-1
      IF VALOR > 0
         STORE RTRIM(escrito)+" "+DES TO escrito
      ENDIF
      IF CIENTOS = 1 .AND. DECENAS*10+UNIDADES > 0
         STORE RTRIM(escrito)+"TO" TO escrito
      ENDIF

      ***** DECENAS ****
      IF DECENAS > 1
         GO TOP
         LOCATE FOR VALOR > DECENAS*10
         IF .NOT. FOUND()
            STORE "ERROR, NO ENCONTRE LAS DECENAS APROPIADAS" TO MES
            DO AVISO WITH MES
         ENDIF
         GO RECNO()-1
         IF VALOR > 0
            STORE RTRIM(escrito)+" "+DES TO escrito
         ENDIF
      ELSE
         STORE DECENAS*10+UNIDADES TO UNIDADES
      ENDIF

      ***** UNIDADES ****
      GO TOP
      LOCATE FOR VALOR > UNIDADES
      IF .NOT. FOUND()
         STORE "ERROR, NO ENCONTRE LAS UNIDADES APROPIADAS" TO MES
         DO AVISO WITH MES
      ENDIF
      GO RECNO()-1
      IF VALOR > 0
         STORE RTRIM(escrito)+" Y "+DES TO escrito
      ENDIF
      STOR UNIDADES-VALOR TO RESTO
      STORE .T. TO CHECKREST
      DO WHILE CHECKREST
         GO TOP
         IF RESTO = 0
            STORE .F. TO CHECKREST
            LOOP
         ENDIF
         LOCATE FOR VALOR > RESTO
         IF .NOT. FOUND()
            STORE "ERROR, NO ENCONTRE EL RESTO DE LAS UNIDADES APROPIADAS" TO MES
            DO AVISO WITH MES
         ENDIF
         GO RECNO()-1
         STORE RTRIM(escrito)+" Y "+DES TO escrito
         STORE RESTO-VALOR TO RESTO
      ENDDO
      STORE RTRIM(escrito)+" Bolivares con " TO escrito

      ***** CENTIMOS ****

      STORE RTRIM(escrito)+" "+LTRIM(RTRIM(STR(CENTIMOS,5)))+" CENTIMOS" TO escrito
      *********  FIN CALCULO MONTO ESCRITO   **********


      set devi to print
      IF POSI = 1
         @ PROW(),1 SAY CHR(14)+warning+CHR(18)
         SET DEVI TO SCRE
         CLOSE DATA
         CLOSE INDEX
         QUIT
      ENDIF

      @ 1,30-(LEN(QQWW)/2) SAY CHR(14)+QQWW
      @ 1,80 SAY CHR(18)
      @ 6,3  SAY "NUMERO DE IDENTIFICACION"
      @ 6,30 SAY "NOMBRE Y APELLIDO"
      @ 6,50 SAY "UTILIDADES   (Bs.):"+STR(WUTILIDAD,9,2)
      @ 7,3  say wcedula
      @ 7,30 say rtrim(wnombre)+" "+wapellido
      @ 8,50 SAY  "DEDUCCION I.N.C.E.:"+STR(Wince,9,2)
      @ 9,50 SAY  "DEDUCCION I.S.L.R.:"+STR(WISLR,9,2)
      @ 10,3 say "Basico  : "+str(wultbasico,9,2)
      @ 10,50 SAY "Total Neto a Pagar:"+str(wneto,9,2)
      @ 15,3 say "     He recibido de "+QQWW
      @ 17,3 say "la cantidad de "+CHR(15)+escrito+CHR(18)
      @ 19,3 say "que representan "+ltrim(str(wdiasutil,9,2))+"  dias de basico del  per¡odo "+dtoc(inidate)+" al "+dtoc(wfindate)
      @ 21,3 say "por concepto de utilidades, de acuerdo con la ley organica del trabajo."
      @ 28,25 say "__________________________________"
      @ 29,25 say "        Firma del trabajador      "
      @ 32,3 say "____________________________               _______________________________"
      @ 33,3 say "        Testigo                                       Testigo             "
      @ 38,3 say RTRIM(IPNOMINA.LUGAR)+", "+dtoc(wfecact)
      @ 39,3 say "  Lugar y Fecha del Pago    "
      @ 42,50 say chr(15)+"Papel sellado inutilizado en la copia"+chr(18)
      @ 43,50 say chr(15)+"que quedan en poder de "+QQWW+chr(18)

      REPLACE PERSONAL->LASTUTIL WITH PERSONAL->UTILIDAD
      REPLACE PERSONAL->UTILIDAD WITH WFINDATE
      store (INT(wmeses))*30 to wdivide
      if wdivide > 0
         REPLACE PERSONAL->salpro WITH WUTILIDAD / wdivide
      else
         replace personal->salpro with 0
      endif
      
   ENDIF

****************************************************************************

   IF WFORMAPAGO = "PORCENTAJE"
      SELECT HISTORICO
      set exact off
      SEEK wcedula
      if .NOT. FOUND()
         STORE "No se encontraron pagos en el historico para esta cedula en este periodo" to mes
         do aviso with mes
         loop
      endif
      STORE 0        TO WTOTBON
      DO WHILE .NOT. EOF() .and. CEDULA = WCEDULA 
         IF  FECHA > INIDATE .AND. FECHA <= WFECSEEK .and. nomina <> "UTLDA" .AND. NOMINA <> "LIQUI"
            STORE WTOTBON + BSTOTBON TO WTOTBON
         ENDIF
         SKIP
      ENDDO
      set exact on
      store (wtotbon*wporciento)/100 to wutilidad
      STORE WUTILIDAD TO VARIABLE
      DO REDONDEO WITH VARIABLE
      STORE VARIABLE TO WUTILIDAD
      STORE ROUND(WUTILIDAD,2) TO WUTILIDAD

      STORE (WUTILIDAD*.5)/100 TO WINCE
      STORE WINCE TO VARIABLE
      DO REDONDEO WITH VARIABLE
      STORE VARIABLE TO WINCE
      STORE ROUND(WINCE,2) TO WINCE

      STORE WUTILIDAD*(PERSONAL->ISLR/100) TO WISLR
      STORE WISLR TO VARIABLE
      DO REDONDEO WITH VARIABLE
      STORE VARIABLE TO WISLR
      STORE ROUND(WISLR,2) TO WISLR
       
      IF WCONTRATO = "PETROLERO" .AND. WSIND <> SPACE(12)
         STORE WUTILIDAD*(0.5/100) TO WDECSIND
         STORE WDECSIND TO VARIABLE
         DO REDONDEO WITH VARIABLE
         STORE VARIABLE TO WDECSIND
         STORE ROUND(WDECSIND,2) TO WDECSIND
      ELSE
         STORE 0 TO WDECSIND
      ENDIF

      store wutilidad-wince-wislr-wdecsind to wneto

      select 9
      use ipnince
      locate for cedula = wcedula .and. fecha = wfindate
      if found()
         replace monto with wince
      else
         append blank
         replace cedula with wcedula
         replace fecha with wfindate
         replace monto with wince
      endif

      *********** CALCULO DEL MONTO ESCRITO
      STORE WNETO TO WMONTO
      STORE INT(WMONTO/1000000) TO MILLONES
      STORE WMONTO-MILLONES*1000000 TO WMONTO
      STORE INT(WMONTO/1000) TO MILES
      STORE WMONTO-MILES*1000 TO WMONTO
      STORE INT(WMONTO/100) TO CIENTOS
      STORE WMONTO-CIENTOS*100 TO WMONTO
      STORE INT(WMONTO/10) TO DECENAS
      STORE WMONTO-DECENAS*10 TO WMONTO
      STORE INT(WMONTO/1) TO UNIDADES
      STORE WMONTO-UNIDADES*1 TO WMONTO
      STORE (WNETO-INT(WNETO))*100 TO CENTIMOS
      SELECT 9
      USE IPNMONTO
      store space(50) to escrito
      ***** MILLONES ******
      GO TOP
      LOCATE FOR VALOR > MILLONES
      IF .NOT. FOUND()
         STORE "ERROR, NO ENCONTRE LOS MILLONES APROPIADOS" TO MES
         DO AVISO WITH MES
      ENDIF
      GO RECNO()-1
      IF VALOR > 0
         STORE RTRIM(escrito)+" "+DES TO escrito
      ENDIF
      STORE MILLONES-VALOR TO RESTO
      STORE .T. TO CHECKREST
      DO WHILE CHECKREST
         GO TOP
         IF RESTO = 0
            STORE .F. TO CHECKREST
            LOOP
         ENDIF
         LOCATE FOR VALOR > RESTO
         IF .NOT. FOUND()
            STORE "ERROR, NO ENCONTRE EL RESTO DE LOS MILLONES APROPIADOS" TO MES
            DO AVISO WITH MES
         ENDIF
         GO RECNO()-1
         STORE RTRIM(escrito)+" Y "+DES TO escrito
         STORE RESTO-VALOR TO RESTO
      ENDDO
      IF MILLONES = 1
         STORE RTRIM(escrito)+" MILLON " TO escrito
      ELSE
         IF MILLONES > 1
            STORE RTRIM(escrito)+" MILLONES " TO escrito
         ENDIF
      ENDIF
      ***** MILES ******
      GO TOP
      LOCATE FOR VALOR > MILES
      IF .NOT. FOUND()
         STORE "ERROR, NO ENCONTRE LOS MILES APROPIADOS" TO MES
         DO AVISO WITH MES
      ENDIF
      GO RECNO()-1
      IF VALOR > 0
         STORE RTRIM(escrito)+" "+DES TO escrito
      ENDIF
      STORE MILES-VALOR TO RESTO
      IF MILES >= 100 .AND. MILES < 200 .AND. RESTO > 0
         STORE RTRIM(escrito)+"TO" TO escrito
      ENDIF
      STORE .T. TO CHECKREST
      DO WHILE CHECKREST
         GO TOP
         IF RESTO = 0
            STORE .F. TO CHECKREST
            LOOP
         ENDIF
         LOCATE FOR VALOR > RESTO
         IF .NOT. FOUND()
            STORE "ERROR, NO ENCONTRE EL RESTO DE LOS MILES APROPIADOS" TO MES
            DO AVISO WITH MES
         ENDIF
         GO RECNO()-1
         STORE RTRIM(escrito)+" "+DES TO escrito
         STORE RESTO-VALOR TO RESTO
      ENDDO
      IF MILES > 0
         STORE RTRIM(escrito)+" MIL " TO escrito
      ENDIF

      ***** CIENTOS ****
      GO TOP
      LOCATE FOR VALOR > CIENTOS*100
      IF .NOT. FOUND()
         STORE "ERROR, NO ENCONTRE LOS CIENTOS APROPIADOS" TO MES
         DO AVISO WITH MES
      ENDIF
      GO RECNO()-1
      IF VALOR > 0
         STORE RTRIM(escrito)+" "+DES TO escrito
      ENDIF
      IF CIENTOS = 1 .AND. DECENAS*10+UNIDADES > 0
         STORE RTRIM(escrito)+"TO" TO escrito
      ENDIF

      ***** DECENAS ****
      IF DECENAS > 1
         GO TOP
         LOCATE FOR VALOR > DECENAS*10
         IF .NOT. FOUND()
            STORE "ERROR, NO ENCONTRE LAS DECENAS APROPIADAS" TO MES
            DO AVISO WITH MES
         ENDIF
         GO RECNO()-1
         IF VALOR > 0
            STORE RTRIM(escrito)+" "+DES TO escrito
         ENDIF
      ELSE
         STORE DECENAS*10+UNIDADES TO UNIDADES
      ENDIF

      ***** UNIDADES ****
      GO TOP
      LOCATE FOR VALOR > UNIDADES
      IF .NOT. FOUND()
         STORE "ERROR, NO ENCONTRE LAS UNIDADES APROPIADAS" TO MES
         DO AVISO WITH MES
      ENDIF
      GO RECNO()-1
      IF VALOR > 0
         STORE RTRIM(escrito)+" Y "+DES TO escrito
      ENDIF
      STOR UNIDADES-VALOR TO RESTO
      STORE .T. TO CHECKREST
      DO WHILE CHECKREST
         GO TOP
         IF RESTO = 0
            STORE .F. TO CHECKREST
            LOOP
         ENDIF
         LOCATE FOR VALOR > RESTO
         IF .NOT. FOUND()
            STORE "ERROR, NO ENCONTRE EL RESTO DE LAS UNIDADES APROPIADAS" TO MES
            DO AVISO WITH MES
         ENDIF
         GO RECNO()-1
         STORE RTRIM(escrito)+" Y "+DES TO escrito
         STORE RESTO-VALOR TO RESTO
      ENDDO
      STORE RTRIM(escrito)+" Bolivares con " TO escrito

      ***** CENTIMOS ****

      STORE RTRIM(escrito)+" "+LTRIM(RTRIM(STR(CENTIMOS,5)))+" CENTIMOS" TO escrito
      *********  FIN CALCULO MONTO ESCRITO   **********


      set devi to print
      IF POSI = 1
         @ PROW(),1 SAY CHR(14)+warning+CHR(18)
         SET DEVI TO SCRE
         CLOSE DATA
         CLOSE INDEX
         QUIT
      ENDIF

      @ 1,30-(LEN(QQWW)/2) SAY CHR(14)+QQWW
      @ 1,80 SAY CHR(18)
      @ 6,3  SAY "NUMERO DE IDENTIFICACION"
      @ 6,30 SAY "NOMBRE Y APELLIDO"
      @ 6,50 SAY "UTILIDADES   (Bs.):"+STR(WUTILIDAD,9,2)
      @ 7,3  say wcedula
      @ 7,30 say rtrim(wnombre)+" "+wapellido
      @ 8,50 SAY  "DEDUCCION I.N.C.E. :"+STR(Wince,9,2)
      @ 9,50 SAY  "DEDUCCION I.S.L.R. :"+STR(WISLR,9,2)
      @ 10,3 SAY  "Total bonificable:"+str(wtotbon,9,2)
      @ 10,50 SAY "DEDUCCION SINDICATO:"+str(wdecsind,9,2)
      @ 11,50 SAY "Total Neto a Pagar:"+str(wneto,9,2)
      @ 15,3 say "     He recibido de "+QQWW
      @ 17,3 say "la cantidad de "+CHR(15)+escrito+CHR(18)
      @ 19,3 say "que representan el "+STR(UTILIDAD->PORCENTAJE,5,5)+"% de la suma mis sueldos o salarios devengados"
      @ 21,3 say "durante el per¡odo "+dtoc(inidate)+" al "+dtoc(wfindate)
      @ 23,3 say "por concepto de utilidades, de acuerdo con el art.174 de la ley organica del"
      @ 25,3 say "trabajo."
      @ 28,30 say "__________________________________"
      @ 29,30 say "      Firma del trabajador        "
      @ 32,3 say "____________________________               _______________________________"
      @ 33,3 say "        Testigo                                       Testigo             "
      @ 38,3 say RTRIM(IPNOMINA.LUGAR)+", "+dtoc(wfecact)
      @ 39,3 say "  Lugar y Fecha del Pago    "
      @ 42,50 say chr(15)+"Papel sellado inutilizado en la copia"+chr(18)
      @ 43,50 say chr(15)+"que quedan en poder de "+QQWW+chr(18)

      REPLACE PERSONAL->LASTUTIL WITH PERSONAL->UTILIDAD
      REPLACE PERSONAL->UTILIDAD WITH WFINDATE
      store (INT(wmeses))*30 to wdivide
      if wdivide > 0
         REPLACE PERSONAL->salpro WITH WUTILIDAD / wdivide
      else
         replace personal->salpro with 0
      endif
   ENDIF


   SELECT 2
   store wcedula+dtoc(wfecact)+"UTLDA" to xcv
   SEEK xcv
   IF .NOT. FOUND()
      APPEND BLANK
   ENDIF
   REPLACE CEDULA   WITH WCEDULA
   REPLACE FECHA    WITH WFINDATE
   REPLACE nomina   WITH "UTLDA"
   replace bstotbon with wutilidad
   REPLACE bsislr   WITH WISLR
   REPLACE bssindic WITH Wdecsind
   SELECT 1
   REPLACE UTILACUM WITH 0
   set devi to scree
   eject
ENDDO
CLOSE DATA
CLOSE INDEX
RETURN

