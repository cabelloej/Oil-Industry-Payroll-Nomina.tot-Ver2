**********************************************************************
*              Actualizador de fecha actual del sistema              *
**********************************************************************
SELECT 9
USE ipndate
STORE "INGRESE LA FECHA ACTUAL" TO MES
DO MENSAJE WITH MES
SET COLOR TO W+/B
STORE 05 TO LINE
STORE 00 TO COL
@ LINE,COL CLEAR TO LINE+4,COL+48
@ LINE,COL TO LINE+4,COL+47 DOUBLE
@ LINE,COL+13 SAY "FECHA DEL SISTEMA"
@ LINE+2,COL+1 SAY "FECHA      :"
@ LINE+2,COL+13 GET FECHASIST
READ
STORE FECHASIST TO WFECACT
CLOSE DATA
CLOSE INDEX
SET COLOR TO
RETURN
