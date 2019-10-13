*********************************************
*          informe de deposito habitacional *
*********************************************
select 1 
use ipnhisto
select 2
use ipnperso index ipnperso ALIAS PERSONAL
SELECT 8
USE IPNFACTO INDEX IPNFACTO ALIAS FACTORES
SELECT 9
USE IPNOMINA INDEX IPNOMINA ALIAS NOMINA

store ctod("  -  -    ") to fec1
store ctod("  -  -    ") to fec2
set color to w/n
@ 5,1 clear to 10,50
@ 5,1 to 10,50 double
@ 5,2  say "AHORRO HABITACIONAL INDIVIDUAL DETALLADO"
@ 7,3 SAY "FECHA INICIAL  :" GET FEC1
@ 8,3 SAY "FECHA FINAL    :" GET FEC2
@ 9,3 SAY "CEDULA         :"
READ
IF FEC1 >= FEC2
   CLOSE DATA
   CLOSE INDEX
   RETURN
ENDIF

STORE "Ingrese la cedula a reportar :" to mes
store space(10) to wcodnom
@ 9,20 get wcodnom
read
if wcodnom = space(10)
   close data
   close index
   return
endif
select 2
find &wcodnom
if eof()
   store "Cedula no registrada" to mes
   do aviso with mes
   close data
   close index
   return
endif
store rtrim(apellido)+" "+nombre to wdesnom
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
index on cedula+STR(YEAR(FECHA))+STR(MONTH(FECHA))+STR(DAY(FECHA)) to ipntemp9
Append from ipnhisto for FECHA >=FEC1 .AND. FECHA <= FEC2 .AND. cedula = wcodnom

SET DEVI TO PRINT
STORE 0 TO TOTAL1
STORE 0 TO TOTAL2
STORE 1 TO PAGINA
store " "  TO TITULO1
STORE "AHORRO HABITACIONAL INDIVIDUAL (DETALLADO)" TO TITULO2
@ 0,0 SAY CHR(18)
@ 0,40-(LEN(TITULO1)/2) SAY TITULO1
@ 0,80 SAY "FECHA :"+DTOC(WFECACT)
@ 1,40-(LEN(TITULO2)/2) SAY TITULO2
@ 1,80 SAY "PAGINA:"+STR(PAGINA,4)
@ 3,1 SAY "EMPLEADOR: "+RTRIM(QQWW)+"   CODIGO :"+QQWWCODAH+"  No. DE  R.I.F. : "+QQWWRIF
@ 4,1 SAY "CEDULA:"+WCODNOM+" "+WDESNOM+" -- DEL "+DTOC(FEC1)+" AL "+DTOC(FEC2)
@ 5,0 SAY "+-------+-------+----------------------------------------+---+------------+----------+----+----------+----------+----------+"
@ 6,0 SAY "|       |       |           APELLIDOS Y NOMBRES          |NAC|  CEDULA    |FECHA PAGO|SEXO|    1%    |    2%    |    3%    |"
@ 7,0 SAY "+-------+-------+----------------------------------------+---+------------+----------+----+----------+----------+----------+"
STORE 7 TO LINE
SELECT 1
GO TOP
STORE CEDULA TO RUPTURA
DO WHILE .NOT. EOF()
   STORE 0 TO DATA
   STORE CEDULA TO WCEDULA
   select 2
   find &wcedula
   if eof()
      STORE "******" TO WNACION
      STORE "*"  TO WSEXO
      STORE CTOD("  -  -    ")  TO WNATAL
      STORE "NO REGISTRADO EN MAESTRO" TO WNOMBRE
      STORE SPACE(5) TO QQQ
   ELSE
      STORE NACION TO WNACION
      STORE SEXO TO WSEXO
      STORE NATALDATE  TO WNATAL
      STORE RTRIM(PERSONAL->NOMBRE)+" "+PERSONAL->APELLIDO TO WNOMBRE
      STORE PERSONAL->NOMINA TO QQQ
   ENDIF
   if qqq = space(5)
      store personal->exnomina to qqq
   endif
   if qqq = space(5)
      store "La cedula "+personal->cedula+" de "+rtrim(personal->nombre)+" "+rtrim(personal->apellido)+" no sera incluido" to mes
      set devi to scre
      do aviso with mes
      set devi to print
      SELECT 1
      skip
      loop
   endif
   SELECT 9
   FIND &QQQ
   IF EOF()
      STORE "ERROR "+PERSONAL->CEDULA+" CON NOMINA NO REGISTRADA" TO MES
      set devi to scre
      DO AVISO WITH MES
      set devi to print
      select 1
      skip
      LOOP
   ENDIF
   STORE NOMINA->FACTCOD TO EEE
   SELECT 8
   FIND &EEE
   IF EOF()
      STORE "ERROR NOMINA"+QQQ+" CON FACTORES NO REGISTRADOS" TO MES
      set devi to scre
      DO AVISO WITH MES
      set devi to print
      select 1
      skip
      LOOP
   ENDIF
   SELECT 1
   DO WHILE .NOT. EOF() .and. cedula = wcedula
      IF LINE > 55
         STORE PAGINA + 1 TO PAGINA
         @ 0,0 SAY CHR(18)
         @ 0,40-(LEN(TITULO1)/2) SAY TITULO1
         @ 0,80 SAY "FECHA :"+DTOC(WFECACT)
         @ 1,40-(LEN(TITULO2)/2) SAY TITULO2
         @ 1,80 SAY "PAGINA:"+STR(PAGINA,4)
         @ 3,1 SAY "EMPLEADOR: "+RTRIM(QQWW)+"   CODIGO :"+QQWWCODAH+"  No. DE  R.I.F. : "+QQWWRIF
         @ 4,1 SAY "CEDULA:"+WCODNOM+" "+WDESNOM+" -- DEL "+DTOC(FEC1)+" AL "+DTOC(FEC2)
         @ 5,0 SAY "+-------+-------+----------------------------------------+---+------------+----------+----+----------+----------+----------+"
         @ 6,0 SAY "|       |       |           APELLIDOS Y NOMBRES          |NAC|  CEDULA    |FECHA PAGO|SEXO|    1%    |    2%    |    3%    |"
         @ 7,0 SAY "+-------+-------+----------------------------------------+---+------------+----------+----+----------+----------+----------+"
         STORE 7 TO LINE
      ENDIF
      STORE SPACE(15) TO WQUEFUE
      STORE 0 TO VAMOS

      IF (PERSONAL->INGRESO >= FEC1 .AND. PERSONAL->INGRESO <=FEC2)
         STORE 1 TO VAMOS
         STORE "*******" TO WQUEFUE
      ENDIF
      IF (personal->flagah >= FEC1 .AND. personal->flagah <=FEC2)
         STORE 1 TO VAMOS
         STORE "        *******" TO WQUEFUE
      ENDIF
      STORE (PERSONAL->SUELDO+PERSONAL->BONOCO) TO BBB
      STORE LINE+1 TO LINE
      IF LINE >60
         STORE PAGINA + 1 TO PAGINA
         @ 0,0 SAY CHR(18)
         @ 0,40-(LEN(TITULO1)/2) SAY TITULO1
         @ 0,80 SAY "FECHA :"+DTOC(WFECACT)
         @ 1,40-(LEN(TITULO2)/2) SAY TITULO2
         @ 1,80 SAY "PAGINA:"+STR(PAGINA,4)
         @ 3,1 SAY "EMPLEADOR: "+RTRIM(QQWW)+"   CODIGO :"+QQWWCODAH+"  No. DE  R.I.F. : "+QQWWRIF
         @ 4,1 SAY "CEDULA:"+WCODNOM+" "+WDESNOM+" -- DEL "+DTOC(FEC1)+" AL "+DTOC(FEC2)
         @ 5,0 SAY "+-------+-------+----------------------------------------+---+------------+----------+----+----------+----------+----------+"
         @ 6,0 SAY "|       |       |           APELLIDOS Y NOMBRES          |NAC|  CEDULA    |FECHA PAGO|SEXO|    1%    |    2%    |    3%    |"
         @ 7,0 SAY "+-------+-------+----------------------------------------+---+------------+----------+----+----------+----------+----------+"
         STORE 7 TO LINE
      ENDIF
      @ LINE,0 SAY "|       |       |                                        |   |            |          |    |          |          |          |"
      IF DATA = 0
         @ LINE,1 SAY WQUEFUE
         @ LINE,17 SAY WNOMBRE
         @ LINE,59 SAY WNACION
         @ LINE,62 SAY WCEDULA
      ENDIF
      @ LINE,75 SAY DTOC(FECHA)
      IF DATA = 0
         @ LINE,86 SAY WSEXO
      ENDIF
      @ LINE,90 SAY BSAHRHAB PICTURE "###,###.##"
      STORE BSAHRHAB + TOTAL1 TO TOTAL1
      STORE BSAHRHAB + TOTAL2 TO TOTAL2
      STORE 1 TO DATA
      SELECT 1
      skip
   ENDDO
   STORE TOTAL2*2 TO WEMPRESA2
      STORE LINE +1 TO LINE
      @ LINE,0 SAY "|       |       |                                        |   |            |          |    |          |          |          |"
      @ LINE,17 SAY "T O T A L E S :"
      @ LINE,90  SAY TOTAL2 PICTURE "###,###.##"
      @ LINE,101 SAY WEMPRESA2 PICTURE "###,###.##"
      @ LINE,112 SAY TOTAL2+WEMPRESA2 PICTURE "###,###.##"
      STORE LINE+1 TO LINE
      @ LINE,0 SAY "+-------+-------+----------------------------------------+---+------------+----------+----+----------+----------+----------+"
   STORE 0 TO TOTAL2
   SELECT 1
ENDDO
   STORE LINE + 2 TO LINE
   IF LINE >60
      STORE PAGINA + 1 TO PAGINA
      @ 0,0 SAY CHR(18)
      @ 0,40-(LEN(TITULO1)/2) SAY TITULO1
      @ 0,80 SAY "FECHA :"+DTOC(WFECACT)
      @ 1,40-(LEN(TITULO2)/2) SAY TITULO2
      @ 1,80 SAY "PAGINA:"+STR(PAGINA,4)
      @ 3,1 SAY "EMPLEADOR: "+RTRIM(QQWW)+"   CODIGO :"+QQWWCODAH+"  No. DE  R.I.F. : "+QQWWRIF
      @ 4,1 SAY "CEDULA:"+WCODNOM+" "+WDESNOM+" -- DEL "+DTOC(FEC1)+" AL "+DTOC(FEC2)
      @ 5,0 SAY "+-------+-------+----------------------------------------+---+------------+----------+----+----------+----------+----------+"
      @ 6,0 SAY "|       |       |           APELLIDOS Y NOMBRES          |NAC|  CEDULA    |FECHA PAGO|SEXO|    1%    |    2%    |    3%    |"
      @ 7,0 SAY "+-------+-------+----------------------------------------+---+------------+----------+----+----------+----------+----------+"
      STORE 7 TO LINE
   ENDIF
   @ LINE,70 SAY "T O T A L E S :"
   @ LINE,90  SAY TOTAL1 PICTURE "###,###.##"
   STORE TOTAL1*2 TO WEMPRESA
   @ LINE,101 SAY WEMPRESA PICTURE "###,###.##"
   @ LINE,112 SAY WEMPRESA+TOTAL1 PICTURE "###,###.##"
   CLOSE DATA
   CLOSE INDEX
   delete file ipntemp9.dbf
SET DEVI TO SCRE
EJECT
RETURN


