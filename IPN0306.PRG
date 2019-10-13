*********************************************
*         informe de pago a sindicatos      *
*********************************************
select 1 
use ipnhisto
select 2
use ipnperso index ipnperso
select 3
use ipnsindi
store ctod("  -  -    ") to fec1
store ctod("  -  -    ") to fec2
set color to w+/B
@ 5,1 clear to 10,50
@ 5,1 to 10,50 double
@ 5,10 say "PAGO A SINDICATOS"
@ 7,3 SAY "FECHA INICIAL  :" GET FEC1
@ 8,3 SAY "FECHA FINAL    :" GET FEC2
@ 9,3 SAY "TIPO DE NOMINA :"
READ
IF FEC1 >= FEC2
   CLOSE DATA
   CLOSE INDEX
   RETURN
ENDIF
STORE "TIPO DE NOMINA A REPORTAR: (O)BREROS, (E)MPLEADOS" to mes
store "O" to p1
store "E" to p2
store " " to resp
do pide2 with p1,p2,mes,resp
STORE RESP TO WPER
IF RESP = "O"
   STORE "O B R E R O S" TO DEFINE
ELSE
   STORE "E M P L E A D O S" TO DEFINE
ENDIF
STORE "OPCIONES: (C)ONTINUAR, (S)ALIR" TO MES
STORE "C" TO P1
STORE "S" TO P2
STORE " " TO RESP
DO PIDE2 WITH P1,P2,MES,RESP
IF RESP = "S"
   CLOSE DATA
   CLOSE INDEX
   RETURN
ENDIF
select 1
copy stru to ipntemp9
select 1
use ipntemp9
Append from ipnhisto for FECHA >=FEC1 .AND. FECHA <= FEC2 .AND. NOMINA <> "LIQUI"
SET DEVI TO PRINT
STORE 0 TO PAGINA
store 100 to line
select 3
do while .not. eof()
   store contrato to wcontrato
   store definicion to wdefinicion
   STORE PORSINDI TO WPORSINDI
   STORE PORFEDER TO WPORFEDER
   STORE 0 TO WDEDUCIDO
   select 2
   GO TOP
   locate for sindicato = wcontrato
   do while .not. eof()
      if WPER <> substr(tipo,1,1)
         skip
         loop
      endif
      store cedula to wcedula
      store nombre to wnombre
      store apellido to wapellido
      select 1
      locate for cedula = wcedula .and. FECHA >=FEC1 .AND. FECHA <= FEC2 .AND. NOMINA <> "LIQUI"
      DO WHILE .NOT. EOF()
         STORE WDEDUCIDO + BSSINDIC TO WDEDUCIDO
         STORE LINE + 1 TO LINE
         IF LINE > 50
            STORE PAGINA +1  TO PAGINA
            @ 0,0 SAY CHR(18)
            @ 1,40-(LEN(qqww)/2)-5 SAY CHR(14)+qqww+CHR(18)
            @ 4,2 SAY "APORTE A SINDICATOS DEL "+DTOC(FEC1)+" AL "+DTOC(FEC2)
            @ 4,60 SAY "PAGINA:"+STR(PAGINA,4)
            @ 5,2 SAY DEFINE
            @ 5,60 SAY "FECHA :"+DTOC(WFECACT)
            @ 6,0 say chr(15)
            @ 7,2 SAY "SINDICATO"
            @ 7,26 SAY "CEDULA"
            @ 7,37 SAY "NOMBRE COMPLETO"
            @ 7,80 SAY "FECHA"
            @ 7,94 SAY "DEDUCCION"
            STORE 8 TO LINE
         ENDIF
         @ LINE,2 SAY WDEFINICION
         @ LINE,26 SAY WCEDULA
         @ LINE,37 SAY RTRIM(WNOMBRE)+" "+WAPELLIDO
         @ LINE,80 SAY DTOC(FECHA)
         @ LINE,94 SAY BSSINDIC PICTURE "#####.##"
         CONTINUE
      ENDDO
      SELECT 2
      CONTINUE
   ENDDO
   if wdeducido > 0
      STORE LINE+2 TO LINE
      @ LINE,40 SAY "TOTAL DEDUCCIONES "
      @ LINE,90 SAY WDEDUCIDO PICTURE "#######.##"

      STORE LINE+1 TO LINE
      @ LINE,40 SAY "TOTAL SINDICATO "+WDEFINICION
      @ LINE,90 SAY (WDEDUCIDO*WPORSINDI)/100 PICTURE "#######.##"

      STORE LINE+1 TO LINE
      @ LINE,40 SAY "TOTAL FEDERACION "
      @ LINE,90 SAY (WDEDUCIDO*WPORFEDER)/100 PICTURE "#######.##"
      STORE 100 TO LINE
   endif
   SELECT 3
   SKIP
ENDDO
CLOSE DATA
CLOSE INDEX
DELETE FILE IPNTEMP9.DBF
SET DEVI TO SCRE
EJECT
RETURN

