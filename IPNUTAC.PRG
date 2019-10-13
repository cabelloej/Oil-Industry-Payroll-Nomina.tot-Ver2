SET TALK OFF
SET ECHO OFF
SET DATE ITAL
SET DELE ON
SET PROC TO IPNPROC
SELECT 1
USE IPNHISTO INDEX IPNHISTO, IPNHIST2
SELECT 2
USE IPNPERSO INDEX IPNPERSO
REPLACE ALL UTILACUM WITH 0
SELECT 2
GO TOP
DO WHILE .NOT. EOF()
      IF NOMINA = SPACE(5)
         SKIP
         LOOP
      ENDIF
      STOR CEDULA TO WCEDULA
      IF UTILIDAD = CTOD("  -  -    ")
         STORE INGRESO TO INIDATE
      ELSE
         STORE UTILIDAD+1 TO INIDATE
      ENDIF
      STORE DATE() TO WFINDATE
      SELECT 1
      set exact off
      find &wcedula
      if eof()
         STORE "No se encontraron pagos en el historico para "+WCEDULA to mes
         do aviso with mes
         SELECT 2
         SKIP
         loop
      endif
      STORE 0 TO WTOTBON
      DO WHILE .NOT. EOF() .and. CEDULA = WCEDULA 
         if  FECHA >= INIDATE .AND. FECHA <= WFINDATE .and. nomina <> "UTLDA" .AND. NOMINA <> "LIQUI"
            STORE WTOTBON + BSTOTBON TO WTOTBON
            @ 0,0 CLEAR
            @ 1,0 TO 10,60
            @ 2,1 SAY "CEDULA:"+WCEDULA
            @ 3,1 SAY "NOMBRE:"+RTRIM(IPNPERSO->APELLIDO)+" "+IPNPERSO->NOMBRE+SPACE(15)
            @ 4,1 SAY "DESDE :"+DTOC(INIDATE)
            @ 5,1 SAY "TOTAL :"+STR(WTOTBON,12,2)
         endif
         skip
      ENDDO
      SELECT 2
      REPLACE UTILACUM WITH WTOTBON
      SKIP
ENDDO
CLOSE DATA
CLOSE INDEX
RETURN
