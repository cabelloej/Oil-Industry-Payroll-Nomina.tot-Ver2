store "APERTURA DE NOMINAS" TO HEADING
set color to W+/B
@ 5,0 to 21,79 double
@ 5,40-(LEN(HEADING)/2) SAY HEADING
@ 6,1 clear to 20,78
store .t. to aperturas
do while aperturas
   STORE .T. TO VALIDA
   DO WHILE VALIDA
      STore "CODIGO DE NOMINA DESEADA" to mess
      do mensaje with mess
      @ 5,0 CLEAR TO 20,79
      @ 5,0 TO 20,79 DOUBLE
      @ 5,40-(LEN(HEADING)/2) SAY HEADING
      store space(5) to wcodnom
      @ 8,5 SAY  "CODIGO         :" GET WCODNOM
      @ 10,5 SAY "DESCRIPCION    :                                    "
      @ 12,5 SAY "ULTIMA APERTURA:                                    "
      @ 14,5 SAY "NUEVO PERIODO  :                                    "
      READ
      STORE UPPER(WCODNOM) TO WCODNOM
      IF WCODNOM = SPACE(5)
         CLOSE DATA
         CLOSE INDEX
         RETURN
      ENDIF
      SELECT 1
      USE IPNOMINA INDEX IPNOMINA ALIAS NOMINA
      FIND &WCODNOM
      IF EOF()
         STORE "NOMINA NO REGISTRADA" TO MES
         DO AVISO WITH MES
         LOOP
      ENDIF
      @ 10,5 SAY "DESCRIPCION    :"+DESNOM
      STORE "ES ESTA LA NOMINA QUE DESEA ABRIR ? (S/N)" TO MES
      STORE " " TO RESP
      STORE "S" TO P1
      STORE "N" TO P2
      DO PIDE2 WITH P1,P2,MES,RESP
      IF RESP = "N"
         LOOP
      ELSE
         STORE .F. TO VALIDA
      ENDIF
   ENDDO

   STORE FACTCOD TO WFACTOR
   SELECT 2
   USE IPNFACTOR INDEX IPNFACTOR ALIAS TABLA
   FIND &WFACTOR
   IF EOF()
      STORE "ERROR, TABLA DE FACTORES DE ESTA NOMINA NO ESTA REGISTRADA" TO MES
      DO AVISO WITH MESS
      LOOP
   ENDIF

   SELECT 1
   IF ESTADO <> 0
      STORE "ATENCION: Esta nomina no ha sido cerrada, Ingrese clave:" to mess
      do mensaje with mess
      store "     " to wwx
      set color to b/b
      set intensity off
      @ 23,70 get wwx
      read
      set intensity on
      set color to w+/b
      if upper(wwx) <> "IPNOK"
         loop
      endif
   endif
   @ 12,5 SAY "ULTIMA APERTURA:"+" DEL "+DTOC(LAST1)+" AL "+DTOC(LAST2)
   STORE LAST2 +1 TO WAPE1
   STORE LAST2 + TABLA->F_DIAS+TABLA->F_DESNOR TO WAPE2
   @ 14,5 SAY "NUEVO PERIODO  : DEL            AL          "
   store .t. to wlapso
   do while wlapso
      @ 14,26 GET WAPE1
      @ 14,40 GET WAPE2
      READ
      store wape2-wape1 to wdifer
      if wdifer > (tabla->f_dias+tabla->f_desnor)
         store "ADVERTENCIA: El nuevo periodo no se ajusta a los parametros de la nomina" to mess
         do aviso with mess
         else
         store .f. to wlapso
      endif
   enddo

   store "Opciones: (T)ODO EL PERSONAL, (S)ELECTIVA" to mes
   store "T" to p1
   store "S" to p2
   store " " to resp
   do pide2 with p1,p2,mes,resp
   if resp = "T"
      store 0 to pick
   else
      store 1 to pick
   endif

   STORE "OPCIONES: (C)ONTINUAR, (S)ALIR" TO MES
   STORE "C" TO P1
   STORE "S" TO P2
   STORE " " TO RESP
   DO PIDE2 WITH P1,P2,MES,RESP
   if resp = "S"
      LOOP
   ENDIF
   STORE 0 TO LIQUIDADOS
   STORE "EFECTUANDO APERTURA, FAVOR ESPERAR..." TO MES
   DO MENSAJE WITH MES
   @ 5,0 CLEAR TO 20,79
   @ 5,0 TO 20,79 DOUBLE
   @ 5,6  SAY "LISTADO DE PERSONAL CON CONTRATO VENCIDO AL PROXIMO PERIODO DE PAGO"
   @ 6,5 SAY "CEDULA"
   @ 6,20 SAY "NOMBRE"
   @ 6,60 SAY "FIN DE CONTRATO"

   STORE 0 TO HOLYCONT
   STORE 0 TO NOLABOR
   STORE 0 TO FINFERIA
   STORE CTOD("  -  -    ") TO WWWFER1
   STORE CTOD("  -  -    ") TO WWWFER2
   SELECT 3
   USE IPNHOLLY
   DO WHILE .NOT. EOF()
      STORE DAY(FECHA) TO DF
      STORE MONTH(FECHA) TO MF
      store 0 to vez
      do while vez < (tabla->f_dias+tabla->f_desnor)
         store wape1+vez to wapetest
         STORE DAY(WAPETEST) TO WD1
         STORE MONTH(WAPETEST) TO WM1
         STORE YEAR(WAPETEST) TO WY1
         if df=wd1 .and. mf=wm1
            store holycont+1 to holycont
            if dow(wapetest) > 1 .AND. dow(wapetest) < 7
               store nolabor + 1 to nolabor
               IF NOLABOR = 1
                  STORE STR(WD1,2)+"-"+STR(WM1,2)+"-"+STR(WY1,4) TO SUBWWW
                  STORE CTOD(SUBWWW) TO WWWFER1
               ELSE
                  IF NOLABOR = 2
                     STORE STR(WD1,2)+"-"+STR(WM1,2)+"-"+STR(WY1,4) TO SUBWWW
                     STORE CTOD(SUBWWW) TO WWWFER2
                  ENDIF
               ENDIF
            else
               store finferia + 1 to finferia
            endif
         endif
         store vez+1 to vez
      enddo
      skip
   enddo
   *@ 12,12 say "numero de dias feriados :"+str(holycont)
   *@ 13,12 say "dias de trabajo feriados:"+str(nolabor)
   *@ 14,12 say "fin de semana feriado   :"+str(finferia)
   *WAIT
   select 3
   use ipnperso alias personal
   SELECT 4
   USE IPNPROCO INDEX IPNPROCO ALIAS PROCESO
   DELETE ALL FOR P_NOMINA = WCODNOM
   PACK

   SELECT 3
   STORE 6 TO LINE
   locate for NOMINA = WCODNOM
   DO WHILE .NOT. EOF()
      IF FINCONTRA <> CTOD("  -  -    ") .AND. (FINCONTRA >= WAPE1 .AND.;
         FINCONTRA <= WAPE2+TABLA->F_DIAS+TABLA->F_DESNOR)
         STORE LINE+1 TO LINE
         STORE LIQUIDADOS + 1 TO LIQUIDADOS
         IF LINE > 20
            STORE "OPRIMA CUALQUIER TECLA PARA CONTINUAR CON EL LISTADO" TO MES
            DO AVISO WITH MES
            @ 7,1 CLEAR TO 19,78
            STORE "EFECTUANDO APERTURA, FAVOR ESPERAR..." TO MES
            DO MENSAJE WITH MES
            STORE 7 TO LINE
         ENDIF
         @ LINE,1 SAY CEDULA
         @ LINE,20 SAY RTRIM(NOMBRE)+" "+APELLIDO
         @ LINE,60 SAY DTOC(FINCONTRA)
      ENDIF
      if pick = 1
         store  "DESEA LIQUIDAR A "+rtrim(personal->nombre)+" "+rtrim(personal->apellido)+" ? (S/N)" to mes
         store "S" to p1
         store "N" to p2
         store " " to resp
         do pide2 with p1,p2,mes,resp
         if resp = "N" .OR. RESP = "n"
            select 3
            continue
            loop
         endif
         store  "CANCELAR CESTA BASICA A "+rtrim(personal->nombre)+" "+rtrim(personal->apellido)+" ? (S/N)" to mes
         store "S" to p1
         store "N" to p2
         store " " to resp
         do pide2 with p1,p2,mes,resp
         if resp = "S" .OR. RESP = "s"
            store "S" TO WFLAGCES2
         ELSE
            STORE " " TO WFLAGCES2
         endif
      else
         STORE " " TO WFLAGCES2
      endif

      SELECT 4
      IF PERSONAL->INGRESO > WAPE1
         IF PERSONAL->INGRESO > WAPE2
            STORE "En la cedula "+personal->cedula+" no se ajusta ingreso con periodo de nomina" to mes
            do aviso with mes
            STORE "Esta cedula no sera incluida en la nomina" to mes
            do aviso with mes
            skip
            loop
         endif
         store personal->ingreso - WAPE1 To wtime
      else
         store 0 to wtime
      endif

      STORE TABLA->F_DIAS - NOLABOR TO WF_DIAS
      STORE WF_DIAS       - WTIME   TO WF_DIAS

      if substr(personal->tipo,1,1) = "O" .and. WF_DIAS < 3
         store 0 to wdesnor
      else
         store TABLA->F_DESNOR to wdesnor
      endif

      STORE 0 TO WNOFER
      IF WWWFER1 <> CTOD("  -  -    ") .AND. PERSONAL->INGRESO > WWWFER1
         STORE WNOFER+1 TO WNOFER
      ENDIF
      IF WWWFER2 <> CTOD("  -  -    ") .AND. PERSONAL->INGRESO > WWWFER2
        STORE WNOFER+1 TO WNOFER
      ENDIF
      APPEND BLANK
      REPLACE P_NOMINA WITH NOMINA->CODNOM
      REPLACE P_CEDULA WITH PERSONAL->CEDULA

      IF PERSONAL->TIPO = "OT"
         REPLACE P_UTILIDAD      WITH "S"
         REPLACE P_INDEMNI       WITH "S"
         SELECT 3
         CONTINUE
         LOOP
      ENDIF

      IF PERSONAL->TURNO = "G" .OR. (PERSONAL->TV1>0 .OR. PERSONAL->TV2>0 .OR. PERSONAL->TV3>0)
         STORE WF_DIAS+NOLABOR TO WAYUDA
      ELSE
         STORE WF_DIAS+NOLABOR TO WAYUDA
      ENDIF
      STORE 0 TO WWEXAMEN
      IF (PERSONAL->INGRESO >=WAPE1 .AND. PERSONAL->INGRESO <= WAPE2) .AND. (PERSONAL->CONTRATO = "PETROLERO" .OR. PERSONAL->CONTRATO = "PEQUIVEN")
         STORE PERSONAL->SUELDO+PERSONAL->BONOCO TO WWEXAMEN
      ENDIF
      STORE PERSONAL->CP TO WCP
      IF PERSONAL->CP > PERSONAL->MP
         STORE PERSONAL->MP TO WCP
      ENDIF

      STORE " " TO WFLAGCES1
      IF (TABLA->F_CESTA > 0 .AND. UPPER(PERSONAL->CESTA) = "S") .AND. (MONTH(WAPE2) <> MONTH(WAPE2+(TABLA->F_DIAS+TABLA->F_DESNOR)))
         STORE "S" TO WFLAGCES1
      ENDIF

      STORE WF_DIAS+WDESNOR+NOLABOR TO WVIVE
      REPLACE P_DIASORD       WITH WF_DIAS
      REPLACE P_DESNOR        WITH WDESNOR
      REPLACE P_PDESLEG       WITH "S"
      REPLACE P_AYUCIU        WITH WAYUDA
      REPLACE P_FERORD        WITH HOLYCONT - WNOFER
      REPLACE P_FLAGCES2      WITH WFLAGCES2
      REPLACE P_FLAGCES1      WITH WFLAGCES1
      IF PERSONAL->CONTRATO="CONSTRUCCION"
         REPLACE P_TVDA       WITH (PERSONAL->TV1*(P_DIASORD+P_DIASORM+P_DIASORN))-PERSONAL->TV1
         REPLACE P_TVMA       WITH (PERSONAL->TV2*(P_DIASORD+P_DIASORM+P_DIASORN))-PERSONAL->TV2
         REPLACE P_TVNA       WITH (PERSONAL->TV3*(P_DIASORD+P_DIASORM+P_DIASORN))-PERSONAL->TV3
         REPLACE P_COMIDA     WITH (PERSONAL->COMIDAS*(P_DIASORD+P_DIASORM+P_DIASORN))-PERSONAL->COMIDAS
         REPLACE P_BTRAN      WITH WF_DIAS-1
         REPLACE P_BALIM      WITH WF_DIAS-1
         REPLACE P_BSUBS      WITH WF_DIAS-1
         REPLACE P_STDA       WITH (PERSONAL->ST1*(P_DIASORD+P_DIASORM+P_DIASORN))-PERSONAL->ST1
         REPLACE P_STMA       WITH (PERSONAL->ST2*(P_DIASORD+P_DIASORM+P_DIASORN))-PERSONAL->ST2
         REPLACE P_STNA       WITH (PERSONAL->ST3*(P_DIASORD+P_DIASORM+P_DIASORN))-PERSONAL->ST3
      ELSE
         REPLACE P_TVDA       WITH PERSONAL->TV1*(P_DIASORD+P_DIASORM+P_DIASORN)
         REPLACE P_TVMA       WITH PERSONAL->TV2*(P_DIASORD+P_DIASORM+P_DIASORN)
         REPLACE P_TVNA       WITH PERSONAL->TV3*(P_DIASORD+P_DIASORM+P_DIASORN)
         REPLACE P_COMIDA     WITH PERSONAL->COMIDAS*(P_DIASORD+P_DIASORM+P_DIASORN)
         REPLACE P_BTRAN      WITH WF_DIAS
         REPLACE P_BALIM      WITH WF_DIAS
         REPLACE P_BSUBS      WITH WF_DIAS
         REPLACE P_STDA       WITH PERSONAL->ST1*(P_DIASORD+P_DIASORM+P_DIASORN)
         REPLACE P_STMA       WITH PERSONAL->ST2*(P_DIASORD+P_DIASORM+P_DIASORN)
         REPLACE P_STNA       WITH PERSONAL->ST3*(P_DIASORD+P_DIASORM+P_DIASORN)
      ENDIF
      REPLACE P_VIVE          WITH WVIVE
      IF WWEXAMEN > 0
         REPLACE P_OCNB3      WITH WWEXAMEN
         REPLACE P_DESC3      WITH "EMP"
      ENDIF
      REPLACE P_PRESPER       WITH WCP
      REPLACE P_DES3          WITH PERSONAL->CB
      REPLACE P_OCB3          WITH PERSONAL->MB
      REPLACE P_DESC4         WITH PERSONAL->CNB
      REPLACE P_OCNB4         WITH PERSONAL->MNB
      REPLACE P_DESCR3        WITH PERSONAL->CD
      REPLACE P_OD3           WITH PERSONAL->MD
      SELECT 3
      CONTINUE
   ENDDO
   SELECT 1
   REPLACE ESTADO WITH 1
   REPLACE LAST1 WITH APERT1
   REPLACE LAST2 WITH APERT2
   REPLACE APERT1 WITH WAPE1
   REPLACE APERT2 WITH WAPE2
   REPLACE FERTOT WITH HOLYCONT
   REPLACE FERORD WITH NOLABOR
   REPLACE FEREXT WITH FINFERIA
   if pick = 1
      store "Recuerde liquidar al personal seleccionado antes de reabrir esta nomina" to mes
      do aviso with mes
      store "Si desea abandonar la operacion, debe abrir la nomina sin efectuar el cierre" to mes
      do aviso with mes
   endif
   IF LIQUIDADOS > 0
      STORE "OPRIMA CUALQUIER TECLA PARA CONTINUAR" TO MES
      DO AVISO WITH MES
   ENDIF
enddo

