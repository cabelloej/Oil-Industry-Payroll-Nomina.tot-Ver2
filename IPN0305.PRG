*********************************************
*     informe AL I.N.C.E.                   *
*********************************************
select 1 
use ipnhisto INDEX IPNHISTO, IPNHIST2
select 2
use ipnperso index ipnperso
SELECT 3
USE IPNINCE
store ctod("  -  -    ") to fec1
store ctod("  -  -    ") to fec2
store space(5)           to wnomina
set color to w+/B
@ 5,1 clear to 10,50
@ 5,1 to 10,50 double
@ 5,10  say "APORTE AL I.N.C.E."
@ 6,3 SAY "NOMINA         :" GET WNOMINA
@ 7,3 SAY "FECHA INICIAL  :" GET FEC1
@ 8,3 SAY "FECHA FINAL    :" GET FEC2
READ
IF FEC1 >= FEC2
   CLOSE DATA
   CLOSE INDEX
   RETURN
ENDIF
STORE "Opciones :  (C)ontinuar, (R)echazar" to mes
store "C" to p1
store "R" to p2
store " " to resp
do pide2 with p1,p2,mes,resp
if resp = "R"
   close data
   close index
   return
endif
store "Procesando informacion, favor esperar" to mes
do mensaje with mes
select 1
copy stru to ipntemp9
select 1
use ipntemp9
index on cedula to ipntemp9
Append from ipnhisto for FECHA >=FEC1 .AND. FECHA <= FEC2 .AND.; 
       NOMINA <> "UTLDA" .AND. NOMINA <> "LIQUI" 
SET DEVI TO PRINT
STORE 0 TO TOTAL1
STORE 0 TO TOTAL2
STORE 1 TO PAGINA
STORE 100 TO WLINE
SELECT 1
GO TOP
store "0000000000" to wrupced
DO WHILE .NOT. EOF()
   IF WNOMINA<>SPACE(5).AND.WNOMINA<>NOMINA
      SELECT 1
      SKIP
      LOOP
   ENDIF
   store cedula to wcedula
   SELECT 2
   FIND &WCEDULA
   IF .NOT. EOF()
      IF INCE <> "SI"
         SELECT 1
         SKIP
         LOOP
      ENDIF
   ENDIF
   *** CONTROL DE RUPTURA POR PERSONA
   IF WCEDULA <> WRUPCED
      select 2
      find &wcedula
      if eof()
         STORE "NO REG. EN MAESTRO" to  wnombre
      else
         STORE RTRIM(NOMBRE)+" "+APELLIDO TO WNOMBRE
      endif
      *** IMPRIMIR ENCABEZADO DE PERSONA
      STORE WLINE + 1 TO WLINE
      DO SALTAPAT
      @ WLINE,2 SAY CEDULA
      @ WLINE,14 SAY WNOMBRE
   ENDIF
   STORE WCEDULA TO WRUPCED
   ***
   SELECT 1
   STORE WLINE + 1 TO WLINE
   DO SALTAPAT
   @ WLINE,53 SAY DTOC(FECHA)
   @ WLINE,66 SAY BSTOTBON PICTURE "##,###,###.##"
   STORE BSTOTBON + TOTAL1 TO TOTAL1
   skip
ENDDO
STORE WLINE + 1 TO WLINE
@ WLINE,0 SAY REPLICATE("-",80)
***
STORE WLINE + 2 TO WLINE
@ WLINE,0 SAY "TOTAL BONIFICABLE DEL PERSONAL:"+STR(TOTAL1,12,2)
STORE TOTAL1*2/100 TO WEMPRESA
STORE WLINE + 2 TO WLINE
@ WLINE,0 SAY "TOTAL APORTE DEL LA EMPRESA   :"+STR(WEMPRESA,12,2)

STORE 100 TO WLINE
******* APORTE DEL PERSONAL ****************
SELECT 3
GO TOP
LOCATE FOR FECHA >=FEC1 .AND. FECHA <= FEC2
DO WHILE .NOT. EOF()
   STORE CEDULA TO WCEDULA
   SELECT 2
   FIND &WCEDULA
   IF EOF()
      STORE "NO REGISTRADO EN MAESTRO" TO WNOMBRE
   ELSE
      STORE RTRIM(NOMBRE)+" "+APELLIDO TO WNOMBRE
   ENDIF
   STORE .F. TO WFLAGEX
   IF WNOMINA<>SPACE(5)
      IF NOMINA<>SPACE(5)
         IF NOMINA<>WNOMINA
            STORE .T. TO WFLAGEX
         ENDIF
      ELSE
         IF EXNOMINA<>SPACE(5)
            IF EXNOMINA<>WNOMINA
               STORE .T. TO WFLAGEX
            ENDIF
         ENDIF
      ENDIF
   ENDIF
   IF WFLAGEX
      SELECT 3
      CONTINUE
      LOOP
   ENDIF
   SELECT 3
   STORE WLINE + 1 TO WLINE
   DO SALTAEMP
   @ WLINE,2 SAY CEDULA
   @ WLINE,14 SAY WNOMBRE
   @ WLINE,50 SAY DTOC(FECHA)
   @ WLINE,63 SAY MONTO PICTURE "##,###,###.##"
   STORE MONTO + TOTAL2 TO TOTAL2
   CONTINUE
ENDDO
STORE WLINE + 1 TO WLINE
@ WLINE,0 SAY REPLICATE("-",80)
STORE WLINE + 1 TO WLINE
@ WLINE,1   SAY "TOTAL DESCUENTO DE UTILIDADES       :"+STR(TOTAL2,12,2)
@ WLINE+2,1 SAY "TOTAL EMPRESA + APORTE DE UTILIDADES:"+STR((WEMPRESA+TOTAL2),12,2)
CLOSE DATA
CLOSE INDEX
delete file ipntemp9.dbf
delete file ipntemp9.IDX
SET DEVI TO SCRE
EJECT
RETURN

*****************
PROC SALTAPAT
*****************
      IF WLINE > 50
         STORE PAGINA + 1 TO PAGINA
         @ 0,0 SAY CHR(18)
         @ 1,40-(LEN(QQWW)/2)-5 SAY CHR(14)+QQWW+CHR(18)
         @ 2,0 SAY "NOMINA: "+WNOMINA
         @ 4,2 SAY "APORTE AL I.N.C.E. DEL "+DTOC(FEC1)+" AL "+DTOC(FEC2)
         @ 4,60 SAY "PAGINA:"+STR(PAGINA,4)
         @ 5,2 SAY "APORTE DE LA EMPRESA"
         @ 5,60 SAY "FECHA :"+DTOC(WFECACT)
         @ 7,2 SAY "CEDULA"
         @ 7,14 SAY "NOMBRE COMPLETO"
         @ 7,53 SAY "FECHA DE PAGO"
         @ 7,74 SAY "MONTO"
         @ 8,0 SAY REPLICATE("-",80)
         STORE 9 TO WLINE
      ENDIF
RETURN
*****************
PROC SALTAEMP
*****************
   IF WLINE > 50
      STORE PAGINA + 1 TO PAGINA
      @ 0,0 SAY CHR(18)
      @ 1,40-(LEN(QQWW)/2)-5 SAY CHR(14)+QQWW+CHR(18)
      @ 2,2 SAY  "APORTE AL I.N.C.E. DEL "+DTOC(FEC1)+" AL "+DTOC(FEC2)
      @ 2,60 SAY "PAGINA:"+STR(PAGINA,4)
      @ 3,0 SAY  "NOMINA: "+WNOMINA 
      @ 3,60 SAY "FECHA :"+DTOC(WFECACT)
      @ 3,2 SAY  "APORTE DEL PERSONAL "
      @ 5,2 SAY  "CEDULA"
      @ 5,14 SAY "NOMBRE COMPLETO"
      @ 5,50 SAY "FECHA UTILIDAD"
      @ 5,70 SAY "DESCUENTO"
      @ 6,0 SAY REPLICATE("-",80)
      STORE 7 TO WLINE
   ENDIF
RETURN

