*** VACACIONES PETROLERAS Y PETROQUIMICAS
   store "Procesando informacion, Favor esperar..." to mes
   do mensaje with mes
   STORE 12 TO WMESES
   STORE 30 TO WLAPSO
   SELECT 4
   USE IPNPETRO
   LOCATE FOR MESES > WMESES
   IF .NOT. FOUND()
      STORE "ERROR, NO SE ENCONTRO REGISTRO DE MESES A PAGAR" TO MES
      DO AVISO WITH MES
      LOOP
   ENDIF
   GO RECNO() - 1
   STORE VACACION TO WDIASVAC
   STORE BONOVAC  TO WDIASBON

   STORE SPACE(35) TO QQWW
   DO INFORMA WITH QQWW
   IF QQWW <> t3
      STORE 1 TO POSI
      else
      STORE 0 TO POSI
   ENDIF
   SELECT 4
   USE IPNOMINA INDEX IPNOMINA ALIAS NOMINA
   IF WNOMINA = SPACE(5)
      STORE "ERROR, Esta cedula no tiene nomina asignada" to mes
      do aviso with mes
      close data
      close index
      return
   endif
   FIND &WNOMINA
   IF EOF()
      STORE "ERROR, codigo de nomina no registrado en maestro de nominas" to mes
      do aviso with mes
      loop
   endif
   store factcod to wfactor
   select 4
   use ipnfactor
   locate for faccod = wfactor
   if .not. found()
      store "ERROR, tabla de factores de la nomina del obrero no esta registrada" to mes
      do aviso with mes
      loop
   endif
   store f_ayuciu  to wayuciu
   store f_vivien  to wvive

   STORE 0 TO WSALPRO
   IF SUBSTR(PERSONAL->TIPO,1,1)="O" .AND. PERSONAL->TURNO="G"
      *********** BUSQUEDA DE HISTORICO ****************
      SELECT HISTORICO
      SORT TO IPNTEMP2 ON FECHA /D FOR CEDULA = WCEDULA .AND.;
              NOMINA <> "UTLDA" .AND. NOMINA <> "LIQUI" .AND. FECHA <= WFINDATE
      SELECT 4
      USE IPNTEMP2
      PACK
      STORE 6  TO BUSCAR
      STORE 42 TO DIVIDIR
      STORE 0 TO CONTEO
      STORE 0 TO ACUMULADO
      STORE 10 TO ZX
      DO WHILE .NOT. EOF() .AND. CONTEO < BUSCAR
         STORE BSSTDA+BSSTDB+BSSTMA+BSSTMB+BSSTNA+BSSTNB TO WMENOSST
         STORE ACUMULADO + (BSTOTBON-WMENOSST) TO ACUMULADO
         STORE CONTEO + 1 TO CONTEO
         IF DESOCB1="V"
            STORE ACUMULADO - BSOCB1 TO ACUMULADO
            IF BSTOTBON = BSOCB1
               STORE CONTEO - 1 TO CONTEO
            ENDIF
         ENDIF
         SKIP
      ENDDO
      STORE ACUMULADO/DIVIDIR  TO WSALPRO
      STORE WSALPRO            TO WBASICODIA
   ELSE
      STORE (WBASICO+WBONOCO+WAYUCIU) TO WBASICODIA
   ENDIF

   STORE (WBASICO+WBONOCO)         TO WSINAYUDA
   store WSINAYUDA*WDIASVAC        TO BSSINAYUDA

   STORE DAY(INIDATE)    TO DDDD1
   STORE DAY(WFINDATE)   TO DDDD2
   STORE MONTH(INIDATE)  TO MMMM1
   STORE MONTH(WFINDATE) TO MMMM2

   store WFechasal + wlapso to wfechaven
   STORE 0 TO ADICIONAL
   STORE 0 TO WFERIADO
   SELECT 5
   USE IPNHOLLY
   DO WHILE .NOT. EOF()
      STORE wfechasal TO F1
      STORE wfechaven TO F2
      STORE 0 TO NUMDIA
      DO WHILE F1<=F2
         STORE NUMDIA + 1 TO NUMDIA
         IF DAY(F1) = DAY(FECHA) .AND. MONTH(F1) = MONTH(FECHA)
            STORE WFERIADO + 1 TO WFERIADO
            STORE F2 TO F1
            IF NUMDIA <= 15
               STORE ADICIONAL + 1 TO ADICIONAL
            ENDIF
         ENDIF
         STORE F1+1 TO F1
      ENDDO
      SKIP
   ENDDO
   STORE WLAPSO+WFERIADO TO WDIASDISF

   *** CALCULOS FINALES
   STORE WBASICODIA*WDIASVAC          TO BSDIASVAC
   STORE WVIVE*WLAPSO                 TO BSVIVE
   STORE (WSINAYUDA)*WDIASBON         TO BSBONOVAC
   STORE WBASICODIA*WFERIADO          TO BSFERIADO

   STORE (BSDIASVAC+BSBONOVAC+BSFERIADO)*wislr to WBSISLR
   STORE (BSDIASVAC+BSFERIADO)*wsso            to WBSSSO
   STORE (BSDIASVAC+BSFERIADO)*wspf            to WBSSpf
   STORE (BSSINAYUDA+BSFERIADO)*WAH            to WBSAH
   STORE BSSINAYUDA*WCAJA                      to WBSCAJA
   IF PERSONAL->TIPO = "E"
      STORE WSINDIC*2                          to WBSSINDIC
   ELSE
      STORE WSINDIC*4                          to WBSSINDIC
   ENDIF
   store 360000*wsso to wmaxsso
   store 360000*wspf to wmaxspf
   if wbssso > wmaxsso
      store wmaxsso to wbssso
   endif
   if wbsspf > wmaxspf
      store wmaxspf to wbsspf
   endif


   set devi to print
   IF POSI = 1
      @ PROW(),1 SAY CHR(14)+warning+CHR(18)
      SET DEVI TO SCRE
      CLOSE DATA
      CLOSE INDEX
      QUIT
   ENDIF
   @ 1,0  SAY CHR(14)+QQWW
   @ 2,60 SAY "FECHA :"+DTOC(WFECACT)
   @ 4,30 SAY "VACACIONES ANUALES"
   @ 5,1  SAY "NOMBRE: "+RTRIM(WNOMBRE)+" "+WAPELLIDO
   @ 5,60 SAY "CEDULA: "+WCEDULA
   @ 7,1  SAY "BASICO: "+STR(WBASICO,8,2)
   @ 7,20 SAY "BONO  : "+STR(WBONOCO,8,2)
   @ 7,40 SAY "AYUDA : "+STR(WAYUCIU,8,2)
   @ 7,60 SAY "NORMAL: "+STR(WSALPRO,8,2)
   @ 9,1  SAY "PERIODO VENCIDO :  DEL "+DTOC(INIDATE)+" AL "+DTOC(WFINDATE)
   @ 10,1 SAY "PERIODO DISFRUTE:  DEL "+DTOC(WFECHASAL)+" AL "+DTOC(WFECHAVEN)
   @ 12,1 SAY "DESCRIPCION                      UNID.     ASIGNAC.      DEDUCION       SALDO"
   @ 13,1 SAY "----------------------------     -----   ----------   -----------  ----------"
   @ 14,1 SAY "VACACIONES ANUALES"
   @ 14,30 SAY STR(WLAPSO,8,2)
   @ 14,40 SAY STR(BSDIASVAC,12,2)
   @ 16,1 SAY "FERIADOS PERIODO DISFRUTE"
   @ 16,30 SAY STR(WFERIADO,8,2)
   @ 16,40 SAY STR(BSFERIADO,12,2)
   @ 18,1 SAY "BONO VACACIONAL"
   @ 18,30 SAY STR(WMESES,8,2)
   @ 18,40 SAY STR(BSBONOVAC,12,2)
   @ 20,1 SAY "VIVIENDA"
   @ 20,30 SAY STR(WLAPSO,8,2)
   @ 20,40 SAY STR(BSVIVE,12,2)
   @ 22,1 SAY "IMPUESTO SOBRE LA RESTA"
   @ 22,54 SAY STR(WBSISLR,12,2)
   @ 24,1 SAY "SEGURO SOCIAL OBLIGATORIO"
   @ 24,54 SAY STR(WBSSSO,12,2)
   @ 26,1 SAY "SEGURO DE PARO FORZOSO"
   @ 26,54 SAY STR(WBSSPF,12,2)
   @ 28,1 SAY "AHORRO HABITACIONAL"
   @ 28,54 SAY STR(WBSAH,12,2)
   @ 30,1 SAY "SINDICATOS"
   @ 30,54 SAY STR(WBSSINDIC,12,2)
   @ 32,1 SAY "PRESTAMOS"
   @ 32,54 SAY STR(WPRESTAMO,12,2)
   @ 34,1 SAY "CAJA DE AHORRORS"
   @ 34,54 SAY STR(WBSCAJA,12,2)
   STORE (BSDIASVAC+BSFERIADO+BSBONOVAC+BSVIVE) TO WTOTASIG
   STORE (WBSISLR+WBSSSO+WBSSPF+WBSAH+WBSSINDIC+WPRESTAMO+WBSCAJA) TO WTOTDEC
   STORE WTOTASIG-WTOTDEC TO WMONTO
   @ 36,1 SAY "T O T A L E S  "
   @ 36,40 SAY STR(WTOTASIG,12,2)
   @ 36,54 SAY STR(WTOTDEC,12,2)
   @ 36,67 SAY STR(WMONTO,12,2)
   @ 39,40 say "__________________________________"
   @ 40,40 say chr(15)+"Firma del trabajador o a su ruego por no saber firmar"+chr(18)
   @ 44,3 say "____________________________               _______________________________"
   @ 45,3 say "        Testigo                                       Testigo             "
   @ 49,3 say "____________________________"
   @ 50,3 say "  Lugar y Fecha del Pago    "
   @ 51,50 say chr(15)+"Papel sellado inutilizado en la copia"+chr(18)
   @ 52,50 say chr(15)+"que quedan en poder de "+QQWW+chr(18)
   EJECT
   store "Actualizando Historico, Favor esperar..." to mes
   set devi to scree
   do mensaje with mes
   SELECT 2
   STORE WCEDULA+DTOC(WFECHASAL)+WNOMINA TO WCLAVE
   FIND &WCLAVE
   IF EOF()
      APPEND BLANK
      STORE .T. TO WFLAGACUM
   ELSE
      STORE .F. TO WFLAGACUM
   ENDIF
   REPLACE CEDULA WITH WCEDULA
   REPLACE FECHA WITH WFECHASAL
   REPLACE nomina WITH WNOMINA
   REPLACE DESOCB1 WITH "V"
   REPLACE HROCB1 WITH (WLAPSO+WFERIADO)*8
   REPLACE BSOCB1 WITH WTOTASIG
   replace bstotbon with WTOTASIG
   REPLACE BSISLR WITH WBSISLR
   REPLACE BSSSO  WITH WBSSSO
   REPLACE BSAHRHAB  WITH WBSAH
   REPLACE BSSINDIC  WITH WBSSINDIC
   REPLACE BSPRESPER WITH WPRESTAMO
   REPLACE BSCAJA    WITH WBSCAJA
   REPLACE BSTOTDEC  WITH WTOTDEC

   SELECT 1
   REPLACE LASTVACA WITH VACACION
   REPLACE VACACION WITH WFINDATE
   IF WPRESTAMO > 0
      REPLACE MP WITH MP - WPRESTAMO
   ENDIF
   IF WFLAGACUM
      REPLACE UTILACUM WITH UTILACUM+WTOTASIG
   ENDIF
   SET DEVI TO SCRE

