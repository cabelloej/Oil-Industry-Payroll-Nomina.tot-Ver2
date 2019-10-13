*********************************************
*          informe de ret. islr             *
*********************************************
select 1 
use ipnhisto
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
@ 5,10 say "RETENCION I.S.L.R."
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

select 1
copy stru to ipntemp9
select 1
use ipntemp9
Append from ipnhisto for FECHA >=FEC1 .AND. FECHA <= FEC2
go bott

SET DEVI TO PRINT
STORE 0 TO TOTAL1
STORE 0 TO TOTAL2
STORE 1 TO PAGINA
@ 0,0 SAY CHR(18)
@ 1,40-(LEN(QQWW)/2)-5 SAY CHR(14)+QQWW+CHR(18)
@ 4,2 SAY "RETENCION I.S.L.R. DEL "+DTOC(FEC1)+" AL "+DTOC(FEC2)
@ 4,60 SAY "PAGINA:"+STR(PAGINA,4)
@ 5,2 SAY DEFINE
@ 5,60 SAY "FECHA :"+DTOC(WFECACT)
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
   LOCATE FOR FECHA >=FEC1 .AND. FECHA <= FEC2 .AND. CEDULA = PERSONAL->CEDULA
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
         @ 0,0 SAY CHR(18)
         @ 1,40-(LEN(QQWW)/2) SAY CHR(14)+QQWW+CHR(18)
         @ 4,2 SAY "RETENCION I.S.L.R. DEL "+DTOC(FEC1)+" AL "+DTOC(FEC2)
         @ 4,60 SAY "PAGINA:"+STR(PAGINA,4)
         @ 5,2 SAY DEFINE
         @ 5,60 SAY "FECHA :"+DTOC(WFECACT)
         @ 6,0 SAY "CEDULA"
         @ 6,12 SAY "NOMBRE COMPLETO"
         @ 6,57 SAY "FECHA DE PAGO"
         @ 6,78 SAY "MONTO RET."
         STORE 8 TO LINE
      ENDIF
      @ LINE,2 SAY CEDULA
      @ LINE,14 SAY WNOMBRE
      @ LINE,57 SAY DTOC(FECHA)
      @ LINE,70 SAY BSISLR PICTURE "##,###,###.##"
      STORE BSISLR + TOTAL1 TO TOTAL1
      STORE BSISLR + TOTAL2 TO TOTAL2
      SELECT 1
      CONTINUE
   ENDDO
   STORE LINE +1 TO LINE
   @ LINE,14 SAY "TOTAL RETENIDO"
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
      @ 0,0 SAY CHR(18)
      @ 1,40-(LEN(QQWW)/2) SAY CHR(14)+QQWW+CHR(18)
      @ 4,2 SAY "RETENCION I.S.L.R. DEL "+DTOC(FEC1)+" AL "+DTOC(FEC2)
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


   set devi to scree
   STORE "Procesando totales, favor esperar..." to mes
   do mensaje with mes
   set devi to print
   SELECT 1
   GO TOP
   LOCATE FOR FECHA >=FEC1 .AND. FECHA <= FEC2
   STORE 0 TO TT1
   STORE 0 TO TT2
   STORE 0 TO TT3
   STORE 0 TO TT4
   STORE 0 TO TT5
   STORE 0 TO TT6
   DO WHILE .NOT. EOF()

      store cedula to wwced
      select 2
      find &wwced
      if eof()
         store "Error, cedula "+WWCED+" en historico no registrada en personal" TO MES
         do aviso with mes
         loop
         select 1
         continue
         LOOP
      endif

      IF RESP <> SUBSTR(TIPO,1,1)
         SELECT 1
         CONTINUE
         LOOP
      ENDIF

      SELECT 1
      if bstotbon+bstotnbon > 0
         store "S" to wstatremu
      else
         store " " to wstatremu
      endif

      if bsislr > 0
         store "S" to wstatrete
      else
         store " " to wstatrete
      endif

      *** remuneraciones pagadas durante el periodo ****
      store bstotbon+bstotnbon+tt1 to tt1

      *** remuneraciones sujetas a retencion ***
      if bsislr > 0
         store bstotbon+bstotnbon+tt2 to tt2
      endif

      *** total de islr a enterar ***
      store bsislr+tt3 to tt3

      if wstatremu = "S"
         replace PERSONAL->statremu with wstatremu
      endif
      if wstatrete = "S"
         replace PERSONAL->statrete with wstatrete
      endif
      SELECT 1
      CONTINUE
   ENDDO
   select 2
   go top
   do while .not. eof()
      IF RESP <> SUBSTR(TIPO,1,1)
         SKIP
         LOOP
      ENDIF

      if statremu = "S"
         store tt4+1 to tt4
      endif
      if statrete = "S"
         store tt5+1 to tt5
      endif
      if islr > 0 .and. statremu = "S"
         store tt6+1 to tt6
      endif
      skip
   enddo
   eject

   @ 0,0 SAY CHR(18)
   @ 1,40-(LEN(QQWW)/2)-5 SAY CHR(14)+QQWW+CHR(18)
   @ 4,2 SAY "RETENCION I.S.L.R. DEL "+DTOC(FEC1)+" AL "+DTOC(FEC2)
   @ 4,60 SAY "PAGINA:"+STR(PAGINA,4)
   @ 5,2 SAY DEFINE
   @ 5,60 SAY "FECHA :"+DTOC(WFECACT)
   @ 7,10 say "T O T A L E S"

   @ 10,5 say "TOTAL NUMERO DE PERSONAS QUE PERCIBIERON REMUNERACION :"
   @ 10,70 SAY TT4 PICTURE "######"
   @ 12,5 SAY "TOTAL NUMERO DE PERSONAS SUJETAS A RETENCION:"
   @ 12,70 SAY TT6 PICTURE "######"
   @ 14,5 SAY "TOTAL NUMERO DE PERSONAS CON IMPUESTO RETENIDO:"
   @ 14,70 SAY TT5 PICTURE "######"
   @ 16,5 say "TOTAL REMUNERACIONES PAGADAS O ABONADAS:"
   @ 16,70 SAY TT1 PICTURE "###,###,###.##"
   @ 18,5 SAY "TOTAL REMUNERACIONES SUJETAS A RETENCION :"
   @ 18,70 SAY TT2 PICTURE "###,###,###.##"
   CLOSE DATA
   CLOSE INDEX
   DELETE FILE IPNTEMP9.DBF
SET DEVI TO SCRE
EJECT
RETURN

