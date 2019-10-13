************************************
*       PAGO DE ANTIGUEDAD LDT     *
************************************
store "INSTALACION NO AUTORIZADA" TO WARNING
SELECT 1
USE IPNPERSO INDEX IPNPERSO ALIAS PERSONAL
SELECT 2
USE IPNHISTO INDEX IPNHISTO, IPNHIST2 ALIAS HISTORICO
STORE .T. TO UTIL
DO WHILE UTIL
   SET COLOR TO W+/B
   @ 5,0 CLEAR TO 12,50
   @ 5,0 TO 12,50 DOUBLE
   STORE "ANTIGUEDAD ANUAL LDT" TO HEADING
   @ 5,25-(LEN(HEADING)/2) SAY HEADING
   STORE SPACE(10) TO WCEDULA
   STORE "INGRESE LA CEDULA A PROCESAR" TO MES
   DO MENSAJE WITH MES
   @ 08,5  SAY "CEDULA         :" GET WCEDULA
   @ 09,5  SAY "FECHA DE INICIO:"
   @ 10,5  SAY "FECHA DE CORTE :"
   READ
   IF WCEDULA = SPACE(10)
      STORE .F. TO UTIL
      LOOP
   ENDIF
   SELECT PERSONAL
   FIND &WCEDULA
   IF EOF()
      STORE "CEDULA NO REGISTRADA" TO MES
      DO AVISO WITH MES
      LOOP
   ENDIF
   STORE NOMINA    TO WNOMINA
   store sueldo    to wbasico
   STORE BONOCO    TO WBONOCO
   STORE ANTIGUE   TO INIDATE
   STORE LASTANTI  TO WLASTANTI
   STORE CONTRATO  TO wcontrato
   STORE INGRESO   TO WINGRESO
   store nombre    to wnombre
   store apellido  to wapellido
   IF INIDATE = CTOD("  -  -    ")
      STORE WINGRESO TO INIDATE
   ELSE
      STORE INIDATE+1 TO INIDATE
   ENDIF
   if INIDATE = CTOD("  -  -    ")
      STORE "ESTA PERSONA NO TIENE FECHA DE INGRESO" to mes
      do aviso with mes
      loop
   endif

   STORE "INGRESE LA FECHA INICIAL DE LA ANTIGUEDAD" TO MES
   DO MENSAJE WITH MES
   @ 09,22 GET INIDATE
   READ

   STORE DTOC(INIDATE) TO WORKDATE
   store SUBSTR(WORKDATE,1,6) TO FE1
   store SUBSTR(WORKDATE,7,4) TO FE2
   STORE VAL(FE2)+1 TO FE2
   STORE STR(FE2,4) TO FE2
   STORE CTOD(FE1+FE2) TO WFINDATE
   STORE "INGRESE LA FECHA DE CORTE  DE LA ANTIGUEDAD" TO MES
   DO MENSAJE WITH MES
   @ 10,22  GET WFINDATE
   READ
   if wFINDATE = CTOD("  -  -    ")
      loop
   endif

   if wfindate < inidate
      store "ERROR, en asignacion de fechas" to mes
      do aviso with mes
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
   IF wcontrato = "LDT"
      DO IPN0311A
      LOOP
   ELSE
      STORE "CONTRATO INVALIDO, SOLO PARA PERSONAL POR LDT" TO MES
      DO AVISO WITH MES
   ENDIF
ENDDO
CLOSE DATA
CLOSE INDEX
RETURN

