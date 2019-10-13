PUSH KEY CLEAR
ON KEY LABEL F1 DO PROCIMP

STORE .T. TO TABLA
DO WHILE TABLA
   store "TABLAS DE LIQUIDACION" TO HEAD
   SET COLOR TO W+/B
   @ 05,01 CLEAR TO 20,50
   @ 05,01 TO 20,50 DOUBLE
   @ 05,15 SAY HEAD
   @ 06,05 SAY "TABLA A PROCESAR:"
   @ 07,05 SAY "MESES CUMPLIDOS :"
   @ 08,05 SAY "PREAVISO        :"
   @ 09,05 SAY "PREAVISO ADIC.  :"
   @ 10,05 SAY "ANTIGUEDAD LEG. :"
   @ 11,05 SAY "ANTIGUEDAD CONT.:"
   @ 12,05 SAY "ANTIGUEDAD ADIC.:"
   @ 13,05 SAY "VACACION        :"
   @ 14,05 SAY "BONO VACACIONAL :"
   @ 15,05 SAY "UTILIDAD        :"
   @ 16,05 SAY "TOTAL           :"
   @ 17,05 SAY "GARANTIA        :"
   @ 18,05 SAY "INDEN.ADICIONAL :"
   @ 19,05 SAY "INDEN.COMPLEMENT:"

   STORE "(P)etrolera,(L)ey del Trab.,(C)onstrucci¢n,pe(Q)uiven,F1=Ver,(S)alir" to mes
   DO mensaje with mes
   store " " to wo
   @ 23,77 get wo
   read
   store UPPER(wo) to resp

   IF RESP = "S" .OR. RESP = " "
      PUSH KEY CLEAR
      SET COLOR TO
      CLOSE DATA
      CLOSE INDEX
      RETURN
   ENDIF
   
   IF RESP = "P"
      STORE "IPNPETRO" TO FILE
      STORE "PETROLERA" TO TEXTO
   ENDIF

   IF RESP = "L"
      STORE "IPNLDT" TO FILE
      STORE "LEY DEL TRABAJO" TO TEXTO
   ENDIF

   IF RESP = "C"
      STORE "IPNCONST" TO FILE
      STORE "LEY DE LA CONTRUCCION" TO TEXTO
   ENDIF

   IF RESP = "Q"
      STORE "IPNPEQUI" TO FILE
      STORE "PEQUIVEN" TO TEXTO
   ENDIF
   
   @ 6,24 SAY TEXTO

   SELECT 1
   USE &FILE
   STORE 0.00 TO WMESES
   STORE "Indique el numero de meses a procesar (Ù para salir) " to mes
   do mensaje with mes
   @ 7,24 GET WMESES PICTURE "#####.##"
   READ
   if wmeses = 0
      close data
      close index
      return
   endif
   go top
   locate for meses = wmeses
   if .not. found()
      store "Numero de meses no registrado en esta tabla. Ingresar? (S/N) " to mes
      store "S" to p1
      store "N" to p2
      store " " to resp
      do pide2 with p1,p2,mes,resp
      iF resp = "N"
         loop
      endif
      append blank
      replace meses with wmeses
      @ 08,24 get preaviso    picture "#####.##"
      @ 09,24 get preaviso2   picture "#####.##"
      @ 10,24 get antiguedad  picture "#####.##"
      @ 11,24 get antigueda2  picture "#####.##"
      @ 12,24 get cesantia    picture "#####.##"
      @ 13,24 get vacacion    picture "#####.##"
      @ 14,24 get bonovac     picture "#####.##"
      @ 15,24 get utilidad    picture "#####.##"
      @ 16,24 get total       picture "#####.##"
      @ 17,24 get garantia    picture "#####.##"
      @ 18,24 get indenadd    picture "#####.##"
      @ 19,24 get indencom    picture "#####.##"
      READ
      SORT ON MESES TO IPNTEMP3
      ZAP
      APPEND FROM IPNTEMP3
      loop
   endif
   @ 08,24 say preaviso    picture "#####.##"
   @ 09,24 say preaviso2   picture "#####.##"
   @ 10,24 say antiguedad  picture "#####.##"
   @ 11,24 say antigueda2  picture "#####.##"
   @ 12,24 say cesantia    picture "#####.##"
   @ 13,24 say vacacion    picture "#####.##"
   @ 14,24 say bonovac     picture "#####.##"
   @ 15,24 say utilidad    picture "#####.##"
   @ 16,24 say total       picture "#####.##"
   @ 17,24 say garantia    picture "#####.##"
   @ 18,24 SAY INDENADD    picture "#####.##"
   @ 19,24 SAY INDENCOM    picture "#####.##"
   store "Desea (M)odificar, (E)liminar, (R)echazar" to mes
   store "M" TO P1
   STORE "R" TO P2
   store "E" TO P3
   STORE " " TO RESP
   DO PIDE3 WITH P1,P2,P3,MES,RESP
   IF RESP = "E"
      DELETE
      PACK
      SORT ON MESES TO IPNTEMP3
      ZAP
      APPEND FROM IPNTEMP3
      LOOP
   ENDIF
   IF RESP = "R"
      LOOP
   ENDIF
   IF RESP = "M"
      @ 08,24 get preaviso    picture "#####.##"
      @ 09,24 get preaviso2   picture "#####.##"
      @ 10,24 get antiguedad  picture "#####.##"
      @ 11,24 get antigueda2  picture "#####.##"
      @ 12,24 get cesantia    picture "#####.##"
      @ 13,24 get vacacion    picture "#####.##"
      @ 14,24 get bonovac     picture "#####.##"
      @ 15,24 get utilidad    picture "#####.##"
      @ 16,24 get total       picture "#####.##"
      @ 17,24 get garantia    picture "#####.##"
      @ 18,24 get indenadd    picture "#####.##"
      @ 19,24 get indencom    picture "#####.##"
      READ
   ENDIF
ENDDO

************
PROC PROCIMP
************
STORE "VER TABLA" TO TEXTO
@ 6,24 SAY TEXTO
STORE "Tabla (P)etrolera, (L)ey del trabajo, (C)onstrucci¢n pe(Q)uiven" to mes
store "P" TO P1
STORE "L" TO P2
STORE "C" TO P3
STORE "Q" TO P4
STORE " " TO RESP
DO PIDE4 WITH P1,P2,P3,p4,MES,RESP
IF RESP = "P"
   STORE "IPNPETRO" TO FILE
   STORE "PETROLERA" TO TEXTO
ENDIF
IF RESP = "L"
   STORE "IPNLDT" TO FILE
   STORE "LEY DEL TRABAJO" TO TEXTO
ENDIF
IF RESP = "C"
   STORE "IPNCONST" TO FILE
   STORE "LEY DE LA CONTRUCCION" TO TEXTO
ENDIF
IF RESP = "Q"
   STORE "IPNPEQUI" TO FILE
   STORE "PEQUIVEN" TO TEXTO
ENDIF
select 1
use &file

SAVE SCRE TO WSCREIMP
STORE "OPCIONES: (M)ONITOR, (I)MPRESORA, (S)ALIR" to mess
store "M" TO P1
STORE "I" TO P2
STORE "S" TO P3
STORE " " TO RESP
DO PIDE3 WITH P1, P2, P3, MESS, RESP
STORE "" TO WSALIDA
IF RESP = "M"
   STORE 20  TO WSALTO
   STORE "M" TO WSALIDA
   SET DEVI  TO SCRE
ELSE
   IF RESP = "I"
      STORE 55  TO WSALTO
      STORE "I" TO WSALIDA
      SET DEVI  TO PRINT
   ENDIF
ENDIF
*
IF RESP<>"S"
   STORE 100 TO WLINE
   STORE 0   TO WPAGE
   GO TOP
   DO WHILE .NOT. EOF()
      STORE WLINE+1 TO WLINE
      IF WLINE>=WSALTO
         DO HEADER
      ENDIF
      @ WLINE,00 SAY MESES      PICTURE "###.#"
      @ WLINE,06 SAY PREAVISO   PICTURE "###.#"
      @ WLINE,12 SAY PREAVISO2  PICTURE "###.#"
      @ WLINE,18 SAY ANTIGUEDAD PICTURE "###.#"
      @ WLINE,24 SAY ANTIGUEDA2 PICTURE "###.#"
      @ WLINE,30 SAY CESANTIA   PICTURE "###.#"
      @ WLINE,36 SAY VACACION   PICTURE "###.#"
      @ WLINE,42 SAY BONOVAC    PICTURE "###.#"
      @ WLINE,48 SAY UTILIDAD   PICTURE "###.#"
      @ WLINE,54 SAY INDENADD   PICTURE "###.#"
      @ WLINE,60 SAY INDENCOM   PICTURE "###.#"
      SKIP
   ENDDO
ENDIF
IF WSALIDA="M"
   STORE "OPRIMA <ENTER> PARA FINALIZAR" TO MES
   DO AVISO WITH MES
ELSE
   IF WSALIDA = "I"
      EJECT
   ENDIF
ENDIF
SET DEVI TO SCRE
REST SCRE FROM WSCREIMP
RETURN
************
PROC HEADER
************
STORE WPAGE+1 TO WPAGE
IF WSALIDA="M"
   IF WPAGE>1
      STORE "OPRIMA <ENTER> PARA CONTINUAR" TO MES
      DO AVISO WITH MES
   ENDIF
   @ 0,0 CLEAR
ENDIF
IF LASTKEY()=27
   GO BOTT
ENDIF
@ 00,00 SAY QQWW
@ 00,60 SAY "FECHA  : "+DTOC(DATE())
@ 01,00 SAY "SISTEMA DE NOMINA"
@ 01,60 SAY "PAGINA : "+STR(WPAGE,2)
@ 02,00 SAY "LISTADO DE TABLA DE LIQUIDACION "+TEXTO
@ 04,00 SAY "Meses  P.L.  P.A.  A.L.  A.C.  A.A.  VAC.  B.V.  UTL.  I.A.  I.C."
@ 05,00 SAY "----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----"
STORE 06 TO WLINE
RETURN
