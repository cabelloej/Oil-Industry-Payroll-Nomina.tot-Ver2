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

STORE 0 TO FLAG
select 2
use ipnperso INDEX IPNPERSO
store .t. to retro
do while retro
   store date() to wdesde
   store date() to whasta
   STORE SPACE(5) TO WNOMINA
   @ 5,0 clear to 21,79
   @ 5,0 to 21,79 double
   @ 5,30 say "RESUMEN DE PAGO POR CONCEPTOS BONIFICABLES"
   @ 08,5 SAY "DESDE            :" GET WDESDE
   @ 10,5 SAY "HASTA            :" GET WHASTA
   @ 12,5 SAY "NOMINA           :" GET WNOMINA
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
   @ 12,35 SAY DESNOM
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
   INDEX ON CEDULA TO IPNX
   APPEND FROM IPNHISTO FOR FECHA >= WDESDE .AND. FECHA <= WHASTA .AND. NOMINA = WNOMINA
   SET DEVI TO PRINT
   DO HEAD0211
   STORE 17 TO LINE
   STORE 0 TO WXDIAORD
   STORE 0 TO WXDESNOR
   STORE 0 TO WXDESTRA
   STORE 0 TO WXPRIDOM
   STORE 0 TO WXDIAFER
   STORE 0 TO WXAYUDA
   STORE 0 TO WXVIVE
   STORE 0 TO WXHOREXT
   STORE 0 TO WXBONNOC
   STORE 0 TO WXHORVIA
   STORE 0 TO WXCOMIDA
   STORE 0 TO WEDIAORD
   STORE 0 TO WEDESNOR
   STORE 0 TO WEDESTRA
   STORE 0 TO WEPRIDOM
   STORE 0 TO WEDIAFER
   STORE 0 TO WEAYUDA
   STORE 0 TO WEVIVE
   STORE 0 TO WEHOREXT
   STORE 0 TO WEBONNOC
   STORE 0 TO WEHORVIA
   STORE 0 TO WECOMIDA
   STORE 0 TO WEUTILIDAD
   SELECT 1
   GO TOP
   STORE CEDULA TO WCEDULA
   STORE BASICO TO WBASICO
   DO WHILE .NOT. EOF()
      ********* INICIO DE RUPTURA DE CONTROL E IMPRESION DEL RESUMEN DEL OBRERO ****
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
         STORE INGRESO TO WINGRESO
         STORE RETIRO TO WRETIRO
         SELECT 4
         ****  RESULTADOS DE MULTIPLICAR LOS WX * W
         STORE WXDIAORD/8 TO WXDIAORD
         STORE WEDIAORD+WEDESNOR+WEDESTRA+WEPRIDOM+WEDIAFER TO BSTOTDIA
         STORE WXDIAORD+WXDESNOR+WXDESTRA+WXPRIDOM+WXDIAFER TO WXTOTDIA
         STORE  WEAYUDA              TO BSAYUDA
         STORE  WEVIVE               TO BSVIVE
         STORE  WEHOREXT             TO BSHOREXT
         STORE  WEBONNOC             TO BSBONNOC
         STORE  WEHORVIA             TO BSHORVIA
         STORE  WECOMIDA             TO BSCOMIDA
         STORE  WEUTILIDAD           TO BSUTIL
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
            @ LINE,139 SAY STR(XXHOREXT,7,2)
            @ LINE,148 SAY STR(XXHOREXTBS,8,2)
            @ LINE,157 SAY STR(XXBONNOC,7,2)
            @ LINE,166 SAY STR(XXBONNOCBS,8,2)
            @ LINE,174 SAY STR(XXHORVIA,7,2)
            @ LINE,183 SAY STR(XXHORVIABS,8,2)
            @ LINE,192 SAY STR(XXCOMIDA,7,2)
            @ LINE,201 SAY STR(XXCOMIDABS,8,2)
            @ LINE,210 SAY STR(XXUTILIDAD,9,2)
            @ LINE,220 SAY STR(QQTOTGEN,9,2)
         STORE LINE+1 TO LINE
       @ LINE,0 SAY  "|----------------------------------------+--------+--------+--------+--------+-------+--------+---------+----------------+----------------+-----------------+-----------------+----------------+-----------------|---------|----------|"
            EJECT
            DO HEAD0211
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
       * @ LINE,121 SAY STR(WXVIVE,7,2)
         @ LINE,131 SAY STR(BSVIVE,7,2)
         @ LINE,140 SAY STR(WXHOREXT,7,2)
         @ LINE,149 SAY STR(BSHOREXT,7,2)
         @ LINE,157 SAY STR(WXBONNOC,7,2)
         @ LINE,167 SAY STR(BSBONNOC,7,2)
         @ LINE,174 SAY STR(WXHORVIA,7,2)
         @ LINE,184 SAY STR(BSHORVIA,7,2)
         @ LINE,192 SAY STR(WXCOMIDA,7,2)
         @ LINE,202 SAY STR(BSCOMIDA,7,2)
         @ LINE,210 SAY STR(BSUTIL,9,2)
         STORE BSTOTDIA+BSAYUDA+BSVIVE+BSHOREXT+BSBONNOC+BSHORVIA+BSCOMIDA+BSUTIL TO BSTOTGEN
         STORE QQTOTGEN+BSTOTGEN TO QQTOTGEN
         @ LINE,220 SAY STR(BSTOTGEN,9,2)

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
         STORE 0 TO WXDIAORD
         STORE 0 TO WXDESNOR
         STORE 0 TO WXDESTRA
         STORE 0 TO WXPRIDOM
         STORE 0 TO WXDIAFER
         STORE 0 TO WXAYUDA
         STORE 0 TO WXVIVE
         STORE 0 TO WXHOREXT
         STORE 0 TO WXBONNOC
         STORE 0 TO WXHORVIA
         STORE 0 TO WXCOMIDA
         STORE 0 TO WEDIAORD
         STORE 0 TO WEDESNOR
         STORE 0 TO WEDESTRA
         STORE 0 TO WEPRIDOM
         STORE 0 TO WEDIAFER
         STORE 0 TO WEAYUDA
         STORE 0 TO WEVIVE
         STORE 0 TO WEHOREXT
         STORE 0 TO WEBONNOC
         STORE 0 TO WEHORVIA
         STORE 0 TO WECOMIDA
         STORE 0 TO WEUTILIDAD
         SELECT 1
         STORE CEDULA TO WCEDULA
         STORE BASICO TO WBASICO
      ENDIF
      ********* FIN DE RUPTURA DE CONTROL E IMPRESION DEL RESUMEN DEL OBRERO ****
      STORE  WXDIAORD+HRORD                     TO WXDIAORD
      STORE  WEDIAORD+BSORD                     TO WEDIAORD
      STORE  WXDESNOR+(HRDESNOR/8)              TO WXDESNOR
      STORE  WEDESNOR+BSDESNOR                  TO WEDESNOR
      STORE  WXDESTRA+(HRDESCON/8)+(HRDESLEG/8) TO WXDESTRA
      STORE  WEDESTRA+BSDESCON+BSDESLEG         TO WEDESTRA

      STORE WXDESTRA+HRDESCOM/8 TO WXDESTRA
      STORE WEDESTRA+BSDESCOM   TO WEDESTRA
      IF DESOCB1 = "DC"
         STORE WXDESTRA+HROCB1/8 TO WXDESTRA
         STORE WEDESTRA+BSOCB1   TO WEDESTRA
      ENDIF
      IF DESOCB2 = "DC"
         STORE WXDESTRA+HROCB2/8 TO WXDESTRA
         STORE WEDESTRA+BSOCB2   TO WEDESTRA
      ENDIF
      IF DESOCB3 = "DC"
         STORE WXDESTRA+HROCB3/8 TO WXDESTRA
         STORE WEDESTRA+BSOCB3   TO WEDESTRA
      ENDIF

      STORE  WXPRIDOM +((HRBD+HRFERPRI)/8) TO WXPRIDOM
      STORE  WEPRIDOM + (BSBD+BSFERPRI)    TO WEPRIDOM


      STORE WXDIAFER+HRFERIADO/8 TO WXDIAFER
      STORE WEDIAFER+BSFERIADO   TO WEDIAFER
      IF SUBSTR(DESOCB1,1,1) = "F"
         STORE WXDIAFER+HROCB1/8 TO WXDIAFER
         STORE WEDIAFER+BSOCB1   TO WEDIAFER
      ENDIF
      IF SUBSTR(DESOCB2,1,1) = "F"
         STORE WXDIAFER+HROCB2/8 TO WXDIAFER
         STORE WEDIAFER+BSOCB2   TO WEDIAFER
      ENDIF
      IF SUBSTR(DESOCB3,1,1) = "F"
         STORE WXDIAFER+HROCB3/8 TO WXDIAFER
         STORE WEDIAFER+BSOCB3   TO WEDIAFER
      ENDIF

      STORE  WXAYUDA+(HRAYUCIU/8) TO WXAYUDA
      STORE  WEAYUDA+ BSAYUCIU    TO WEAYUDA
      STORE  WEVIVE+ BSVIVE       TO WEVIVE
      STORE  WXHOREXT + HRST      TO  WXHOREXT
      STORE  WEHOREXT + BSST      TO WEHOREXT
      STORE  WXBONNOC + HRBN+HRBNG  TO WXBONNOC
      STORE  WXBONNOC + HRBNV     TO WXBONNOC
      STORE  WEBONNOC + BSBN+BSBNG  TO WEBONNOC
      STORE  WEBONNOC + BSBNV     TO WEBONNOC
      STORE  WXHORVIA + HRTV      TO WXHORVIA
      STORE  WEHORVIA + BSTV      TO WEHORVIA
      STORE  WXCOMIDA + HRCOMIDA  TO WXCOMIDA
      STORE  WECOMIDA + BSCOMIDA  TO WECOMIDA

      STORE WEUTILIDAD+BSREPCOM TO WEUTILIDAD
      IF DESOCB1 <> "DC"  .AND. SUBSTR(DESOCB1,1,1) <> "F"
      ENDIF
      IF DESOCB2 <> "DC"  .AND. SUBSTR(DESOCB2,1,1) <> "F"
         STORE WEUTILIDAD+BSOCB2   TO WEUTILIDAD
      ENDIF
      IF DESOCB3 <> "DC"  .AND. SUBSTR(DESOCB3,1,1) <> "F"
         STORE WEUTILIDAD+BSOCB3   TO WEUTILIDAD
      ENDIF

      SKIP
   ENDDO
   **** RUPTURA DEL ULTIMO OBRERO
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
         STORE INGRESO TO WINGRESO
         STORE RETIRO TO WRETIRO
         SELECT 4
         ****  RESULTADOS DE MULTIPLICAR LOS WX * W
         STORE WXDIAORD/8 TO WXDIAORD
         STORE WEDIAORD+WEDESNOR+WEDESTRA+WEPRIDOM+WEDIAFER TO BSTOTDIA
         STORE WXDIAORD+WXDESNOR+WXDESTRA+WXPRIDOM+WXDIAFER TO WXTOTDIA
         STORE  WEAYUDA              TO BSAYUDA
         STORE  WEVIVE               TO BSVIVE
         STORE  WEHOREXT             TO BSHOREXT
         STORE  WEBONNOC             TO BSBONNOC
         STORE  WEHORVIA             TO BSHORVIA
         STORE  WECOMIDA             TO BSCOMIDA
         STORE  WEUTILIDAD           TO BSUTIL
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
            @ LINE,139 SAY STR(XXHOREXT,7,2)
            @ LINE,148 SAY STR(XXHOREXTBS,8,2)
            @ LINE,157 SAY STR(XXBONNOC,7,2)
            @ LINE,166 SAY STR(XXBONNOCBS,8,2)
            @ LINE,174 SAY STR(XXHORVIA,7,2)
            @ LINE,183 SAY STR(XXHORVIABS,8,2)
            @ LINE,192 SAY STR(XXCOMIDA,7,2)
            @ LINE,201 SAY STR(XXCOMIDABS,8,2)
            @ LINE,210 SAY STR(XXUTILIDAD,9,2)
            @ LINE,220 SAY STR(QQTOTGEN,9,2)
         STORE LINE+1 TO LINE
       @ LINE,0 SAY  "|----------------------------------------+--------+--------+--------+--------+-------+--------+---------+----------------+----------------+-----------------+-----------------+----------------+-----------------|---------|----------|"
            EJECT
            DO HEAD0211
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
       * @ LINE,121 SAY STR(WXVIVE,7,2)
         @ LINE,131 SAY STR(BSVIVE,7,2)
         @ LINE,140 SAY STR(WXHOREXT,7,2)
         @ LINE,149 SAY STR(BSHOREXT,7,2)
         @ LINE,157 SAY STR(WXBONNOC,7,2)
         @ LINE,167 SAY STR(BSBONNOC,7,2)
         @ LINE,174 SAY STR(WXHORVIA,7,2)
         @ LINE,184 SAY STR(BSHORVIA,7,2)
         @ LINE,192 SAY STR(WXCOMIDA,7,2)
         @ LINE,202 SAY STR(BSCOMIDA,7,2)
         @ LINE,210 SAY STR(BSUTIL,9,2)
         STORE BSTOTDIA+BSAYUDA+BSVIVE+BSHOREXT+BSBONNOC+BSHORVIA+BSCOMIDA+BSUTIL TO BSTOTGEN
         STORE QQTOTGEN+BSTOTGEN TO QQTOTGEN
         @ LINE,220 SAY STR(BSTOTGEN,9,2)

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
   **** FIN RUPTURA ULTIMO OBRERO
         STORE LINE+1 TO LINE
       @ LINE,0 SAY  "|                                        |        |        |        |        |       |        |         |                |                |                 |                 |                |                 |         |          |"
            @ line,1 say "T O T A L     G E N E R A L:"
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
            @ LINE,139 SAY STR(XXHOREXT,7,2)
            @ LINE,148 SAY STR(XXHOREXTBS,8,2)
            @ LINE,157 SAY STR(XXBONNOC,7,2)
            @ LINE,166 SAY STR(XXBONNOCBS,8,2)
            @ LINE,174 SAY STR(XXHORVIA,7,2)
            @ LINE,183 SAY STR(XXHORVIABS,8,2)
            @ LINE,192 SAY STR(XXCOMIDA,7,2)
            @ LINE,201 SAY STR(XXCOMIDABS,8,2)
            @ LINE,210 SAY STR(XXUTILIDAD,9,2)
            @ LINE,220 SAY STR(QQTOTGEN,9,2)
            STORE LINE+1 TO LINE
       @ LINE,0 SAY  "|----------------------------------------+--------+--------+--------+--------+-------+--------+---------+----------------+----------------+-----------------+-----------------+----------------+-----------------|---------|----------|"
            EJECT
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