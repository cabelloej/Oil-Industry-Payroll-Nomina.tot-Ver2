
*******************************************************************************
*                  PROGRAMA PARA IMPRIMIR LOS SOBRES SIN FORMATO  MICHINAUX   *
*******************************************************************************
store "INSTALACION NO AUTORIZADA" to warning
STORE "IMPRIMIR SOBRES" TO T2
SELECT 1 
USE IPNOMINA INDEX IPNOMINA ALIAS NOMINA
SELECT 2
USE IPNPROCO INDEX IPNPROCO ALIAS PROCESO
SELECT 3
USE IPNFACTO INDEX IPNFACTO ALIAS TABLA
SELECT 4
USE IPNPERSO  ALIAS PERSONAL
select 8
use ipncargos index ipncargos
SELECT 9
USE IPNSINDI
SELECT 10
USE IPNUTILI
STORE .T. TO REPORTA
DO WHILE REPORTA
   STORE .T. TO NOMINA
   DO WHILE NOMINA
      STORE 0 TO WWTOTA
      STORE 0 TO WWTOTB
      STORE 0 TO WWTOTC
      STORE 0 TO WWTOTD
      SELECT 1
      STORE SPACE(5) TO WCODNOM
      SET COLOR TO W+/B
      @ 5,1 CLEAR TO 12,50
      @ 5,1 TO 12,50 DOUBLE
      @ 5,25-(LEN(T2)/2) SAY T2
      STORE "CODIGO DE LA NOMINA:" to mess
      do mensaje with mess
      @ 7, 3 say "NOMINA     : " GET WCODNOM
      @ 9, 3 SAY "DESCRIPCION:"
      @ 10,3 SAY "DESDE No.  :"
      @ 11,3 SAY "HASTA No.  :"
      READ
      STORE UPPER(WCODNOM) TO WCODNOM
      IF WCODNOM=SPACE(5)
         CLOSE DATA
         CLOSE INDEX
         RETURN
      ENDIF
      FIND &WCODNOM

      IF EOF()
         STORE "NOMINA NO REGISTRADA" to mes
         do aviso with mes
         loop
      endif
      @ 9,16 SAY DESNOM
      STORE 0 TO WSOBREI
      STORE 0 TO WSOBREF
      STORE "INGRESE EL No. DEL PRIMER SOBRE A IMPRIMIR (Ù) PARA EL PRIMERO" TO MES
      DO MENSAJE WITH MES
      @ 10,16 GET WSOBREI PICTURE "####"
      READ
      STORE "INGRESE EL No. DEL ULTIMO SOBRE A IMPRIMIR (Ù) PARA EL ULTIMO" TO MES
      DO MENSAJE WITH MES
      @ 11,16 GET WSOBREF PICTURE "####"
      READ
      STORE "OPCIONES: (C)ONTINUAR, (S)ALIR"to mes
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

   store "IMPRIMIENDO SOBRES ..." TO MES
   DO MENSAJE WITH MES

   SELECT 3
   FIND &WFACTOR
   IF EOF()
      STORE "ERROR, TABLA DE FACTORES DE ESTA NOMINA NO ESTA REGISTRADA" TO MES
      DO AVISO WITH MESS
      LOOP
   ENDIF

   SET DEVI TO PRINT
   @ prow(),1 say chr(27)+chr(67)+chr(33)
   STORE SPACE(35) TO QQWW
   DO INFORMA WITH QQWW
   IF QQWW <> t3
      STORE 1 TO POSI
      else
      STORE 0 TO POSI
   ENDIF

   STORE 0 TO GENTE
   STORE 0 TO VEZ
   SELECT 4
   GO TOP
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
      SELECT 9
      LOCATE FOR CONTRATO = PERSONAL->SINDICATO
      IF FOUND()
         STORE DEFINICION TO QWRESTO
         ELSE
         STORE "NO REGISTRADO" TO QWRESTO
      ENDIF

      STORE VEZ + 1 TO VEZ
      STORE GENTE + 1 TO GENTE
      IF WSOBREI > 0 .AND. GENTE < WSOBREI
         SELECT 4
         CONTINUE
         LOOP
      ENDIF
      IF WSOBREF > 0 .AND. GENTE > WSOBREF
         SELECT 4
         CONTINUE
         LOOP
      ENDIF

      select 2
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
      SELECT 8
      SEEK WCLASIF
      IF EOF()
         STORE "????????" TO WCLASIFDES
      ELSE
         STORE DESCRI     TO WCLASIFDES
      ENDIF
      SELECT 2
      *********************************************************************
      ***  I M P R I M I R    D A T O S    D E L    P E R S O N A L     ***
      *********************************************************************
      @ 1,10  say QQWW
      @ 1,45  say nomina->apert1
      @ 1,56  say nomina->apert2
      @ 1,82  SAY STR(GENTE,4)
     *@ 2,108 SAY RTRIM(WCODNOM)+"-"+DTOC(NOMINA->APERT2)+"-"+LTRIM(STR(GENTE,4))
      @ 3,10  say rtrim(personal->apellido)+", "+RTRIM(PERSONAL->NOMBRE)
      @ 3,45  say personal->cedula
      @ 3,72  say WBASICO picture "#######.##"
     *@ 5,95  say rtrim(personal->apellido)+", "+RTRIM(PERSONAL->NOMBRE)
      @ 6,10  say NOMINA->DESNOM
      @ 6,58  say wclasif
     *@ 8,95  say personal->cedula
      STORE 8 TO LINE
     *@ LINE+1,95 SAY QQWW

      IF PROCESO->P_REPOSO <> SPACE(2)
         STORE LINE+1 TO LINE
         @ LINE,05 SAY "*** EN REPOSO DURANTE ESTE PERIODO DE PAGO ***"
      ENDIF

      if wbsordd > 0
         store line +1 to line
         @ line,10 say "BO"
         @ line,15 say "Horas ordinarias diurnas"
         @ line,48 say whorasord picture "###.##"
         @ line,57 say wbsordd   picture "######.##"
      endif
      if wbsordm > 0
         store line +1 to line
         @ line,10 say "BO"
         @ line,15 say "Horas ordinarias mixtas"
         @ line,48 say whorasorm picture "###.##"
         @ line,57 say wbsordm   picture "######.##"
      endif
      if wbsordn > 0
         store line +1 to line
         @ line,10 say "BO"
         @ line,15 say "Horas ordinarias nocturnas"
         @ line,48 say whorasorn picture "###.##"
         @ line,57 say wbsordn   picture "######.##"
      endif

      if WSTDABS > 0
         store line +1 to line
         @ line,10 say "BO"
         @ line,15 say "Sobre tiempo diurno"
         @ line,48 say wstda picture "###.##"
         @ line,57 say wstdabs picture "######.##"
      endif
      if WSTDBBS > 0
         store line +1 to line
         @ line,10 say "BO"
         @ line,15 say "Sobre tiempo diurno +"
         @ line,48 say wstdb picture "###.##"
         @ line,57 say wstdbbs picture "######.##"
      endif

      if WSTMABS > 0
         store line +1 to line
         @ line,10 say "BO"
         @ line,15 say "Sobre tiempo mixto"
         @ line,48 say wstma picture "###.##"
         @ line,57 say wstmabs picture "######.##"
      endif
      if WSTMBBS > 0
         store line +1 to line
         @ line,10 say "BO"
         @ line,15 say "Sobre tiempo mixto +"
         @ line,48 say wstmb picture "###.##"
         @ line,57 say wstmbbs picture "######.##"
      endif
      if WSTNABS > 0
         store line +1 to line
         @ line,10 say "BO"
         @ line,15 say "Sobre tiempo nocturno"
         @ line,48 say wstna picture "###.##"
         @ line,57 say wstnabs picture "######.##"
      endif
      if WSTNBBS > 0
         store line +1 to line
         @ line,10 say "BO"
         @ line,15 say "Sobre tiempo nocturno +"
         @ line,48 say wstnb picture "###.##"
         @ line,57 say wstnbbs picture "######.##"
      endif
      if WSTGMBS+WSTGNBS > 0
         store line +1 to line
         @ line,10 say "BO"
         @ line,15 say "Sobre tiempo de guardia"
         @ line,48 say wstgm+wstgn picture "###.##"
         @ line,57 say wstgmbs+wstgnbs picture "######.##"
      endif

      if wtvdabs  > 0
         store line +1 to line
         @ line,10 say "BO"
         @ line,15 say "Tiempo de viaje diurno"
         @ line,48 say wtvda picture "###.##"
         @ line,57 say wtvdabs  picture "######.##"
      endif
      if wtvdbbs  > 0
         store line +1 to line
         @ line,10 say "BO"
         @ line,15 say "Tiempo de viaje diurno +"
         @ line,48 say wtvdb picture "###.##"
         @ line,57 say wtvdbbs  picture "######.##"
      endif

      if wtvmabs  > 0
         store line +1 to line
         @ line,10 say "BO"
         @ line,15 say "Tiempo de viaje mixto"
         @ line,48 say wtvma picture "###.##"
         @ line,57 say wtvmabs  picture "######.##"
      endif
      if wtvmbbs  > 0
         store line +1 to line
         @ line,10 say "BO"
         @ line,15 say "Tiempo de viaje mixto +"
         @ line,48 say wtvmb picture "###.##"
         @ line,57 say wtvmbbs  picture "######.##"
      endif

      if wtvnabs  > 0
         store line +1 to line
         @ line,10 say "BO"
         @ line,15 say "Tiempo de viaje nocturno"
         @ line,48 say wtvna picture "###.##"
         @ line,57 say wtvnabs  picture "######.##"
      endif
      if wtvnbbs  > 0
         store line +1 to line
         @ line,10 say "BO"
         @ line,15 say "Tiempo de viaje nocturno +"
         @ line,48 say wtvnb picture "###.##"
         @ line,57 say wtvnbbs  picture "######.##"
      endif

      if wdesnorbs > 0
         store line+1 to line
         @ line,10 say "BO"
         @ line,15 say "Descanso normal"
         @ line,48 say wdesnorhr picture "###.##"
         @ line,57 say wdesnorbs picture "######.##"
      endif

      if wdesconbs > 0
         store line+1 to line
         @ line,10 say "BO"
         @ line,15 say "Descanso contractual trabajado"
         @ line,48 say wdesconhr picture "###.##"
         @ line,57 say wdesconbs picture "######.##"
      endif

      if wdeslegbs > 0
         store line+1 to line
         @ line,10 say "BO"
         @ line,15 say "Descanso legal trabajado"
         @ line,48 say wdesleghr picture "###.##"
         @ line,57 say wdeslegbs picture "######.##"
      endif

      if wdcbs > 0
         store line+1 to line
         @ line,10 say "BO"
         @ line,15 say "Descanso compensatorio"
         @ line,48 say wdc   picture "###.##"
         @ line,57 say wdcbs picture "######.##"
      endif

      if wayuciubs > 0
         store line+1 to line
         @ line,10 say "BO"
         @ line,15 say "Ayuda de ciudad"
         @ line,48 say wayuciuhr picture "###.##"
         @ line,57 say wayuciubs picture "######.##"
      endif

      if wcomidabs > 0
         store line+1 to line
         @ line,10 say "BO"
         @ line,15 say "Comidas"
         @ line,48 say wcomida picture "###.##"
         @ line,57 say wcomidabs picture "######.##"
      endif

      if wrepcombs > 0
         store line+1 to line
         @ line,10 say "BO"
         @ line,15 say "Reposo/Comida"
         @ line,48 say wrepcom picture "###.##"
         @ line,57 say wrepcombs picture "######.##"
      endif

      if wfertot > 0
         store line+1 to line
         @ line,10 say "BO"
         @ line,15 say "Feriados                 "
         @ line,48 say wferhoras picture "###.##"
         @ line,57 say wfertot picture "######.##"
      endif

      if wbnbs > 0
         store line+1 to line
         @ line,10 say "BO"
         @ line,15 say "Bono nocturno"
         @ line,48 say wbn picture "###.##"
         @ line,57 say wbnbs picture "######.##"
      endif

      if wbngbs > 0
         store line+1 to line
         @ line,10 say "BO"
         @ line,15 say "Bono nocturno de guardia"
         @ line,48 say wbnghr picture "###.##"
         @ line,57 say wbngbs picture "######.##"
      endif

      if wbnvbs > 0
         store line+1 to line
         @ line,10 say "BO"
         @ line,15 say "Bono nocturno de viaje"
         @ line,48 say wbnv picture "###.##"
         @ line,57 say wbnvbs picture "######.##"
      endif

      if wbdbs+wferprihr > 0
         store line+1 to line
         @ line,10 say "BO"
         @ line,15 say "Prima Dom./Prima Fer.Trab."
         @ line,48 say wbdhr+wferprihr picture "###.##"
         @ line,57 say wbdbs+wferpribs picture "######.##"
      endif

      if wbcbs > 0
         store line+1 to line
         @ line,10 say "BO"
         @ line,15 say "Bono Compensatorio."
         @ line,48 say wbchr picture "###.##"
         @ line,57 say wbcbs picture "######.##"
      endif

      if wocbBS3 > 0
         store line+1 to line
         @ line,10 say "BO"
         @ line,15 say wdes3
         @ line,48 say wocbhr3 picture "###.##"
         @ line,57 say wocbbs3 picture "######.##"
      endif

      if wocbBS4 > 0
         store line+1 to line
         @ line,10 say "BO"
         @ line,15 say wdes4
         @ line,48 say wocbhr4 picture "###.##"
         @ line,57 say wocbbs4 picture "######.##"
      endif

      *****  no bonificable  *******
      if wbonotran > 0
         store line+1 to line
         @ line,10 say "NB"
         @ line,15 say "Bono de transporte"
         @ line,57 say wbonotran picture "######.##"
      endif

      if wbonoalim > 0
         store line+1 to line
         @ line,10 say "NB"
         @ line,15 say "Bono alimenticio"
         @ line,57 say wbonoalim picture "######.##"
      endif

      if wbonosubs > 0
         store line+1 to line
         @ line,10 say "NB"
         @ line,15 say "Bono subsidio   "
         @ line,57 say wbonosubs picture "######.##"
      endif

      if wcesta > 0
         store line+1 to line
         @ line,10 say "NB"
         @ line,15 say "Cesta basica"
         @ line,57 say wcesta picture "######.##"
      endif

      if wvivebs > 0
         store line+1 to line
         @ line,10 say "NB"
         @ line,15 say "Vivienda (I.S.A.)"
         @ line,57 say wvivebs picture "######.##"
      endif

      if wutilidad > 0
         store line+1 to line
         @ line,10 say "NB"
         @ line,15 say "Utilidades"
         @ line,57 say wutilidad picture "######.##"
      endif

      if windemniza > 0
         store line+1 to line
         @ line,10 say "NB"
         @ line,15 say "Indemnizacion"
         @ line,57 say windemniza picture "######.##"
      endif

      if wocnb3 > 0
         store line+1 to line
         @ line,10 say "NB"
         @ line,15 say wdesc3
         @ line,57 say wocnb3 picture "######.##"
      endif

      if wocnb4 > 0
         store line+1 to line
         @ line,10 say "NB"
         @ line,15 say wdesc4
         @ line,57 say wocnb4 picture "######.##"
      endif

      **** DEDUCCIONES ***********
      if wislr > 0
         store line+1 to line
         @ line,10 say "DE"
         @ line,15 say "Impuesto Sobre La Renta"
         @ line,69 say wislr picture "######.##"
      endif

      if wsso > 0
         store line+1 to line
         @ line,10 say "DE"
         @ line,15 say "Seguro Social Obligatorio"
         @ line,69 say wsso picture "######.##"
      endif

      if wspf > 0
         store line+1 to line
         @ line,10 say "DE"
         @ line,15 say "Seguro de paro forzoso"
         @ line,69 say wspf picture "######.##"
      endif

      if wAHRHAB > 0
         store line+1 to line
         @ line,10 say "DE"
         @ line,15 say "Ahorro Habitacional"
         @ line,69 say WAHRHAB picture "######.##"
      endif

      if wsindic > 0
         store line+1 to line
         @ line,10 say "DE"
         @ line,15 say "Aporte "+QWRESTO
         @ line,69 say wsindic picture "######.##"
      endif

      if wpresper > 0
         store line+1 to line
         @ line,10 say "DE"
         @ line,15 say "Prestamo I/O Anticipos"
         @ line,69 say wpresper picture "######.##"
      endif

      if wcaja > 0
         store line+1 to line
         @ line,10 say "DE"
         @ line,15 say "Aporte a Caja de Ahorros"
         @ line,69 say wcaja picture "######.##"
      endif

      if wod3 > 0
         store line+1 to line
         @ line,10 say "DE"
         @ line,15 say Wdescr3
         @ line,69 say Wod3 picture "######.##"
      endif

      if wod4 > 0
         store line+1 to line
         @ line,10 say "DE"
         @ line,15 say Wdescr4
         @ line,69 say Wod4 picture "######.##"
      endif

      STORE LINE+1 TO LINE
     @ 26,56 SAY PERSONAL->MP-WPRESPER PICTURE "#######.##"
     @ 26,69  say dtoc(WFECACT)
     @ 26,80  say wnetopagar picture "######.##"
    *@ 27,93  say nomina->apert1
    *@ 27,103 say nomina->apert2
    *@ 27,114 say wnetopagar picture "######.##"

     STORE PERSONAL->UTILACUM+WTOTBON TO WUTILACUM
     SELECT 10
     GO TOP
     LOCATE FOR CONTRATO = PERSONAL->CONTRATO
     IF FOUND()
        STORE PORCENTAJE TO WFACTUTIL
     ELSE
        STORE 0 TO WFACTUTIL
     ENDIF
     IF (PERSONAL->CONTRATO = "PETROLERO" .OR. PERSONAL->CONTRATO = "PEQUIVEN") .AND. PERSONAL->TIPO <> "OT"
        @ 27,42 SAY STR(WUTILACUM,10,2)
     ENDIF
     *** FIN DISPLAY DE ESTATUS
    * @ 30, 1 SAY "F I R M A    D E L    B E N E F I C I A R I O : ---------------------------------------"
    * @ 31,0 SAY REPLICATE("-",116)
     SELECT 4
     CONTINUE
   ENDDO
   @ PROW(),0 SAY CHR(18)
   @ prow(),1 say chr(27)+chr(67)+chr(66)
   EJECT
   SELECT 1
   REPLACE ESTADO WITH 3
   SET DEVI TO SCREE
   restore scre from s5
ENDDO

