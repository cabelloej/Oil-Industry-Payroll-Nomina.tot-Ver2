*************************************************************************
*                     Actualizador de archivo de empleados              *
*************************************************************************
SELECT 1
USE IPNPERSO INDEX IPNPERSO
SELECT 3
USE IPNCARGO INDEX IPNCARGO
SELECT 1
STORE 0 TO ACTLOC
DO WHILE ACTLOC = 0
   STORE "CEDULA A PROCESAR, F1=VER, <ENTER>=SALIR" TO MES
   DO MENSAJE WITH MES
   SET COLOR TO W+/B
   @ 5,0 CLEAR TO 21,79
   *@ 5,0 TO 21,79
   @ 5,34 SAY "DATOS LABORALES"
   @ 06,1 SAY "CEDULA:"
   @ 07,1 SAY "FECHA DE INGRESO:                  Nro.CUENTA :"
   @ 08,1 SAY "FIN DE CONTRATO :                  TIPO CUENTA:"
   @ 09,1 SAY "NOMINA          :"
   @ 10,1 SAY "TIPO            :"
   @ 11,1 SAY "TURNO           :"
   @ 12,1 SAY "CONTRATO        :"
   @ 13,1 SAY "CARGO           :"
   @ 14,1 SAY "BASICO          :"
   @ 15,1 SAY "BONO COMPENSAT. :"
   @ 16,1 SAY "BONO TRANSPORTE :"
   @ 17,1 SAY "BONO ALIMENTO   :"
   @ 18,1 SAY "BONO SUBSIDIO   :"
   @ 19,1 SAY "CESTA BASICA    :"
   @ 20,1 SAY "NUMERO EN BOTAS :"
   @ 21,1 SAY "APORTE AL INCE ?:"
   STORE SPACE(10) TO WCEDULA
   @ 6,8 GET WCEDULA
   READ
   IF WCEDULA = SPACE(10)
      STORE 1 TO ACTLOC
      LOOP
   ENDIF
   SELECT 1
   FIND &WCEDULA
   IF EOF()
      STORE "CEDULA NO REGISTRADA, FAVOR INGRESAR" TO MES
      DO AVISO WITH MES
      LOOP
   ELSE
      STORE INGRESO         TO WINGRESO
      STORE FINCONTRA       TO WFINCONTRA
      STORE NOMINA          TO WNOMINA
      STORE TIPO            TO WTIPO
      STORE TURNO           TO WTURNO
      STORE CONTRATO        TO WCONTRATO
      STORE CARGO           TO WCARGO
      STORE SUELDO          TO WSUELDO
      STORE BONOCO          TO WBONOCO
      STORE BT              TO WBT
      STORE BA              TO WBA
      STORE BS              TO WBS
      STORE CESTA           TO WCESTA
      STORE BOTAS           TO WBOTAS
      STORE INCE            TO WINCE
      STORE NUMECUEN        TO WNUMECUEN
      STORE TIPOCUEN        TO WTIPOCUEN
      IF WCARGO <> SPACE(6)
         SELECT 3
         FIND &WCARGO
         IF EOF()
            STORE "NO REGISTRADO" TO WCARGODES
         ELSE
            STORE DESCRI TO WCARGODES
         ENDIF
      ELSE
         STORE "NO INGRESADO" TO WCARGODES
      ENDIF
      SELECT 1
      @ 06,20 SAY RTRIM(NOMBRE)+" "+APELLIDO
      @ 07,18 SAY WINGRESO
      @ 07,50 SAY WNUMECUEN
      @ 08,18 SAY WFINCONTRA
      @ 08,50 SAY WTIPOCUEN
      @ 09,18 SAY WNOMINA
      @ 10,18 SAY WTIPO
      @ 11,18 SAY WTURNO
      @ 12,18 SAY WCONTRATO
      @ 13,18 SAY WCARGO
      @ 13,30 SAY WCARGODES
      @ 14,18 SAY WSUELDO PICTURE "99999.99"
      @ 15,18 SAY WBONOCO PICTURE "9999.99"
      @ 16,18 SAY WBT     PICTURE "9999.99"
      @ 17,18 SAY WBA     PICTURE "9999.99"
      @ 18,18 SAY WBS     PICTURE "9999.99"
      @ 19,18 SAY WCESTA
      @ 20,18 SAY WBOTAS
      @ 21,18 SAY WINCE

      STORE "OPCIONES: (M)ODIFICAR, (S)ALIR" TO MES
      STORE " " TO RESP
      STORE "M" TO P1
      STORE "S" TO P2
      DO PIDE2 WITH P1,P2,MES,RESP
      IF RESP = "S"
         LOOP
      ENDIF
      IF RESP = "M"
         STORE "FECHA DE INGRESO A LA EMPRESA (DD/MM/AAAA)" TO MES
         DO MENSAJE WITH MES
         @ 7,18  GET WINGRESO
         READ
         STORE "NUMERO DE CUENTA BANCARIA PARA DEPOSITAR EL PAGO" TO MES
         DO MENSAJE WITH MES
         @ 7,50  GET WNUMECUEN
         READ
         STORE "INGRESE LA FECHA DE TERMINACION DEL CONTRATO CON LA EMPRESA" TO MES
         DO MENSAJE WITH MES
         @ 8,18 GET WFINCONTRA
         READ
         STORE "INGRESE LA TIPO DE CUENTA" TO MES
         DO MENSAJE WITH MES
         @ 8,50 GET WTIPOCUEN
         READ
         SELECT 2
         USE IPNOMINA INDEX IPNOMINA
         STORE .T. TO FLAG1
         STORE "INGRESE EL CODIGO DE LA NOMINA RESPECTIVA " TO MES
         DO MENSAJE WITH MES
         DO WHILE FLAG1
            @ 9,18  GET WNOMINA
            READ
            IF WNOMINA = SPACE(5)
               STORE .F. TO FLAG1
               LOOP
            ENDIF
            STORE UPPER(WNOMINA) TO WNOMINA
            FIND &WNOMINA
            IF .NOT. EOF()
               STORE .F. TO FLAG1
            ENDIF
         ENDDO
         SELECT 1
         STORE .T. TO FLAG1
         STORE "TIPO DE PERSONAL: (E)MPLEADO, (OF)=OBRERO FIJO, (OT)=OBRERO TEMPORAL" TO MES
         DO MENSAJE WITH MES
         DO WHILE FLAG1
            @ 10,18 GET WTIPO
            READ
            STORE UPPER(WTIPO) TO WTIPO
            IF WTIPO = "E" .OR. WTIPO = "OF" .OR. WTIPO = "OT"
               STORE .F. TO FLAG1
            ENDIF
         ENDDO
         STORE .T. TO FLAG2
         STORE "TURNO DE PERSONAL: (R)=REGULAR, (G)=GUARDIA" TO MES
         DO MENSAJE WITH MES
         DO WHILE FLAG2
            @ 11,18 GET WTURNO
            READ
            STORE UPPER(WTURNO) TO WTURNO
            IF WTURNO = "R" .OR. WTURNO = "G"
               STORE .F. TO FLAG2
            ENDIF
         ENDDO
         STORE "INGRESE EL CONTRATO A LA CUAL PERTENECE" TO MES
         DO MENSAJE WITH MES
         @ 12,18 GET WCONTRATO
         READ
         STORE .T. TO WVERCAR
         STORE WCARGO TO WLASTCARGO
         SELECT 3
         DO WHILE WVERCAR
            STORE "INGRESE EL CARGO DE VA A DESEMPE¥AR EL REPORTADO" TO MES
            DO MENSAJE WITH MES
            @ 13,18 GET WCARGO
            READ
            IF WCARGO = SPACE(10)
               STORE .F. TO WVERCAR
               LOOP
            ELSE
               IF WCARGO <> WLASTCARGO
                  FIND &WCARGO
                  IF EOF()
                     STORE "CARGO NO REGISTRADO EN MAESTRO DE CARGOS" TO MES
                     DO AVISO WITH MES
                     LOOP
                  ELSE
                     STORE SUELDO TO WSUELDO
                     STORE BONOCO TO WBONOCO
                     STORE DESCRI TO WCARGODES
                     @ 13,30 SAY WCARGODES
                  ENDIF
               ENDIF
            ENDIF
            STORE .F. TO WVERCAR
         ENDDO
         SELECT 1
         STORE "INGRESE EL SUELDO BASICO DIARIO DEL REPORTADO" TO MES
         DO MENSAJE WITH MES
         store wsueldo to qazsueldo
         @ 14,18 GET WSUELDO PICTURE "99999.99"
         READ
         STORE "INGRESE EL MONTO DIARIO DEL BONO COMPENSATORIO" TO MES
         DO MENSAJE WITH MES
         store wBONOCO to qaz90
         @ 15,18 GET WBONOCO PICTURE "9999.99"
         READ
         STORE "INDIQUE EL MONTO DIARIO POR BONO DE TRANSPORTE" TO MES
         DO MENSAJE WITH MES
         @ 16,18 GET WBT PICTURE "9999.99"
         READ
         STORE "INDIQUE EL MONTO DIARIO POR BONO ALIMENTICIO" TO MES
         DO MENSAJE WITH MES
         @ 17,18  GET WBA PICTURE "9999.99"
         READ
         STORE "INDIQUE EL MONTO DIARIO POR BONO SUBSIDIO" TO MES
         DO MENSAJE WITH MES
         @ 18,18  GET WBS PICTURE "9999.99"
         READ
         STORE "INDIQUE SI ESTA PERSONA RECIBE CESTA BASICA (S/N)" TO MES
         DO MENSAJE WITH MES
         @ 19,18 GET WCESTA
         READ
         STORE "INGRESE EL NUMERO EN BOTAS" TO MES
         DO MENSAJE WITH MES
         @ 20,18  GET WBOTAS
         READ
         STORE "INDIQUE SI LA EMPRESA APORTA AL INCE POR EL EMPLEADO (SI/NO)" TO MES
         DO MENSAJE WITH MES
         @ 21,18 GET WINCE
         READ

         STORE "CONFORME ? (S/N)" TO MES
         STORE " " TO RESP
         STORE "S" TO P1
         STORE "N" TO P2
         DO PIDE2 WITH P1,P2,MES,RESP
         IF RESP = "S"
            REPLACE INGRESO         WITH WINGRESO
            REPLACE FINCONTRA       WITH WFINCONTRA
            REPLACE NOMINA          WITH WNOMINA
            REPLACE TIPO            WITH WTIPO
            REPLACE TURNO           WITH WTURNO
            REPLACE CONTRATO        WITH WCONTRATO
            REPLACE CARGO           WITH WCARGO
            REPLACE SUELDO          WITH WSUELDO
            REPLACE BONOCO          WITH WBONOCO
            REPLACE BT              WITH WBT
            REPLACE BA              WITH WBA
            REPLACE BS              WITH WBS
            REPLACE INCE            WITH WINCE
            REPLACE BOTAS           WITH WBOTAS
            REPLACE CESTA           WITH WCESTA
            REPLACE NUMECUEN        WITH WNUMECUEN
            REPLACE TIPOCUEN        WITH WTIPOCUEN
            if qazsueldo <> wsueldo .or. wBONOCO <> qaz90
               store "Atencion: Ud. vario el sueldo. Desea registrarlo en informe A.H.? (S/N)" to mes
               store "S" to p1
               store "N" to p2
               store " " to resp
               do pide2 with p1,p2,mes,resp
               if resp = "S"
                  store "Indique a partir de que fecha vario el sueldo" to mes
                  do mensaje with mes
                  store ctod("  -  -    ") to qazdate
                  @ 23,70 get qazdate
                  read
                  replace flagah with qazdate
               endif
            endif
         ENDIF
      ELSE
         LOOP
      ENDIF
   ENDIF
ENDDO
CLOSE DATA
CLOSE INDEX
SET COLOR TO
RETURN

