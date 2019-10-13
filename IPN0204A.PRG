********************************************************************************
*            PROGRAMA PARA IMPRIMIR LA NOMINA  FORMATO PETROLERO               *
********************************************************************************
STORE 1 TO WFROM
store "INSTALACION NO AUTORIZADA" to warning
STORE "REPORTE DE NOMINA :" TO T2
SELECT 1 
USE IPNOMINA INDEX IPNOMINA ALIAS NOMINA
SELECT 2
USE IPNPROCO INDEX IPNPROCO ALIAS PROCESO
SELECT 3
USE IPNFACTO INDEX IPNFACTO ALIAS TABLA
SELECT 4
USE IPNPERSO INDEX IPNPERSO ALIAS PERSONAL
SELECT 9
USE IPNCARGO INDEX IPNCARGO
SELECT 4
STORE .T. TO REPORTA
DO WHILE REPORTA
   STORE .T. TO NOMINAX
   DO WHILE NOMINAX
      STORE 0 TO WWTOTA
      STORE 0 TO WWTOTB
      STORE 0 TO WWTOTC
      STORE 0 TO WWTOTD
      SELECT 1
      STORE SPACE(5) TO WCODNOM
      SET COLOR TO W+/B
      @ 5,1 CLEAR TO 12,50
      @ 5,1 TO 12,50 DOUBLE
      @ 5,15 SAY "LIQUIDACION"
      @ 5,25-(LEN(T2)/2) SAY T2
      STORE "NOMINA A IMPRIMIR" to mess
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
         STORE "NOMINA NO REGISTRADA" to mes
         do aviso with mes
         loop
      endif
      @ 9,16 SAY DESNOM
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

      IF ESTADO = 1
         STORE .F. TO NOMINAX
         loop
      endif

      IF ESTADO = 0
         STORE "ERROR, esta nomina esta cerrada " to mes
         do aviso with mes
         loop
      endif

      if estado = 2 .or. estado = 3
         store space(5) to Wclave
         store "IPNOK" TO WORD
         store "ERROR, esta nomina ya fue reportada. Ingrese clave de acceso: " to mess
         @ 23,40 - (len(mess)/2) say mess
         SET INTENSITY OFF
         SET COLOR TO B/B
         @ 23,(40-(len(mess)/2)+len(mess)) get wclave
         READ
         SET INTENSITY ON
         SET COLOR TO W+/B
         IF WCLAVE = WORD
            STORE .F. TO NOMINAX
         ENDIF
      ENDIF
   ENDDO

   STORE FACTCOD TO WFACTOR
   SELECT 3
   FIND &WFACTOR
   IF EOF()
      STORE "ERROR, TABLA DE FACTORES DE ESTA NOMINA NO ESTA REGISTRADA" TO MES
      DO AVISO WITH MESS
      LOOP
   ENDIF

   SET DEVI TO PRINT
   STORE SPACE(35) TO QQWW
   DO INFORMA WITH QQWW
   IF QQWW <> t3
      STORE 1 TO POSI
      else
      STORE 0 TO POSI
   ENDIF

   STORE 1 TO LN
   DO IPNFORMA
   STORE 20 TO LINE
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
      STORE VEZ + 1 TO VEZ
      STORE GENTE + 1 TO GENTE
      IF VEZ = 6
         STORE 8 TO LN
         STORE LINE + 1 TO LINE
         DO IPNFORMA

         STORE 1 TO LN
         DO IPNFORMA
         STORE 20 TO LINE
         STORE 1 TO VEZ

         STORE 7 TO LN
         STORE LINE + 1 TO LINE
         DO IPNFORMA
         STORE 7 TO LN
         DO IPNFORMA
      ELSE
         STORE 7 TO LN
         STORE LINE + 1 TO LINE
         DO IPNFORMA
         STORE 7 TO LN
         DO IPNFORMA
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
      STORE 2 TO LN
      STORE LINE + 1 TO LINE
      DO IPNFORMA
      ******* PRIMERA LINEA DE DATOS ***********
      @ LINE,33 SAY WCEDULA
      @ LINE,44 SAY WDIASTRABd       PICTURE "@z ##.#"
      @ LINE,48 SAY WHORASORd        PICTURE "@z ###.#"
      @ LINE, 54 SAY WBSORDd         PICTURE "@z ######.##"
      @ LINE, 64 SAY WSTDA+WSTDB     PICTURE "@z ##.#"
      @ LINE, 69 SAY WSTDABS+WSTDBBS PICTURE "@z #####.##"
      @ LINE, 78 SAY WTVDA+WTVDB     PICTURE "@z ##.#"
      @ LINE, 82 SAY WTVDABS+WTVDBBS PICTURE "@z #####.##"
      @ LINE,90 SAY WDESNORHR  PICTURE "@z ###"
      @ LINE,93 SAY WDESNORBS  PICTURE "@z ######.##"
      @ LINE,103 SAY WAYUCIUHR PICTURE "@z ###"
      @ LINE,107 SAY WAYUCIUBS PICTURE "@z #####.##"
      @ LINE,116 SAY WBN+WBNGHR       PICTURE "@z ###"
      @ LINE,120 SAY WBNBS+WBNGBS     PICTURE "@z #####.##"
 *    @ LINE,129 SAY WDES1
 *    @ LINE,131 SAY WOCBHR1 PICTURE "@z ###"
 *    @ LINE,134 SAY WOCBBS1 PICTURE "@z ######.##"

      @ LINE,154 SAY WBONOTRAN+WBONOALIM PICTURE "@z #####.##"
      @ LINE,166 SAY WUTILIDAD PICTURE "@z #####.##"
   
      @ LINE,185 SAY WISLR    PICTURE "@z #####.##"
      @ LINE,193 SAY WSINDIC  PICTURE "@z #####.##"
*     @ LINE,202 SAY WDESCR1
*     @ LINE,205 SAY WOD1     PICTURE "@z #####.##"

      STORE LINE + 1 TO LINE
      STORE 3 TO LN
      DO IPNFORMA

      STORE 4 TO LN
      STORE LINE + 1 TO LINE
      DO IPNFORMA

      ***********  SEGUNDA LINEA DE DATOS ************
      @ LINE,1   SAY GENTE PICTURE "@z ###"
      @ line,5   SAY RTRIM(WNOMBRE)+" "+RTRIM(WAPELLIDO)
      @ LINE,44  SAY WDIASTRABm      PICTURE "@z ##.#"
      @ LINE,48  SAY WHORASORm       PICTURE "@z ###.#"
      @ LINE,54  SAY WBSORDm         PICTURE "@z ######.##"
      @ LINE,64  SAY WSTMA+WSTMB     PICTURE "@z ##.#"
      @ LINE,69  SAY WSTMABS+WSTMBBS PICTURE "@z #####.##"
      @ LINE,78  SAY WTVMA+WTVMB     PICTURE "@z ##.#"
      @ LINE,82  SAY WTVMABS+WTVMBBS PICTURE "@z #####.##"
      @ LINE,90  SAY WDESCONHR       PICTURE "@z ###"
      @ LINE,93  SAY WDESCONBS       PICTURE "@z ######.##"
      @ LINE,103 SAY WCOMIDA         PICTURE "@z ###"
      @ LINE,107 SAY WCOMIDABS       PICTURE "@z #####.##"
      @ LINE,116 SAY WBNV            PICTURE "@z ###"
      @ LINE,120 SAY WBNVBS          PICTURE "@z #####.##"
  *   @ LINE,129 SAY WDES2
  *   @ LINE,131 SAY WOCBHR2         PICTURE "@z ###"
  *   @ LINE,134 SAY WOCBBS2         PICTURE "@z ######.##"

      @ LINE,154 SAY WBONOSUBS       PICTURE "@z #####.##"
      @ LINE,166 SAY WINDEMNIZA      PICTURE "@z #####.##"

      @ LINE,185 SAY WSSO            PICTURE "@z #####.##"
      @ LINE,193 SAY WPRESPER        PICTURE "@z #####.##"
  *   @ LINE,202 SAY WDESCR2
  *   @ LINE,205 SAY WOD2            PICTURE "@z #####.##"

      STORE 5 TO LN
      STORE LINE + 1 TO LINE
      DO IPNFORMA

      STORE 6 TO LN
      STORE LINE + 1 TO LINE
      DO IPNFORMA

      ***********  TERCERA LINEA DE DATOS ************
      SELECT 9
      SEEK WCLASIF
      IF EOF()
         STORE "????????????????????????????" TO WCLASIFDES
      ELSE
         STORE DESCRI TO WCLASIFDES
      ENDIF
      SELECT 2
      @ LINE,5   SAY WCLASIFDES
      @ LINE,35  SAY WBASICO         PICTURE "@z #####.##"
      @ LINE,44  SAY WDIASTRABn      PICTURE "@z ##.#"
      @ LINE,48  SAY WHORASORn       PICTURE "@z ###.#"
      @ LINE,54  SAY WBSORDn         PICTURE "@z ######.##"
      @ LINE,64  SAY WSTNA+WSTNB     PICTURE "@z ##.#"
      @ LINE,69  SAY WSTNABS+WSTNBBS PICTURE "@z #####.##"
      @ LINE,78  SAY WTVNA+WTVNB     PICTURE "@z ##.#"
      @ LINE,82  SAY WTVNABS+WTVNBBS PICTURE "@z #####.##"
      @ LINE,90  SAY WDESLEGHR       PICTURE "@z ###"
      @ LINE,93  SAY WDESLEGBS       PICTURE "@z ######.##"
      @ LINE,102 SAY WREPCOM         PICTURE "@z ##.#"
      @ LINE,107 SAY WREPCOMBS       PICTURE "@z #####.##"
      @ LINE,116 SAY WBDHR+WFERPRIHR PICTURE "@z ###"
      @ LINE,120 SAY WBDBS+WFERPRIBS PICTURE "@z #####.##"
      @ LINE,129 SAY WDES3
      @ LINE,131 SAY WOCBHR3         PICTURE "@z ###"
      @ LINE,134 SAY WOCBBS3         PICTURE "@z ######.##"

      @ LINE,154 SAY WCESTA          PICTURE "@z #####.##"
      @ LINE,163 SAY WDESC3
      @ LINE,166 SAY WOCNB3          PICTURE "@z #####.##"

      @ LINE,185 SAY WSPF            PICTURE "@z #####.##"
      @ LINE,193 SAY WCAJA           PICTURE "@z #####.##"
      @ LINE,202 SAY WDESCR3
      @ LINE,205 SAY WOD3            PICTURE "@z #####.##"

      STORE 6.5 TO LN
      STORE LINE + 1 TO LINE
      DO IPNFORMA

      STORE 6 TO LN
      STORE LINE + 1 TO LINE
      DO IPNFORMA
      ****** CUARTA LIEA DE DATOS
      @ LINE,35  SAY WSALNOR         PICTURE "@z #####.##"
      @ LINE,64  SAY WSTGM+WSTGN     PICTURE "@z ##.#"
      @ LINE,69  SAY WSTGMBS+WSTGNBS PICTURE "@z #####.##"
      @ LINE,90  SAY WDC             PICTURE "@z ###"
      @ LINE,93  SAY WDCBS           PICTURE "@z ######.##"
      @ LINE,102 SAY WFERHORAS       PICTURE "@z ##.#"
      @ LINE,107 SAY WFERTOT         PICTURE "@z #####.##"
      @ LINE,116 SAY WBCHR           PICTURE "@z ###"
      @ LINE,120 SAY WBCBS           PICTURE "@z #####.##"
      @ LINE,129 SAY WDES4
      @ LINE,131 SAY WOCBHR4         PICTURE "@z ###"
      @ LINE,134 SAY WOCBBS4         PICTURE "@z ######.##"

      @ LINE,154 SAY WVIVEBS         PICTURE "@z #####.##"
      @ LINE,163 SAY WDESC4
      @ LINE,166 SAY WOCNB4          PICTURE "@z #####.##"

      @ LINE,185 SAY WAHRHAB         PICTURE "@z #####.##"
      @ LINE,202 SAY WDESCR4
      @ LINE,205 SAY WOD4            PICTURE "@z #####.##"

      ****** TOTALES
      @ LINE,144 SAY WTOTBON  PICTURE "@z ######.##"
      @ LINE,175 SAY WTOTNBON PICTURE "@z ######.##"
      @ LINE,213 SAY WTOTDEC  PICTURE "@z ######.##"
      ****** NETO A PAGAR
      @ LINE,223 SAY WNETOPAGAR PICTURE "@z ######.##"
      STORE WWTOTA+WTOTBON  TO WWTOTA
      STORE WWTOTB+WTOTNBON TO WWTOTB
      STORE WWTOTC+WTOTDEC  TO WWTOTC
      STORE WWTOTD+WNETOPAGAR TO WWTOTD
      SELECT 4
      CONTINUE
   ENDDO
   STORE 8 TO LN
   STORE LINE + 1 TO LINE
   DO IPNFORMA
   STORE LINE + 1 TO LINE
   @ LINE+1, 1 SAY "T  O  T  A  L  E  S          D  E       L  A       N  O  M  I  N  A :"
   @ LINE+1,143 SAY WWTOTA  PICTURE "@z #######.##"
   @ LINE+1,174 SAY WWTOTB  PICTURE "@z #######.##"
   @ LINE+1,212 SAY WWTOTC  PICTURE "@z #######.##"
   @ LINE+1,222 SAY WWTOTD  PICTURE "@z #######.##"
   EJECT
   SELECT 1
   REPLACE ESTADO WITH 2
   @ PROW(),0 SAY CHR(18)
   SET DEVI TO SCREE
ENDDO

