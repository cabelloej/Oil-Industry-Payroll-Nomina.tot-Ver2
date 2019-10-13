*** IMPRIMIR OBRERO
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
STORE DIFERENCIA TO WEJCPORDIA
SELECT 4
STORE (WEJCPORDIA/8)*(WEXTRA/100) TO WEJCEXTRA
STORE (WEJCPORDIA/8)*(WVIAJE/100) TO WEJCVIAJE
STORE (WEJCPORDIA/8)*(WNOCTU/100) TO WEJCNOCTU
STORE (WEJCPORDIA/8)              TO WREPCOM
STORE WXDIAORD/8 TO WXDIAORD
*** RECORTA LAS CANTIDADESD CALCULADAS A LO MAXIMO EN DIAS DEL PERIODO
IF (WXDIAORD+WXDESNOR)>WMAXDIAS
   STORE ((WXDIAORD+WXDESNOR)-WMAXDIAS) TO WXDIF
   IF WXDIAORD>WTOTNOR
      STORE WXDIF-(WXDIAORD-WTOTNOR) TO WXDIF
      STORE WTOTNOR                  TO WXDIAORD
      STORE WXDESNOR-WXDIF           TO WXDESNOR
   ENDIF
   *STORE WXDIAORD - ((WXDIAORD+WXDESNOR)-WMAXDIAS) TO WXDIAORD
ENDIF
****  RESULTADOS DE MULTIPLICAR LOS WX * W
STORE WXDIAORD+WXDESNOR+WXDESTRA+WXPRIDOM+WXDIAFER TO WXTOTDIA
STORE WXTOTDIA*WEJCPORDIA TO BSTOTDIA
STORE  WXAYUDA   *  WAYUDA  TO BSAYUDA
STORE  WXVIVE    *  WVIVE   TO BSVIVE
STORE  WXHOREXT  *  WEJCEXTRA  TO BSHOREXT
STORE  WXBONNOC  *  WEJCNOCTU  TO BSBONNOC
STORE  WXHORVIA  *  WEJCVIAJE  TO BSHORVIA
STORE  WXCOMIDA  *  WCOMIDA TO BSCOMIDA
*STORE  WXREPCOM  *  WREPCOM TO BSREPCOM
STORE  WXCESTA   *  WCESTA  TO BSCESTA
STORE LINE+1 TO LINE
IF LINE > 55
   @ LINE,0 SAY  "|                                        |        |        |        |        |       |        |         |                |                |                 |                 |                |                 |         |          |"
   @ line,1 say "S U B T O T A L :"
   @ LINE,42 SAY XXDIAORD picture  "@z #####.##"
   @ LINE,51 SAY XXDESNOR picture  "@z #####.##"
   @ LINE,60 SAY XXDESTRA picture  "@z #####.##"
   @ LINE,69 SAY XXPRIDOM picture  "@z #####.##"
   @ LINE,77 SAY XXDIAFER picture  "@z #####.##"
   @ LINE,86  SAY XXTOTDIA picture "@z #####.##"
   @ LINE,95  SAY XXTOTPAG picture "@z ######.##"
   @ LINE,107 SAY XXAYUDA+XXVIVE  picture "@z ####"
   @ LINE,113 SAY XXAYUDABS+XXVIVEBS picture "@z #####.##"
   @ LINE,121 SAY XXCESTA picture "@z ####.##"
   @ LINE,130 SAY XXCESTABS picture "@z #####.##"
   @ LINE,138 SAY XXHOREXT picture "@z ####.##"
   @ LINE,147 SAY XXHOREXTBS picture "@z ######.##"
   @ LINE,157 SAY XXBONNOC picture "@z ####.##"
   @ LINE,166 SAY XXBONNOCBS picture "@z #####.##"
   @ LINE,174 SAY XXHORVIA picture "@z ####.##"
   @ LINE,183 SAY XXHORVIABS picture "@z #####.##"
   @ LINE,192 SAY XXCOMIDA picture "@z ####.##"
   @ LINE,201 SAY XXCOMIDABS picture "@z #####.##"
   @ LINE,210 SAY XXUTILIDAD picture "@z ######.##"
   @ LINE,220 SAY QQTOTGEN picture "@z #######.##"
   STORE LINE+1 TO LINE
   @ LINE,0 SAY  "|----------------------------------------+--------+--------+--------+--------+-------+--------+---------+----------------+----------------+-----------------+-----------------+----------------+-----------------|---------|----------|"
   STORE LINE+1 TO LINE
   @ LINE,0 SAY  "|                                        |        |        |        |        |       |        |         |                |                |                 |                 |                |                 |         |          |"
   @ LINE,192 SAY XXREPCOM picture "@z ####.##"
   @ LINE,201 SAY XXREPCOMBS picture "@z #####.##"
   STORE LINE+1 TO LINE
   @ LINE,0 SAY  "|----------------------------------------+--------+--------+--------+--------+-------+--------+---------+----------------+----------------+-----------------+-----------------+----------------+-----------------|---------|----------|"
   EJECT
   DO HEAD0309
   STORE 18 TO LINE
ENDIF
@ LINE,0 say  "|                                        |        |        |        |        |       |        |         |                |                |                 |                 |                |                 |         |          |"
@ LINE,1 SAY WNOMBRE
STORE LINE+1 TO LINE
@ LINE,0 SAY  "|----------------------------------------+        |        |        |        |       |        |         |                |                |                 |                 |                |                 |         |          |"
@ LINE,43 SAY WXDIAORD PICTURE "@z ####.##"
@ LINE,52 SAY WXDESNOR picture "@z ####.##"
@ LINE,61 SAY WXDESTRA picture "@z ####.##"
@ LINE,70 SAY WXPRIDOM picture "@z ####.##"
@ LINE,78 SAY WXDIAFER picture "@z ####.##"
@ LINE,87  SAY WXTOTDIA picture "@z ####.##"
@ LINE,95  SAY BSTOTDIA picture "@z ######.##"
@ LINE,105 SAY WXAYUDA+WXVIVE  picture "@z ####.##"
@ LINE,113 SAY BSAYUDA+BSVIVE picture "@z #####.##"
@ LINE,121 SAY WXCESTA  picture "@z ####.##"
@ LINE,131 SAY BSCESTA picture "@z ####.##"
@ LINE,138 SAY WXHOREXT picture "@z ####.##"
@ LINE,147 SAY BSHOREXT picture "@z ######.##"
@ LINE,157 SAY WXBONNOC picture "@z ####.##"
@ LINE,167 SAY BSBONNOC picture "@z ####.##"
@ LINE,174 SAY WXHORVIA picture "@z ####.##"
@ LINE,184 SAY BSHORVIA picture "@z ####.##"
@ LINE,192 SAY WXCOMIDA picture "@z ####.##"
@ LINE,202 SAY BSCOMIDA picture "@z ####.##"
STORE (BSTOTDIA+BSAYUDA+BSHOREXT+BSBONNOC+BSHORVIA+BSCOMIDA+BSREPCOM )*(WUTIL/100) TO BSUTIL
@ LINE,210 SAY BSUTIL picture "@z ######.##"
STORE BSTOTDIA+BSAYUDA+BSVIVE+BSHOREXT+BSBONNOC+BSHORVIA+BSCOMIDA+BSREPCOM +BSUTIL+BSCESTA TO BSTOTGEN
STORE QQTOTGEN+BSTOTGEN TO QQTOTGEN
@ LINE, 220 SAY STR(BSTOTGEN,9,2)
STORE LINE+1 TO LINE
@ LINE,0 SAY  "|            |         |                 |        |        |        |        |       |        |         |                |                |                 |                 |                |                 |         |          |"
@ LINE,1 SAY WCEDULA
@ LINE,15 SAY STR(WBASICO,8,2)
SELECT 9
SEEK WCARGO
IF EOF()
   STORE "NO REGISTRADO" TO WCARGODES
ELSE
   STORE DESCRI          TO WCARGODES
ENDIF
SELECT 4
@ LINE,25 SAY WCARGODES
@ LINE,192 SAY WXREPCOM picture "@z ####.##"
@ LINE,202 SAY BSREPCOM  picture "@z ####.##"
STORE LINE+1 TO LINE
@ LINE,0 SAY  "|----------------------------------------|        |        |        |        |       |        |         |                |                |                 |                 |                |                 |         |          |"
STORE LINE+1 TO LINE
@ LINE,0 SAY  "|            |         |                 |        |        |        |        |       |        |         |                |                |                 |                 |                |                 |         |          |"
@ LINE,1 SAY WINGRESO
@ LINE,15 SAY WRETIRO
@ LINE,20 SAY WEJCPORDIA
STORE LINE+1 TO LINE
@ LINE,0 SAY  "|----------------------------------------+        |        |        |        |       |        |         |                |                |                 |                 |                |                 |         |          |"
STORE LINE+1 TO LINE
@ LINE,0 SAY  "|                                        |        |        |        |        |       |        |         |                |                |                 |                 |                |                 |         |          |"
STORE LINE+1 TO LINE
@ LINE,0 SAY  "|----------------------------------------+--------+--------+--------+--------+-------+--------+---------+----------------+----------------+-----------------+-----------------+----------------+-----------------|---------|----------|"
**********************************
RETURN
