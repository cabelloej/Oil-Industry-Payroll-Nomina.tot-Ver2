STORE "OPCIONES: (C)ONTINUAR, (S)ALIR" TO MES
STORE "C" TO P1
STORE "S" TO P2
STORE " " TO RESP
DO PIDE2 WITH P1,P2,MES,RESP
IF RESP = "S"
   RETURN
ENDIF
SET DEVI TO PRINT
select 1
use ipnperso index ipnperso
store 100 to line
store 0 to PAGINA
do while .not. eof()
   if nomina = space(5) .or. botas = space(5)
      skip
      loop
   endif
   store wfecact - ingreso to wlapso
   store wlapso/90 to wtrimestres
   store (wlapso/90) - int(wlapso/90) to wdecimales
   store wdecimales*90 to wdiasaprox
   if wdiasaprox < 75
      skip
      loop
   endif
   store line + 1 to line
   if line >= 55
      STORE PAGINA + 1 TO PAGINA
      @ 1,0 say chr(14)+qqww
      @ 2,60 SAY "FECHA :"+DTOC(WFECACT)
      @ 3,0 say "ALERTA DE EQUIPOS DE SEGURIDAD"
      @ 3,60 SAY "PAGINA:"+STR(PAGINA,2)
      @ 5,0   SAY "CEDULA"
      @ 5,15  SAY "NOMBRE"
      @ 5,50  SAY "INGRESO"
      @ 5,60  SAY "NOMINA"
      @ 5,70  SAY "BOTAS"
      STORE REPLICATE("-",80) TO WSTRING
      @ 6,0 SAY WSTRING
      STORE 7 TO LINE
   ENDIF
   @ LINE,0  SAY CEDULA
   @ LINE,15  SAY RTRIM(APELLIDO)+" "+NOMBRE
   @ LINE,50  SAY INGRESO
   @ LINE,60  SAY NOMINA
   @ LINE,70  SAY BOTAS
   SKIP
enddo
IF LINE <> 100
   EJECT
ENDIF
close data
close index
SET DEVI TO SCRE
return

