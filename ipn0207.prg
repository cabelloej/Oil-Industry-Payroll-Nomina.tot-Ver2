****************************************************************************
*                  RESUMEN CONCEPTUAL                                     *
***************************************************************************
store "INSTALACION NO AUTORIZADA" to warning
STORE "RESUMEN CONCEPTUAL" TO T2
SELECT 1 
USE IPNOMINA INDEX IPNOMINA ALIAS NOMINA
SELECT 2
USE IPNPROCO INDEX IPNPROCO ALIAS PROCESO
SELECT 4
USE IPNPERSO  ALIAS PERSONAL
STORE .T. TO REPORTA
DO WHILE REPORTA
   STORE .T. TO ZNOMINA
   DO WHILE ZNOMINA
      *** BONIFICABLES
      STORE 0 TO WXHRORD     
      STORE 0 TO WXBSORD     
      STORE 0 TO WXHRST      
      STORE 0 TO WXBSST      
      STORE 0 TO WXHRTV      
      STORE 0 TO WXBSTV      
      STORE 0 TO WXHRDESNOR  
      STORE 0 TO WXBSDESNOR  
      STORE 0 TO WXHRDESCON  
      STORE 0 TO WXBSDESCON  
      STORE 0 TO WXHRDESLEG  
      STORE 0 TO WXBSDESLEG  
      STORE 0 TO WXHRDESCOM  
      STORE 0 TO WXBSDESCOM  
      STORE 0 TO WXHRAYUCIU  
      STORE 0 TO WXBSAYUCIU  
      STORE 0 TO WXHRCOMIDA  
      STORE 0 TO WXBSCOMIDA  
      STORE 0 TO WXHRREPCOM  
      STORE 0 TO WXBSREPCOM  
      STORE 0 TO WXHRFERIADO 
      STORE 0 TO WXBSFERIADO 
      STORE 0 TO WXHRBN      
      STORE 0 TO WXBSBN      
      STORE 0 TO WXHRBNG     
      STORE 0 TO WXBSBNG     
      STORE 0 TO WXHRBNV     
      STORE 0 TO WXBSBNV     
      STORE 0 TO WXHRBD      
      STORE 0 TO WXBSBD      
      STORE 0 TO WXHRFERPRI  
      STORE 0 TO WXBSFERPRI  
      STORE 0 TO WXHRBONOCOM 
      STORE 0 TO WXBSBONOCOM 
      STORE 0 TO WXHROCB1    
      STORE 0 TO WXBSOCB1    
      STORE 0 TO WXDESOCB2   
      STORE 0 TO WXHROCB2    
      STORE 0 TO WXBSOCB2    
      STORE 0 TO WXBSTOTBON  
      *** NO BONIFICABLES
      STORE 0 TO WXBSBONOTRAN 
      STORE 0 TO WXBSBONOALIM 
      STORE 0 TO WXBSBONOSUBS 
      STORE 0 TO WXBSCESTA    
      STORE 0 TO WXBSVIVE     
      STORE 0 TO WXbsutilidad 
      STORE 0 TO WXbsindemniz 
      STORE 0 TO WXBSOCNB1    
      STORE 0 TO WXBSOCNB2    
      STORE 0 TO WXBSTOTNBON  
      *** DEDUCCIONES
      STORE 0 TO WXBSISLR     
      STORE 0 TO WXBSSSO      
      STORE 0 TO WXBSSPF      
      STORE 0 TO WXBSAHRHAB   
      STORE 0 TO WXBScaja     
      STORE 0 TO WXBSSINDIC   
      STORE 0 TO WXBSPRESPER  
      STORE 0 TO WXBSOD1      
      STORE 0 TO WXBSOD2      
      STORE 0 TO WXBSTOTDEC   
      *** OTROS TOTALES
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
      STORE "CODIGO DE NOMINA" to mess
      do mensaje with mess
      @ 07,3 say "NOMINA    : "
      @ 09,3 SAY "DECRIPCION: "
      @ 11,3 SAY "SALIDA    : "
      @ 07,15 GET WCODNOM
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
      @ 9,15 SAY DESNOM
      SAVE SCRE TO WSCREIMP
      STORE "OPCIONES: (M)ONITOR, (I)MPRESORA" to mess
      store "M" TO P1
      STORE "I" TO P2
      STORE " " TO RESP
      DO PIDE2 WITH P1, P2, MESS, RESP
      STORE RESP TO WSALIDA
      IF WSALIDA="M"
         @ 11,15 SAY "MONITOR"
      ELSE
        @ 11,15 SAY "IMPRESORA"
      ENDIF
      STORE "OPCIONES: (C)ONTINUAR, (R)ECHAZAR" to mes
      store "C" to p1
      store "R" to p2
      STORE " " TO RESP
      DO PIDE2 WITH P1,P2,MES,RESP
      IF RESP = "R"
         LOOP
      ENDIF

      IF ESTADO = 0
         STORE "ERROR, esta nomina ya esta cerrada " to mes
         do aviso with mes
         loop
      else
         exit
      endif
   ENDDO
   STORE SPACE(35) TO QQWW
   DO INFORMA WITH QQWW
   IF QQWW <> t3
      STORE 1 TO POSI
      else
      STORE 0 TO POSI
   ENDIF
   STORE FACTCOD TO WFACTOR
   SELECT 3
   USE IPNFACTOR INDEX IPNFACTOR ALIAS TABLA
   FIND &WFACTOR
   IF EOF()
      STORE "ERROR, TABLA DE FACTORES DE ESTA NOMINA NO ESTA REGISTRADA" TO MES
      DO AVISO WITH MESS
      LOOP
   ENDIF

   STORE "RESUMIENDO NOMINA, FAVOR ESPERAR ..." to mes
   do mensaje with mes
   STORE 0 TO GENTE
   STORE 0 TO VEZ
   SELECT 4
   LOCATE FOR NOMINA = WCODNOM
   DO WHILE .NOT. EOF()
      STORE MP TO WMP
      STORE CP TO WCP
      STORE CEDULA TO WCEDULA
      SELECT 2
      FIND &WCEDULA
      IF EOF()
         STORE "ADVERTENCIA:"+RTRIM(personal->nombre)+" "+RTRIM(personal->apellido)+" sin reg. de corte." to mes
         SET DEVI TO SCREE
         @ 23,1 SAY SPACE(78)
         @ 23,40-(LEN(MES)/2) SAY MES
         select 4
         continue
         LOOP
      endif

      STORE VEZ + 1 TO VEZ
      STORE GENTE + 1 TO GENTE
      select 2
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
      *** ACUMULA
      STORE WXHRORD      + WHORASOR     TO WXHRORD
      STORE WXBSORD      + WBSORD       TO WXBSORD
      STORE WXHRST       + WTOTSTHR     TO WXHRST
      STORE WXBSST       + WTOTSTBS     TO WXBSST
      STORE WXHRTV       + WTOTTVHR     TO WXHRTV
      STORE WXBSTV       + WTOTTVBS     TO WXBSTV
      STORE WXHRDESNOR   + WDESNORHR    TO WXHRDESNOR
      STORE WXBSDESNOR   + WDESNORBS    TO WXBSDESNOR
      STORE WXHRDESCON   + WDESCONHR    TO WXHRDESCON
      STORE WXBSDESCON   + WDESCONBS    TO WXBSDESCON
      STORE WXHRDESLEG   + WDESLEGHR    TO WXHRDESLEG
      STORE WXBSDESLEG   + WDESLEGBS    TO WXBSDESLEG
      STORE WXHRDESCOM   + WDC          TO WXHRDESCOM
      STORE WXBSDESCOM   + WDCBS        TO WXBSDESCOM
      STORE WXHRAYUCIU   + WAYUCIUHR    TO WXHRAYUCIU
      STORE WXBSAYUCIU   + WAYUCIUBS    TO WXBSAYUCIU
      STORE WXHRCOMIDA   + WCOMIDA      TO WXHRCOMIDA
      STORE WXBSCOMIDA   + WCOMIDABS    TO WXBSCOMIDA
      STORE WXHRREPCOM   + WREPCOM      TO WXHRREPCOM
      STORE WXBSREPCOM   + WREPCOMBS    TO WXBSREPCOM
      STORE WXHRFERIADO  + WFERHORAS    TO WXHRFERIADO
      STORE WXBSFERIADO  + WFERTOT      TO WXBSFERIADO
      STORE WXHRBN       + WBN          TO WXHRBN
      STORE WXBSBN       + WBNBS        TO WXBSBN
      STORE WXHRBNG      + WBNGHR       TO WXHRBNG
      STORE WXBSBNG      + WBNGBS       TO WXBSBNG
      STORE WXHRBNV      + WBNV         TO WXHRBNV
      STORE WXBSBNV      + WBNVBS       TO WXBSBNV
      STORE WXHRBD       + WBDHR        TO WXHRBD
      STORE WXBSBD       + WBDBS        TO WXBSBD
      STORE WXHRFERPRI   + WFERPRIHR    TO WXHRFERPRI
      STORE WXBSFERPRI   + WFERPRIBS    TO WXBSFERPRI
      STORE WXHRBONOCOM  + WBCHR        TO WXHRBONOCOM
      STORE WXBSBONOCOM  + WBCBS        TO WXBSBONOCOM
      STORE WXHROCB1     + WOCBHR3      TO WXHROCB1
      STORE WXBSOCB1     + WOCBBS3      TO WXBSOCB1
      STORE WXHROCB2     + WOCBHR4      TO WXHROCB2
      STORE WXBSOCB2     + WOCBBS4      TO WXBSOCB2
      STORE WXBSTOTBON   + WTOTBON      TO WXBSTOTBON
      ***                               
      STORE WXBSBONOTRAN + WBONOTRAN    TO WXBSBONOTRAN
      STORE WXBSBONOALIM + WBONOALIM    TO WXBSBONOALIM
      STORE WXBSBONOSUBS + WBONOSUBS    TO WXBSBONOSUBS
      STORE WXBSCESTA    + WCESTA       TO WXBSCESTA
      STORE WXBSVIVE     + WVIVEBS      TO WXBSVIVE
      STORE WXbsutilidad + wutilidad    TO WXBSUTILIDAD
      STORE WXbsindemniz + windemniza   TO WXBSINDEMNIZ
      STORE WXBSOCNB1    + WOCNB3       TO WXBSOCNB1
      STORE WXBSOCNB2    + WOCNB4       TO WXBSOCNB2
      STORE WXBSTOTNBON  + WTOTNBON     TO WXBSTOTNBON
      ***                                  
      STORE WXBSISLR     + WISLR        TO WXBSISLR
      STORE WXBSSSO      + WSSO         TO WXBSSSO
      STORE WXBSSPF      + WSPF         TO WXBSSPF
      STORE WXBSAHRHAB   + WAHRHAB      TO WXBSAHRHAB
      STORE WXBScaja     + Wcaja        TO WXBSCAJA
      STORE WXBSSINDIC   + WSINDIC      TO WXBSSINDIC
      STORE WXBSPRESPER  + WPRESPER     TO WXBSPRESPER
      STORE WXBSOD1      + WOD3         TO WXBSOD1
      STORE WXBSOD2      + WOD4         TO WXBSOD2
      STORE WXBSTOTDEC   + WTOTDEC      TO WXBSTOTDEC
      SELECT 4
      CONTINUE
   ENDDO
   *** MUESTRA RESUMEN
   IF WSALIDA = "M"
      STORE 20  TO WSALTO
      SET DEVI  TO SCRE
   ELSE
      STORE 55  TO WSALTO
      SET DEVI  TO PRINT
   ENDIF
   STORE 100 TO WLINE
   STORE 0   TO WPAGE
   IF WXBSORD> 0
      STORE WLINE+1 TO WLINE
      IF WLINE>=WSALTO
         DO HEADER
      ENDIF
      @ WLINE,00 SAY "BO"
      @ WLINE,03 SAY "TIEMPO ORDINARIO TRABAJADO  "
      @ WLINE,33 SAY WXHRORD       picture "####.##"
      @ WLINE,47 SAY WXBSORD       picture "#########.##"
   ENDIF
   IF WXBSST > 0
      STORE WLINE+1 TO WLINE
      IF WLINE>=WSALTO
         DO HEADER
      ENDIF
      @ WLINE,00 SAY "BO"
      @ WLINE,03 SAY "SOBRE TIEMPO            "
      @ WLINE,34 SAY WXHRST        picture "###.##"
      @ WLINE,48 SAY WXBSST        picture "#######.##"
   ENDIF
   IF WXBSTV > 0
      STORE WLINE+1 TO WLINE
      IF WLINE>=WSALTO
         DO HEADER
      ENDIF
      @ WLINE,00 SAY "BO"
      @ WLINE,03 SAY "TIEMPO DE VIAJE   "
      @ WLINE,34 SAY WXHRTV        picture "###.##"
      @ WLINE,48 SAY WXBSTV        picture "#######.##"
   ENDIF
   IF WXBSDESNOR > 0
      STORE WLINE+1 TO WLINE
      IF WLINE>=WSALTO
         DO HEADER
      ENDIF
      @ WLINE,00 SAY "BO"
      @ WLINE,03 SAY "DESCANSO NORMAL         "
      @ WLINE,34 SAY WXHRDESNOR    picture "###.##"
      @ WLINE,48 SAY WXBSDESNOR    picture "#######.##"
   ENDIF
   IF WXBSDESCON > 0
      STORE WLINE+1 TO WLINE
      IF WLINE>=WSALTO
         DO HEADER
      ENDIF
      @ WLINE,00 SAY "BO"
      @ WLINE,03 SAY "DESCANSO CONTRACTUAL TRABAJADO"
      @ WLINE,34 SAY WXHRDESCON    picture "###.##"
      @ WLINE,48 SAY WXBSDESCON    picture "#######.##"
   ENDIF
   IF WXBSDESLEG > 0
      STORE WLINE+1 TO WLINE
      IF WLINE>=WSALTO
         DO HEADER
      ENDIF
      @ WLINE,00 SAY "BO"
      @ WLINE,03 SAY "DESCANSO LEGAL TRABAJADO"
      @ WLINE,34 SAY WXHRDESLEG    picture "###.##"
      @ WLINE,48 SAY WXBSDESLEG    picture "#######.##"
   ENDIF
   IF WXBSDESCOM > 0
      STORE WLINE+1 TO WLINE
      IF WLINE>=WSALTO
         DO HEADER
      ENDIF
      @ WLINE,00 SAY "BO"
      @ WLINE,03 SAY "DESCANSO COMPENSATORIO"
      @ WLINE,34 SAY WXHRDESCOM    picture "###.##"
      @ WLINE,48 SAY WXBSDESCOM    picture "#######.##"
   ENDIF
   IF WXBSAYUCIU > 0
      STORE WLINE+1 TO WLINE
      IF WLINE>=WSALTO
         DO HEADER
      ENDIF
      @ WLINE,00 SAY "BO"
      @ WLINE,03 SAY "AYUDA DE CIUDAD"
      @ WLINE,34 SAY WXHRAYUCIU    picture "###.##"
      @ WLINE,48 SAY WXBSAYUCIU    picture "#######.##"
   ENDIF
   IF WXBSCOMIDA > 0
      STORE WLINE+1 TO WLINE
      IF WLINE>=WSALTO
         DO HEADER
      ENDIF
      @ WLINE,00 SAY "BO"
      @ WLINE,03 SAY "COMIDAS"
      @ WLINE,34 SAY WXHRCOMIDA    picture "###.##"
      @ WLINE,48 SAY WXBSCOMIDA    picture "#######.##"
   ENDIF
   IF WXBSREPCOM > 0
      STORE WLINE+1 TO WLINE
      IF WLINE>=WSALTO
         DO HEADER
      ENDIF
      @ WLINE,00 SAY "BO"
      @ WLINE,03 SAY "REPOSO/COMIDA"
      @ WLINE,34 SAY WXHRREPCOM    picture "###.##"
      @ WLINE,48 SAY WXBSREPCOM    picture "#######.##"
   ENDIF
   IF WXBSFERIADO> 0
      STORE WLINE+1 TO WLINE
      IF WLINE>=WSALTO
         DO HEADER
      ENDIF
      @ WLINE,00 SAY "BO"
      @ WLINE,03 SAY "FERIADOS"
      @ WLINE,34 SAY WXHRFERIADO   picture "###.##"
      @ WLINE,48 SAY WXBSFERIADO   picture "#######.##"
   ENDIF
   IF WXBSBN     > 0
      STORE WLINE+1 TO WLINE
      IF WLINE>=WSALTO
         DO HEADER
      ENDIF
      @ WLINE,00 SAY "BO"
      @ WLINE,03 SAY "BONO NOCTURNO X TRABAJO"
      @ WLINE,34 SAY WXHRBN        picture "###.##"
      @ WLINE,48 SAY WXBSBN        picture "#######.##"
   ENDIF
   IF WXBSBNG    > 0
      STORE WLINE+1 TO WLINE
      IF WLINE>=WSALTO
         DO HEADER
      ENDIF
      @ WLINE,00 SAY "BO"
      @ WLINE,03 SAY "BONO NOCTURNO X GUARDIA"
      @ WLINE,34 SAY WXHRBNG       picture "###.##"
      @ WLINE,48 SAY WXBSBNG       picture "#######.##"
   ENDIF
   IF WXBSBNV    > 0
      STORE WLINE+1 TO WLINE
      IF WLINE>=WSALTO
         DO HEADER
      ENDIF
      @ WLINE,00 SAY "BO"
      @ WLINE,03 SAY "BONO NOCTURNO X VIAJE"
      @ WLINE,34 SAY WXHRBNV       picture "###.##"
      @ WLINE,48 SAY WXBSBNV       picture "#######.##"
   ENDIF
   IF WXBSBD     > 0
      STORE WLINE+1 TO WLINE
      IF WLINE>=WSALTO
         DO HEADER
      ENDIF
      @ WLINE,00 SAY "BO"
      @ WLINE,03 SAY "BONO DOMINICAL"
      @ WLINE,34 SAY WXHRBD        picture "###.##"
      @ WLINE,48 SAY WXBSBD        picture "#######.##"
   ENDIF
   IF WXBSFERPRI > 0
      STORE WLINE+1 TO WLINE
      IF WLINE>=WSALTO
         DO HEADER
      ENDIF
      @ WLINE,00 SAY "BO"
      @ WLINE,03 SAY "PRIMA FERIADO TRABAJADO"
      @ WLINE,34 SAY WXHRFERPRI    picture "###.##"
      @ WLINE,48 SAY WXBSFERPRI    picture "#######.##"
   ENDIF
   IF WXBSOCB1+WXBSOCB2 > 0
      STORE WLINE+1 TO WLINE
      IF WLINE>=WSALTO
         DO HEADER
      ENDIF
      @ WLINE,00 SAY "BO"
      @ WLINE,03 SAY "OTROS CONCEPTOS BONIFICABLES"
      @ WLINE,34 SAY WXHROCB1+WXHROCB1  picture "###.##"
      @ WLINE,48 SAY WXBSOCB1+WXBSOCB2  picture "#######.##"
   ENDIF
   IF WXBSBONOTRAN   > 0
      STORE WLINE+1 TO WLINE
      IF WLINE>=WSALTO
         DO HEADER
      ENDIF
      @ WLINE,00 SAY "NB"
      @ WLINE,03 SAY "BONO DE TRANSPORTE"
      @ WLINE,48 SAY WXBSBONOTRAN  picture "#######.##"
   ENDIF
   IF WXBSBONOALIM   > 0
      STORE WLINE+1 TO WLINE
      IF WLINE>=WSALTO
         DO HEADER
      ENDIF
      @ WLINE,00 SAY "NB"
      @ WLINE,03 SAY "BONO ALIMENTICIO"
      @ WLINE,48 SAY WXBSBONOALIM  picture "#######.##"
   ENDIF
   IF WXBSBONOSUBS   > 0
      STORE WLINE+1 TO WLINE
      IF WLINE>=WSALTO
         DO HEADER
      ENDIF
      @ WLINE,00 SAY "NB"
      @ WLINE,03 SAY "BONO SUBSIDIO"
      @ WLINE,48 SAY WXBSBONOSUBS  picture "#######.##"
   ENDIF
   IF WXBSCESTA      > 0
      STORE WLINE+1 TO WLINE
      IF WLINE>=WSALTO
         DO HEADER
      ENDIF
      @ WLINE,00 SAY "NB"
      @ WLINE,03 SAY "CESTA BASICA"
      @ WLINE,48 SAY WXBSCESTA     picture "#######.##"
   ENDIF
   IF WXBSVIVE       > 0
      STORE WLINE+1 TO WLINE
      IF WLINE>=WSALTO
         DO HEADER
      ENDIF
      @ WLINE,00 SAY "NB"
      @ WLINE,03 SAY "VIVIENDA"
      @ WLINE,48 SAY WXBSVIVE      picture "#######.##"
   ENDIF
   IF WXBSUTILIDAD   > 0
      STORE WLINE+1 TO WLINE
      IF WLINE>=WSALTO
         DO HEADER
      ENDIF
      @ WLINE,00 SAY "NB"
      @ WLINE,03 SAY "UTILIDAD FRACCIONADA"
      @ WLINE,48 SAY WXBSUTILIDAD  picture "#######.##"
   ENDIF
   IF WXBSINDEMNIZ   > 0
      STORE WLINE+1 TO WLINE
      IF WLINE>=WSALTO
         DO HEADER
      ENDIF
      @ WLINE,00 SAY "NB"
      @ WLINE,03 SAY "INDEMNIZACION MINIMA"
      @ WLINE,48 SAY WXBSINDEMNIZ  picture "#######.##"
   ENDIF
   IF WXBSOCNB1+WXBSOCNB2 > 0
      STORE WLINE+1 TO WLINE
      IF WLINE>=WSALTO
         DO HEADER
      ENDIF
      @ WLINE,00 SAY "NB"
      @ WLINE,03 SAY "OTROS CONCEPTOS NO BONIFICABLES"
      @ WLINE,48 SAY WXBSOCNB1+WXBSOCNB2  picture "######.##"
   ENDIF
   IF WXBSISLR   > 0
      STORE WLINE+1 TO WLINE
      IF WLINE>=WSALTO
         DO HEADER
      ENDIF
      @ WLINE,00 SAY "DE"
      @ WLINE,03 SAY "IMPUESTO SOBRE LA RENTA"
      @ WLINE,62 SAY WXBSISLR       picture "#######.##"
   ENDIF
   IF WXBSSSO    > 0
      STORE WLINE+1 TO WLINE
      IF WLINE>=WSALTO
         DO HEADER
      ENDIF
      @ WLINE,00 SAY "DE"
      @ WLINE,03 SAY "SEGURO SOCIAL OBLIGATORIO"
      @ WLINE,62 SAY WXBSSSO        picture "#######.##"
   ENDIF
   IF WXBSSPF    > 0
      STORE WLINE+1 TO WLINE
      IF WLINE>=WSALTO
         DO HEADER
      ENDIF
      @ WLINE,00 SAY "DE"
      @ WLINE,03 SAY "SEGURO DE PARO FORZOSO"
      @ WLINE,62 SAY WXBSSPF        picture "#######.##"
   ENDIF
   IF WXBSAHRHAB > 0
      STORE WLINE+1 TO WLINE
      IF WLINE>=WSALTO
         DO HEADER
      ENDIF
      @ WLINE,00 SAY "DE"
      @ WLINE,03 SAY "LEY DE POLITICA HABITACIONAL"
      @ WLINE,62 SAY WXBSAHRHAB     picture "#######.##"
   ENDIF
   IF WXBSCAJA   > 0
      STORE WLINE+1 TO WLINE
      IF WLINE>=WSALTO
         DO HEADER
      ENDIF
      @ WLINE,00 SAY "DE"
      @ WLINE,03 SAY "CAJA DE AHORROS"
      @ WLINE,62 SAY WXBSCAJA       picture "#######.##"
   ENDIF
   IF WXBSSINDIC > 0
      STORE WLINE+1 TO WLINE
      IF WLINE>=WSALTO
         DO HEADER
      ENDIF
      @ WLINE,00 SAY "DE"
      @ WLINE,03 SAY "CUOTA SINDICAL"
      @ WLINE,62 SAY WXBSSINDIC     picture "#######.##"
   ENDIF
   IF WXBSPRESPER> 0
      STORE WLINE+1 TO WLINE
      IF WLINE>=WSALTO
         DO HEADER
      ENDIF
      @ WLINE,00 SAY "DE"
      @ WLINE,03 SAY "PRESTAMOS PERSONALES"
      @ WLINE,62 SAY WXBSPRESPER    picture "#######.##"
   ENDIF
   IF WXBSOD1+WXBSOD2 > 0
      STORE WLINE+1 TO WLINE
      IF WLINE>=WSALTO
         DO HEADER
      ENDIF
      @ WLINE,00 SAY "DE"
      @ WLINE,03 SAY "OTRAS DEDUCCIONES"
      @ WLINE,62 SAY WXBSOD1+WXBSOD2 picture "#######.##"
   ENDIF

   STORE WLINE+1 TO WLINE
   IF WLINE>WSALTO
      DO HEADER
   ENDIF
   *
   @ WLINE,0 SAY REPLICATE("-",80)
   STORE WLINE+1 TO WLINE
   IF WLINE>=WSALTO
      DO HEADER
   ENDIF
   @ WLINE,03 SAY "TOTAL BONIFICABLE"
   @ WLINE,26 SAY WXBSTOTBON             picture "###,###,###.##"
   *
   STORE WLINE+1 TO WLINE
   IF WLINE>=WSALTO
      DO HEADER
   ENDIF
   @ WLINE,03 SAY "TOTAL NO BONIFICABLE"
   @ WLINE,26 SAY WXBSTOTNBON            picture "###,###,###.##"
   *
   STORE WLINE+1 TO WLINE
   IF WLINE>=WSALTO
      DO HEADER
   ENDIF
   @ WLINE,03 SAY "TOTAL ASIGNACIONES"
   @ WLINE,43 SAY WXBSTOTBON+WXBSTOTNBON picture "###,###,###.##"
   *
   STORE WLINE+1 TO WLINE
   IF WLINE>=WSALTO
      DO HEADER
   ENDIF
   @ WLINE,03 SAY "TOTAL DEDUCCIONES"
   @ WLINE,57 SAY WXBSTOTDEC      picture "###,###,###.##"
   STORE WLINE+1 TO WLINE
   IF WLINE>=WSALTO
      DO HEADER
   ENDIF
   @ WLINE,03 SAY "SALDO GENERAL"
   @ WLINE,26 SAY (WXBSTOTBON+WXBSTOTNBON)-WXBSTOTDEC  picture "###,###,###.##"
   
   IF WSALIDA="M"
      STORE "OPRIMA <ENTER> PARA FINALIZAR" TO MES
      DO AVISO WITH MES
   ELSE
      IF WSALIDA = "I"
         EJECT
      ENDIF
   ENDIF
   SET DEVI TO SCRE
   REST SCRE FROM WSCREIMP
   ***
   SELECT 1
   REPLACE ESTADO WITH 4
   SET DEVI TO SCREE
ENDDO
************
PROC HEADER
************
STORE WPAGE+1 TO WPAGE
IF WSALIDA="M"
   IF WPAGE>1
      STORE "OPRIMA <ENTER> PARA CONTINUAR" TO MES
      DO AVISO WITH MES
   ENDIF
   @ 0,0 CLEAR
ENDIF
@ 00,00 SAY QQWW
@ 00,60 SAY "FECHA  : "+DTOC(DATE())
@ 01,00 SAY "SISTEMA DE NOMINA"
@ 01,60 SAY "PAGINA : "+STR(WPAGE,2)
@ 02,00 SAY "RESUMEN CONCEPTUAL DE NOMINA"
@ 04,00 SAY "NOMINA: "+ALLTRIM(NOMINA.DESNOM)+" DEL: "+DTOC(NOMINA.APERT1)+" AL: "+DTOC(NOMINA.APERT2)
@ 06,00 SAY "TP"
@ 06,03 SAY "DESCRIPCION"
@ 06,35 SAY "CANT."
@ 06,45 SAY "ASIGNACIONES"
@ 06,60 SAY "DEDUCCIONES"
@ 07,00 SAY "--"
@ 07,03 SAY "----------------------------"
@ 07,35 SAY "-----"
@ 07,45 SAY "------------"
@ 07,60 SAY "-----------"
STORE 08 TO WLINE
RETURN

