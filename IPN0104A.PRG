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
   STORE "CEDULA DESEADA, F1=VER, <ENTER>=SALIR" TO MES
   DO MENSAJE WITH MES
   SET COLOR TO W+/B
   @ 5,0 CLEAR TO 21,79
   @ 5,0 TO 21,79
   @ 5,30 SAY " DATOS PERSONALES "
   @ 7,1  SAY "CEDULA:"
   @ 7,20 SAY "NOMBRES:"
   @ 7,49 SAY "APELLIDOS:"
   @ 9,1  SAY "DIRECCION..........:"
   @ 12,1 SAY "FECHA NATAL........:"
   @ 14,1 SAY "LUGAR DE NACIMIENTO:"
   @ 16,1 SAY "NACIONALIDAD.......:"
   @ 18,1 SAY "SEXO...............:"
   @ 20,1 SAY "ESTADO CIVIL.......:"
   STORE SPACE(10) TO WCEDULA
   @ 7,8 GET WCEDULA
   READ
   IF WCEDULA = SPACE(10)
      STORE 1 TO ACTLOC
      LOOP
   ENDIF
   SELECT 1
   FIND &WCEDULA
   IF EOF()
      STORE "CEDULA NO REGISTRADA, DESEA INGRESAR ? (S/N)" TO MES
      STORE " " TO RESP
      STORE "S" TO P1
      STORE "N" TO P2
      DO PIDE2 WITH P1,P2,MES,RESP
      IF RESP = "S"
         STORE SPACE(20) TO WNOMBRE
         STORE SPACE(20) TO WAPELLIDO
         STORE SPACE(20) TO WDIR1
         STORE SPACE(20) TO WDIR2
         STORE CTOD("  -  -    ") TO WNATALDATE
         STORE SPACE(15) TO WNATALCITY
         STORE SPACE(1)  TO WNACION
         STORE SPACE(1)  TO WSEXO
         STORE SPACE(1) TO WCIVILSTATE

         STORE "INGRESE EL PRIMER NOMBRE Y LA INICIAL DEL SEGUNDO" TO MES
         DO MENSAJE WITH MES
         @ 7,28 GET WNOMBRE
         READ
         STORE "INGRESE EL PRIMER APELLIDO Y LA INICIAL DEL SEGUNDO" TO MES
         DO MENSAJE WITH MES
         @ 7,59  GET WAPELLIDO
         READ
         STORE "INGRESE LA DIRECCION COMPLETA DEL EMPLEADO" TO MES
         DO MENSAJE WITH MES
         @ 09,22  GET WDIR1
         @ 10,22  GET WDIR2
         READ
         STORE "INGRESE LA FECHA DE NACIMIENTO (DD/MM/AAAA)" TO MES
         DO MENSAJE WITH MES
         @ 12,22  GET WNATALDATE
         READ
         STORE "PAIS Y CIUDAD SI ES EXTRANGERO, CIUDAD SI ES VENEZOLANO" TO MES
         DO MENSAJE WITH MES
         @ 14,22  GET WNATALCITY
         READ
         STORE .T. TO FLAG1
         STORE "INGRESE LA NACIONALIDAD DEL EMPLEADO: (V)ENEZOLANO, (E)XTRANGERO" TO MES
         DO MENSAJE WITH MES
         DO WHILE FLAG1
            @ 16,22 GET WNACION
            READ
            STORE UPPER(WNACION) TO WNACION
            IF WNACION = "V" .OR. WNACION = "E"
               STORE .F. TO FLAG1
            ENDIF
         ENDDO
         STORE "INGRESE EL SEXO DEL LA PERSONA (M/F)" TO MES
         DO MENSAJE WITH MES
         @ 18,22 GET WSEXO
         READ
         STORE .T. TO FLAG1
         STORE "INGRESE EL ESTADO CIVIL (S)OLTERO, (C)ASADO, (V)IUDO, (D)IVORCIADO" TO MES
         DO MENSAJE WITH MES
         DO WHILE FLAG1
            @ 20,22  GET WCIVILSTATE
            READ
            STORE UPPER(WCIVILSTATE) TO WCIVILSTATE
            IF WCIVILSTATE = "S" .OR. WCIVILSTATE = "C" .OR. WCIVILSTATE = "D" .OR WCIVILSTATE = "V"
               STORE .F. TO FLAG1
            ENDIF
         ENDDO

         STORE "CONFORME ? (S/N)" TO MES
         STORE " " TO RESP
         STORE "S" TO P1
         STORE "N" TO P2
         DO PIDE2 WITH P1,P2,MES,RESP
         IF RESP = "S"
            APPEND BLANK
            REPLACE CEDULA          WITH WCEDULA
            REPLACE NOMBRE          WITH WNOMBRE
            REPLACE APELLIDO        WITH WAPELLIDO
            REPLACE DIR1            WITH WDIR1
            REPLACE DIR2            WITH WDIR2
            REPLACE NACION          WITH WNACION
            REPLACE NATALCITY       WITH WNATALCITY
            REPLACE NATALDATE       WITH WNATALDATE
            REPLACE SEXO            WITH WSEXO
            REPLACE CIVILSTATE      WITH WCIVILSTATE
         ENDIF
      ELSE
         LOOP
      ENDIF
   ELSE
      STORE CEDULA          TO WCEDULA
      STORE NOMBRE          TO WNOMBRE
      STORE APELLIDO        TO WAPELLIDO
      STORE DIR1            TO WDIR1
      STORE DIR2            TO WDIR2
      STORE NACION          TO WNACION
      STORE NATALCITY       TO WNATALCITY
      STORE NATALDATE       TO WNATALDATE
      STORE SEXO            TO WSEXO
      STORE CIVILSTATE      TO WCIVILSTATE
      @ 7,28  SAY WNOMBRE
      @ 7,59  SAY WAPELLIDO
      @ 09,22 SAY WDIR1
      @ 10,22 SAY WDIR2
      @ 12,22 SAY WNATALDATE
      @ 14,22 SAY WNATALCITY
      @ 16,22 SAY WNACION
      @ 18,22 SAY WSEXO
      @ 20,22 SAY WCIVILSTATE
      STORE "OPCIONES: (M)ODIFICAR, (E)LIMINAR, (S)ALIR" TO MES
      STORE " " TO RESP
      STORE "M" TO P1
      STORE "E" TO P2
      STORE "S" TO P3
      DO PIDE3 WITH P1,P2,P3,MES,RESP
      IF RESP = "S"
         LOOP
      ENDIF
      IF RESP = "E"
         DELETE
         PACK
      ENDIF
      IF RESP = "M"
         STORE "INGRESE EL PRIMER NOMBRE Y LA INICIAL DEL SEGUNDO" TO MES
         DO MENSAJE WITH MES
         @ 7,28 GET WNOMBRE
         READ
         STORE "INGRESE EL PRIMER APELLIDO Y LA INICIAL DEL SEGUNDO" TO MES
         DO MENSAJE WITH MES
         @ 7,59  GET WAPELLIDO
         READ
         STORE "INGRESE LA DIRECCION COMPLETA DEL EMPLEADO" TO MES
         DO MENSAJE WITH MES
         @ 09,22  GET WDIR1
         @ 10,22  GET WDIR2
         READ
         STORE "INGRESE LA FECHA DE NACIMIENTO (DD/MM/AA)" TO MES
         DO MENSAJE WITH MES
         @ 12,22  GET WNATALDATE
         READ
         STORE "PAIS Y CIUDAD SI ES EXTRANGERO, CIUDAD SI ES VENEZOLANO" TO MES
         DO MENSAJE WITH MES
         @ 14,22  GET WNATALCITY
         READ
         STORE .T. TO FLAG1
         STORE "INGRESE LA NACIONALIDAD DEL EMPLEADO: (V)ENEZOLANO, (E)XTRANGERO" TO MES
         DO MENSAJE WITH MES
         DO WHILE FLAG1
            @ 16,22 GET WNACION
            READ
            STORE UPPER(WNACION) TO WNACION
            IF WNACION = "V" .OR. WNACION = "E"
               STORE .F. TO FLAG1
            ENDIF
         ENDDO
         STORE "INGRESE EL SEXO DEL LA PERSONA (M/F)" TO MES
         DO MENSAJE WITH MES
         @ 18,22 GET WSEXO
         READ
         STORE .T. TO FLAG1
         STORE "INGRESE EL ESTADO CIVIL (S)OLTERO, (C)ASADO, (V)IUDO, (D)IVORCIADO" TO MES
         DO MENSAJE WITH MES
         DO WHILE FLAG1
            @ 20,22  GET WCIVILSTATE
            READ
            STORE UPPER(WCIVILSTATE) TO WCIVILSTATE
            IF WCIVILSTATE = "S" .OR. WCIVILSTATE = "C" .OR. WCIVILSTATE = "D" .OR WCIVILSTATE = "V"
               STORE .F. TO FLAG1
            ENDIF
         ENDDO
         STORE "CONFORME ? (S/N)" TO MES
         STORE " " TO RESP
         STORE "S" TO P1
         STORE "N" TO P2
         DO PIDE2 WITH P1,P2,MES,RESP
         IF RESP = "S"
            REPLACE CEDULA          WITH WCEDULA
            REPLACE NOMBRE          WITH WNOMBRE
            REPLACE APELLIDO        WITH WAPELLIDO
            REPLACE DIR1            WITH WDIR1
            REPLACE DIR2            WITH WDIR2
            REPLACE NACION          WITH WNACION
            REPLACE NATALCITY       WITH WNATALCITY
            REPLACE NATALDATE       WITH WNATALDATE
            REPLACE SEXO            WITH WSEXO
            REPLACE CIVILSTATE      WITH WCIVILSTATE
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
