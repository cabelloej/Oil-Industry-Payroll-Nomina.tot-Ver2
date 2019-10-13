STORE 0 TO QQTOTGEN
STORE 0 TO XXDIAORD
STORE 0 TO XXDESNOR
STORE 0 TO XXDESTRA
STORE 0 TO XXPRIDOM
STORE 0 TO XXDIAFER
STORE 0 TO XXTOTDIA
STORE 0 TO XXTOTPAG
STORE 0 TO XXAYUDA
STORE 0 TO XXAYUDABS
STORE 0 TO XXVIVE
STORE 0 TO XXVIVEBS
STORE 0 TO XXHOREXT
STORE 0 TO XXHOREXTBS
STORE 0 TO XXBONNOC
STORE 0 TO XXBONNOCBS
STORE 0 TO XXHORVIA
STORE 0 TO XXHORVIABS
STORE 0 TO XXCOMIDA
STORE 0 TO XXCOMIDABS
STORE 0 TO XXUTILIDAD

STORE 0 TO QXDESNOR
STORE 0 TO QXDIANOR
STORE 0 TO QXAYUDA
STORE 0 TO QXVIVE
STORE 0 TO FLAG
select 2
use ipnperso INDEX IPNPERSO
select 4
use ipnretro
store .t. to retro
do while retro
   store date() to wdesde
   store date() to whasta
   STORE SPACE(5) TO WNOMINA
   @ 5,0 clear to 21,79
   @ 5,0 to 21,79 double
   @ 5,30 say "CALCULO DE RETROACTIVO"
   @ 6,5 SAY  "AUMENTO POR DIA  :" GET WPORDIA PICTURE "###.##"
   @ 7,5 SAY  "SOBRE TIEMPO     :" GET WEXTRA  PICTURE "###.##"
   @ 8,5 SAY  "TIEMPO DE VIAJE  :" GET WVIAJE  PICTURE "###.##"
   @ 09,5 SAY "AYUDA DE CIUDAD  :" GET WAYUDA  PICTURE "###.##"
   @ 10,5 SAY "VIVIENDA         :" GET WVIVE   PICTURE "###.##"
   @ 11,5 SAY "BONO NOCTURNO    :" GET WNOCTU  PICTURE "###.##"
   @ 12,5 SAY "COMIDAS          :" GET WCOMIDA PICTURE "###.##"
   @ 13,5 SAY "UTILIDAD         :" GET WUTIL   PICTURE "###.##"
   @ 14,5 SAY "DESDE            :" GET WDESDE
   @ 15,5 SAY "HASTA            :" GET WHASTA
   @ 16,5 SAY "DIAS. ADIC. Hrs. :" GET WDIAADD  PICTURE "###.##"
   @ 17,5 SAY "DESC. ADIC. Hrs. :" GET WDESADD  PICTURE "###.##"
   @ 18,5 SAY "AYUDA DE CIUDAD  :" GET WAYUADD  PICTURE "###.##"
   @ 19,5 SAY "VIVIENDA         :" GET QXVIVE   PICTURE "###.##"
   READ
   STORE WDIAADD TO QXDIANOR
   STORE WDESADD/8 TO QXDESNOR
   STORE WAYUADD TO QXAYUDA
   @ 20,5 SAY "NOMINA           :" GET WNOMINA
   READ
   IF WNOMINA = SPACE(5)
      CLOSE DATA
      CLOSE INDEX
      RETURN
   ENDIF
   SELECT 3
   USE IPNOMINA INDEX IPNOMINA
   FIND &WNOMINA
   IF EOF()
      STORE "NOMINA NO REGISTRADA" TO MES
      DO AVISO WITH MES
      CLOSE DATA
      CLOSE INDEX
      RETURN
   ENDIF
   @ 20,35 SAY DESNOM
   STORE "OPCIONES: (C)ONTINUAR, (S)ALIR" to mes
   store "C" to p1
   store "S" to p2
   store " " to resp
   do pide2 with p1,p2,mes,resp
   if resp = "S"
      close data
      close index
      return
   endif

   SELECT 1
   USE IPNHISTO
   COPY STRU TO IPNX
   SELECT 1
   USE IPNX
   APPEND FROM IPNHISTO FOR FECHA > WDESDE-7 .AND. FECHA <= WHASTA .AND. NOMINA = WNOMINA
   INDEX ON CEDULA TO IPNX
   SET INDEX TO IPNX

   SET DEVI TO PRINT
   @ 1,0 SAY CHR(14)+qqww
   @ 3,0 SAY "CONTRATO U ORDEN DE SERVICIO: "+IPNOMINA->CONTRATO
   @ 5,0 SAY "NOMBRE DE LA OBRA O SERVICIO: "+IPNOMINA->DESNOM
   @ 7,0 SAY "BONIFICACION UNICA Y ESPECIAL - PERIODO COMPRENDIDO DESDE "+DTOC(WDESDE-1)+ " HASTA "+DTOC(WHASTA)
   @ 09,0 SAY CHR(15)
   @ 09,0 say  "+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+"
   @ 10,0 say  "| N O M B R E                            |  DIAS  |  DESC. |  DESC. | PRIMA  |FERIADO|  TOTAL |A PAGAR  |  AYUDA CIUDAD  |   VIVIENDA     |  HORAS EXTRAS   | BONO NOCTURNO   | TIEMPO VIAJE   |     COMIDA      |UTILIDAD |  TOTAL   |"
   @ 11,0 SAY  "|----------------------------------------+TRABAJA.| NORMAL | TRABAJ.|DOMINIC.|       |No. DIAS|  Bs.    |----------------|----------------|-----------------|-----------------|----------------|-----------------|   Bs.   |   Bs.    |"
   @ 12,0 SAY  "|  CEDULA    | SALARIO |  CLASIFICACION  |        |        |        |        |       |        |         |DIAS       Bs.  |DIAS       Bs.  |Hrs.        Bs.  |Hrs.       Bs.   |Hrs.       Bs.  | No.        Bs.  |         |          |"
   @ 13,0 SAY  "|----------------------------------------|        |        |        |        |       |        |         |                |                |                 |                 |                |                 |         |          |"
   @ 14,0 SAY  "|   INGRESO  | TERMINO |                 |        |        |        |        |       |        |         |                |                |                 |                 |                |                 |         |          |"
   @ 15,0 SAY  "|----------------------------------------+        |        |        |        |       |        |         |                |                |                 |                 |                |                 |         |          |"
   @ 16,0 SAY  "|             F I R M A                  |        |        |        |        |       |        |         |                |                |                 |                 |                |                 |         |          |"
   @ 17,0 SAY  "|----------------------------------------+--------+--------+--------+--------+-------+--------+---------+----------------+----------------+-----------------+-----------------+----------------+-----------------+---------+----------+"
   STORE 17 TO LINE

   STORE QXDIANOR TO WXDIAORD
   STORE QXDESNOR TO WXDESNOR
   STORE 0 TO WXDESTRA
   STORE 0 TO WXPRIDOM
   STORE 0 TO WXDIAFER
   STORE QXAYUDA TO WXAYUDA
   STORE QXVIVE TO WXVIVE
   STORE 0 TO WXHOREXT
   STORE 0 TO WXBONNOC
   STORE 0 TO WXHORVIA
   STORE 0 TO WXCOMIDA
   SELECT 1
   GO TOP
   STORE CEDULA TO WCEDULA
   STORE BASICO TO WBASICO
   DO WHILE .NOT. EOF()
      IF CEDULA <> WCEDULA
         SELECT 2
         FIND &WCEDULA
         IF EOF()
            SET DEVI TO SCRE
            STORE "ERRORRRRRRR, CEDULA: "+WCEDULA+" NO REGISTRADA EN MAESTRO DE PERSONAL" TO MES
            DO AVISO WITH MES
            CLOSE DATA
            CLOSE INDEX
            RETURN
         ENDIF
         STORE RTRIM(NOMBRE)+" "+RTRIM(APELLIDO) TO WNOMBRE
         STORE CARGO TO WCARGO
*        IF INGRESO <> CTOD("  -  -    ")
            STORE INGRESO TO WINGRESO
*        ENDIF
         STORE RETIRO TO WRETIRO
         SELECT 4
         ****  RESULTADOS DE MULTIPLICAR LOS WX * W
         STORE WXDIAORD/8 TO WXDIAORD
         STORE WXDIAORD+WXDESNOR+WXDESTRA+WXPRIDOM+WXDIAFER TO WXTOTDIA
         STORE WXTOTDIA*WPORDIA TO BSTOTDIA
         STORE  WXAYUDA   *  WAYUDA  TO BSAYUDA
         STORE  WXVIVE    *  WVIVE   TO BSVIVE
         STORE  WXHOREXT  *  WEXTRA  TO BSHOREXT
         STORE  WXBONNOC  *  WNOCTU  TO BSBONNOC
         STORE  WXHORVIA  *  WVIAJE  TO BSHORVIA
         STORE  WXCOMIDA  *  WCOMIDA TO BSCOMIDA
         STORE LINE+1 TO LINE
         IF LINE > 55
       @ LINE,0 SAY  "|                                        |        |        |        |        |       |        |         |                |                |                 |                 |                |                 |         |          |"
            @ line,1 say "S U B T O T A L  :"
            @ LINE,42 SAY STR(XXDIAORD,8,2)
            @ LINE,51 SAY STR(XXDESNOR,8,2)
            @ LINE,60 SAY STR(XXDESTRA,8,2)
            @ LINE,69 SAY STR(XXPRIDOM,8,2)
            @ LINE,77 SAY STR(XXDIAFER,8,2)
            @ LINE,86  SAY STR(XXTOTDIA,8,2)
            @ LINE,95  SAY STR(XXTOTPAG,9,2)
            @ LINE,105 SAY STR(XXAYUDA,7,2)
            @ LINE,113 SAY STR(XXAYUDABS,8,2)
            @ LINE,121 SAY STR(XXVIVE,7,2)
            @ LINE,130 SAY STR(XXVIVEBS,8,2)
            @ LINE,138 SAY STR(XXHOREXT,8,2)
            @ LINE,148 SAY STR(XXHOREXTBS,8,2)
            @ LINE,157 SAY STR(XXBONNOC,7,2)
            @ LINE,166 SAY STR(XXBONNOCBS,8,2)
            @ LINE,174 SAY STR(XXHORVIA,7,2)
            @ LINE,183 SAY STR(XXHORVIABS,8,2)
            @ LINE,192 SAY STR(XXCOMIDA,7,2)
            @ LINE,201 SAY STR(XXCOMIDABS,8,2)
            @ LINE,210 SAY STR(XXUTILIDAD,9,2)
            @ LINE,220 SAY STR(QQTOTGEN,10,2)
         STORE LINE+1 TO LINE
       @ LINE,0 SAY  "|----------------------------------------+--------+--------+--------+--------+-------+--------+---------+----------------+----------------+-----------------+-----------------+----------------+-----------------|---------|----------|"
            EJECT
   @ 0,0 say chr(18)
   @ 1,0 SAY CHR(14)+qqww
   @ 3,0 SAY "CONTRATO U ORDEN DE SERVICIO: "+IPNOMINA->CONTRATO
   @ 5,0 SAY "NOMBRE DE LA OBRA O SERVICIO: "+IPNOMINA->DESNOM
   @ 7,0 SAY "BONIFICACION UNICA Y ESPECIAL - PERIODO COMPRENDIDO DESDE "+DTOC(WDESDE-1)+ " HASTA "+DTOC(WHASTA)
   @ 09,0 SAY CHR(15)
   @ 09,0 say  "+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+"
   @ 10,0 say  "| N O M B R E                            |  DIAS  |  DESC. |  DESC. | PRIMA  |FERIADO|  TOTAL |A PAGAR  |  AYUDA CIUDAD  |   VIVIENDA     |  HORAS EXTRAS   | BONO NOCTURNO   | TIEMPO VIAJE   |     COMIDA      |UTILIDAD |  TOTAL   |"
   @ 11,0 SAY  "|----------------------------------------+TRABAJA.| NORMAL | TRABAJ.|DOMINIC.|       |No. DIAS|  Bs.    |----------------|----------------|-----------------|-----------------|----------------|-----------------|   Bs.   |   Bs.    |"
   @ 12,0 SAY  "|  CEDULA    | SALARIO |  CLASIFICACION  |        |        |        |        |       |        |         |DIAS       Bs.  |DIAS       Bs.  |Hrs.        Bs.  |Hrs.       Bs.   |Hrs.       Bs.  | No.        Bs.  |         |          |"
   @ 13,0 SAY  "|----------------------------------------|        |        |        |        |       |        |         |                |                |                 |                 |                |                 |         |          |"
   @ 14,0 SAY  "|   INGRESO  | TERMINO |                 |        |        |        |        |       |        |         |                |                |                 |                 |                |                 |         |          |"
   @ 15,0 SAY  "|----------------------------------------+        |        |        |        |       |        |         |                |                |                 |                 |                |                 |         |          |"
   @ 16,0 SAY  "|             F I R M A                  |        |        |        |        |       |        |         |                |                |                 |                 |                |                 |         |          |"
   @ 17,0 SAY  "|----------------------------------------+--------+--------+--------+--------+-------+--------+---------+----------------+----------------+-----------------+-----------------+----------------+-----------------+---------+----------+"
            STORE 18 TO LINE
         ENDIF
      @ LINE,0 say  "|                                        |        |        |        |        |       |        |         |                |                |                 |                 |                |                 |         |          |"
         @ LINE,1 SAY WNOMBRE
         STORE LINE+1 TO LINE
      @ LINE,0 SAY  "|----------------------------------------+        |        |        |        |       |        |         |                |                |                 |                 |                |                 |         |          |"
         @ LINE,43 SAY STR(WXDIAORD,7,2)
         @ LINE,52 SAY STR(WXDESNOR,7,2)
         @ LINE,61 SAY STR(WXDESTRA,7,2)
         @ LINE,70 SAY STR(WXPRIDOM,7,2)
         @ LINE,78 SAY STR(WXDIAFER,7,2)
         @ LINE,87  SAY STR(WXTOTDIA,7,2)
         @ LINE,95  SAY STR(BSTOTDIA,9,2)
         @ LINE,105 SAY STR(WXAYUDA,7,2)
         @ LINE,113 SAY STR(BSAYUDA,8,2)
         @ LINE,121 SAY STR(WXVIVE,7,2)
         @ LINE,131 SAY STR(BSVIVE,7,2)
         @ LINE,137 SAY STR(WXHOREXT,8,2)
         @ LINE,147 SAY STR(BSHOREXT,8,2)
         @ LINE,157 SAY STR(WXBONNOC,7,2)
         @ LINE,167 SAY STR(BSBONNOC,7,2)
         @ LINE,174 SAY STR(WXHORVIA,7,2)
         @ LINE,184 SAY STR(BSHORVIA,7,2)
         @ LINE,192 SAY STR(WXCOMIDA,7,2)
         @ LINE,202 SAY STR(BSCOMIDA,7,2)
         STORE (BSTOTDIA+BSAYUDA+BSHOREXT+BSBONNOC+BSHORVIA+BSCOMIDA)*(WUTIL/100) TO BSUTIL
         @ LINE,210 SAY STR(BSUTIL,9,2)
         STORE BSTOTDIA+BSAYUDA+BSVIVE+BSHOREXT+BSBONNOC+BSHORVIA+BSCOMIDA+BSUTIL TO BSTOTGEN
         STORE QQTOTGEN+BSTOTGEN TO QQTOTGEN
         @ LINE,220 SAY STR(BSTOTGEN,10,2)

         STORE LINE+1 TO LINE
       @ LINE,0 SAY  "|            |         |                 |        |        |        |        |       |        |         |                |                |                 |                 |                |                 |         |          |"
         @ LINE,1 SAY WCEDULA
         @ LINE,15 SAY STR(WBASICO,8,2)
         @ LINE,25 SAY WCARGO
         STORE LINE+1 TO LINE
       @ LINE,0 SAY  "|----------------------------------------|        |        |        |        |       |        |         |                |                |                 |                 |                |                 |         |          |"
         STORE LINE+1 TO LINE
       @ LINE,0 SAY  "|            |         |                 |        |        |        |        |       |        |         |                |                |                 |                 |                |                 |         |          |"
         @ LINE,1 SAY WINGRESO
         @ LINE,15 SAY WRETIRO
         STORE LINE+1 TO LINE
       @ LINE,0 SAY  "|----------------------------------------+        |        |        |        |       |        |         |                |                |                 |                 |                |                 |         |          |"
         STORE LINE+1 TO LINE
       @ LINE,0 SAY  "|                                        |        |        |        |        |       |        |         |                |                |                 |                 |                |                 |         |          |"
         STORE LINE+1 TO LINE
       @ LINE,0 SAY  "|----------------------------------------+--------+--------+--------+--------+-------+--------+---------+----------------+----------------+-----------------+-----------------+----------------+-----------------|---------|----------|"
         **********************************
         STORE XXDIAORD     + WXDIAORD     TO XXDIAORD
         STORE XXDESNOR     + WXDESNOR     TO XXDESNOR
         STORE XXDESTRA     + WXDESTRA     TO XXDESTRA
         STORE XXPRIDOM     + WXPRIDOM     TO XXPRIDOM
         STORE XXDIAFER     + WXDIAFER     TO XXDIAFER
         STORE XXTOTDIA     + WXTOTDIA     TO XXTOTDIA
         STORE XXTOTPAG     + BSTOTDIA     TO XXTOTPAG
         STORE XXAYUDA      + WXAYUDA      TO XXAYUDA
         STORE XXAYUDABS    + BSAYUDA      TO XXAYUDABS
         STORE XXVIVE       + WXVIVE       TO XXVIVE
         STORE XXVIVEBS     + BSVIVE       TO XXVIVEBS
         STORE XXHOREXT     + WXHOREXT     TO XXHOREXT
         STORE XXHOREXTBS   + BSHOREXT     TO XXHOREXTBS
         STORE XXBONNOC     + WXBONNOC     TO XXBONNOC
         STORE XXBONNOCBS   + BSBONNOC     TO XXBONNOCBS
         STORE XXHORVIA     + WXHORVIA     TO XXHORVIA
         STORE XXHORVIABS   + BSHORVIA     TO XXHORVIABS
         STORE XXCOMIDA     + WXCOMIDA     TO XXCOMIDA
         STORE XXCOMIDABS   + BSCOMIDA     TO XXCOMIDABS
         STORE XXUTILIDAD   + BSUTIL       TO XXUTILIDAD
      ****************************************
         STORE QXDIANOR TO WXDIAORD
         STORE QXDESNOR TO WXDESNOR
         STORE 0 TO WXDESTRA
         STORE 0 TO WXPRIDOM
         STORE 0 TO WXDIAFER
         STORE QXAYUDA TO WXAYUDA
         STORE QXVIVE TO WXVIVE
         STORE 0 TO WXHOREXT
         STORE 0 TO WXBONNOC
         STORE 0 TO WXHORVIA
         STORE 0 TO WXCOMIDA
         SELECT 1
         STORE CEDULA TO WCEDULA
         STORE BASICO TO WBASICO
      ENDIF
      if fecha = ctod("06-05-1990")
         STORE  WXDESTRA+(HRDESCON/8)+(HRDESLEG/8) TO WXDESTRA
         IF DESOCB1 = "DC"
            STORE WXDESTRA+HROCB1/8 TO WXDESTRA
         ENDIF
         IF DESOCB2 = "DC"
            STORE WXDESTRA+HROCB2/8 TO WXDESTRA
         ENDIF
         IF DESOCB3 = "DC"
            STORE WXDESTRA+HROCB3/8 TO WXDESTRA
         ENDIF
      else
         STORE  WXDIAORD+HRORD TO WXDIAORD
         STORE  WXDESNOR + 0 TO WXDESNOR
         STORE  WXDESTRA+(HRDESCON/8)+(HRDESLEG/8) TO WXDESTRA
         IF DESOCB1 = "DC"
            STORE WXDESTRA+HROCB1/8 TO WXDESTRA
         ENDIF
         IF DESOCB2 = "DC"
            STORE WXDESTRA+HROCB2/8 TO WXDESTRA
         ENDIF
         IF DESOCB3 = "DC"
            STORE WXDESTRA+HROCB3/8 TO WXDESTRA
         ENDIF
         STORE  WXPRIDOM +(HRBD/8)+(HRFERPRI/8) TO WXPRIDOM

         IF DESOCB1 = "FT"
            STORE WXDIAFER+HROCB1/8 TO WXDIAFER
         ENDIF
         IF DESOCB2 = "FT"
            STORE WXDIAFER+HROCB2/8 TO WXDIAFER
         ENDIF
         IF DESOCB3 = "FT"
            STORE WXDIAFER+HROCB3/8 TO WXDIAFER
         ENDIF

         STORE  WXAYUDA+ 0  TO WXAYUDA
         STORE  WXVIVE+ 0  TO WXVIVE
         STORE  WXHOREXT + 0 TO WXHOREXT
         STORE  WXBONNOC + 0 TO WXBONNOC
         STORE  WXHORVIA + 0 TO WXHORVIA
         STORE  WXCOMIDA + 0 TO WXCOMIDA
      endif
      SKIP
   ENDDO
   *** IMPRIMIR EL ULTIMO OBRERO
         SELECT 2
         FIND &WCEDULA
         IF EOF()
            SET DEVI TO SCRE
            STORE "ERRORRRRRRR, CEDULA: "+WCEDULA+" NO REGISTRADA EN MAESTRO DE PERSONAL" TO MES
            DO AVISO WITH MES
            CLOSE DATA
            CLOSE INDEX
            RETURN
         ENDIF
         STORE RTRIM(NOMBRE)+" "+RTRIM(APELLIDO) TO WNOMBRE
         STORE CARGO TO WCARGO
*        IF INGRESO <> CTOD("  -  -    ")
            STORE INGRESO TO WINGRESO
*        ENDIF
         STORE RETIRO TO WRETIRO
         SELECT 4
         ****  RESULTADOS DE MULTIPLICAR LOS WX * W
         STORE WXDIAORD/8 TO WXDIAORD
         STORE WXDIAORD+WXDESNOR+WXDESTRA+WXPRIDOM+WXDIAFER TO WXTOTDIA
         STORE WXTOTDIA*WPORDIA TO BSTOTDIA
         STORE  WXAYUDA   *  WAYUDA  TO BSAYUDA
         STORE  WXVIVE    *  WVIVE   TO BSVIVE
         STORE  WXHOREXT  *  WEXTRA  TO BSHOREXT
         STORE  WXBONNOC  *  WNOCTU  TO BSBONNOC
         STORE  WXHORVIA  *  WVIAJE  TO BSHORVIA
         STORE  WXCOMIDA  *  WCOMIDA TO BSCOMIDA
         STORE LINE+1 TO LINE
         IF LINE > 55
       @ LINE,0 SAY  "|                                        |        |        |        |        |       |        |         |                |                |                 |                 |                |                 |         |          |"
            @ line,1 say "S U B T O T A L :"
            @ LINE,42 SAY STR(XXDIAORD,8,2)
            @ LINE,51 SAY STR(XXDESNOR,8,2)
            @ LINE,60 SAY STR(XXDESTRA,8,2)
            @ LINE,69 SAY STR(XXPRIDOM,8,2)
            @ LINE,77 SAY STR(XXDIAFER,8,2)
            @ LINE,86  SAY STR(XXTOTDIA,8,2)
            @ LINE,95  SAY STR(XXTOTPAG,9,2)
            @ LINE,105 SAY STR(XXAYUDA,7,2)
            @ LINE,113 SAY STR(XXAYUDABS,8,2)
            @ LINE,121 SAY STR(XXVIVE,7,2)
            @ LINE,130 SAY STR(XXVIVEBS,8,2)
            @ LINE,137 SAY STR(XXHOREXT,8,2)
            @ LINE,147 SAY STR(XXHOREXTBS,8,2)
            @ LINE,157 SAY STR(XXBONNOC,7,2)
            @ LINE,166 SAY STR(XXBONNOCBS,8,2)
            @ LINE,174 SAY STR(XXHORVIA,7,2)
            @ LINE,183 SAY STR(XXHORVIABS,8,2)
            @ LINE,192 SAY STR(XXCOMIDA,7,2)
            @ LINE,201 SAY STR(XXCOMIDABS,8,2)
            @ LINE,210 SAY STR(XXUTILIDAD,9,2)
            @ LINE,220 SAY STR(QQTOTGEN,10,2)
         STORE LINE+1 TO LINE
       @ LINE,0 SAY  "|----------------------------------------+--------+--------+--------+--------+-------+--------+---------+----------------+----------------+-----------------+-----------------+----------------+-----------------|---------|----------|"
            EJECT
   @ 0,0 say chr(18)
   @ 1,0 SAY CHR(14)+qqww
   @ 3,0 SAY "CONTRATO U ORDEN DE SERVICIO: "+IPNOMINA->CONTRATO
   @ 5,0 SAY "NOMBRE DE LA OBRA O SERVICIO: "+IPNOMINA->DESNOM
   @ 7,0 SAY "BONIFICACION UNICA Y ESPECIAL - PERIODO COMPRENDIDO DESDE "+DTOC(WDESDE-1)+ " HASTA "+DTOC(WHASTA)
   @ 09,0 SAY CHR(15)
   @ 09,0 say  "+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+"
   @ 10,0 say  "| N O M B R E                            |  DIAS  |  DESC. |  DESC. | PRIMA  |FERIADO|  TOTAL |A PAGAR  |  AYUDA CIUDAD  |   VIVIENDA     |  HORAS EXTRAS   | BONO NOCTURNO   | TIEMPO VIAJE   |     COMIDA      |UTILIDAD |  TOTAL  |"
   @ 11,0 SAY  "|----------------------------------------+TRABAJA.| NORMAL | TRABAJ.|DOMINIC.|       |No. DIAS|  Bs.    |----------------|----------------|-----------------|-----------------|----------------|-----------------|   Bs.   |   Bs.   |"
   @ 12,0 SAY  "|  CEDULA    | SALARIO |  CLASIFICACION  |        |        |        |        |       |        |         |DIAS       Bs.  |DIAS       Bs.  |Hrs.        Bs.  |Hrs.       Bs.   |Hrs.       Bs.  | No.        Bs.  |         |         |"
   @ 13,0 SAY  "|----------------------------------------|        |        |        |        |       |        |         |                |                |                 |                 |                |                 |         |         |"
   @ 14,0 SAY  "|   INGRESO  | TERMINO |                 |        |        |        |        |       |        |         |                |                |                 |                 |                |                 |         |         |"
   @ 15,0 SAY  "|----------------------------------------+        |        |        |        |       |        |         |                |                |                 |                 |                |                 |         |         |"
   @ 16,0 SAY  "|             F I R M A                  |        |        |        |        |       |        |         |                |                |                 |                 |                |                 |         |         |"
   @ 17,0 SAY  "|----------------------------------------+--------+--------+--------+--------+-------+--------+---------+----------------+----------------+-----------------+-----------------+----------------+-----------------+---------+---------+"
            STORE 18 TO LINE
         ENDIF
      @ LINE,0 say  "|                                        |        |        |        |        |       |        |         |                |                |                 |                 |                |                 |         |          |"
         @ LINE,1 SAY WNOMBRE
         STORE LINE+1 TO LINE
      @ LINE,0 SAY  "|----------------------------------------+        |        |        |        |       |        |         |                |                |                 |                 |                |                 |         |          |"
         @ LINE,43 SAY STR(WXDIAORD,7,2)
         @ LINE,52 SAY STR(WXDESNOR,7,2)
         @ LINE,61 SAY STR(WXDESTRA,7,2)
         @ LINE,70 SAY STR(WXPRIDOM,7,2)
         @ LINE,78 SAY STR(WXDIAFER,7,2)
         @ LINE,87  SAY STR(WXTOTDIA,7,2)
         @ LINE,95  SAY STR(BSTOTDIA,9,2)
         @ LINE,105 SAY STR(WXAYUDA,7,2)
         @ LINE,113 SAY STR(BSAYUDA,8,2)
         @ LINE,121 SAY STR(WXVIVE,7,2)
         @ LINE,131 SAY STR(BSVIVE,7,2)
         @ LINE,137 SAY STR(WXHOREXT,8,2)
         @ LINE,147 SAY STR(BSHOREXT,8,2)
         @ LINE,157 SAY STR(WXBONNOC,7,2)
         @ LINE,167 SAY STR(BSBONNOC,7,2)
         @ LINE,174 SAY STR(WXHORVIA,7,2)
         @ LINE,184 SAY STR(BSHORVIA,7,2)
         @ LINE,192 SAY STR(WXCOMIDA,7,2)
         @ LINE,202 SAY STR(BSCOMIDA,7,2)
         STORE (BSTOTDIA+BSAYUDA+BSHOREXT+BSBONNOC+BSHORVIA+BSCOMIDA)*(WUTIL/100) TO BSUTIL
         @ LINE,210 SAY STR(BSUTIL,9,2)
         STORE BSTOTDIA+BSAYUDA+BSVIVE+BSHOREXT+BSBONNOC+BSHORVIA+BSCOMIDA+BSUTIL TO BSTOTGEN
         STORE QQTOTGEN+BSTOTGEN TO QQTOTGEN
         @ LINE, 220 SAY STR(BSTOTGEN,9,2)

         STORE LINE+1 TO LINE
       @ LINE,0 SAY  "|            |         |                 |        |        |        |        |       |        |         |                |                |                 |                 |                |                 |         |          |"
         @ LINE,1 SAY WCEDULA
         @ LINE,15 SAY STR(WBASICO,8,2)
         @ LINE,25 SAY WCARGO
         STORE LINE+1 TO LINE
       @ LINE,0 SAY  "|----------------------------------------|        |        |        |        |       |        |         |                |                |                 |                 |                |                 |         |          |"
         STORE LINE+1 TO LINE
       @ LINE,0 SAY  "|            |         |                 |        |        |        |        |       |        |         |                |                |                 |                 |                |                 |         |          |"
         @ LINE,1 SAY WINGRESO
         @ LINE,15 SAY WRETIRO
         STORE LINE+1 TO LINE
       @ LINE,0 SAY  "|----------------------------------------+        |        |        |        |       |        |         |                |                |                 |                 |                |                 |         |          |"
         STORE LINE+1 TO LINE
       @ LINE,0 SAY  "|                                        |        |        |        |        |       |        |         |                |                |                 |                 |                |                 |         |          |"
         STORE LINE+1 TO LINE
       @ LINE,0 SAY  "|----------------------------------------+--------+--------+--------+--------+-------+--------+---------+----------------+----------------+-----------------+-----------------+----------------+-----------------|---------|----------|"
         **********************************
         STORE XXDIAORD     + WXDIAORD     TO XXDIAORD
         STORE XXDESNOR     + WXDESNOR     TO XXDESNOR
         STORE XXDESTRA     + WXDESTRA     TO XXDESTRA
         STORE XXPRIDOM     + WXPRIDOM     TO XXPRIDOM
         STORE XXDIAFER     + WXDIAFER     TO XXDIAFER
         STORE XXTOTDIA     + WXTOTDIA     TO XXTOTDIA
         STORE XXTOTPAG     + BSTOTDIA     TO XXTOTPAG
         STORE XXAYUDA      + WXAYUDA      TO XXAYUDA
         STORE XXAYUDABS    + BSAYUDA      TO XXAYUDABS
         STORE XXVIVE       + WXVIVE       TO XXVIVE
         STORE XXVIVEBS     + BSVIVE       TO XXVIVEBS
         STORE XXHOREXT     + WXHOREXT     TO XXHOREXT
         STORE XXHOREXTBS   + BSHOREXT     TO XXHOREXTBS
         STORE XXBONNOC     + WXBONNOC     TO XXBONNOC
         STORE XXBONNOCBS   + BSBONNOC     TO XXBONNOCBS
         STORE XXHORVIA     + WXHORVIA     TO XXHORVIA
         STORE XXHORVIABS   + BSHORVIA     TO XXHORVIABS
         STORE XXCOMIDA     + WXCOMIDA     TO XXCOMIDA
         STORE XXCOMIDABS   + BSCOMIDA     TO XXCOMIDABS
         STORE XXUTILIDAD   + BSUTIL       TO XXUTILIDAD
         STORE LINE+1 TO LINE
       @ LINE,0 SAY  "|                                        |        |        |        |        |       |        |         |                |                |                 |                 |                |                 |         |          |"
            @ line,1 say "T O T A L     R E T R O A C T I V O  :"
            @ LINE,42 SAY STR(XXDIAORD,8,2)
            @ LINE,51 SAY STR(XXDESNOR,8,2)
            @ LINE,60 SAY STR(XXDESTRA,8,2)
            @ LINE,69 SAY STR(XXPRIDOM,8,2)
            @ LINE,77 SAY STR(XXDIAFER,8,2)
            @ LINE,86  SAY STR(XXTOTDIA,8,2)
            @ LINE,95  SAY STR(XXTOTPAG,9,2)
            @ LINE,105 SAY STR(XXAYUDA,7,2)
            @ LINE,113 SAY STR(XXAYUDABS,8,2)
            @ LINE,122 SAY STR(XXVIVE,7,2)
            @ LINE,130 SAY STR(XXVIVEBS,8,2)
            @ LINE,137 SAY STR(XXHOREXT,8,2)
            @ LINE,147 SAY STR(XXHOREXTBS,8,2)
            @ LINE,157 SAY STR(XXBONNOC,7,2)
            @ LINE,166 SAY STR(XXBONNOCBS,8,2)
            @ LINE,174 SAY STR(XXHORVIA,7,2)
            @ LINE,183 SAY STR(XXHORVIABS,8,2)
            @ LINE,192 SAY STR(XXCOMIDA,7,2)
            @ LINE,201 SAY STR(XXCOMIDABS,8,2)
            @ LINE,210 SAY STR(XXUTILIDAD,9,2)
            @ LINE,220 SAY STR(QQTOTGEN,10,2)
         STORE LINE+1 TO LINE
       @ LINE,0 SAY  "|----------------------------------------+--------+--------+--------+--------+-------+--------+---------+----------------+----------------+-----------------+-----------------+----------------+-----------------|---------|----------|"
   STORE .F. TO RETRO
   @ PROW(),0 SAY CHR(18)
   SET DEVI TO SCRE
   EJECT
   close data
   close index
   DELETE FILE IPNX.DBF
   DELETE FILE IPNX.IDX
ENDDO

