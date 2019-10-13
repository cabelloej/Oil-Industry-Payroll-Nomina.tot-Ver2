*********************************************
*          historico de  deposito habitacional *
*********************************************
select 1 
use ipnhisto
select 2
use ipnperso index ipnperso ALIAS PERSONAL
store ctod("  -  -    ") to fec1
store ctod("  -  -    ") to fec2
store .t. to histo
do while histo
   set color to w/n
   @ 5,1 clear to 10,50
   @ 5,1 to 10,50 double
   @ 5,10 say "AHORRO HAB. INDIVIDUAL DETALLADO"
   STORE SPACE(10) TO WCEDULA
   @ 6,3 say " CEDULA        :" GET WCEDULA
   READ
   if wcedula = space(10)
      close data
      close index
      return
   endif
   SELECT 2
   LOCATE FOR CEDULA = WCEDULA
   IF EOF()
      STORE "ERROR, cedula no registrada" to mes
      do aviso with mes
      loop
   endif

   @ 7,3 SAY "FECHA INICIAL  :" GET FEC1
   @ 8,3 SAY "FECHA FINAL    :" GET FEC2
   READ
   IF FEC1 >= FEC2
      CLOSE DATA
      CLOSE INDEX
      RETURN
   ENDIF
   STORE "OPCIONES: (A)CEPTAR, (R)ECHAZAR" TO MES
   STORE "A" TO P1
   STORE "R" TO P2
   STORE " " TO RESP
   DO PIDE2 WITH P1,P2,MES,RESP
   IF RESP = "R"
      CLOSE DATA
      CLOSE INDEX
      RETURN
   ENDIF
   SET DEVI TO PRINT
   STORE 0 TO TOTAL1
   STORE 1 TO PAGINA
   @ 0,0 SAY CHR(18)
   @ 1,40-(LEN(QQWW)/2)-5 SAY CHR(14)+QQWW+CHR(18)
   @ 4,2 SAY "HISTORICO DE AHORRO HABITACIONAL DEL "+DTOC(FEC1)+" AL "+DTOC(FEC2)
   @ 4,60 SAY "PAGINA:"+STR(PAGINA,4)
   @ 5,60 SAY "FECHA :"+DTOC(WFECACT)
   @ 6,2 SAY "APORTE DEL PERSONAL "
   @ 7,2 SAY "CEDULA"
   @ 7,14 SAY "NOMBRE COMPLETO"
   @ 7,57 SAY "FECHA DE PAGO"
   @ 7,78 SAY "MONTO RET."
   STORE 8 TO LINE
   SELECT 1
   GO TOP
   LOCATE FOR FECHA >=FEC1 .AND. FECHA <= FEC2 .AND. NOMINA <> "UTLDA" .AND. CEDULA = PERSONAL->CEDULA .AND. NOMINA <> "LIQUI"
   DO WHILE .NOT. EOF()
      STORE PERSONAL->CEDULA TO WCEDULA
      STORE RTRIM(PERSONAL->NOMBRE)+" "+PERSONAL->APELLIDO TO WNOMBRE

      STORE LINE + 1 TO LINE
      IF LINE > 55
         STORE PAGINA + 1 TO PAGINA
         @ 0,0 SAY CHR(18)
         @ 1,40-(LEN(QQWW)/2) SAY CHR(14)+QQWW+CHR(18)
         @ 2,0 SAY "HISTORICO DE AHORRO HABITACIONAL DEL "+DTOC(FEC1)+" AL "+DTOC(FEC2)
         @ 2,60 SAY "PAGINA:"+STR(PAGINA,4)
         @ 4,0 SAY "APORTE DEL PERSONAL "
         @ 6,0 SAY "CEDULA"
         @ 6,12 SAY "NOMBRE COMPLETO"
         @ 6,57 SAY "FECHA DE PAGO"
         @ 6,78 SAY "MONTO RET."
         STORE 8 TO LINE
      ENDIF
      @ LINE,2 SAY CEDULA
      @ LINE,14 SAY WNOMBRE
      @ LINE,57 SAY DTOC(FECHA)
      @ LINE,70 SAY BSAHRHAB PICTURE "##,###,###.##"
      STORE BSAHRHAB + TOTAL1 TO TOTAL1
      SELECT 1
      CONTINUE
   ENDDO
   STORE LINE +1 TO LINE
   @ LINE,14 SAY "TOTAL RETENIDO "
   @ LINE,90 SAY TOTAL1 PICTURE "##,###,###.##"
   STORE TOTAL1*2 TO WEMPRESA
   STORE LINE+1 TO LINE
   @ LINE ,14 SAY "APORTE DE LA EMPRESA         "
   @ LINE,90 SAY WEMPRESA PICTURE "##,###,###.##"
   EJECT
   set devi to scree
enddo
CLOSE DATA
CLOSE INDEX
SET DEVI TO SCRE
EJECT
RETURN




