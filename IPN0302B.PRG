SELECT 1
USE IPNPERSO INDEX IPNPERSO             ALIAS PERSONAL
SELECT 2
USE IPNHISTO index ipnhisto, IPNHIST2   ALIAS HISTORICO
SELECT 3
USE IPNUTILI                            ALIAS UTILIDAD
SELECT 10
USE IPNOMINA INDEX IPNOMINA             ALIAS NOMINA

STORE .T. TO UTIL
DO WHILE UTIL
   SET COLOR TO W+/B
   @ 5,0 CLEAR TO 16,50
   @ 5,0 TO 16,50 DOUBLE
   STORE "RESUMEN DE UTILIDADES" TO HEADING
   @ 5,25-(LEN(HEADING)/2) SAY HEADING
   STORE SPACE(5) TO WNOMRES
   STORE "INGRESE LA NOMINA A ESTIMAR. ENTER=TODAS, ESC=SALIR" TO MES
   DO MENSAJE WITH MES
   @ 8,2 SAY "NOMINA :" GET WNOMRES
   READ
   IF WNOMRES=SPACE(5).OR.LASTKEY()=27         
      EXIT
   ENDIF
   SET DEVI  TO PRINT
   STORE 100 TO WLINE
   STORE 0   TO WTOTREP
   SELECT PERSONAL
   GO TOP
   DO WHILE .NOT. EOF()
      IF WNOMRES<>SPACE(5).AND.WNOMRES<>NOMINA
         SELECT PERSONAL
         SKIP
         LOOP
      ENDIF
      IF NOMINA=SPACE(5)
         SELECT PERSONAL
         SKIP
         LOOP
      ENDIF
      store cedula     to wcedula
      store sueldo     to wbasico
      store BONOCO     to wbONOCO
      STORE NOMINA     TO WNOMINA
      STORE UTILIDAD+1 TO winidate
      STORE CONTRATO   TO WCONTRATO
      STORE INGRESO    TO WINGRESO
      store substr(RTRIM(apellido)+", "+RTRIM(nombre),1,24) to wnombre
      store tipo       to wtipo
      STORE SINDICATO  TO WSIND

      SELECT NOMINA
      FIND &WNOMINA
      IF EOF()
         SET DEVI TO SCRE
         STORE "Error, nomina "+WNOMINA+" de cedula "+wcedula+" no esta registrada" TO MES
         DO AVISO WITH MES
         SET DEVI TO PRINT
         SELECT PERSONAL
         SKIP
         LOOP
      ENDIF
    
      IF winidate = CTOD("  -  -    ")
         STORE WINGRESO TO winidate
      ENDIF
      
      store wfecact to wfindate
      store wfecact to wfecseek
      STORE ((WFINDATE - winidate)+1)/30 TO WMESES
      STORE ROUND(WMESES,1) TO WMESES

      SELECT UTILIDAD
      GO TOP
      LOCATE FOR CONTRATO = WCONTRATO
      IF .NOT. FOUND()
         set devi to scre
         STORE "Error, contrato "+wcontrato+" de cedula "+wcedula+" es invalido" to mes
         do aviso with mes
         set devi to print
         select personal
         skip
         loop
      endif
      IF (dias>0.and.porcentaje>0) .or. (dias=0.and.porcentaje=0)
         set devi to scre
         STORE "Error, tabla de utilidades "+wcontrato+" ha sido alterada" to mes
         do aviso with mes
         set devi to print
         select personal
         skip
         loop
      endif

      IF DIAS > 0 .AND. PORCENTAJE = 0
         STORE "DIAS" TO WFORMAPAGO
      ENDIF
      IF PORCENTAJE > 0 .AND. DIAS = 0
         STORE "PORCENTAJE" TO WFORMAPAGO
         STORE PORCENTAJE   TO WPORCIENTO
      ENDIF

      IF WFORMAPAGO = "DIAS"
         IF WCONTRATO = "PETROLERO"
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
            set devi to scre
            STORE "Error, tabla "+wliquida+" no contiene meses a pagar a "+wcedula TO MES
            DO AVISO WITH MES
            set devi to print
            select personal
            skip
            LOOP
         ENDIF
         GO RECNO() - 1
         STORE UTILIDAD TO WDIASUTIL

         * BUSQUEDA DE HISTORICO
         SELECT historico
         SORT TO IPNTEMP2 ON FECHA /D FOR CEDULA = WCEDULA .AND. FECHA <= WFINDATE  .AND. NOMINA <> "LIQUI"
         SELECT 4
         USE IPNTEMP2
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
         STORE 10 TO ZX
         DO WHILE .NOT. EOF() .AND. CONTEO < BUSCAR
            IF NOMINA<>"UTLDA".AND.DESOCB1<>"V "
               STORE ACUMULADO + (BSTOTBON+BSTOTNBON-BSTOTDEC) TO ACUMULADO
               STORE CONTEO +1 TO CONTEO
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

         STORE PROMEDI*WDIASUTIL TO WUTILIDAD
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
      
         STORE WUTILIDAD-WINCE-WISLR-WDECSIND TO WNETO

         DO IMPLIN
         STORE WTOTREP + WNETO TO WTOTREP

      ENDIF
      IF WFORMAPAGO = "PORCENTAJE"
         SELECT HISTORICO
         SET ORDER TO IPNHISTO
         SEEK WCEDULA
         IF .NOT. FOUND()
            set devi to scre
            STORE "Error, no encontre historicos para :"+wcedula  to mes
            do aviso with mes
            set devi to print
         ENDIF
         STORE 0  TO WTOTBON
         DO WHILE .NOT. EOF() .and. CEDULA = WCEDULA 
            IF  FECHA > winidate .AND. FECHA <= WFECSEEK .and. nomina <> "UTLDA" .AND. NOMINA <> "LIQUI"
               STORE WTOTBON + BSTOTBON TO WTOTBON
            ENDIF
            SKIP
         ENDDO
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

         DO IMPLIN
         STORE WTOTREP + WNETO TO WTOTREP
         
      ENDIF
      SELECT PERSONAL
      SKIP
   ENDDO
   STORE WLINE + 2 TO WLINE
   @ wline,126 SAY str(WTOTREP,11,2)
   SET DEVI TO SCRE
   EJECT
ENDDO
CLOSE DATA
CLOSE INDEX
RETURN
***************
PROCEDURE SALTO
***************
@ 1,00 SAY CHR(18)+CHR(14)+QQWW
@ 2,00 SAY "RESUMEN DE UTILIDADES AL "+DTOC(WFECACT)
@ 3,00 SAY "NOMINA "+WNOMRES
@ 3,00 SAY CHR(15)

@ 06,00  SAY "CEDULA"
@ 06,11  SAY "NOMBRE Y APELLIDO"
@ 06,35  SAY "DESDE     "
@ 06,47  SAY "HASTA     "
@ 06,60  say " TOT.BONIF"
@ 06,70  SAY " PORC"     
@ 06,77  SAY "PROMxDIA" 
@ 06,88  SAY "DIAS"     
@ 06,93  SAY  "UTILIDADES"
@ 06,105 SAY  "I.N.C.E."  
@ 06,114 SAY  "I.S.L.R." 
@ 06,127 SAY  "NETO PAGAR"
STORE 08 TO WLINE
RETURN
*****************
PROCEDURE IMPLIN
*****************
STORE WLINE+1 TO WLINE
IF WLINE>50
   DO SALTO
ENDIF
@ wline,00  SAY wcedula
@ wline,11  SAY wnombre
@ wline,35  SAY winidate
@ wline,47  SAY wfindate
if wformapago="PORCENTAJE"
   @ wline,59  say str(wtotbon,9,2)
   @ wline,70  SAY str(wporciento,5,2)
else
   @ wline,77  SAY str(promedi,9,2)
   @ wline,88  SAY str(wdiasutil,3)
endif
@ wline,94  SAY STR(WUTILIDAD,9,2)
@ wline,105 SAY STR(Wince,9,2)
@ wline,114 SAY STR(WISLR,9,2)
@ wline,128 SAY str(wneto,9,2)
RETURN
