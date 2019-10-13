SAVE SCRE TO WSCREPRE1
select 1
use ipncargos index ipncargos
select 3
use ipnprer  index ipnprer
select 4
use ipnparr  index ipnparr
STORE SPACE(6) TO WCODPRE
STORE .T. TO WELABORA
DO WHILE WELABORA
   @ 00,00 clear
   @ 00,00 SAY QQWW
   @ 01,00 SAY "IMPRIMIR PRESUPUESTO DE GASTOS REEMBOLSABLES"
   @ 02,00 say "PRESUPUESTO:"
   @ 03,00 SAY "DESCRIPCION:"
   STORE "INGRESE CODIGO DEL PRESUPUESTO A IMPRIMIR, <ESC>=SALIR" TO MES
   DO MENSAJE WITH MES
   @ 02,12 GET WCODPRE
   READ
   IF READKEY()=12.OR.READKEY()=268.OR.WCODPRE=SPACE(6)
      CLOSE DATA
      CLOSE INDEX
      RESTORE SCRE FROM WSCREPRE1
      RETURN
   ENDIF
   SELECT 3
   FIND &WCODPRE
   IF EOF()
      STORE "PRESUPUESTO NO REGISTRADO, VERIFIQUE" TO MES
      DO AVISO WITH MES
      LOOP
   ELSE
      STORE DESCRI   TO WDESCRI
      @ 03,12 SAY WDESCRI
      STORE "OPCIONES: (C)ONTINUAR, (S)ALIR" TO MES
      STORE "C" TO P1
      STORE "S" TO P2
      STORE " " TO RESP
      DO PIDE2 WITH P1,P2,MES,RESP
      STORE RESP TO WCS
      IF WCS = "S"
         LOOP
      ENDIF
   ENDIF
   SET DEVI TO PRINT
   *** PARTIDAS
   SELECT 4
   SET EXACT OFF
   FIND &WCODPRE
   SET EXACT ON
   DO WHILE .NOT. EOF() .AND. CODPRE = WCODPRE
      STORE CODCAR TO WCODCAR
      SELECT 1
      FIND &WCODCAR
      IF EOF()
         STORE "NO DEFINIDO EN CARGOS" TO WCARGODES
      ELSE
         STORE DESCRI                  TO WCARGODES
      ENDIF
      SELECT 4
      DO PAR0401
      SKIP
   ENDDO

   SET DEVI TO PRINT
   STORE 0   TO WTOTPRESU
   STORE 100 TO WLINE
   SELECT 4
   SET EXACT OFF
   FIND &WCODPRE
   SET EXACT ON
   DO WHILE .NOT. EOF() .AND. CODPRE = WCODPRE
      STORE WLINE + 1 TO WLINE
      IF WLINE > 55
         @ 00,00 SAY CHR(14)+QQWW
         @ 01,00 say "PRESUPUESTO DE SUMINISTRO DE PERSONAL POR GASTOS REEMBOLSABLES"
         @ 03,00 SAY WCODPRE+" "+WDESCRI
         @ 04,00 SAY "+-------------------------------------+----------+--------------+--------------+"
         @ 05,00 SAY "|                                     |          |      COSTO   |     COSTO    |"
         @ 06,00 SAY "|       D E S C R I P C I O N         | CANTIDAD |     UNITARIO |     TOTAL    |"
         @ 07,00 SAY "+-------------------------------------+----------+--------------+--------------+"
         STORE 8 TO WLINE
      ENDIF
      STORE CODCAR TO WCODCAR
      SELECT 1
      FIND &WCODCAR
      IF EOF()
         STORE "NO DEFINIDO EN CARGOS" TO WCARGODES
      ELSE
         STORE DESCRI                  TO WCARGODES
      ENDIF
      SELECT 4
      @ WLINE,01 SAY RTRIM(CODPAR)+"-"+WCARGODES
      @ WLINE,40 SAY CANTIDAD    PICTURE "#######.##"
      @ WLINE,52 SAY BSTOTPAR    PICTURE "#,###,###.##"
      STORE CANTIDAD*BSTOTPAR TO WTOTRENG
      @ WLINE,66 SAY WTOTRENG    PICTURE "##,###,###.##"
      @ WLINE,00 SAY "|                                     |          |              |              |"
      STORE WTOTPRESU+WTOTRENG TO WTOTPRESU
      STORE WLINE + 1 TO WLINE
      @ WLINE,00 SAY "+-------------------------------------+----------+--------------+--------------+"
      SKIP
   ENDDO
   STORE WLINE + 1 TO WLINE
   @ WLINE,03 SAY "T O T A L    P R E S U P U E S T O   Bs.                                          |"
   @ WLINE,65 SAY WTOTPRESU PICTURE "###,###,###.##"
   EJECT
   SET DEVI TO SCRE
ENDDO

