SAVE SCRE TO SCREVAL
*********************************
* IMPRIMIR valuaciones  *
*********************************
SELECT 1
USE IPNPREF  INDEX IPNPREF
SELECT 2
USE IPNVALF  INDEX IPNVALF
SELECT 3
USE IPNOMINA INDEX IPNOMINA

STORE SPACE(6) TO WCODPRE
SET COLOR TO W/N
STORE .T. TO PRE
DO WHILE PRE
   SET COLOR TO W/N
   @ 00,0 CLEAR 
   @ 00,0 SAY QQWW
   @ 01,0 SAY "               I M P R I M I R         V A L U A C I O N E S                    "
   @ 02,0 SAY "+-----------+------------------------------------------------------------------+"
   @ 03,0 SAY "|OBRA:      |DESC.:                                                            |"
   @ 04,0 SAY "+-----------+---+--------------------+----------------+------------------------+"
   @ 05,0 SAY "|VALUACION      |FECHA               |DESDE           |HASTA                   |"
   @ 06,0 SAY "+---------------+--------------------+----------------+------------------------+"
   STORE "CODIGO DE LA OBRA A EVALUAR" to mes
   do mensaje with mes
   @ 3,6 GET WCODPRE
   READ
   if wcodpre = space(6).OR.READKEY()=12.OR.READKEY()=268
      close data
      close index
      @ 0,0 CLEAR
      RESTORE SCRE FROM SCREVAL
      return
   endif
   select 1
   FIND &wcodpre
   IF EOF()
      STORE "Codigo de presupuesto no registrado, (Ù)" to mes
      do aviso with mes
      loop
   endif
   store descri   to wdescri
   store nomina   to wnomina
   @ 03,19 SAY WDESCRI
   SELECT 3
   FIND &WNOMINA
   IF EOF()
      STORE "CODIGO DE NOMINA NO REGISTRADO, VERIFIQUE" TO MES
      DO AVISO WITH MES
   ENDIF
   STORE 100 TO WLINE
   STORE 0   TO WPAGE
   select 2
   set exact off
   find &WCODPRE
   set exact ON
   do while .not. eof() .and. CODPRE = WCODPRE
      STORE WLINE+1 TO WLINE
      IF WLINE>20
         STORE WPAGE + 1 TO WPAGE
         IF WPAGE > 1
            STORE "OPRIMA <ENTER> PARA CONTINUAR" TO MES
            DO AVISO WITH MES
         ENDIF
         @ 7,0 CLEAR
         STORE 7 TO WLINE
      ENDIF
      @ WLINE,01 SAY CODVAL
      @ WLINE,17 SAY FECHA
      @ WLINE,38 SAY DESDE
      @ WLINE,55 SAY HASTA
     skip
   enddo
   STORE "INGRESE EL CODIGO DE VALUACION QUE DESEA IMPRIMIR" TO MES
   DO MENSAJE WITH MES
   STORE SPACE(6) TO WCODVAL
   @ 22,1 GET WCODVAL
   READ
   IF WCODVAL=SPACE(6).OR.READKEY()=12.OR.READKEY()=268
      EXIT
   ENDIF
   STORE WCODPRE+WCODVAL TO WCLAVEVAL
   SELECT 2
   FIND &WCLAVEVAL
   IF EOF()
      STORE "VALUACION NO REGISTRADA, VERIFIQUE" TO MES
      DO AVISO WITH MES
      LOOP
   ENDIF
   SET DEVI TO PRINT
   @ 00,0 SAY CHR(18)
   @ 00,0 SAY CHR(14)+qqww
   @ 01,00 SAY CHR(14)+"INFORME DE EJECUCION DE OBRA"
   @ 03,0 SAY "SE¥ORES  : CORPOVEN, S.A."
   @ 03,65 SAY "FECHA :"+DTOC(IPNVALF->FECHA)
   @ 04,0 SAY "OBRA     : "+IPNPREF->DESCRI
   @ 08,0 SAY "UBICACION:"+IPNOMINA->LUGAR
   @ 09,0 SAY "CONTRATO :"+IPNOMINA->CONTRATO
   @ 10,0 SAY  CHR(14)+"VALUACION  No. "+IPNVALF->CODVAL
   @ 12,0 SAY "PERIODO  :"+DTOC(IPNVALF->DESDE)+" AL "+DTOC(IPNVALF->HASTA)
   @ 13,0 say chr(15)
   @ 13,0 SAY "+-------------+----------------------------------------+-----------+-----------+------------+------------+------------+------------+"
   @ 14,0 SAY "|No.          |DESCRIPCION                             |  UNIDAD   |CANT.CONTR.|COSTOxUNIDAD|CANT.EJECUT.|ACU.AL PERD.|TOT. PARTIDA|"
   @ 15,0 SAY "+-------------+----------------------------------------+-----------+-----------+------------+------------+------------+------------+"
  
   @ 16,0   SAY "|1.           | 1er. TURNO 7:00 A.M. - 3:00 P.M.       |           |           |            |            |            |            |"
   @ 17,0   SAY "|             |                                        |           |           |            |            |            |            |"
   @ 18,0   SAY "|1.1.         | DIAS/H NORMALES DE TRABAJO             |   DIAS    |           |            |            |            |            |"
   @ 18,69  SAY IPNPREF->DNT1                    PICTURE "#######.##"
   @ 18,82  SAY IPNVALF->CUDNT1                  PICTURE "#######.##"
   @ 18,95  SAY IPNVALF->DNT1                    PICTURE "#######.##"
   @ 18,108 SAY IPNVALF->DNT1+IPNVALF->ACDNT1    PICTURE "#######.##"
   STORE IPNVALF->DNT1*IPNVALF->CUDNT1 TO WDNT1
   @ 18,118 SAY WDNT1                            PICTURE "##,###,###.##"
   @ 19,0   SAY "|             |                                        |           |           |            |            |            |            |"

   @ 20,0   SAY "|1.2.         | HORAS/H DE SOBRETIEMPO                 |   HORAS   |           |            |            |            |            |"
   @ 20,69  SAY IPNPREF->HST1                    PICTURE "#######.##"
   @ 20,82  SAY IPNVALF->CUHST1                  PICTURE "#######.##"
   @ 20,95  SAY IPNVALF->HST1                    PICTURE "#######.##"
   @ 20,108 SAY IPNVALF->HST1+IPNVALF->ACHST1    PICTURE "#######.##"
   STORE IPNVALF->HST1*IPNVALF->CUHST1  TO WHST1
   @ 20,118 SAY WHST1                            PICTURE "##,###,###.##"
   @ 21,0   SAY "|             |                                        |           |           |            |            |            |            |"

   @ 22,0   SAY "|1.3.         | DIAS/H DESCANSO TRABAJADO              |   DIAS    |           |            |            |            |            |"
   @ 22,69  SAY IPNPREF->DND1                      PICTURE "#######.##"
   @ 22,82  SAY IPNVALF->CUDTND1                   PICTURE "#######.##"
   @ 22,95  SAY IPNVALF->DTND1                     PICTURE "#######.##"
   @ 22,108 SAY IPNVALF->DTND1+IPNVALF->ACDTND1    PICTURE "#######.##"
   STORE IPNVALF->DTND1*IPNVALF->CUDTND1 TO WDND1
   @ 22,118 SAY WDND1                              PICTURE "##,###,###.##"
   @ 23,0   SAY "|             | (NO DOMINGO)                           |           |           |            |            |            |            |"
   @ 24,0   SAY "|             |                                        |           |           |            |            |            |            |"

   @ 25,0   SAY "|1.4.         | DIAS/H DESCANSO TRABAJADO              |   DIAS    |           |            |            |            |            |"
   @ 25,69  SAY IPNPREF->DSD1                     PICTURE "#######.##"
   @ 25,82  SAY IPNVALF->CUDTD1                   PICTURE "#######.##"
   @ 25,95  SAY IPNVALF->DTD1                     PICTURE "#######.##"
   @ 25,108 SAY IPNVALF->DTD1+IPNVALF->ACDTD1     PICTURE "#######.##"
   STORE IPNVALF->DTD1*IPNVALF->CUDTD1 TO WDSD1
   @ 25,118 SAY WDSD1                             PICTURE "##,###,###.##"
   @ 26,0   SAY "|             | (DOMINGO Y FERIADO)                    |           |           |            |            |            |            |"
   @ 27,0   SAY "|             |                                        |           |           |            |            |            |            |"

   @ 28,0   SAY "|2.           | 2nd. TURNO 3:00 A.M. - 11:00 P.M.      |           |           |            |            |            |            |"
   @ 29,0   SAY "|             |                                        |           |           |            |            |            |            |"
   @ 30,0   SAY "|2.1.         | DIAS/H NORMALES DE TRABAJO             |   DIAS    |           |            |            |            |            |"
   @ 30,69  SAY IPNPREF->DNT2                    PICTURE "#######.##"
   @ 30,82  SAY IPNVALF->CUDNT2                  PICTURE "#######.##"
   @ 30,95  SAY IPNVALF->DNT2                    PICTURE "#######.##"
   @ 30,108 SAY IPNVALF->DNT2+IPNVALF->ACDNT2    PICTURE "#######.##"
   STORE IPNVALF->DNT2*IPNVALF->CUDNT2 TO WDNT2
   @ 30,118 SAY WDNT2                            PICTURE "##,###,###.##"
   @ 31,0   SAY "|             |                                        |           |           |            |            |            |            |"

   @ 32,0   SAY "|2.2.         | HORAS/H DE SOBRETIEMPO                 |   HORAS   |           |            |            |            |            |"
   @ 32,69  SAY IPNPREF->HST2                    PICTURE "#######.##"
   @ 32,82  SAY IPNVALF->CUHST2                  PICTURE "#######.##"
   @ 32,95  SAY IPNVALF->HST2                    PICTURE "#######.##"
   @ 32,108 SAY IPNVALF->HST2+IPNVALF->ACHST2    PICTURE "#######.##"
   STORE IPNVALF->HST2*IPNVALF->CUHST2 TO WHST2
   @ 32,118 SAY WHST2                            PICTURE "##,###,###.##"
   @ 33,0   SAY "|             |                                        |           |           |            |            |            |            |"

   @ 34,0   SAY "|2.3.         | DIAS/H DESCANSO TRABAJADO              |   DIAS    |           |            |            |            |            |"
   @ 34,69  SAY IPNPREF->DND2                      PICTURE "#######.##"
   @ 34,82  SAY IPNVALF->CUDTND2                   PICTURE "#######.##"
   @ 34,95  SAY IPNVALF->DTND2                     PICTURE "#######.##"
   @ 34,108 SAY IPNVALF->DTND2+IPNVALF->ACDTND2    PICTURE "#######.##"
   STORE IPNVALF->DTND2*IPNVALF->CUDTND2 TO WDND2
   @ 34,118 SAY WDND2                              PICTURE "##,###,###.##"
   @ 35,0   SAY "|             | (NO DOMINGO)                           |           |           |            |            |            |            |"
   @ 36,0   SAY "|             |                                        |           |           |            |            |            |            |"

   @ 37,0   SAY "|2.4.         | DIAS/H DESCANSO TRABAJADO              |   DIAS    |           |            |            |            |            |"
   @ 37,69  SAY IPNPREF->DSD2                     PICTURE "#######.##"
   @ 37,82  SAY IPNVALF->CUDTD2                   PICTURE "#######.##"
   @ 37,95  SAY IPNVALF->DTD2                     PICTURE "#######.##"
   @ 37,108 SAY IPNVALF->DTD2+IPNVALF->ACDTD2     PICTURE "#######.##"
   STORE IPNVALF->DTD2*IPNVALF->CUDTD2 TO WDSD2
   @ 37,118 SAY WDSD2                             PICTURE "##,###,###.##"
   @ 38,0   SAY "|             | (DOMINGO Y FERIADO)                    |           |           |            |            |            |            |"
   @ 39,0   SAY "|             |                                        |           |           |            |            |            |            |"

   @ 40,0   SAY "|3.           | 3er. TURNO 11:00 A.M. - 7:00 P.M.      |           |           |            |            |            |            |"
   @ 41,0   SAY "|             |                                        |           |           |            |            |            |            |"
   @ 42,0   SAY "|3.1.         | DIAS/H NORMALES DE TRABAJO             |   DIAS    |           |            |            |            |            |"
   @ 42,69  SAY IPNPREF->DNT3                    PICTURE "#######.##"
   @ 42,82  SAY IPNVALF->CUDNT3                  PICTURE "#######.##"
   @ 42,95  SAY IPNVALF->DNT3                    PICTURE "#######.##"
   @ 42,108 SAY IPNVALF->DNT3+IPNVALF->ACDNT3    PICTURE "#######.##"
   STORE IPNVALF->DNT3*IPNVALF->CUDNT3 TO WDNT3
   @ 42,118 SAY WDNT3                            PICTURE "##,###,###.##"
   @ 43,0   SAY "|             |                                        |           |           |            |            |            |            |"

   @ 44,0   SAY "|3.2.         | HORAS/H DE SOBRETIEMPO                 |   HORAS   |           |            |            |            |            |"
   @ 44,69  SAY IPNPREF->HST3                    PICTURE "#######.##"
   @ 44,82  SAY IPNVALF->CUHST3                  PICTURE "#######.##"
   @ 44,95  SAY IPNVALF->HST3                    PICTURE "#######.##"
   @ 44,108 SAY IPNVALF->HST3+IPNVALF->ACHST3    PICTURE "#######.##"
   STORE IPNVALF->HST3*IPNVALF->CUHST3 TO WHST3
   @ 44,118 SAY WHST3                            PICTURE "##,###,###.##"
   @ 45,0   SAY "|             |                                        |           |           |            |            |            |            |"

   @ 46,0   SAY "|3.3.         | DIAS/H DESCANSO TRABAJADO              |   DIAS    |           |            |            |            |            |"
   @ 46,69  SAY IPNPREF->DND3                      PICTURE "#######.##"
   @ 46,82  SAY IPNVALF->CUDTND3                   PICTURE "#######.##"
   @ 46,95  SAY IPNVALF->DTND3                     PICTURE "#######.##"
   @ 46,108 SAY IPNVALF->DTND3+IPNVALF->ACDTND3    PICTURE "#######.##"
   STORE IPNVALF->DTND3*IPNVALF->CUDTND3 TO WDND3
   @ 46,118 SAY WDND3                              PICTURE "##,###,###.##"
   @ 47,0   SAY "|             | (NO DOMINGO)                           |           |           |            |            |            |            |"
   @ 48,0   SAY "|             |                                        |           |           |            |            |            |            |"

   @ 49,0   SAY "|3.4.         | DIAS/H DESCANSO TRABAJADO              |   DIAS    |           |            |            |            |            |"
   @ 49,69  SAY IPNPREF->DSD3                     PICTURE "#######.##"
   @ 49,82  SAY IPNVALF->CUDTD3                   PICTURE "#######.##"
   @ 49,95  SAY IPNVALF->DTD3                     PICTURE "#######.##"
   @ 49,108 SAY IPNVALF->DTD3+IPNVALF->ACDTD3     PICTURE "#######.##"
   STORE IPNVALF->DTD3*IPNVALF->CUDTD3 TO WDSD3
   @ 49,118 SAY WDSD3                             PICTURE "##,###,###.##"
   @ 50,0   SAY "|             | (DOMINGO Y FERIADO)                    |           |           |            |            |            |            |"
   @ 51,0   SAY "|             |                                        |           |           |            |            |            |            |"

   @ 52,0   SAY "|4.           | CESTA BASICA                           |   UNIDAD  |           |            |            |            |            |"
   @ 52,69  SAY IPNPREF->CEST                     PICTURE "#######.##"
   @ 52,82  SAY IPNVALF->CUCESTA                  PICTURE "#######.##"
   @ 52,95  SAY IPNVALF->CESTA                    PICTURE "#######.##"
   @ 52,108 SAY IPNVALF->CESTA+IPNVALF->ACCESTA   PICTURE "#######.##"
   STORE IPNVALF->CESTA*IPNVALF->CUCESTA TO WCESTA
   @ 52,118 SAY WCESTA                            PICTURE "##,###,###.##"
   @ 53,0   SAY "|             |                                        |           |           |            |            |            |            |"

   STORE WDNT1+WDNT2+WDNT3+WHST1+WHST2+WHST3+WDND1+WDND2+WDND3+WDSD1+WDSD2+WDSD3+WCESTA TO WTOTVAL
   @ 54,0 SAY "+-------------+----------------------------------------+-----------+-----------+------------+------------+------------+------------|"
   @ 55,0 SAY "| T O T A L    V A L U A C I O N   B s.                                                                               |            |"
   @ 55,117 SAY WTOTVAL                            PICTURE "###,###,###.##"
   @ 56,0 SAY "+---------------------------------------------------------------------------------------------------------------------+------------+"
   EJECT
   SET DEVI TO SCRE
ENDDO





