********************************************************************************
*             PROGRAMA PARA IMPRIMIR LA NOMINA  FORMATO ORDINARIO         *
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

      STORE 0 TO WWTOTBAS
      STORE 0 TO WWTOTST
      STORE 0 TO WWTOTTV
      STORE 0 TO WWTOTDES
      STORE 0 TO WWTOTCOM
      STORE 0 TO WWTOTOTB
      STORE 0 TO WWTOTBT
      STORE 0 TO WWTOTBA
      STORE 0 TO WWTOTBS
      STORE 0 TO WWTOTOTN

      STORE 0 TO WWTOTSSO
      STORE 0 TO WWTOTSPF
      STORE 0 TO WWTOTLPH
      STORE 0 TO WWTOTSIN
      STORE 0 TO WWTOTPRE
      STORE 0 TO WWTOTOTRO
      SELECT 1
      STORE SPACE(5) TO WCODNOM
      @ 5,1 CLEAR TO 12,50
      @ 5,1 TO 12,50 DOUBLE
      @ 5,15 SAY "LIQUIDACION"
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

      IF ESTADO = 1
         STORE .F. TO WFNOMINA
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
            STORE .F. TO WFNOMINA
         ENDIF
      ENDIF
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
         @ 0,0 say chr(18)
         @ 0,0 say chr(14)+qqww
         @ 2,0 say "NOMINA:"+WCODNOM+"  -  "+WDESNOM
         @ 3,0 say chr(15)
         @ 3,0 say "PERIODO  DEL:"+DTOC(NOMINA->APERT1)+" AL "+DTOC(NOMINA->APERT2)                
         @ 5,0 SAY "|CEDULA     NOMBRE                   CARGO        SALARIO D.T.   BASICO SD SM SN  BOLIVARES TD   TN   BOLIVARES DESC/FER. COMIDAS OTR.BON. B.T.A. B.SUBS OTR.PAG. TOT.ASI.  PREST. SEG.SO SEG.PF SIND. A.HAB. OTR.DEC. NETO PAGAR|"
         @ 6,0 SAY " ---------- ------------------------ ------------ ------- ------------- ------------------- ------------------- --------- ------- -------- ------ ------ -------- -------- ------- ------ ------ ----- ------ -------- ---------- "
         STORE 7 TO LINE
      ENDIF
      @ LINE,1 SAY WCEDULA
      @ LINE,12 SAY RTRIM(PERSONAL->NOMBRE)+" "+RTRIM(PERSONAL->APELLIDO)
      @ LINE,37 say PERSONAL->CARGO
      @ LINE,48 say WBASICO PICTURE "#####.##"
      @ LINE,57 SAY WDIASTRAB+(WDESNORHR/TABLA->F_HORASD) PICTURE "##.#"
      @ LINE, 62 SAY WBSORD+WDESNORBS PICTURE "######.##"
      @ LINE, 71 SAY WSTDA+WSTDB PICTURE "###"
      @ LINE, 75 SAY WSTMA+WSTMB+WSTGM PICTURE "##"
      @ LINE, 77 SAY WSTNA+WSTNB+WSTGN PICTURE "###"
      @ LINE, 83 SAY WTOTSTBS PICTURE "#####.##"
      @ LINE, 91 SAY WTVDA+WTVDB PICTURE "##"
      @ LINE, 94 SAY WTVMA+WTVMB PICTURE "##"
      @ LINE, 97 SAY WTVMA+WTVNB PICTURE "##"
      @ LINE,103 SAY WTOTTVBS PICTURE "#####.##"
      @ LINE,113 SAY WDESCONBS+WDESLEGBS+WFERTOT+WDCBS PICTURE "#####.##"
      @ LINE,122 SAY WCOMIDABS+WREPCOMBS PICTURE "####.##"
      @ LINE,130 SAY WBNGBS+WBNVBS+WAYUCIUBS+WBNBS+WBDBS+WFERPRIBS+WBCBS+PROCESO->P_OCB3+PROCESO->P_OCB4 PICTURE "#####.##"

      @ LINE,138 SAY WBONOTRAN+WBONOALIM PICTURE "####.##"
      @ LINE,145 SAY WBONOSUBS PICTURE "####.##"
      @ LINE,153 SAY WCESTA+WVIVEBS+WUTILIDAD+WINDEMNIZA+PROCESO->P_OCNB3+PROCESO->P_OCNB4 PICTURE "#####.##"
      @ LINE,161 SAY WTOTBON+WTOTNBON PICTURE "######.##"

      @ LINE,169 SAY WPRESPER   PICTURE "######.##"
      @ LINE,178 SAY WSSO       PICTURE "####.##"
      @ LINE,185 SAY WSPF       PICTURE "####.##"
      @ LINE,191 SAY WSINDIC    PICTURE "####.##"
      @ LINE,198 SAY WAHRHAB    PICTURE "####.##"
      @ LINE,206 SAY WISLR+WCAJA+PROCESO->P_OD3+PROCESO->P_OD4  PICTURE "#####.##"
      @ LINE,216 SAY WNETOPAGAR PICTURE "######.##"
      STORE WWTOTA+WTOTBON    TO WWTOTA
      STORE WWTOTB+WTOTNBON   TO WWTOTB
      STORE WWTOTC+WTOTDEC    TO WWTOTC
      STORE WWTOTD+WNETOPAGAR TO WWTOTD

      STORE WWTOTBAS  + (WBSORD+WDESNORBS)                    TO WWTOTBAS
      STORE WWTOTST   + WTOTSTBS                              TO WWTOTST
      STORE WWTOTTV   + WTOTTVBS                              TO WWTOTTV
      STORE WWTOTDES  + (WDESCONBS+WDESLEGBS+WFERTOT+WDCBS)   TO WWTOTDES
      STORE WWTOTCOM  + (WCOMIDABS+WREPCOMBS)                 TO WWTOTCOM
      STORE WWTOTOTB  + (WBNGBS+WBNVBS+WAYUCIUBS+WBNBS+;
                        WBDBS+WFERPRIBS+WBCBS+PROCESO->P_OCB3+;
                        PROCESO->P_OCB4)                      TO WWTOTTOTB

      STORE WWTOTBT   + WBONOTRAN                             TO WWTOTBT
      STORE WWTOTBA   + WBONOALIM                             TO WWTOTBA
      STORE WWTOTBS   + WBONOSUBS                             TO WWTOTBS
      STORE WWTOTOTN  + WCESTA+WVIVEBS+WUTILIDAD+WINDEMNIZA+;
                        PROCESO->P_OCNB3+PROCESO->P_OCNB4     TO WWTOTTOTN
      STORE WWTOTOTRO + WISLR+WCAJA+PROCESO->P_OD3+PROCESO->P_OD4  TO  WWTOTOTRO
      STORE WWTOTSSO  + WSSO     TO  WWTOTSSO
      STORE WWTOTSPF  + WSPF     TO  WWTOTSPF
      STORE WWTOTLPH  + WAHRHAB  TO  WWTOTLPH
      STORE WWTOTSIN  + WSINDIC  TO  WWTOTSIN
      STORE WWTOTPRE  + WPRESPER TO  WWTOTPRE

      SELECT 4
      CONTINUE
   ENDDO
   EJECT
   @ 00,00 say chr(18)
   @ 00,00 say chr(14)+qqww
   @ 02,00 say "NOMINA:"+WCODNOM+"  -  "+WDESNOM
   @ 03,00 say chr(15)
   @ 03,00 say "PERIODO  DEL:"+DTOC(NOMINA->APERT1)+" AL "+DTOC(NOMINA->APERT2)
   @ 06,00 SAY "T  O  T  A  L  E  S          D  E       L  A       N  O  M  I  N  A :"
   @ 08,00 SAY "ASIGNACIONES :"
   @ 10,00 SAY "DIAS ORD.y DES:"
   @ 10,25 SAY WWTOTBAS PICTURE "@z ##########.##"
   @ 11,00 SAY "SOBRETIEMPO   :"
   @ 11,25 SAY WWTOTST  PICTURE "@z ##########.##"
   @ 12,00 SAY "TIEMPO DE VIAJ:"
   @ 12,25 SAY WWTOTTV  PICTURE "@z ##########.##"
   @ 13,00 SAY "DESC.TRAB/FER.:"
   @ 13,25 SAY WWTOTDES PICTURE "@z ##########.##"
   @ 14,00 SAY "REPOSO/COMIDAS:"
   @ 14,25 SAY WWTOTCOM PICTURE "@z ##########.##"
   @ 15,00 SAY "OTRAS BONIFIC.:"
   @ 15,25 SAY WWTOTOTB PICTURE "@z ##########.##"
   @ 16,00 SAY "BONO TRAN/ALIM:"
   @ 16,25 SAY WWTOTBT+WWTOTBA  PICTURE "@z ##########.##"
   @ 17,00 SAY "BONO SUBSIDIO :"
   @ 17,25 SAY WWTOTBS  PICTURE "@z ##########.##"
   @ 18,00 SAY "OTROS NO BONIF:"
   @ 18,25 SAY WWTOTOTN PICTURE "@z ##########.##"
   @ 19,00 SAY "TOTAL ASIGNACIONES:"
   @ 19,25 SAY WWTOTA+WWTOTB    PICTURE "@z #######.##"
   @ 21,00 SAY "DEDUCCIONES:"
   @ 23,00 SAY "PRESTAMOS     :"
   @ 23,25 SAY WWTOTPRE         PICTURE "@z #######.##"
   @ 24,00 SAY "SEGURO SOCIAL :"
   @ 24,25 SAY WWTOTSSO         PICTURE "@z #######.##"
   @ 25,00 SAY "PPARO FORZOSO :"
   @ 25,25 SAY WWTOTSPF         PICTURE "@z #######.##"
   @ 26,00 SAY "POLITICA HAB. :"
   @ 26,25 SAY WWTOTLPH         PICTURE "@z #######.##"
   @ 27,00 SAY "SINDICATOS    :"
   @ 27,25 SAY WWTOTSIN         PICTURE "@z #######.##"
   @ 28,00 SAY "OTROS         :"
   @ 28,25 SAY WWTOTOTRO        PICTURE "@z #######.##"
   @ 29,00 SAY "TOTAL DEDUCCIONES :"
   @ 29,25 SAY WWTOTC  PICTURE "@z #######.##"
   @ 31,00 SAY "TOTAL NETO        :"
   @ 31,25 SAY WWTOTD  PICTURE "@z #######.##"
   EJECT
   SELECT 1
   REPLACE ESTADO WITH 2
   @ PROW(),0 SAY CHR(18)
   SET DEVI TO SCREE
ENDDO
RETURN
