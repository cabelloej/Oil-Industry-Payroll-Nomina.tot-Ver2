********************************************************************************
*             PROGRAMA PARA IMPRIMIR LA NOMINA  BANCARIA                     *
********************************************************************************
store "INSTALACION NO AUTORIZADA" to warning
STORE "REPORTE DE NOMINA :" TO T2
SELECT 1 
USE IPNOMINA INDEX IPNOMINA ALIAS NOMINA
SELECT 2
USE IPNPROCO INDEX IPNPROCO ALIAS PROCESO
SELECT 4
USE IPNPERSO INDEX IPNPERSO ALIAS PERSONAL
STORE .T. TO REPORTA
DO WHILE REPORTA
   STORE .T. TO WFNOMINA
   DO WHILE WFNOMINA
      STORE 0 TO WWTOTA
      STORE 0 TO WWTOTB
      STORE 0 TO WWTOTC
      STORE 0 TO WWTOTD

      SELECT 1
      STORE SPACE(5) TO WCODNOM
      @ 5,1 CLEAR TO 12,50
      @ 5,1 TO 12,50 DOUBLE
      @ 5,15 SAY "BANCARIA"
      @ 5,25-(LEN(T2)/2) SAY T2
      STORE "Ingrese el codigo de la nomina que desea imprimir" to mess
      do mensaje with mess
      @ 7,3 say "NOMINA: " GET WCODNOM
      @ 9,3 SAY "DESCRIPCION:"
      READ
      STORE UPPER(WCODNOM) TO WCODNOM
      IF WCODNOM=SPACE(5)
         CLOSE DATA
         CLOSE INDEX
         RETURN
      ENDIF
      FIND &WCODNOM
      IF EOF()
         STORE "Nomina no registrada" to mes
         do aviso with mes
         loop
      endif
      @ 9,16 SAY DESNOM
      STORE DESNOM TO WDESNOM
      STORE "Opciones: (C)ontinuar, (S)alir"to mes
      store "C" to p1
      store "S" to p2
      store " " to resp
      do pide2 with p1,p2,mes,resp
      if resp = "S"
         close data
         close index
         return
      endif
      IF ESTADO = 0
         STORE "ERROR, esta nomina esta cerrada " to mes
         do aviso with mes
         loop
      else
         exit
      endif
   ENDDO

   STORE FACTCOD TO WFACTOR
   SELECT 3
   USE IPNFACTO INDEX IPNFACTO ALIAS TABLA
   FIND &WFACTOR
   IF EOF()
      STORE "ERROR, TABLA DE FACTORES DE ESTA NOMINA NO ESTA REGISTRADA" TO MES
      DO AVISO WITH MESS
      LOOP
   ENDIF

   SET DEVI TO PRINT
   STORE SPACE(35) TO qqww
   DO informa WITH qqww
   IF qqww <> t3
      STORE 1 TO POSI
      else
      STORE 0 TO POSI
   ENDIF

   STORE 100 TO LINE
   STORE 0 TO GENTE
   SELECT 4
   LOCATE FOR NOMINA = WCODNOM
   DO WHILE .NOT. EOF()
      STORE CEDULA TO WCEDULA
      SELECT 2
      FIND &WCEDULA
      IF EOF()
         STORE "ADVERTENCIA:"+RTRIM(personal->nombre)+" "+RTRIM(personal->apellido)+" sin reg. de corte." to mes
         SET DEVI TO SCREE
         @ 23,1 SAY SPACE(78)
         @ 23,40-(LEN(MES)/2) SAY MES
         SET DEVI TO PRINT
         select 4
         continue
         LOOP
      endif
      STORE GENTE + 1 TO GENTE
      select 2
      *** CALCULO DE PAGO ***
      *** CALCULO DE PAGO ***
      STORE SPACE(10) TO WCEDULA,WNOMBRE,WAPELLIDO,WCLASIF
      STORE SPACE(3)  TO WDES3,WDES4,WDESC3,WDESC4,WDESCR3,WDESCR4
      STORE 0 TO WBASICO,WBONOCO,WSALBAS,WSALNOR,WSUELDO,WDIASTRAB,WDIASTRABD,WDIASTRABM,WDIASTRABN
      STORE 0 TO WHORASOR,WHORASORD,WHORASORM,WHORASORN,WBSORD,WBSORDD,WBSORDM,WBSORDN,WSTDA,WSTDB,WSTDABS,WSTDBBS,WSTMA,WSTMB,WSTMABS,WSTMBBS
      STORE 0 TO WSTNA,WSTNB,WSTNABS,WSTNBBS,WTOTSTHR,WTOTSTBS,WSTGM,WSTGN,WSTGMBS,WSTGNBS
      STORE 0 TO WTVDA,WTVDABS,WTVMA,WTVMABS,WTVNA,WTVNABS,WTVDB,WTVMB,WTVNB,WTVDBBS,WTVMBBS,WTVNBBS
      STORE 0 TO WTOTTVHR,WTOTTVBS,WDESNORHR,WDESNORBS,WDC,WDCBS,WBCHR,WBCBS,WFERHORAS,WFERTOT,WFERPRIHR,WFERPRIBS,WBNGHR,WBNGBS
      STORE 0 TO WDESCONHR,WDESCONBS,WDESLEGHR,WDESLEGBS,WBNVBS,WBNV,WCOMIDA,WCOMIDABS,WAYUCIUHR,WAYUCIUBS,WBN,WBNBS,WBDHR,WBDBS
      STORE 0 TO WREPCOM,WREPCOMBS,WOCBHR1,WOCBHR2,WOCBHR3,WOCBHR4,WOCBBS1,WOCBBS2,WOCBBS3,WOCBBS4,WTOTBON
      STORE 0 TO WCESTA,WVIVE,WVIVEBS,WBONOTRAN,WBONOALIM,WBONOSUBS,WOCNB3,WOCNB4,WUTILIDAD,WINDEMNIZA,WTOTNBON
      STORE 0 TO WCAJA,WISLR,WSSO,WSPF,WPRESPER,WSINDIC,WOD3,WOD4,WAHRHAB,WTOTDEC
      STORE 0 TO WNETOPAGAR
      DO IPN0000
      ***********************
      IF WTOTBON+WTOTNBON = 0
         SELECT 4
         CONTINUE
         LOOP
      ENDIF
      IF POSI = 1
         @ PROW(),1 SAY CHR(14)+warning+CHR(18)
         SET DEVI TO SCRE
         CLOSE DATA
         CLOSE INDEX
         QUIT
      ENDIF
      *********************************************************************
      ***  I M P R I M I R    D A T O S    D E L    P E R S O N A L     ***
      *********************************************************************
      store line + 1 to line
      if line > 55
         @ 00,00 say chr(18)
         @ 00,00 say chr(14)+qqww 
         @ 01,00 SAY "NOMINA BANCARIA"
         @ 01,60 SAY WFECACT
         
         @ 03,00 SAY "NOMINA : "+NOMINA->DESNOM
         @ 04,00 SAY "PERIODO: "+DTOC(NOMINA->APERT1)+" AL "+DTOC(NOMINA->APERT2)
         
         @ 06,00 SAY "NOMBRE                   CEDULA     Nro.DE CUENTA   TIPO                MONTO"
         @ 07,00 SAY "------------------------ ---------- --------------- ---------- --------------" 
         STORE 08 TO LINE
      ENDIF

      @ LINE,00 SAY RTRIM(PERSONAL->NOMBRE)+" "+RTRIM(PERSONAL->APELLIDO)
      @ LINE,25 SAY WCEDULA
      @ LINE,36 say PERSONAL->NUMECUEN
      @ LINE,52 say PERSONAL->TIPOCUEN
      @ LINE,62 SAY WNETOPAGAR PICTURE "999,999,999.99"
      
      STORE WWTOTA+WTOTBON    TO WWTOTA
      STORE WWTOTB+WTOTNBON   TO WWTOTB
      STORE WWTOTC+WTOTDEC    TO WWTOTC
      STORE WWTOTD+WNETOPAGAR TO WWTOTD
         
      SELECT 4
      CONTINUE
   ENDDO
   @ LINE+2,00 SAY "TOTAL NETO :"
   @ LINE+2,14 SAY WWTOTD  PICTURE "@z #######.##"
   EJECT
   @ PROW(),0 SAY CHR(18)
   SET DEVI TO SCREE
ENDDO
RETURN
