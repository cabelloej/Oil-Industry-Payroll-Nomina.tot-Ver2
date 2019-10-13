*********************************************************************************
*                  PROGRAMA PARA IMPRIMIR LOS SOBRES                           *
********************************************************************************
store "INSTALACION NO AUTORIZADA" to warning
STORE "CONSULTAR PAGOS" TO T2
SELECT 1 
USE IPNOMINA INDEX IPNOMINA ALIAS NOMINA
SELECT 2
USE IPNPROCO INDEX IPNPROCO ALIAS PROCESO
SELECT 3
USE IPNFACTOR INDEX IPNFACTOR ALIAS TABLA
select 5
use ipnotcon index ipnotcon
select 4
USE IPNPERSO INDEX IPNPERSO ALIAS PERSONAL
SELECT 9
USE IPNSINDI
STORE .T. TO REPORTA
SAVE SCRE TO S9
DO WHILE REPORTA
   RESTORE SCRE FROM S9
   STORE .T. TO NOMINAX
   DO WHILE NOMINAX
      STORE 0 TO WWTOTA
      STORE 0 TO WWTOTB
      STORE 0 TO WWTOTC
      STORE 0 TO WWTOTD
      SELECT 4
      STORE SPACE(5) TO WCODNOM
      STORE SPACE(10) TO WCODPER
      SET COLOR TO W+/b
      @ 5,1 CLEAR TO 12,50
      @ 5,1 TO 12,50 DOUBLE
      @ 5,25-(LEN(T2)/2) SAY T2
      STORE "CEDULA A CONSULTAR" to mess
      do mensaje with mess
      @ 7,3 say "CEDULA     : " GET WCODPER
      @ 9,3 SAY "NOMBRE     :"
      READ
      STORE UPPER(WCODPER) TO WCODPER
      IF WCODPER=SPACE(10)
         CLOSE DATA
         CLOSE INDEX
         RETURN
      ENDIF
      SELECT 4
      FIND &WCODPER
      IF EOF()
         STORE "CEDULA NO REGISTRADA" to mes
         do aviso with mes
         CLOSE DATA
         CLOSE INDEX
         RETURN
      endif
      @ 9,16 SAY rtrim(apellido)+" "+nombre
      store nomina to wcodnom
      if wcodnom = space(5)
         store "Esta persona no esta registrada en nominas" to mes
         do aviso with mes
         CLOSE DATA
         CLOSE INDEX
         RETURN
      endif
      select 1
      FIND &WCODNOM
      IF EOF()
         STORE "Nomina no registrada" to mes
         do aviso with mes
         close data
         close index
         return
      endif
      IF ESTADO = 0
         STORE "ERROR, esta nomina esta cerrada " to mes
         do aviso with mes
         CLOSE DATA
         CLOSE INDEX
         RETURN
      endif
      STORE FACTCOD TO WFACTOR
      store .f. to nominaX
   ENDDO

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
   SELECT 3
   FIND &WFACTOR
   IF EOF()
      STORE "ERROR, TABLA DE FACTORES DE ESTA NOMINA NO ESTA REGISTRADA" TO MES
      DO AVISO WITH MESS
      LOOP
   ENDIF

   STORE SPACE(35) TO QQWW
   DO INFORMA WITH QQWW
   IF QQWW <> t3
      STORE 1 TO POSI
      else
      STORE 0 TO POSI
   ENDIF

   SELECT 4
   DO WHILE .NOT. EOF() .and. cedula = wcodper
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
         skip
         LOOP
      endif
      SELECT 9
      LOCATE FOR CONTRATO = PERSONAL->SINDICATO
      IF FOUND()
         STORE DEFINICION TO QWRESTO
         ELSE
         STORE "NO REGISTRADO" TO QWRESTO
      ENDIF
      select 2
      *** CALCULO DE PAGO ***
      *** CALCULO DE PAGO ***
      STORE SPACE(10) TO WCEDULA,WNOMBRE,WAPELLIDO,WCLASIF
      STORE SPACE(2)  TO WDES3,WDES4,WDESC3,WDESC4,WDESCR3,WDESCR4
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
         @ 0,0 clear
         @ 0,0 say  "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
         @ 1,0 say  "³ APELLIDOS Y NOMBRES               ³  CEDULA   ³   SUELDO   ³ CLASIFICACION   ³"
         @ 2,0 SAY  "ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
         @ 3,0 SAY  "³                                   ³           ³            ³                 ³"
         @ 3,1  say rtrim(personal->nombre)+" "+rtrim(personal->apellido)
         @ 3,37 say personal->cedula
         @ 3,51 say WBASICO picture "#######.##"
         @ 3,62 say wclasif
         @ 4,0 SAY  "ÃÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÂÄÄÄÄÄÄÁÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ´"
         @ 5,0 SAY  "³CLAVE³ DESCRIPCION                             ³UND. ³ ASIGNACION³   DEDUCCION³"
         @ 6,0 SAY  "ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄ´"
         @ 7,0 SAY  "³     ³                                         ³     ³           ³            ³"
 *       @ 8,0 SAY  "ÀÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÙ"
         STORE 6 TO LINE

      IF WBSORDD > 0
         STORE LINE + 1 TO LINE
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "BO"
         @ line,07 say "Horas ordinarias diurnas"
         @ line,50 say whorasord picture "###"
         @ line,57say wbsordd   picture "######.##"
      ENDIF
      IF WBSORDM > 0
         STORE LINE + 1 TO LINE
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "BO"
         @ line,07 say "Horas ordinarias mixtas"
         @ line,49 say whorasorm picture "##.#"
         @ line,57say wbsordm   picture "######.##"
      ENDIF
      IF WBSORDN > 0
         STORE LINE + 1 TO LINE
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "BO"
         @ line,07 say "Horas ordinarias nocturnas"
         @ line,49 say whorasorn picture "##.#"
         @ line,57say wbsordn   picture "######.##"
      ENDIF
      if WSTDABS > 0
         store line +1 to line
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "BO"
         @ line,07 say "Sobre tiempo diurno."
         @ line,49 say WSTDA picture "##.#"
         @ line,57say WSTDABS picture "########.##"
      endif

      if WSTDBBS > 0
         store line +1 to line
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "BO"
         @ line,07 say "Sobre tiempo diurno adicional."
         @ line,49 say WSTDB picture "##.#"
         @ line,57say WSTDBBS picture "######.##"
      endif

      if WSTMABS > 0
         store line +1 to line
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "BO"
         @ line,07 say "Sobre tiempo mixto."
         @ line,49 say WSTMA picture "##.#"
         @ line,57say WSTMABS picture "######.##"
      endif

      if WSTMBBS > 0
         store line +1 to line
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "BO"
         @ line,07 say "Sobre tiempo mixto adicional."
         @ line,49 say WSTMB picture "##.#"
         @ line,57say WSTMBBS picture "######.##"
      endif

      if WSTNABS > 0
         store line +1 to line
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "BO"
         @ line,07 say "Sobre tiempo nocturno."
         @ line,49 say WSTNA picture "##.#"
         @ line,57say WSTNABS picture "######.##"
      endif

      if WSTNBBS > 0
         store line +1 to line
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "BO"
         @ line,07 say "Sobre tiempo nocturno adicional."
         @ line,49 say WSTNB picture "##.#"
         @ line,57say WSTNBBS picture "######.##"
      endif

      if WSTGMBS > 0
         store line +1 to line
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "BO"
         @ line,07 say "Sobre tiempo guardia mixta"
         @ line,49 say WSTGM picture "##.#"
         @ line,57say WSTGMBS picture "######.##"
      endif

      if WSTGNBS > 0
         store line +1 to line
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "BO"
         @ line,07 say "Sobre tiempo guardia nocturna"
         @ line,49 say WSTGN picture "##.#"
         @ line,57say WSTGNBS picture "######.##"
      endif

      if wtvdabs  > 0
         store line +1 to line
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "BO"
         @ line,07 say "Tiempo de viaje diurno de 1.5 Hrs."
         @ line,49 say wtvda picture "##.#"
         @ line,57say wtvdabs  picture "######.##"
      endif
      if wtvdbbs  > 0
         store line +1 to line
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "BO"
         @ line,07 say "Tiempo de viaje diurno de +1.5 Hrs."
         @ line,49 say wtvdb picture "##.#"
         @ line,57say wtvdbbs  picture "######.##"
      endif

      if wtvmabs  > 0
         store line +1 to line
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "BO"
         @ line,07 say "Tiempo de viaje mixto  de 1.5 Hrs."
         @ line,49 say wtvma picture "##.#"
         @ line,57say wtvmabs  picture "######.##"
      endif
      if wtvmbbs  > 0
         store line +1 to line
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "BO"
         @ line,07 say "Tiempo de viaje mixto  de +1.5 Hrs."
         @ line,49 say wtvmb picture "##.#"
         @ line,57say wtvmbbs  picture "######.##"
      endif

      if wtvnabs  > 0
         store line +1 to line
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "BO"
         @ line,07 say "Tiempo de viaje noctur.de 1.5 Hrs."
         @ line,49 say wtvna picture "##.#"
         @ line,57say wtvnabs  picture "######.##"
      endif
      if wtvnbbs  > 0
         store line +1 to line
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "BO"
         @ line,07 say "Tiempo de viaje noctur.de +1.5 Hrs."
         @ line,49 say wtvnb picture "##.#"
         @ line,57say wtvnbbs  picture "######.##"
      endif

      if wdesnorbs > 0
         store line+1 to line
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "BO"
         @ line,07 say "Descanso normal"
         @ line,49 say wdesnorhr picture "##.##"
         @ line,57say wdesnorbs picture "######.##"
      endif

      if wdesconbs > 0
         store line+1 to line
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "BO"
         @ line,07 say "Descanso contractual trabajado"
         @ line,49 say wdesconhr picture "##.##"
         @ line,57say wdesconbs picture "######.##"
      endif

      if wdeslegbs > 0
         store line+1 to line
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "BO"
         @ line,07 say "Descanso legal trabajado"
         @ line,49 say wdesleghr picture "##.##"
         @ line,57say wdeslegbs picture "######.##"
      endif

      if WDCBS > 0
         store line+1 to line
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "BO"
         @ line,07 say "Descanso compensatorio"
         @ line,49 say wdc       picture "##.##"
         @ line,57say wdcbs     picture "######.##"
      endif

      if wayuciubs > 0
         store line+1 to line
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "BO"
         @ line,07 say "Ayuda de ciudad"
         @ line,48 say wayuciuhr picture "###.##"
         @ line,57say wayuciubs picture "######.##"
      endif

      if wcomidabs > 0
         store line+1 to line
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "BO"
         @ line,07 say "Comidas"
         @ line,49 say wcomida picture "##.##"
         @ line,57say wcomidabs picture "######.##"
      endif

      if wrepcombs > 0
         store line+1 to line
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "BO"
         @ line,07 say "Reposo/comida"
         @ line,49 say wrepcom   picture "##.##"
         @ line,57say wrepcombs picture "######.##"
      endif

      if wfertot > 0
         store line+1 to line
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "BO"
         @ line,07 say "Feriados                 "
         @ line,49 say wferhoras picture "##.##"
         @ line,57say wfertot picture "######.##"
      endif

      if wbn > 0
         store line+1 to line
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "BO"
         @ line,07 say "Bono nocturno"
         @ line,49 say wbn picture "##.##"
         @ line,57say wbnbs picture "######.##"
      endif

      if wbnv > 0
         store line+1 to line
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "BO"
         @ line,07 say "Bono nocturno de viaje"
         @ line,49 say wbnv picture "##.##"
         @ line,57say wbnvbs picture "######.##"
      endif

      if wbdbs > 0
         store line+1 to line
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "BO"
         @ line,07 say "Bono dominical"
         @ line,49 say wbdhr picture "##.##"
         @ line,57say wbdbs picture "######.##"
      endif

      if wferpribs > 0
         store line+1 to line
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "BO"
         @ line,07 say "Prima feriado trabajado"
         @ line,49 say wferprihr picture "##.##"
         @ line,57say wferpribs picture "######.##"
      endif

      if wbnGBS > 0
         store line+1 to line
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "BO"
         @ line,07 say "Bono nocturno de guardia"
         @ line,49 say wbnghr picture "##.##"
         @ line,57say wbngbs picture "######.##"
      endif

      if wbcbs > 0
         store line+1 to line
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "BO"
         @ line,07 say "Bono compensatorio"
         @ line,48 say wbchr picture "###.##"
         @ line,57say wbcbs picture "######.##"
      endif

*     if wocbBS1 > 0
*        store line+1 to line
*        IF LINE > 19
*           STORE "Oprima <ENTER> para continuar" to mes
*           do aviso with mes
*           @ 7,0 clear
*           store 7 to line
*        endif
*        @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
*        @ line,2 say "BO"
*        @ line,07 say wdes1
*        @ line,49 say wocbhr1 picture "##.##"
*        @ line,57say wocbbs1 picture "######.##"
*     endif

*     if wocbBS2 > 0
*        store line+1 to line
*        IF LINE > 19
*           STORE "Oprima <ENTER> para continuar" to mes
*           do aviso with mes
*           @ 7,0 clear
*           store 7 to line
*        endif
*        @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
*        @ line,2 say "BO"
*        @ line,07 say wdes2
*        @ line,49 say wocbhr2 picture "##.##"
*        @ line,57say wocbbs2 picture "######.##"
*     endif

      if wocbBS3 > 0
         store line+1 to line
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "BO"
         select 5
         seek wdes3
         if eof()
            store "no registrado" to wdescri3
         else
            store descri to wdescri3
         endif
         @ line,07 say wdescri3
         @ line,49 say wocbhr3 picture "##.##"
         @ line,57say wocbbs3 picture "######.##"
      endif

      if wocbBS4 > 0
         store line+1 to line
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "BO"
         select 5
         seek wdes4
         if eof()
            store "no registrado" to wdescri4
         else
            store descri to wdescri4
         endif
         @ line,07 say wdescri4
         @ line,49 say wocbhr4 picture "##.##"
         @ line,57say wocbbs4 picture "######.##"
      endif


      *****  no bonificable  *******

      if wbonotran > 0
         store line+1 to line
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "NB"
         @ line,07 say "Bono de transporte"
         @ line,57say wbonotran picture "######.##"
      endif

      if wbonoalim > 0
         store line+1 to line
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "NB"
         @ line,07 say "Bono alimenticio"
         @ line,57say wbonoalim picture "######.##"
      endif

      if wbonosubs > 0
         store line+1 to line
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "NB"
         @ line,07 say "Bono subsidio   "
         @ line,57say wbonosubs picture "######.##"
      endif

      if wcesta > 0
         store line+1 to line
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "NB"
         @ line,07 say "Cesta basica"
         @ line,57say wcesta picture "######.##"
      endif

      if wvivebs > 0
         store line+1 to line
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "NB"
         @ line,07 say "Vivienda"
         @ line,57say wvivebs picture "######.##"
      endif

      if wutilidad > 0
         store line+1 to line
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "NB"
         @ line,07 say "Utilidades"
         @ line,57say wutilidad picture "######.##"
      endif

      if windemniza > 0
         store line+1 to line
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "NB"
         @ line,07 say "Indemnizacion"
         @ line,57say windemniza picture "######.##"
      endif

      if wocnb3 > 0
         store line+1 to line
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "NB"
         select 5
         seek wdesc3
         if eof()
            store "no registrado" to wdescri3
         else
            store descri to wdescri3
         endif
         @ line,07 say wdescri3
         @ line,57say wocnb3 picture "######.##"
      endif

      if wocnb4 > 0
         store line+1 to line
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "NB"
         select 5
         seek wdesc4
         if eof()
            store "no registrado" to wdescri4
         else
            store descri to wdescri4
         endif
         @ line,07 say wdescri4
         @ line,57say wocnb4 picture "######.##"
      endif

      **** DEDUCCIONES ***********
      if wislr > 0
         store line+1 to line
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "DE"
         @ line,07 say "I.S.L.R."
         @ line,70 say wislr picture "######.##"
      endif

      if wsso > 0
         store line+1 to line
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "DE"
         @ line,07 say "S.S.O."
         @ line,70 say wsso picture "######.##"
      endif

      if wspf > 0
         store line+1 to line
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "DE"
         @ line,07 say "Seguro de paro forzoso"
         @ line,70 say wspf picture "######.##"
      endif

      if wAHRHAB > 0
         store line+1 to line
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "DE"
         @ line,07 say "Ahorro Habitacional"
         @ line,70 say WAHRHAB picture "######.##"
      endif

      if wsindic > 0
         store line+1 to line
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "DE"
         @ line,07 say "Sindicato "+QWRESTO
         @ line,70 say wsindic picture "######.##"
      endif

      if wCAJA > 0
         store line+1 to line
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "DE"
         @ line,07 say "Caja de ahorros"
         @ line,70 say wcaja picture "######.##"
      endif

      if wpresper > 0
         store line+1 to line
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "DE"
         @ line,07 say "Prestamo personal"
         @ line,70 say wpresper picture "######.##"
      endif

 *    if wod1 > 0
 *       store line+1 to line
 *       IF LINE > 19
 *          STORE "Oprima <ENTER> para continuar" to mes
 *          do aviso with mes
 *          @ 7,0 clear
 *          store 7 to line
 *       endif
 *       @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
 *       @ line,2 say "DE"
 *       @ line,07 say Wdescr1
 *       @ line,70 say Wod1 picture "######.##"
 *    endif

 *    if wod2 > 0
 *       store line+1 to line
 *       IF LINE > 19
 *          STORE "Oprima <ENTER> para continuar" to mes
 *          do aviso with mes
 *          @ 7,0 clear
 *          store 7 to line
 *       endif
 *       @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
 *       @ line,2 say "DE"
 *       @ line,07 say Wdescr2
 *       @ line,70 say Wod2 picture "######.##"
 *    endif

      if wod3 > 0
         store line+1 to line
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "DE"
         @ line,07 say Wdescr3
         @ line,70 say Wod3 picture "######.##"
      endif

      if wod4 > 0
         store line+1 to line
         IF LINE > 19
            STORE "Oprima <ENTER> para continuar" to mes
            do aviso with mes
            @ 7,0 clear
            store 7 to line
         endif
         @ LINE,0 SAY  "³     ³                                         ³     ³           ³            ³"
         @ line,2 say "DE"
         @ line,07 say Wdescr4
         @ line,70 say Wod4 picture "######.##"
      endif

      STORE LINE+1 TO LINE
      @ LINE,0 SAY     "ÀÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÙ"
      @ LINE+1,7 say "T O T A L    A    P A G A R :"
      @ LINE+1,55 SAY wnetopagar picture "########.##"
      SELECT 4
      SKIP
   ENDDO
   STORE "OPRIMA <ENTER> PARA CONTINUAR" TO MES
   DO AVISO WITH MES
   *CALL SAVESCR WITH "R5"
   restore scre from s9
ENDDO

