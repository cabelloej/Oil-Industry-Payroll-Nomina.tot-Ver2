*********************************************
*          informe de UTILIDADES            *
*********************************************
use ipnhisto
COPY STRU TO IPNTEMP9
SELECT 1
USE IPNTEMP9
APPEND FROM IPNHISTO FOR NOMINA = "UTLDA"

select 2
use ipnperso index ipnperso ALIAS PERSONAL
REPLACE ALL STATREMU WITH " "
REPLACE ALL STATRETE WITH " "


store ctod("  -  -    ") to fec1
store ctod("  -  -    ") to fec2
STORE SPACE(2) TO WTIPO
set color to w/n
@ 5,1 clear to 10,50
@ 5,1 to 10,50 double
@ 5,10 say "PAGO DE UTILIDADES"
@ 7,3 SAY "FECHA INICIAL  :" GET FEC1
@ 8,3 SAY "FECHA FINAL    :" GET FEC2
@ 9,3 say "TIPO DE NOMINA :"
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

IF RESP = "O"
   STORE "O B R E R O S" TO DEFINE
ELSE
   STORE "E M P L E A D O S" TO DEFINE
ENDIF

SET DEVI TO PRINT
STORE 0 TO TOTAL1
STORE 0 TO TOTAL2
STORE 1 TO PAGINA
STORE QQWW TO HEAD
@ 0,0 SAY CHR(18)
@ 1,40-(LEN(HEAD)/2)-5 SAY CHR(14)+HEAD+CHR(18)
@ 4,2 SAY "UTILIDADES PAGADAS DEL "+DTOC(FEC1)+" AL "+DTOC(FEC2)
@ 4,60 SAY "PAGINA:"+STR(PAGINA,4)
@ 5,2 SAY DEFINE
@ 5,60 SAY "FECHA :"+DTOC(WFECACT)
@ 7,2 SAY "CEDULA"
@ 7,14 SAY "NOMBRE COMPLETO"
@ 7,57 SAY "FECHA DE PAGO"
@ 7,78 SAY "MONTO "
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
   LOCATE FOR FECHA >=FEC1 .AND. FECHA <= FEC2 .AND. CEDULA = PERSONAL->CEDULA .AND. NOMINA = "UTLDA"
   IF .NOT. FOUND()
      SELECT 2
      SKIP
      LOOP
   ENDIF
   DO WHILE .NOT. EOF()
      STORE PERSONAL->CEDULA TO WCEDULA
      STORE RTRIM(PERSONAL->NOMBRE)+" "+PERSONAL->APELLIDO TO WNOMBRE

      STORE LINE + 1 TO LINE
      IF LINE > 55
         STORE PAGINA + 1 TO PAGINA
         STORE QQWW TO HEAD
         @ 0,0 SAY CHR(18)
         @ 1,40-(LEN(HEAD)/2) SAY CHR(14)+HEAD+CHR(18)
         @ 4,2 SAY "UTILIDADES PAGADAS DEL "+DTOC(FEC1)+" AL "+DTOC(FEC2)
         @ 4,60 SAY "PAGINA:"+STR(PAGINA,4)
         @ 5,2 SAY DEFINE
         @ 5,60 SAY "FECHA :"+DTOC(WFECACT)
         @ 6,0 SAY "CEDULA"
         @ 6,12 SAY "NOMBRE COMPLETO"
         @ 6,57 SAY "FECHA DE PAGO"
         @ 6,78 SAY "MONTO "
         STORE 8 TO LINE
      ENDIF
      @ LINE,2 SAY CEDULA
      @ LINE,14 SAY WNOMBRE
      @ LINE,57 SAY DTOC(FECHA)
      @ LINE,70 SAY BSTOTBON PICTURE "##,###,###.##"
      STORE BSTOTBON + TOTAL1 TO TOTAL1
      STORE BSTOTBON + TOTAL2 TO TOTAL2
      SELECT 1
      CONTINUE
   ENDDO
   STORE LINE +1 TO LINE
   @ LINE,14 SAY "TOTAL PAGADO"
   @ LINE,90 SAY TOTAL2 PICTURE "##,###,###.##"
   STORE "----------" TO D
   STORE D+D+D+D+D+D+D+D+D+D+D+D TO D
   STORE LINE+1 TO LINE
   @ LINE,1 SAY D
   STORE 0 TO TOTAL2
   STORE LINE+1 TO LINE
   SELECT 2
   SKIP
ENDDO
   STORE LINE + 2 TO LINE
   IF LINE >60
      STORE PAGINA + 1 TO PAGINA
      STORE QQWW TO HEAD
      @ 0,0 SAY CHR(18)
      @ 1,40-(LEN(HEAD)/2) SAY CHR(14)+HEAD+CHR(18)
      @ 4,2 SAY "UTILIDADES PAGADAS DEL "+DTOC(FEC1)+" AL "+DTOC(FEC2)
      @ 4,60 SAY "PAGINA:"+STR(PAGINA,4)
      @ 5,2 SAY DEFINE
      @ 5,60 SAY "FECHA :"+DTOC(WFECACT)
      @ 6,0 SAY "CEDULA"
      @ 6,12 SAY "NOMBRE COMPLETO"
      @ 6,57 SAY "FECHA DE PAGO"
      @ 6,70 SAY "MONTO "
      STORE 8 TO LINE
   ENDIF
   @ LINE,40 SAY "TOTAL PAGADO AL PERSONAL    "
   @ LINE,70 SAY TOTAL1 PICTURE "##,###,###.##"
   CLOSE DATA
   CLOSE INDEX
   DELETE FILE IPNTEMP9.DBF
SET DEVI TO SCRE
EJECT
RETURN




