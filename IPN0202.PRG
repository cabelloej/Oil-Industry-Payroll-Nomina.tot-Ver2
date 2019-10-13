*******************************************************************************
*              ACTUALIZADOR DE DATOS DE LA SEMANA DEL OBRERO                  *
*******************************************************************************
store "CARGAR VARIACIONES" TO HEADING
SELECT 1
USE IPNPERSO INDEX IPNPERSO ALIAS PERSONAL
SELECT 2
USE IPNPROCO INDEX IPNPROCO ALIAS PROCESO
SELECT 3
USE IPNFACTOR INDEX IPNFACTOR ALIAS TABLA
SELECT 4
USE IPNOMINA INDEX IPNOMINA ALIAS NOMINA
STORE .T. TO PROCESA
DO WHILE PROCESA
   set color to w+/b
   @ 5,0 to 21,79 double
   @ 5,40-(LEN(HEADING)/2) SAY HEADING
   @ 6,1 clear to 20,78
   @ 06,2 SAY "CEDULA:"
   @ 06,20 SAY "NOMBRES:"
   @ 06,49 SAY "APELLIDOS:"
   @ 07,2  SAY "DIAS ORD. :D., M., N. :"
   @ 08,2  SAY "DIAS FER.NOR,TRA.D,M,N:"
   @ 09,2  SAY "DESC.TRAB.:CON,LEG T/C:"
   @ 10,2  SAY "DESC.NORM., DESC.COMP.:"
   @ 11,2  SAY "SOBRE TMPO.NOR: D,M,N :"
   @ 12,2  SAY "SOBRE TMPO.ADC: D,M,N :"
   @ 13,2  SAY "SOBRE TMPO.GUARDIA M,N:"
   @ 14,2  SAY "TMPO VIA. 1.5 Hr.D,M,N:"
   @ 15,2  SAY "TMPO VIA.+1.5 Hr.D,M,N:"
   @ 16,2  SAY "AYUDA,COMIDAS,PRI.DOM.:"
   @ 17,2  SAY "B.N.:TRAB,VIA,G.M,G.N.:"
   @ 18,2  SAY "REPOSO/COMIDA D, M, N :"
   @ 19,2  SAY "CODIGO Y MONTO BONIFIC:"
   @ 20,2  SAY "CODIGO Y MONTO BONIFIC:"

   @ 07,40 SAY "B.TRAN, B.ALIM, B.SUBS:"
   @ 08,40 SAY "CEST.M,CEST.L,VIVIENDA:"
   @ 09,40 SAY "UTILIDAD, INDEM.MINIMA:"
   @ 10,40 SAY "CODIGO Y MONTO NO BON.:"
   @ 11,40 SAY "CODIGO Y MONTO NO BON.:"
   @ 12,40 SAY "PRESTAMO O ADELANTO   :"
   @ 13,40 SAY "CODIGO Y MONTO DEDEDUC:"
   @ 14,40 SAY "CODIGO Y MONTO DEDEDUC:"
 *  @ 20,40 say "EN REPOSO (SI/NO) :"
   CLEAR GETS
   STORE SPACE(5) TO WWNOMI
   STORE "INGRESE EL CODIGO DE NOMINA A PROCESAR, Ù = BUSQUEDA POR CEDULA" TO MES
   DO MENSAJE WITH MES
   @ 23,74 GET WWNOMI
   READ
   STORE .F. TO WPORNOMI
   IF WWNOMI <> SPACE(5)
      SELECT 4
      FIND &WWNOMI
      IF EOF()
         STORE "NOMINA NO REGISTRADA" TO MES
         CLOSE DATA
         CLOSE INDEX
         RETURN
      ENDIF
      STORE FACTCOD TO WFACTOR
      SELECT 3
      FIND &WFACTOR
      IF EOF()
         STORE "ERROR, TABLA DE FACTORES DE ESTA NOMINA NO ESTA REGISTRADA" TO MES
         DO AVISO WITH MES
         close data
         close index
         return
      ENDIF
      select 4
      if estado = 0
         store "Esta nomina esta cerrada" to mes
         do aviso with mes
         close data
         close index
         return
      ENDIF
      if estado = 2 .OR. ESTADO = 3
         store "Esta nomina ya se imprimio, Ingrese clave:" to mes
         do mensaje with mes
         store "     " to wclave
         SET INTENSITY OFF
         set color to b/b
         @ 23,70 get wclave
         read
         SET INTENSITY ON
         SET COLOR TO W+/b
         if upper(Wclave) <> "IPNOK"
            close data
            close index
            return
         ELSE
            REPLACE ESTADO WITH 1
         ENDIF
      ENDIF
      store .t. to wpornomi
      SELECT 1
      USE IPNPERSO ALIAS PERSONAL
   ELSE
      STORE .T. TO CEDULAR
      DO WHILE CEDULAR
         store "Ingrese la cedula del empleado a procesar" to mes
         do mensaje with mes
         SELECT 1
         STORE SPACE(10) TO WCEDULA
         @ 6,9 GET WCEDULA
         READ
         STORE UPPER(WCEDULA) TO WCEDULA
         IF WCEDULA = SPACE(10)
            CLOSE DATA
            CLOSE INDEX
            RETURN
         ENDIF
         FIND &WCEDULA
         IF EOF()
            store "Cedula no registrada" to mes
            do aviso with mes
            STORE SPACE(10) TO WCEDULA
            CLOSE DATA
            CLOSE INDEX
            RETURN
         ENDIF
         STORE NOMINA TO WNOMINA
         IF WNOMINA = SPACE(5)
            STORE "Esta persona no esta asignada a ninguna nomina (CR)" to mes
            do aviso with mes
            CLOSE DATA
            CLOSE INDEX
            RETURN
         endif
         select 2
         find &wcedula
         if eof()
            store "Error de estructura, no existe registro de proceso para esta persona" to mes
            do aviso with mes
            store "Probablemente fue agregado a la nomina despues de abrirla" to mes
            do aviso with mes
            CLOSE DATA
            CLOSE INDEX
            RETURN
         endif
         SELECT 4
         FIND &WNOMINA
         IF EOF()
            store "Error de estructura, la nomina del empleado no esta registrada" to mes
            do aviso with mes
            CLOSE DATA
            CLOSE INDEX
            RETURN
         ENDIF
         STORE FACTCOD TO WFACTOR
         SELECT 3
         FIND &WFACTOR
         IF EOF()
            STORE "ERROR, TABLA DE FACTORES DE ESTA NOMINA NO ESTA REGISTRADA" TO MES
            DO AVISO WITH MES
            CLOSE DATA
            CLOSE INDEX
            RETURN
         ENDIF
         select 4
         if estado = 0
            store "Esta nomina esta cerrada, Ingrese clave:" to mes
            do mensaje with mes
            store "     " to wclave
            SET INTENSITY OFF
            set color to b/b
            @ 23,70 get wclave
            read
            SET INTENSITY ON
            SET COLOR TO W+/b
            if upper(Wclave) <> "IPNOK"
               CLOSE DATA
               CLOSE INDEX
               RETURN
            ELSE
               REPLACE ESTADO WITH 1
            ENDIF
         ENDIF
         if estado = 2 .OR. ESTADO = 3
            store "Esta nomina ya se imprimio, Ingrese clave:" to mes
            do mensaje with mes
            store "     " to wclave
            SET INTENSITY OFF
            set color to b/b
            @ 23,70 get wclave
            read
            SET INTENSITY ON
            SET COLOR TO W+/b
            if upper(Wclave) <> "IPNOK"
               CLOSE DATA
               CLOSE INDEX
               RETURN
            ELSE
               REPLACE ESTADO WITH 1
            ENDIF
         ENDIF
         STORE .F. TO CEDULAR
      ENDDO
   ENDIF

   SELECT 1
   GO TOP
   IF WPORNOMI
      LOCATE FOR NOMINA = WWNOMI
   ELSE
      FIND &WCEDULA
      LOCATE FOR CEDULA = WCEDULA
   ENDIF
   DO WHILE .NOT. EOF()
      store cedula to wrcedula
      @ 6,9  SAY CEDULA
      @ 6,28 SAY NOMBRE
      @ 6,59 SAY APELLIDO
      select 2
      find &wrcedula
      if eof()
         store "Error de estructura, no existe registro de proceso para esta persona" to mes
         do aviso with mes
         store "Probablemente fue agregado a la nomina despues de abrirla" to mes
         do aviso with mes
         select 1
         continue
         loop
      endif
      @ 07,25  say p_diasorD PICTURE "##.#"
      @ 07,30  say p_diasorM PICTURE "##.#"
      @ 07,35  say p_diasorN PICTURE "##.#"
      @ 08,25  say p_ferord picture "##"
      @ 08,30  say p_ferpriD picture "##"
      @ 08,33  say p_ferpriM picture "##"
      @ 08,36  say p_ferpriN picture "##"
      @ 09,25  say p_Tdescon
      @ 09,27  say p_descon  picture "##.#"
      @ 09,33  say p_Tdesleg
      @ 09,35  say p_desleg  picture "##.#"
      @ 10,25  say p_desnor  picture "##.#"
      @ 10,30  say p_descom  picture "##.#"
      @ 11,24  say p_stdA picture "###.#"
      @ 11,29  say p_stmA picture "###.#"
      @ 11,34  say p_stnA picture "###.#"
      @ 12,25  say p_stdB picture "##.#"
      @ 12,30  say p_stmB picture "##.#"
      @ 12,35  say p_stnB picture "##.#"
      @ 13,30  say p_stgm picture "##.#"
      @ 13,35  say p_stgn picture "##.#"
      @ 14,25  say p_tvdA picture "##.#"
      @ 14,30  say p_tvmA picture "##.#"
      @ 14,35  say p_tvnA picture "##.#"
      @ 15,25  say p_tvdB picture "##.#"
      @ 15,30  say p_tvmB picture "##.#"
      @ 15,35  say p_tvnB picture "##.#"
      @ 16,25  say p_ayuciu picture "##.#"
      @ 16,30  say p_comida picture "##.#"
      @ 16,35  say p_bd     picture "##.#"
      @ 17,25  say p_bnt    picture "##.#"
      @ 17,30  say p_bnv    picture "##.#"
      @ 17,35  say p_bngM   picture "##.#"
      @ 17,40  say p_bngN   picture "##.#"
      @ 18,25  say p_REPCOMD picture "##.#"
      @ 18,30  say p_REPCOMM picture "##.#"
      @ 18,35  say p_REPCOMN picture "##.#"
      @ 19,25  say p_des3
      @ 19,30  say p_ocb3 picture "######.##"
      @ 20,25  say p_des4
      @ 20,30  say p_ocb4 picture "######.##"

      @ 07,63  say p_btran picture "##.##"
      @ 07,69  say p_balim picture "##.##"
      @ 07,75  say p_bsubs picture "##.##"
      @ 08,63  say p_flagces1
      @ 08,66  say p_flagces2
      @ 08,69  say p_vive  picture "##.#"
      @ 09,63  say p_UTILIDAD
      @ 09,69  say p_indemni
      @ 10,63  say p_desc3
      @ 10,69  say p_ocnb3 picture "######.##"
      @ 11,63  say p_desc4
      @ 11,69  say p_ocnb4 picture "######.##"
      @ 12,69  say p_presper picture "######.##"
      @ 13,63  say p_descr3
      @ 13,69  say p_od3 picture "######.##"
      @ 14,63  say p_descr4
      @ 14,69  say p_od4 picture "######.##"
      @ 20,63  SAY P_REPOSO

      store "Seleccione (M)ODIFICAR DATOS, (C)ONTINUAR, (S)ALIR" to mes
      store "M" to p1
      store "C" to p2
      store "S" to p3
      store " " to resp
      do pide3 with p1,p2,P3,mes,resp
      if resp = "C"
         SELECT 1
         CONTINUE
         LOOP
      endif
      IF RESP = "S"
         CLOSE DATA
         CLOSE INDEX
         RETURN
      ENDIF

      STORE P_DIASORD TO WDIASORDD
      STORE P_DIASORM TO WDIASORDM
      STORE P_DIASORN TO WDIASORDN
      STORE P_FERORD  TO WFERORD
      STORE P_FERPRID TO WFERPRID
      STORE P_FERPRIM TO WFERPRIM
      STORE P_FERPRIN TO WFERPRIN
      STORE P_FTDNOR  TO WFTDNOR
      STORE P_FTDDES  TO WFTDDES
      STORE P_FTMNOR  TO WFTMNOR
      STORE P_FTMDES  TO WFTMDES
      STORE P_FTNNOR  TO WFTNNOR
      STORE P_FTNDES  TO WFTNDES
      STORE P_STDA    TO WSTDA
      STORE P_STMA    TO WSTMA
      STORE P_STNA    TO WSTNA
      STORE P_STDB    TO WSTDB
      STORE P_STMB    TO WSTMB
      STORE P_STNB    TO WSTNB
      STORE P_STGM    TO WSTGM
      STORE P_STGN    TO WSTGN
      STORE P_TVDA    TO WTVDA
      STORE P_TVMA    TO WTVMA
      STORE P_TVNA    TO WTVNA
      STORE P_TVDB    TO WTVDB
      STORE P_TVMB    TO WTVMB
      STORE P_TVNB    TO WTVNB
      STORE P_DESNOR  TO WDESNOR
      STORE P_TDESLEG TO WTDESLEG
      STORE P_PDESLEG TO WPDESLEG
      STORE P_DESLEG  TO WDESLEG
      STORE P_TDESCON TO WTDESCON
      STORE P_DESCON  TO WDESCON
      STORE P_DESCOM  TO WDESCOM
      STORE P_AYUCIU  TO WAYUCIU
      STORE P_COMIDA  TO WCOMIDA
      STORE P_REPCOMD TO WREPCOMD
      STORE P_REPCOMM TO WREPCOMM
      STORE P_REPCOMN TO WREPCOMN
      STORE P_BNT     TO WBNT
      STORE P_BNV     TO WBNV
      STORE P_BNGM    TO WBNGM
      STORE P_BNGN    TO WBNGN
      STORE P_BD      TO WBD
      STORE P_DES3    TO WDES3
      STORE P_OCB3    TO WOCB3
      STORE P_DES4    TO WDES4
      STORE P_OCB4    TO WOCB4

      STORE P_BTRAN   TO WBTRAN
      STORE P_BALIM   TO WBALIM
      STORE P_BSUBS   TO WBSUBS
      STORE P_FLAGCES1 TO WFLAGCES1
      STORE P_FLAGCES2 TO WFLAGCES2
      STORE P_VIVE     TO WVIVE
      STORE P_UTILIDAD TO WUTILIDAD
      STORE P_INDEMNI  TO WINDEMNI
      STORE P_DESC3   TO WDESC3
      STORE P_OCNB3   TO WOCNB3
      STORE P_DESC4   TO WDESC4
      STORE P_OCNB4   TO WOCNB4
      STORE P_PRESPER TO WPRESPER
      STORE P_OD3     TO WOD3
      STORE P_DESCR3  TO WDESCR3
      STORE P_OD4     TO WOD4
      STORE P_DESCR4  TO WDESCR4
      STORE P_REPOSO  TO WREPOSO

      STORE .T. TO FLAGCARGA
      DO WHILE FLAGCARGA
         STORE "Ingrese el numero de dias ORDINARIOS " to mes
         do mensaje with mes
         @ 7,25 GET WDIASORDD PICTURE "##.#"
         @ 7,30 GET WDIASORDM PICTURE "##.#"
         @ 7,35 GET WDIASORDN PICTURE "##.#"
         READ
         STORE WDIASORDD+WDIASORDM+WDIASORDN TO WDIASORD
         IF WDIASORD > TABLA->F_DIAS
            STORE "ERROR, el numero de dias maximo fue exedido" TO MES
            do aviso with mes
         else
            store .f. to flagcarga
         endif
      ENDDO
      IF PERSONAL->CONTRATO="CONSTRUCCION"
         IF PERSONAL->TV1>0
            STORE (PERSONAL->TV1*WDIASORD)-PERSONAL->TV1       TO WTVDA
         ENDIF
         IF PERSONAL->TV2>0
            STORE (PERSONAL->TV2*WDIASORD)-PERSONAL->TV2       TO WTVMA
         ENDIF
         IF PERSONAL->TV3>0
            STORE (PERSONAL->TV3*WDIASORD)-PERSONAL->TV3       TO WTVNA
         ENDIF
         IF PERSONAL->COMIDAS>0
            STORE (PERSONAL->COMIDAS*WDIASORD)-PERSONAL->COMIDAS TO WCOMIDA
         ENDIF
      ELSE
         IF PERSONAL->TV1>0
            STORE  PERSONAL->TV1*WDIASORD    TO WTVDA
         ENDIF
         IF PERSONAL->TV2>0
            STORE  PERSONAL->TV2*WDIASORD    TO WTVMA
         ENDIF 
         IF PERSONAL->TV3>0
            STORE  PERSONAL->TV3*WDIASORD    TO WTVNA
         ENDIF
         IF PERSONAL->COMIDAS>0
            STORE  PERSONAL->COMIDAS*WDIASORD TO WCOMIDA
         ENDIF
      ENDIF
      @ 14,25 SAY WTVDA PICTURE "##.#"
      @ 14,30 SAY WTVMA PICTURE "##.#"
      @ 14,35 SAY WTVNA PICTURE "##.#"
      @ 16,30 SAY WCOMIDA PICTURE "##.#"
      IF PERSONAL->TURNO ="G"
         STORE WDIASORDM*.5 TO WSTGM
         STORE WDIASORDN*1  TO WSTGN
         STORE WDIASORDD*.5  TO WREPCOMD
         STORE WDIASORDM*.5  TO WREPCOMM
         STORE WDIASORDN*.5  TO WREPCOMN
         STORE (WDIASORDM*4) TO WBNGM
         STORE (WDIASORDN*6) TO WBNGN
         @ 13,30 SAY WSTGM    PICTURE "##.#"
         @ 13,35 SAY WSTGN    PICTURE "##.#"
         @ 17,35 say WbngM    picture "##.#"
         @ 17,40 say WbngN    picture "##.#"
         @ 18,25 say WrepcomD picture "##.#"
         @ 18,30 say WrepcomM picture "##.#"
         @ 18,35 say WrepcomN picture "##.#"
      ENDIF

      STORE "Ingrese el numero de dias feriados ordinarios" to mes
      do mensaje with mes
      @ 08,25 get wferord picture "##"
      read

      IF WFERORD > 0
         SAVE SCRE TO WSCREFER
         STORE .T. TO WVERFER
         DO WHILE WVERFER
            STORE "NUMERO DE PRIMAS POR FERIADO TRABAJADO EN EL TURNO CORRESPONDIENTE" to mes
            do mensaje with mes
            @ 08,30  GET wferpriD picture "##"
            READ
            IF WFERPRID > 0
               @ 09,40 CLEAR TO 12,78
               @ 09,40       TO 12,78
               @ 10,41 SAY "FERIADOS TRAB.DIURNO EN DIA NORMAL:" GET WFTDNOR  PICTURE "#"
               @ 11,41 SAY "FERIADOS TRAB.DIURNO EN DIA DESC. :" GET WFTDDES  PICTURE "#"
               READ
               IF WFERPRID <> WFTDNOR+WFTDDES
                  STORE "NUMERO DE FERIADOS TRABAJADOS NO CORRESPONDE CON CLASE DETIEMPO" TO MES
                  DO AVISO WITH MES
                  STORE 0 TO WFTDNOR
                  STORE 0 TO WFTDDES
                  RESTORE SCRE FROM WSCREFER
                  LOOP
               ENDIF
               RESTORE SCRE FROM WSCREFER
               @ 08,30  SAY wferpriD picture "##"
            ELSE
               STORE 0 TO WFTDNOR
               STORE 0 TO WFTDDES
            ENDIF
            @ 08,33  GET wferpriM picture "##"
            READ
            IF WFERPRIM > 0
               @ 09,40 CLEAR TO 12,78
               @ 09,40       TO 12,78
               @ 10,41 SAY "FERIADOS TRAB. MIXTO EN DIA NORMAL:" GET WFTMNOR  PICTURE "#"
               @ 11,41 SAY "FERIADOS TRAB. MIXTO EN DIA DESC. :" GET WFTMDES  PICTURE "#"
               READ
               IF WFERPRIM <> WFTMNOR+WFTMDES
                  STORE "NUMERO DE FERIADOS TRABAJADOS NO CORRESPONDE CON CLASE DETIEMPO" TO MES
                  DO AVISO WITH MES
                  STORE 0 TO WFTMNOR
                  STORE 0 TO WFTMDES
                  RESTORE SCRE FROM WSCREFER
                  LOOP
               ENDIF
               RESTORE SCRE FROM WSCREFER
               @ 08,30  SAY wferpriD picture "##"
               @ 08,33  SAY wferpriM picture "##"
            ELSE
               STORE 0 TO WFTMNOR
               STORE 0 TO WFTMDES
            ENDIF
            @ 08,36  GET wferpriN picture "##"
            READ
            IF WFERPRIN > 0
               @ 09,40 CLEAR TO 12,78
               @ 09,40       TO 12,78
               @ 10,41 SAY "FERIADOS TRAB. NOCT. EN DIA NORMAL:" GET WFTNNOR  PICTURE "#"
               @ 11,41 SAY "FERIADOS TRAB. NOCT. EN DIA DESC. :" GET WFTNDES  PICTURE "#"
               READ
               IF WFERPRIN <> WFTNNOR+WFTNDES
                  STORE "NUMERO DE FERIADOS TRABAJADOS NO CORRESPONDE CON CLASE DETIEMPO" TO MES
                  DO AVISO WITH MES
                  STORE 0 TO WFTNNOR
                  STORE 0 TO WFTNDES
                  RESTORE SCRE FROM WSCREFER
                  LOOP
               ENDIF
               RESTORE SCRE FROM WSCREFER
               @ 08,30  SAY wferpriD picture "##"
               @ 08,33  SAY wferpriM picture "##"
               @ 08,36  SAY wferpriN picture "##"
            ELSE
               STORE 0 TO WFTNNOR
               STORE 0 TO WFTNDES
            ENDIF
            IF WFERPRID+WFERPRIM+WFERPRIN > WFERORD
               STORE "NUMERO DE FERIADOS TRABAJADOS EXEDE EL NUMERO DE FERIADOS" TO MES
               DO AVISO WITH MES
               LOOP
            ENDIF
            EXIT
         ENDDO
      ELSE
         STORE 0 TO WFERPRID
         STORE 0 TO WFERPRIM
         STORE 0 TO WFERPRIN
         STORE 0 TO WFTDNOR
         STORE 0 TO WFTDDES
         STORE 0 TO WFTMNOR
         STORE 0 TO WFTMDES
         STORE 0 TO WFTNNOR
         STORE 0 TO WFTNDES
      ENDIF
      IF WFTDNOR > 0
         STORE WDIASORDD+WFTDNOR TO WDIASORDD
      ENDIF
      IF WFTMNOR > 0
         STORE WDIASORDM+WFTMNOR TO WDIASORDM
      ENDIF
      IF WFTNNOR > 0
         STORE WDIASORDN+WFTNNOR TO WDIASORDN
      ENDIF
      @ 7,25 SAY WDIASORDD PICTURE "##.#"
      @ 7,30 SAY WDIASORDM PICTURE "##.#"
      @ 7,35 SAY WDIASORDN PICTURE "##.#"

      STORE WDIASORDD+WDIASORDM+WDIASORDN TO WDIASORD
      IF WDIASORD > TABLA->F_DIAS
         STORE "ERROR, el numero maximo de dias ordinarios fue exedido" TO MES
         DO AVISO WITH MES
         SELECT 1
         LOOP
      ENDIF
      IF PERSONAL->TURNO ="G"
         STORE WDIASORDM*.5  TO WSTGM
         STORE WDIASORDN*1   TO WSTGN
         STORE WDIASORDD*.5  TO WREPCOMD
         STORE WDIASORDM*.5  TO WREPCOMM
         STORE WDIASORDN*.5  TO WREPCOMN
         STORE (WDIASORDM*4) TO WBNGM
         STORE (WDIASORDN*6) TO WBNGN
         @ 13,30 SAY WSTGM    PICTURE "##.#"
         @ 13,35 SAY WSTGN    PICTURE "##.#"
         @ 17,35 say WbngM    picture "##.#"
         @ 17,40 say WbngN    picture "##.#"
         @ 18,25 say WrepcomD picture "##.#"
         @ 18,30 say WrepcomM picture "##.#"
         @ 18,35 say WrepcomN picture "##.#"
      ENDIF

      STORE "Ingrese el Turno (D,M,N) y Numero (Dias) de descansos contractuales trabajados" to mes
      do mensaje with mes
      @ 09,25 GET Wtdescon
      @ 09,27 GET Wdescon PICTURE "##.#"
      READ
      STORE "Ingrese el Turno (D,M,N) y Numero (Dias) de descansos legales trabajados" to mes
      do mensaje with mes
      @ 09,33 GET Wtdesleg
      @ 09,35 GET Wdesleg PICTURE "##.#"
      READ
      IF PERSONAL->TURNO ="G"
         IF WTDESCON = "D"
            STORE WREPCOMD + WDESCON*.5    TO WREPCOMD
         ENDIF
         IF WTDESCON = "M"
            STORE WREPCOMM + WDESCON*.5    TO WREPCOMM
            STORE WSTGM    + WDESCON*.5    TO WSTGM
            STORE WBNGM    + (WDESCON*4)   TO WBNGM
         ENDIF
         IF WTDESCON = "N"
            STORE WREPCOMN + WDESCON*.5    TO WREPCOMN
            STORE WSTGN    + WDESCON*1     TO WSTGN
            STORE WBNGN    + (WDESCON*6)   TO WBNGN
         ENDIF
         IF WTDESLEG = "D"
            STORE WREPCOMD + WDESLEG*.5    TO WREPCOMD
         ENDIF
         IF WTDESLEG = "M"
            STORE WREPCOMM + WDESLEG*.5    TO WREPCOMM
            STORE WSTGM    + WDESLEG*.5    TO WSTGM
            STORE WBNGM    + (WDESLEG*4)   TO WBNGM
         ENDIF
         IF WTDESLEG = "N"
            STORE WREPCOMN + WDESLEG*.5    TO WREPCOMN
            STORE WSTGN    + WDESLEG*1     TO WSTGN
            STORE WBNGN    + (WDESLEG*6)   TO WBNGN
         ENDIF
         @ 13,30 SAY WSTGM    PICTURE "##.#"
         @ 13,35 SAY WSTGN    PICTURE "##.#"
         @ 17,35 say WbngM    picture "##.#"
         @ 17,40 say WbngN    picture "##.#"
         @ 18,25 say WrepcomD picture "##.#"
         @ 18,30 say WrepcomM picture "##.#"
         @ 18,35 say WrepcomN picture "##.#"
      ENDIF
      IF WDESLEG>0
         STORE "Desea pagar el Descanso Compensatorio del Descanso Legal trabajado ? (S/N)" TO MES
         DO MENSAJE WITH MES
         STORE .T. TO WGETDCXDL
         DO WHILE WGETDCXDL
            @ 23,78 GET WPDESLEG
            READ
            IF WPDESLEG = "S" .OR. WPDESLEG = "N"
               EXIT
            ENDIF
         ENDDO
      ELSE
         STORE "N" TO WPDESLEG
      ENDIF
      IF WPDESLEG="S"
         STORE WDESCON+WDESLEG TO WDESCOM
      ELSE
         STORE WDESCON         TO WDESCOM
      ENDIF
      @ 10,30 say Wdescom PICTURE "##.#"
      IF PERSONAL->TURNO = "R"
         STORE WDESLEG TO WBD
         @ 16,35 SAY WBD PICTURE "##.#"
      ENDIF

      STORE WDIASORDD+WDIASORDM+WDIASORDN+WDESCON+WDESLEG TO WDIASORD
      IF substr(personal->tipo,1,1) = "O"
         IF WDIASORD >=3
            STORE TABLA->F_DESNOR TO WDESNOR
         ELSE
            STORE 0 TO WDESNOR
         ENDIF
         @ 10,25 SAY Wdesnor PICTURE "##.#"
      ENDIF
      STORE WDIASORDD+WDIASORDM+WDIASORDN+WDESCON+WDESLEG TO WBALIM
      IF PERSONAL->CONTRATO="CONSTRUCCION"
         STORE WBALIM-1 TO WBALIM
      ENDIF
      IF WBALIM > TABLA->F_DIAS+TABLA->F_DESNOR
         STORE TABLA->F_DIAS+TABLA->F_DESNOR TO WBALIM
      ENDIF
      STORE WDIASORDD+WDIASORDM+WDIASORDN+WDESCON+WDESLEG TO WBTRAN
      IF PERSONAL->CONTRATO="CONSTRUCCION"
         STORE WBTRAN-1 TO WBTRAN
      ENDIF
      IF WBTRAN > TABLA->F_DIAS+TABLA->F_DESNOR
         STORE TABLA->F_DIAS+TABLA->F_DESNOR TO WBTRAN
      ENDIF
      STORE WDIASORDD+WDIASORDM+WDIASORDN+WDESCON+WDESLEG TO WBSUBS
      IF PERSONAL->CONTRATO="CONSTRUCCION"
         STORE WBSUBS-1 TO WBSUBS
      ENDIF
      IF WBSUBS > TABLA->F_DIAS+TABLA->F_DESNOR
         STORE TABLA->F_DIAS+TABLA->F_DESNOR TO WBSUBS
      ENDIF
      @ 07,63  SAY wbTRAN picture "##.##"
      @ 07,69  SAY wbALIM picture "##.##"
      @ 07,75  SAY wbSUBS picture "##.##"

      IF PERSONAL->TV1 > 0 
         IF PERSONAL->CONTRATO="CONSTRUCCION"
            STORE (WDIASORD*PERSONAL->TV1)-PERSONAL->TV1 TO WTVDA
         ELSE
            STORE WDIASORD*PERSONAL->TV1 TO WTVDA
         ENDIF
         @ 14,25 say WTVDA picture "##.#"
      ENDIF
      IF PERSONAL->TV2 > 0 
         IF PERSONAL->CONTRATO="CONSTRUCCION"
            STORE (WDIASORD*PERSONAL->TV2)-PERSONAL->TV2 TO WTVMA
         ELSE
            STORE WDIASORD*PERSONAL->TV2 TO WTVMA
         ENDIF
         @ 14,30 say WTVMA picture "##.#"
      ENDIF
      IF PERSONAL->TV3 > 0
         IF PERSONAL->CONTRATO="CONSTRUCCION"
            STORE (WDIASORD*PERSONAL->TV3)-PERSONAL->TV3 TO WTVNA
         ELSE
            STORE WDIASORD*PERSONAL->TV3 TO WTVNA
         ENDIF
         @ 14,35 SAY WTVNA PICTURE "##.#"
      ENDIF
      IF PERSONAL->ST1 > 0
         STORE WDIASORD*PERSONAL->ST1 TO WSTDA
         @ 11,24 SAY WSTDA PICTURE "###.#"
      ENDIF
      IF PERSONAL->ST2 > 0
         STORE WDIASORD*PERSONAL->ST2 TO WSTMA
         @ 11,29 SAY WSTMA PICTURE "###.#"
      ENDIF
      IF PERSONAL->ST3 > 0
         STORE WDIASORD*PERSONAL->ST3 TO WSTNA
         @ 11,34 SAY WSTNA PICTURE "###.#"
      ENDIF
      IF PERSONAL->COMIDAS > 0 
         IF PERSONAL->CONTRATO="CONSTRUCCION"
            STORE (WDIASORD*PERSONAL->COMIDAS)-PERSONAL->COMIDAS TO WCOMIDA
         ELSE
            STORE WDIASORD*PERSONAL->COMIDAS TO WCOMIDA
         ENDIF
         @ 16,30 say Wcomida PICTURE "##.#"
      ENDIF

      IF (PERSONAL->TURNO = "G" .AND.(WDIASORDM+WDIASORDN>0)) .OR. (PERSONAL->TV1>0 .OR. PERSONAL->TV2>0 .OR. PERSONAL->TV3>0)
         STORE WDIASORD+WFERORD TO WAYUCIU
         IF WAYUCIU > TABLA->F_DIAS
            STORE  TABLA->F_DIAS TO WAYUCIU
         ENDIF
      ELSE
         STORE WDIASORD+WFERORD TO WAYUCIU
         IF WAYUCIU > TABLA->F_DIAS
            STORE  TABLA->F_DIAS TO WAYUCIU
         ENDIF
      ENDIF
      @ 16,25 say WAYUCIU PICTURE "##.#"

      *** MUY BUENA FORMULA PARA DETERMINAR EL No DE DIAS A PAGAR (MAX. TABLA->DIASOR+DESNOR)
      STORE (WDIASORD+WFERORD+(WDESNOR-(WDESCON+WDESLEG))) TO Wvive
      IF Wvive > (TABLA->F_DIAS+TABLA->F_DESNOR)
         STORE  (TABLA->F_DIAS+TABLA->F_DESNOR) TO Wvive
      ENDIF
      @ 08,69  say wvive  picture "##.#"

      STORE "Ingrese el numero de descansos normales del periodo (dias)" to mes
      do mensaje with mes
      @ 10,25 GET Wdesnor PICTURE "##.#"
      READ

      STORE "Ingrese el numero de descansos compensatorios del periodo (dias)" to mes
      do mensaje with mes
      @ 10,30 GET Wdescom PICTURE "##.#"
      READ

      STORE "Ingrese el numero de horas de sobretiempo diurno." to MES
      do mensaje with mes
      @ 11,24 GET WSTDa PICTURE "###.#"
      READ

      STORE "Ingrese el numero de horas de sobretiempo mixto." to mes
      do mensaje with mes
      @ 11,29 GET WSTMa PICTURE "###.#"
      READ

      STORE "Ingrese el numero de horas de sobretiempo nocturno." to mes
      do mensaje with mes
      @ 11,34 GET WSTNa PICTURE "###.#"
      READ

      STORE "Ingrese el numero de horas de sobretiempo diurno adicional." to mes
      do mensaje with mes
      @ 12,25 GET WSTDb PICTURE "##.#"
      READ

      STORE "Ingrese el numero de horas de sobretiempo mixto adicional." to mes
      do mensaje with mes
      @ 12,30 GET WSTMb PICTURE "##.#"
      READ

      STORE "Ingrese el numero de horas de sobretiempo nocturno adicional." to mes
      do mensaje with mes
      @ 12,35 GET WSTNb PICTURE "##.#"
      READ

      STORE "Ingrese el numero de horas de sobretiempo de guardia mixta" to mes
      do mensaje with mes
      @ 13,30 GET WSTGM PICTURE "##.#"
      READ

      STORE "Ingrese el numero de horas de sobretiempo de guardi nocturna" to mes
      do mensaje with mes
      @ 13,35 GET WSTGN PICTURE "##.#"
      READ

      STORE "Numero de horas de tiempo de viaje diurno de 1.5 Hrs." to mes
      do mensaje with mes
      @ 14,25 GET WTVDa PICTURE "##.#"
      READ

      STORE "Numero de horas de tiempo de viaje mixto de 1.5 Hrs." to mes
      do mensaje with mes
      @ 14,30 GET WTVma PICTURE "##.#"
      READ

      STORE "Numero de horas de tiempo de viaje nocturno de 1.5 Hrs." to mes
      do mensaje with mes
      @ 14,35 GET WTVna PICTURE "##.#"
      READ

      STORE "Numero de horas de tiempo de viaje diurno de + 1.5 Hrs." to mes
      do mensaje with mes
      @ 15,25 GET WTVDb PICTURE "##.#"
      READ

      STORE "Numero de horas de tiempo de viaje mixto de + 1.5 Hrs." to mes
      do mensaje with mes
      @ 15,30 GET WTVmb PICTURE "##.#"
      READ

      STORE "Numero de horas de tiempo de viaje nocturno de + 1.5 Hrs." to mes
      do mensaje with mes
      @ 15,35 GET WTVnb PICTURE "##.#"
      READ

      STORE "Numero de dias de ayuda de ciudad" to mes
      do mensaje with mes
      @ 16,25 GET Wayuciu PICTURE "##.#"
      READ

      STORE "Numero de comidas" to mes
      do mensaje with mes
      @ 16,30 GET Wcomida PICTURE "##.#"
      READ

      STORE "Ingrese el numero de bonos dominicales" to mes
      do mensaje with mes
      @ 16,35 GET Wbd PICTURE "##.#"
      read

      STORE "Bonos nocturnos: trabajados, de viaje, guardia mixta y de guardia nocturna" to mes
      do mensaje with mes
      @ 17,25 GET WBNT PICTURE "##.#"
      @ 17,30 GET WBNV PICTURE "##.#"
      @ 17,35 GET WBNGM PICTURE "##.#"
      @ 17,40 GET WBNGN PICTURE "##.#"
      READ

      STORE "Numero de reposo/comida" to mes
      do mensaje with mes
      @ 18,25 GET WrepcomD PICTURE "##.#"
      @ 18,30 GET WrepcomM PICTURE "##.#"
      @ 18,35 GET WrepcomN PICTURE "##.#"
      READ

      STORE "Ingrese el codigo y monto bonificable n.1" to mes
      do mensaje with mes
      @ 19,25 GET Wdes3
      @ 19,30 GET Wocb3 picture "######.##"
      READ

      STORE "Ingrese el codigo y monto bonificable n.2" to mes
      do mensaje with mes
      @ 20,25 GET Wdes4
      @ 20,30 GET Wocb4 picture "######.##"
      READ

      STORE "Ingrese el numero de bonos de transporte" to mes
      do mensaje with mes
      @ 07,63  get wbtran picture "##.##"
      read

      STORE "Ingrese el numero de bonos alimenticios" to mes
      do mensaje with mes
      @ 07,69  get wbalim picture "##.##"
      read

      STORE "Ingrese el numero de bonos subsidios" to mes
      do mensaje with mes
      @ 07,75  get wbsubs picture "##.##"
      read

      STORE "Indique si se va a cancelar la cesta basica MENSUAL (S/N)" to mes
      do mensaje with mes
      @ 08,63  get wflagces1
      read

      STORE "Indique si se va a cancelar la cesta basica por LIQUIDACION (S/N)" to mes
      do mensaje with mes
      @ 08,66  get wflagces2
      read

      STORE "Indique el numero de viviendas a pagar" to mes
      do mensaje with mes
      @ 08,69  get wvive  picture "##.#"
      read

      STORE "Indique si se va a pagar utilidades a este obrero temporal (S/N)" to mes
      do mensaje with mes
      @ 09,63  get wutilidad
      read

      STORE "Indique si se va a indemnizar a este obrero temporal (S/N)" to mes
      do mensaje with mes
      @ 09,69  get windemni
      read

      STORE "Ingrese el codigo y monto del otro concepto NO bonificable n.1" to mes
      do mensaje with mes
      @ 10,63  get wdesc3
      @ 10,69  get wocnb3 picture "######.##"
      read

      STORE "Ingrese el codigo y monto del otro concepto NO bonificable n.2" to mes
      do mensaje with mes
      @ 11,63  get wdesc4
      @ 11,69  get wocnb4 picture "######.##"
      read

      STORE "Ingrese el monto a descontar por concepto de prestamo" to mes
      do mensaje with mes
      @ 12,69  get wpresper picture "######.##"
      read

      STORE "Ingrese el codigo y monto de deduccion n.1" to mes
      do mensaje with mes
      @ 13,63 GET Wdescr3
      @ 13,69 GET Wod3 picture "######.##"
      READ

      STORE "Ingrese el codigo y monto de deduccion n.2" to mes
      do mensaje with mes
      @ 14,63 GET Wdescr4
      @ 14,69 GET Wod4 picture "######.##"
      READ

  *    STORE "Indique si el empleado se encuentra de reposo (SI/NO)" to mes
  *    do mensaje with mes
  *    @ 20,63 GET WREPOSO
  *    READ

      store "Seleccione (A)ceptar datos o (R)echazar" to mes
      store "A" to p1
      store "R" to p2
      store " " to resp
      do pide2 with p1,p2,mes,resp
      if resp = "R"
         SELECT 1
         CONTINUE
         loop
      endif
      replace p_diasorD with wdiasordD
      replace p_diasorM with wdiasordM
      replace p_diasorN with wdiasordN
      replace p_stda    with wstda
      replace p_stma    with wstma
      replace p_stna    with wstna
      replace p_stdb    with wstdb
      replace p_stmb    with wstmb
      replace p_stnb    with wstnb
      replace p_stgm    with wstgm
      replace p_stgn    with wstgn
      replace p_tvda    with wtvda
      replace p_tvma    with wtvma
      replace p_tvna    with wtvna
      replace p_tvdb    with wtvdb
      replace p_tvmb    with wtvmb
      replace p_tvnb    with wtvnb
      replace p_desnor  with wdesnor
      replace p_tdesleg with wtdesleg
      replace p_pdesleg with wpdesleg
      replace p_desleg  with wdesleg
      replace p_tdescon with wtdescon
      replace p_descon  with wdescon
      replace p_descom  with wdescom
      replace p_ayuciu  with wayuciu
      replace p_comida  with wcomida
      replace p_repcomD with wrepcomD
      replace p_repcomM with wrepcomM
      replace p_repcomN with wrepcomN
      replace p_ferord  with wferord
      replace p_ferpriD with wferpriD
      replace p_ferpriM with wferpriM
      replace p_ferpriN with wferpriN
      replace p_ftdnor  with wftdnor
      replace p_ftddes  with wftddes
      replace p_ftmnor  with wftmnor
      replace p_ftmdes  with wftmdes
      replace p_ftnnor  with wftnnor
      replace p_ftndes  with wftndes
      replace p_bnt     with wbnt
      replace p_bnv     with wbnv
      replace p_bngM    with wbngM
      replace p_bngN    with wbngN
      replace p_bd      with wbd
      replace p_des3    with wdes3
      replace p_ocb3    with wocb3
      replace p_des4    with wdes4
      replace p_ocb4    with wocb4

      replace p_btran    with wbtran
      replace p_balim    with wbalim
      replace p_bsubs    with wbsubs
      replace p_flagces1 with wflagces1
      replace p_flagces2 with wflagces2
      replace p_vive     with wvive
      replace p_utilidad with wutilidad
      replace p_indemni  with windemni
      replace p_desc3    with wdesc3
      replace p_ocnb3    with wocnb3
      replace p_desc4    with wdesc4
      replace p_ocnb4    with wocnb4
      replace p_presper  with wpresper
      replace p_descr3   with wdescr3
      replace p_od3      with wod3
      replace p_descr4   with wdescr4
      replace p_od4      with wod4
      replace p_reposo   with wreposo
      SELECT 1
      CONTINUE
   ENDDO
ENDDO
close data
close index
return

