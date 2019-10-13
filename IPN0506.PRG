*********************************************
*          informe de ret. IVSS             *
*********************************************
select 1 
use ipnhisto
select 2
use ipnperso index ipnperso ALIAS PERSONAL
select 3
use ipnomina index ipnomina

store ctod("  -  -    ") to fec1
store ctod("  -  -    ") to fec2
set color to w+/B
@ 05,1 clear to 12,50
@ 05,1 to 12,50 double
@ 05,10 say "RETENCION I.V.S.S."
@ 07,3 SAY "FECHA INICIAL  :" GET FEC1
@ 08,3 SAY "FECHA FINAL    :" GET FEC2
@ 09,3 SAY "TIPO DE NOMINA :"
@ 10,3 SAY "CODIGO NOMINA  :"
READ
IF FEC1 >= FEC2
   CLOSE DATA
   CLOSE INDEX
   RETURN
ENDIF

STORE "Ingrese el tipo de Nomina a reportar : (O)breros, (E)mpleados" to mes
store "O" to p1
store "E" to p2
store " " to resp
do pide2 with p1,p2,mes,resp
store resp to wtiponom

STORE SPACE(5) TO WCODNOM
@ 10,20 GET WCODNOM
READ
select 3
seek wcodnom
if .not. found()
   store "Nomina no registrada, verifique" to aviso
   do aviso with mes
   close data
   close index
   return
endif

IF WTIPONOM = "O"
   STORE "O B R E R O S  NOMINA: "+WCODNOM+" "+IPNOMINA->DESNOM TO DEFINE
ELSE
   STORE "E M P L E A D O S  NOMINA: "+WCODNOM+" "+IPNOMINA->DESNOM TO DEFINE
ENDIF
     
SET DEVI TO PRINT
STORE 0 TO TOTAL1
STORE 0 TO TOTAL2
STORE 1 TO PAGINA
@ 0,0 SAY CHR(15)
@ 1,40-(LEN(QQWW)/2)-5 SAY CHR(14)+QQWW
@ 4,2 SAY "RETENCION I.V.S.S. DEL "+DTOC(FEC1)+" AL "+DTOC(FEC2)
@ 4,60 SAY "PAGINA:"+STR(PAGINA,4)
@ 5,60 SAY "FECHA :"+DTOC(WFECACT)
@ 5,2 SAY DEFINE
@ 7,2 SAY "CEDULA"
@ 7,14 SAY "NOMBRE COMPLETO"
@ 7,57 SAY "FECHA DE PAGO"
@ 7,78 SAY "MONTO RET."
STORE 8 TO LINE
SELECT 2
GO TOP
DO WHILE .NOT. EOF()
   if resp <> substr(tipo,1,1)
      skip
      loop
   endif
   SELECT 1
   GO TOP
   LOCATE FOR FECHA >=FEC1 .AND. FECHA <= FEC2 .AND. NOMINA <> "UTLDA" .AND. CEDULA = PERSONAL->CEDULA .AND. NOMINA <> "LIQUI"
   IF .NOT. FOUND()
      SELECT 2
      SKIP
      LOOP
   ENDIF
   DO WHILE .NOT. EOF()
      STORE PERSONAL->CEDULA TO WCEDULA
      STORE RTRIM(PERSONAL->NOMBRE)+" "+PERSONAL->APELLIDO TO WNOMBRE
      IF NOMINA<>WCODNOM
         SELECT 1
         CONTINUE
         LOOP
      ENDIF
      STORE LINE + 1 TO LINE
      IF LINE > 55
         STORE PAGINA + 1 TO PAGINA
         *@ 0,0 SAY CHR(18)
         @ 1,40-(LEN(QQWW)/2) SAY CHR(14)+QQWW
         @ 4,2 SAY "RETENCION I.V.S.S. DEL "+DTOC(FEC1)+" AL "+DTOC(FEC2)
         @ 4,60 SAY "PAGINA:"+STR(PAGINA,4)
         @ 5,2 SAY DEFINE
         @ 5,60 SAY "FECHA :"+DTOC(WFECACT)
         @ 6,2 SAY "CEDULA"
         @ 6,12 SAY "NOMBRE COMPLETO"
         @ 6,57 SAY "FECHA DE PAGO"
         @ 6,78 SAY "MONTO RET."
         STORE 8 TO LINE
      ENDIF
      @ LINE,2 SAY CEDULA
      @ LINE,14 SAY WNOMBRE
      @ LINE,57 SAY DTOC(FECHA)
      @ LINE,70 SAY BSSSO  PICTURE "##,###,###.##"
      STORE BSSSO  + TOTAL1 TO TOTAL1
      STORE BSSSO  + TOTAL2 TO TOTAL2
      SELECT 1
      CONTINUE
   ENDDO
   IF TOTAL2>0
      STORE LINE +1 TO LINE
      @ LINE,14 SAY "TOTAL RETENIDO "
      @ LINE,90 SAY TOTAL2 PICTURE "##,###,###.##"
      STORE 0 TO TOTAL2
      STORE LINE+1 TO LINE
      STORE "----------" TO D
      STORE D+D+D+D+D+D+D+D+D+D+D+D TO DD
      @ LINE,1 SAY DD
      STORE LINE+1 TO LINE
   ENDIF

   SELECT 2
   SKIP
ENDDO
   STORE LINE + 2 TO LINE
   IF LINE >60
      STORE PAGINA + 1 TO PAGINA
      *@ 0,0 SAY CHR(18)
      @ 1,40-(LEN(QQWW)/2) SAY CHR(14)+QQWW
      @ 4,2 SAY "RETENCION I.V.S.S. DEL "+DTOC(FEC1)+" AL "+DTOC(FEC2)
      @ 4,60 SAY "PAGINA:"+STR(PAGINA,4)
      @ 5,2 SAY DEFINE
      @ 5,60 SAY "FECHA :"+DTOC(WFECACT)
      @ 6,0 SAY "CEDULA"
      @ 6,12 SAY "NOMBRE COMPLETO"
      @ 6,57 SAY "FECHA DE PAGO"
      @ 6,70 SAY "MONTO RET."
      STORE 8 TO LINE
   ENDIF
   @ LINE,40 SAY "TOTAL RETENIDO AL PERSONAL    "
   @ LINE,70 SAY TOTAL1 PICTURE "##,###,###.##"
   @ 0,0 SAY CHR(18)

   CLOSE DATA
   CLOSE INDEX
SET DEVI TO SCRE
EJECT
RETURN




