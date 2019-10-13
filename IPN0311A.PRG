*** ANTIGUEDAD ANUAL LDT
   store "Procesando informacion, Favor esperar..." to mes
   do mensaje with mes

   STORE (WFINDATE - INIDATE)/30 TO WMESES
   STORE WMESES - INT(WMESES) TO WFRACCION
   IF WFRACCION >= 0.5
      STORE INT(WMESES)+0.5  TO WMESES
   ELSE
      STORE INT(WMESES)      TO WMESES
   ENDIF

   STORE (WFINDATE - WINGRESO)/30 TO WMESESAA
   STORE WMESESAA - INT(WMESESAA) TO WFRACCIONAA
   IF WFRACCIONAA >= 0.5
      STORE INT(WMESESAA)+0.5  TO WMESESAA
   ELSE
      STORE INT(WMESESAA)      TO WMESESAA
   ENDIF
       
   *** ANTIGUEDAD LEGAL
   ***
   SELECT 4
   USE IPNLDT
   GO TOP
   LOCATE FOR MESES > WMESES
   IF .NOT. FOUND()
      STORE "ERROR, NO SE ENCONTRO REGISTRO DE MESES A PAGAR :"+STR(WMESES,6,2) TO MES
      DO AVISO WITH MES
      CLOSE DATA
      CLOSE INDEX
      RETURN TO MASTER
   ENDIF
   GO RECNO() - 1
   STORE ANTIGUEDAD TO WDIASANT

   *** ANTIGUEDAD ADICIONAL
   ***
   SELECT 4
   USE IPNLDT
   GO TOP
   LOCATE FOR MESES > WMESESAA
   IF .NOT. FOUND()
      STORE "ERROR, NO SE ENCONTRO REGISTRO DE MESES A PAGAR ANT.ADIC.:"+STR(WMESESAA,6,2) TO MES
      DO AVISO WITH MES
      CLOSE DATA
      CLOSE INDEX
      RETURN TO MASTER
   ENDIF
   GO RECNO() - 1
   STORE CESANTIA   TO WDIASANT2

   STORE SPACE(35) TO QQWW
   DO INFORMA WITH QQWW
   IF QQWW <> t3
      STORE 1 TO POSI
      else
      STORE 0 TO POSI
   ENDIF

   STORE WBASICO TO Wbasicodia
   STORE WBASICODIA TO VARIABLE
   DO REDONDEO WITH VARIABLE
   STORE VARIABLE TO WBASICODIA
   STORE ROUND(WBASICODIA,2) TO WBASICODIA
   
   store WBASICODIA*WDIASANT  TO BSDIASANT
   STORE WBASICODIA*WDIASANT2 TO BSDIASANT2

   STORE DAY(INIDATE)  TO DDDD1
   STORE DAY(WFINDATE) TO DDDD2
   STORE MONTH(INIDATE) TO MMMM1
   STORE MONTH(WFINDATE) TO MMMM2

   set devi to print
   IF POSI = 1
      @ PROW(),1 SAY CHR(14)+warning+CHR(18)
      SET DEVI TO SCRE
      CLOSE DATA
      CLOSE INDEX
      QUIT
   ENDIF
   @ 1,0 SAY CHR(14)+QQWW
   @ 2,60 SAY "FECHA :"+DTOC(WFECACT)
   @ 4,30 SAY "ANTIGUEDAD ANUAL"
   @ 5,1 SAY "NOMBRE: "+RTRIM(WNOMBRE)+" "+WAPELLIDO
   @ 5,60 SAY "CEDULA: "+WCEDULA
   @ 7,1 SAY "SUELDO: "+STR(WBASICODIA,8,2)
   @ 9,1  SAY "PERIODO VENCIDO :  DEL "+DTOC(INIDATE)+" AL "+DTOC(WFINDATE)
   @ 12,1 SAY "DESCRIPCION                      UNID.     ASIGNAC.      DEDUCION       SALDO"
   @ 13,1 SAY "----------------------------     -----   ----------   -----------  ----------"
   @ 14,1 SAY "ANTIGUEDAD ANUAL"
   @ 14,30 SAY STR(WDIASANT,8,2)
   @ 14,40 SAY STR(BSDIASANT,12,2)
   @ 16,1 SAY "ANTIGUEDAD ADICIONAL"
   @ 16,30 SAY STR(WDIASANT2,8,2)
   @ 16,40 SAY STR(BSDIASANT2,12,2)
   STORE (BSDIASANT+BSDIASANT2) TO WMONTO
   @ 34,1 SAY "T O T A L E S  "
   @ 34,67 SAY STR(WMONTO,12,2)
   @ 37,40 say "__________________________________"
   @ 38,40 say chr(15)+"Firma del trabajador o a su ruego por no saber firmar"+chr(18)
   @ 42,3 say "____________________________               _______________________________"
   @ 43,3 say "        Testigo                                       Testigo             "
   @ 47,3 say "____________________________"
   @ 48,3 say "  Lugar y Fecha del Pago    "
   @ 49,50 say chr(15)+"Papel sellado inutilizado en la copia"+chr(18)
   @ 50,50 say chr(15)+"que quedan en poder de "+QQWW+chr(18)
   EJECT
   store "Actualizando Historico, Favor esperar..." to mes
   set devi to scree
   do mensaje with mes
   SELECT 2
   APPEND BLANK
   REPLACE CEDULA   WITH WCEDULA
   REPLACE FECHA    WITH WFINDATE
   REPLACE nomina   WITH "LIQUI"
   REPLACE ANTIGUE  WITH BSDIASANT
   REPLACE CESANTIA WITH BSDIASANT2
   SELECT 1
   REPLACE LASTANTI WITH ANTIGUE
   REPLACE ANTIGUE  WITH WFINDATE
   SET DEVI TO SCRE

