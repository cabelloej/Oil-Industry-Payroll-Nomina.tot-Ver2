********************************************************************************
*                  PROGRAMA PARA IMPRIMIR HISTORICO POR NOMINA                 *
********************************************************************************
STORE 2 TO WFROM
store "INSTALACION NO AUTORIZADA" to warning
STORE "HISTORICO POR NOMINA" TO T2
SELECT 1 
USE IPNHISTO alias historico
select 3
use ipnomina index ipnomina alias nomina
SELECT 4
USE IPNPERSO  ALIAS PERSONAL
STORE .T. TO REPORTA
DO WHILE REPORTA
   STORE 0 TO WWTOTA
   STORE 0 TO WWTOTB
   STORE 0 TO WWTOTC
   STORE 0 TO WWTOTD
   SELECT 3
   STORE SPACE(5) TO WCODNOM
   STORE CTOD("  -  -    ") TO FEC1
   STORE CTOD("  -  -    ") TO FEC2
   SET COLOR TO W/N
   @ 5,1 CLEAR TO 12,50
   @ 5,1 TO 12,50 DOUBLE
   @ 5,25-(LEN(T2)/2) SAY T2
   STORE "Ingrese la nomina que desea imprimir" to mess
   do mensaje with mess
   SET COLOR TO W/N
   @ 7,3 say "NOMINA: " GET WCODNOM
   @ 8,3 SAY "FECHA INICIAL:"
   @ 9,3 SAY "FECHA FINAL  :"
   READ

   STORE UPPER(WCODNOM) TO WCODNOM
   IF WCODNOM=SPACE(5)
      CLOSE DATA
      CLOSE INDEX
      RETURN
   ENDIF
   LOCATE FOR CODNOM  = WCODNOM
   IF .not. found()
      STORE "Nomina no registrada " to mes
      do aviso with mes
      loop
   endif

   @ 8,3 SAY "FECHA INICIAL:" GET FEC1
   READ
   IF FEC1 = CTOD("  -  -    ")
      STORE CTOD("01-01-1980") TO FEC1
      @ 8,18 SAY "PRIMERA  "
   ENDIF

   @ 9,3 SAY "FECHA FINAL  :" GET FEC2
   READ
   IF FEC2 = CTOD("  -  -    ")
      STORE WFECACT TO FEC2
      @ 9,18 SAY "ULTIMA   "
   ENDIF

   IF FEC2 < FEC1
      STORE "ERROR, la fecha final debe ser mayor o igual a la fecha inicial" to mes
      do AVISO with mes
      loop
   endif

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
   SELECT 1
   LOCATE FOR NOMINA = WCODNOM .AND. FECHA >= FEC1 .AND. FECHA <= FEC2
   DO WHILE .NOT. EOF()
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

      SELECT 4
      LOCATE FOR CEDULA = HISTORICO->CEDULA
      IF FOUND()
         STORE PERSONAL->CEDULA TO WCEDULA
         STORE PERSONAL->NOMBRE TO WNOMBRE
         STORE PERSONAL->APELLIDO TO WAPELLIDO
         STORE PERSONAL->CARGO TO WCLASIF
      ELSE
         STORE "NO" TO WNOMBRE
         STORE "REGISTRADO" TO WAPELLIDO
         STORE "DESCONOCIDA" TO WCLASIF
      ENDIF
      SELECT 1

      STORE basico TO WBASICO
      store nomina to wnomina
      store fecha to wfecha

      store hrordD      to whorasorD
      store hrordM      to whorasorM
      store hrordN      to whorasorN
      store bsordD      to wbsordD
      store bsordM      to wbsordM
      store bsordN      to wbsordN
      store hrstDA      to wstDAhr
      store hrstDB      to wstDBhr
      store hrstMA      to wstMAhr
      store hrstMB      to wstMBhr
      store hrstNA      to wstNAhr
      store hrstNB      to wstNBhr
      store hrstGM      to wstGMhr
      store hrstGN      to wstGNhr
      store BSSTDA      to wSTDAbs
      store BSSTDB      to wSTDBbs
      store BSSTMA      to wSTMAbs
      store BSSTMB      to wSTMBbs
      store BSSTNA      to wSTNAbs
      store BSSTNB      to wSTNBbs
      store BSSTGM      to wSTGMBS
      store BSSTGN      to wSTGNBS

      store hrtvDA      to wtvDAhr
      store hrtvDB      to wtvDBhr
      store hrtvMA      to wtvMAhr
      store hrtvMB      to wtvMBhr
      store hrtvNA      to wtvNAhr
      store hrtvNB      to wtvNBhr
      store BSTVDA      to WTVDABS
      store BSTVDB      to WTVDBBS
      store BSTVMA      to WTVMABS
      store BSTVMB      to WTVMBBS
      store BSTVNA      to WTVNABS
      store BSTVNB      to WTVNBBS
      store hrdesnor    to wdesnorhr
      store bsdesnor    to wdesnorbs
      store hrdescon    to wdesconhr
      store bsdescon    to wdesconbs
      store hrdesleg    to wdesleghr
      store bsdesleg    to wdeslegbs
      store hrdesCOm    to wdesCOmhr
      store bsdesCOm    to wdesCOmbs
      store hrayuciu    to wayuciuhr
      store bsayuciu    to wayuciubs
      store hrcomida    to wcomida
      store bscomida    to wcomidabs
      STORE HRREPCOM    TO WREPCOMHR
      STORE BSREPCOM    TO WREPCOMBS
      STORE HRFERIADO   TO WFERIADOHR
      STORE BSFERIADO   TO WFERIADOBS
      store hrbn        to wbn
      store bsbn        to wbnbs
      store hrbnG       to wbnG
      store bsbnG       to wbnGbs
      store hrbnv       to wbnv
      store bsbnv       to wbnvbs
      store hrbd        to wbdhr
      store bsbd        to wbdbs
      STORE HRFERPRI    TO WFERPRIHR
      STORE BSFERPRI    TO WFERPRIBS
      STORE HRBONOCOM   TO WBONOCOMHR
      STORE BSBONOCOM   TO WBONOCOMBS
      store desocb1     to wdes3
      store hrocb1      to wocbhr3
      store bsocb1      to wocbbs3
      store desocb2     to wdes4
      store hrocb2      to wocbhr4
      store bsocb2      to wocbbs4
      store bstotbon    to wtotbon

      store bsbonotran  to wbonotran
      store bsbonoalim  to wbonoalim
      store bscesta     to wcesta
      store bsvive      to wvive
      store bsutilidad  to wutilidad
      store bsindemniz  to windemniza
      store desocnb1    to wdesc3
      store bsocnb1     to wocnb3
      store desocnb2    to wdesc4
      store bsocnb2     to wocnb4
      store bstotnbon   to wtotnbon

      store bsislr     to wislr
      store bssso      to wsso
      store bsspf      to wspf
      store bsahrhab   to wahrhab
      store bssindic   to wsindic
      store bspresper  to wpresper
      store bscaja     to wcajabs
      store desod1     to wdescr3
      store bsod1      to wod3
      store desod2     to wdescr4
      store bsod2      to wod4
      store bstotdec   to wtotdec

      store wtotbon+wtotnbon-wtotdec to wnetopagar

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
      @ LINE,44 SAY Whorasord/8      PICTURE "@z ##.#"
      @ LINE,48 SAY WHORASORd        PICTURE "@z ###.#"
      @ LINE, 54 SAY WBSORDd         PICTURE "@z ######.##"
      @ LINE, 64 SAY WSTDAHR+WSTDBhr  PICTURE "@z ##.#"
      @ LINE, 69 SAY WSTDABS+WSTDBBS PICTURE "@z #####.##"
      @ LINE, 78 SAY WTVDAhr+WTVDBhr PICTURE "@z ##.#"
      @ LINE, 82 SAY WTVDABS+WTVDBBS PICTURE "@z #####.##"
      @ LINE,90 SAY WDESNORHR  PICTURE "@z ###"
      @ LINE,93 SAY WDESNORBS  PICTURE "@z ######.##"
      @ LINE,103 SAY WAYUCIUHR PICTURE "@z ###"
      @ LINE,107 SAY WAYUCIUBS PICTURE "@z #####.##"
      @ LINE,116 SAY WBN+WBNG      PICTURE "@z ###"
      @ LINE,120 SAY WBNBS+WBNGBS     PICTURE "@z #####.##"
 *    @ LINE,129 SAY WDES1
 *    @ LINE,131 SAY WOCBHR1 PICTURE "@z ###"
 *    @ LINE,134 SAY WOCBBS1 PICTURE "@z ######.##"

      @ LINE,154 SAY WBONOTRAN PICTURE "@z #####.##"
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
      @ LINE,44  SAY Whorasorm/7.5   PICTURE "@z ##.#"
      @ LINE,48  SAY WHORASORm       PICTURE "@z ###.#"
      @ LINE,54  SAY WBSORDm         PICTURE "@z ######.##"
      @ LINE,64  SAY WSTMAhr+WSTMBhr PICTURE "@z ##.#"
      @ LINE,69  SAY WSTMABS+WSTMBBS PICTURE "@z #####.##"
      @ LINE,78  SAY WTVMAhr+WTVMBhr PICTURE "@z ##.#"
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

      @ LINE,154 SAY WBONOALIM       PICTURE "@z #####.##"
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
      use ipncargo index ipncargo
      FIND &WCLASIF
      IF EOF()
         STORE "????????????????????????????" TO WCLASIFDES
      ELSE
         STORE DESCRI TO WCLASIFDES
      ENDIF
      SELECT 2
      @ LINE,5   SAY WCLASIFDES
      @ LINE,35  SAY WBASICO         PICTURE "@z #####.##"
      @ LINE,44  SAY Whorasorn/7     PICTURE "@z ##.#"
      @ LINE,48  SAY WHORASORn       PICTURE "@z ###.#"
      @ LINE,54  SAY WBSORDn         PICTURE "@z ######.##"
      @ LINE,64  SAY WSTNAhr+WSTNBhr PICTURE "@z ##.#"
      @ LINE,69  SAY WSTNABS+WSTNBBS PICTURE "@z #####.##"
      @ LINE,78  SAY WTVNAhr+WTVNBhr PICTURE "@z ##.#"
      @ LINE,82  SAY WTVNABS+WTVNBBS PICTURE "@z #####.##"
      @ LINE,90  SAY WDESLEGHR       PICTURE "@z ###"
      @ LINE,93  SAY WDESLEGBS       PICTURE "@z ######.##"
      @ LINE,102 SAY WREPCOMhr       PICTURE "@z ##.#"
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
      @ LINE,193 SAY WCAJAbs         PICTURE "@z #####.##"
      @ LINE,202 SAY WDESCR3
      @ LINE,205 SAY WOD3            PICTURE "@z #####.##"

      STORE 6.5 TO LN
      STORE LINE + 1 TO LINE
      DO IPNFORMA

      STORE 6 TO LN
      STORE LINE + 1 TO LINE
      DO IPNFORMA
      ****** CUARTA LIEA DE DATOS
      @ LINE,64  SAY WSTGMhr+WSTGNhr PICTURE "@z ##.#"
      @ LINE,69  SAY WSTGMBS+WSTGNBS PICTURE "@z #####.##"
      @ LINE,90  SAY WDescomhr       PICTURE "@z ###"
      @ LINE,93  SAY WDescombs       PICTURE "@z ######.##"
      @ LINE,102 SAY WFERIADOHR      PICTURE "@z ##.#"
      @ LINE,107 SAY WFERIADOBS      PICTURE "@z #####.##"
      @ LINE,116 SAY WBONOCOMHR      PICTURE "@z ###"
      @ LINE,120 SAY WBONOCOMBS      PICTURE "@z #####.##"
      @ LINE,129 SAY WDES4
      @ LINE,131 SAY WOCBHR4         PICTURE "@z ###"
      @ LINE,134 SAY WOCBBS4         PICTURE "@z ######.##"

      @ LINE,154 SAY WVIVE           PICTURE "@z #####.##"
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
      SELECT 1
      CONTINUE
   ENDDO

   STORE 8 TO LN
   STORE LINE + 1 TO LINE
   DO FORMA3 WITH  LN
   STORE LINE + 1 TO LINE
   @ LINE+1, 1 SAY "T  O  T  A  L  E  S          D  E       L  A       N  O  M  I  N  A :"
   @ LINE+1,143 SAY WWTOTA  PICTURE "@Z #######.##"
   @ LINE+1,174 SAY WWTOTB  PICTURE "@Z #######.##"
   @ LINE+1,212 SAY WWTOTC  PICTURE "@Z #######.##"
   @ LINE+1,222 SAY WWTOTD  PICTURE "@Z #######.##"
   EJECT
   @ PROW(),0 SAY CHR(18)
   SET DEVI TO SCREE
ENDDO

