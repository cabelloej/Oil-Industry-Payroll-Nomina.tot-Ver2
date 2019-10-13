*********************************************
*          informe de deposito habitacional *
*********************************************
select 1 
use ipnhisto INDEX IPNHISTO, IPNHIST2
select 2
use ipnperso index ipnperso
store ctod("  -  -    ") to fec1
store ctod("  -  -    ") to fec2
set color to w/n
@ 5,1 clear to 10,50
@ 5,1 to 10,50 double
@ 5,10  say "AHORRO HABITACIONAL (LISTADO DETALLADO)"
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
Append from ipnhisto for FECHA >=FEC1 .AND. FECHA <= FEC2 .AND. NOMINA <> "UTLDA" .AND. NOMINA <> "LIQUI"
SET DEVI TO PRINT
STORE 0 TO TOTAL1
STORE 0 TO TOTAL2
STORE 1 TO PAGINA
STORE 100 TO WLINE
store "LISTADO RESUMIDO" TO TITULO1
STORE "AHORRO HABITACIONAL" TO TITULO2
SELECT 1
GO TOP
store "0000000000" to wrupced
STORE 0 TO VAMOS
DO WHILE .NOT. EOF()
   store cedula to wcedula
   *** CONTROL DE RUPTURA POR PERSONA
   IF WCEDULA <> WRUPCED
      IF VAMOS=1
         *** IMPRIME TOTALES PARA LA PERSONA
         STORE WLINE + 1 TO WLINE
         @ WLINE,0 SAY "|       |       |                                        |   |            |          |    |          |          |          |"
         @ WLINE,17 SAY "T O T A L E S :"
         @ WLINE,90  SAY TOTAL2   PICTURE "###,###.##"
         @ WLINE,101 SAY TOTAL2*2 PICTURE "###,###.##"
         @ WLINE,112 SAY TOTAL2*3 PICTURE "###,###.##"
         STORE WLINE + 1 TO WLINE
         @ WLINE,0 SAY "+-------+-------+----------------------------------------+---+------------+----------+----+----------+----------+----------+"
         STORE 0 TO TOTAL2
         ***
      ENDIF
      ***
      select 2
      find &wcedula
      if eof()
         STORE space(1) to  wnacion,sexo,wnombre,qqq
         store ctod("  -  -    ") to wnatal,wingreso,wflagah
      else
         STORE NACION    TO WNACION
         STORE SEXO      TO WSEXO
         STORE NATALDATE TO WNATAL
         STORE RTRIM(NOMBRE)+" "+APELLIDO TO WNOMBRE
         STORE INGRESO   TO WINGRESO
         STORE FLAGAH    TO WFLAGAH
         STORE NOMINA    TO QQQ
      endif
      STORE SPACE(15) TO WQUEFUE
      *STORE 0 TO VAMOS
      STORE 1 TO VAMOS
      IF (WINGRESO >= FEC1 .AND. WINGRESO <=FEC2)
         *STORE 1 TO VAMOS
         STORE "*******" TO WQUEFUE
      ENDIF
      IF (Wflagah >= FEC1 .AND. Wflagah <=FEC2)
         *STORE 1 TO VAMOS
         STORE "        *******" TO WQUEFUE
      ENDIF
      IF VAMOS = 1
         *** IMPRIMIR ENCABEZADO DE PERSONA
         STORE WLINE + 1 TO WLINE
         IF WLINE >= 55
            STORE PAGINA + 1 TO PAGINA
            @ 0,0 SAY CHR(18)
            @ 0,40-(LEN(TITULO1)/2) SAY TITULO1
            @ 0,80 SAY "FECHA :"+DTOC(WFECACT)
            @ 1,40-(LEN(TITULO2)/2) SAY TITULO2
            @ 1,80 SAY "PAGINA:"+STR(PAGINA,4)
            @ 3,1 SAY "EMPLEADOR: "+RTRIM(QQWW)+"   CODIGO :"+QQWWCODAH+"  No. DE  R.I.F. : "+QQWWRIF
            @ 4,1 SAY "DEL "+DTOC(FEC1)+" AL "+DTOC(FEC2)
            @ 5,0 SAY "+-------+-------+----------------------------------------+---+------------+----------+----+----------+----------+----------+"
            @ 6,0 SAY "|INCORP.|VARIAC.|           APELLIDOS Y NOMBRES          |NAC|  CEDULA    |FECHA PAGO|SEXO|    1%    |    2%    |    3%    |"
            @ 7,0 SAY "+-------+-------+----------------------------------------+---+------------+----------+----+----------+----------+----------+"
            STORE 8 TO WLINE
         ENDIF
         @ WLINE,0 SAY "|       |       |                                        |   |            |          |    |          |          |          |"
         @ WLINE,1 SAY WQUEFUE
         @ WLINE,17 SAY WNOMBRE
         @ WLINE,59 SAY WNACION
         @ WLINE,62 SAY WCEDULA
         *@ WLINE,75 SAY WNATAL
         @ WLINE,86 SAY WSEXO
      ENDIF
      STORE WCEDULA TO WRUPCED
   ENDIF
   ***
   STORE WLINE + 1 TO WLINE
   IF WLINE >= 55
      STORE PAGINA + 1 TO PAGINA
      @ 0,0 SAY CHR(18)
      @ 0,40-(LEN(TITULO1)/2) SAY TITULO1
      @ 0,80 SAY "FECHA :"+DTOC(WFECACT)
      @ 1,40-(LEN(TITULO2)/2) SAY TITULO2
      @ 1,80 SAY "PAGINA:"+STR(PAGINA,4)
      @ 3,1 SAY "EMPLEADOR: "+RTRIM(QQWW)+"   CODIGO :"+QQWWCODAH+"  No. DE  R.I.F. : "+QQWWRIF
      @ 4,1 SAY "DEL "+DTOC(FEC1)+" AL "+DTOC(FEC2)
      @ 5,0 SAY "+-------+-------+----------------------------------------+---+------------+----------+----+----------+----------+----------+"
      @ 6,0 SAY "|INCORP.|VARIAC.|           APELLIDOS Y NOMBRES          |NAC|  CEDULA    |FECHA PAGO|SEXO|    1%    |    2%    |    3%    |"
      @ 7,0 SAY "+-------+-------+----------------------------------------+---+------------+----------+----+----------+----------+----------+"
      STORE 8 TO WLINE
   ENDIF
   SELECT 1
   @ WLINE,0 SAY "|       |       |                                        |   |            |          |    |          |          |          |"
   @ WLINE,75 SAY FECHA
   @ WLINE,90  SAY BSAHRHAB   PICTURE "###,###.##"
   @ WLINE,101 SAY BSAHRHAB*2 PICTURE "###,###.##"
   @ WLINE,112 SAY BSAHRHAB*3 PICTURE "###,###.##"
   STORE BSAHRHAB + TOTAL1 TO TOTAL1
   STORE BSAHRHAB + TOTAL2 TO TOTAL2
   skip
ENDDO
IF VAMOS=1
   *** IMPRIME TOTALES PARA LA PERSONA
   STORE WLINE + 1 TO WLINE
   @ WLINE,0 SAY "|       |       |                                        |   |            |          |    |          |          |          |"
   @ WLINE,17 SAY "T O T A L E S :"
   @ WLINE,90  SAY TOTAL2   PICTURE "###,###.##"
   @ WLINE,101 SAY TOTAL2*2 PICTURE "###,###.##"
   @ WLINE,112 SAY TOTAL2*3 PICTURE "###,###.##"
   STORE WLINE + 1 TO WLINE
   @ WLINE,0 SAY "+-------+-------+----------------------------------------+---+------------+----------+----+----------+----------+----------+"
   STORE 0 TO TOTAL2
   ***
ENDIF
STORE WLINE + 1 TO WLINE
@ WLINE,17 SAY "T O T A L    G E N E R A L :"
@ WLINE,90  SAY TOTAL1   PICTURE "###,###.##"
@ WLINE,101 SAY TOTAL1*2 PICTURE "###,###.##"
@ WLINE,112 SAY TOTAL1*3 PICTURE "###,###.##"
CLOSE DATA
CLOSE INDEX
delete file ipntemp9.dbf
delete file ipntemp9.IDX
SET DEVI TO SCRE
EJECT
RETURN

