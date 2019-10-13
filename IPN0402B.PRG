SAVE SCRE TO WSCREPRE1
select 1
use ipncargos index ipncargos
select 3
use ipnpref  index ipnpref
select 4
use ipnparf  index ipnparf
STORE SPACE(6) TO WCODPRE
STORE .T. TO WELABORA
DO WHILE WELABORA
   @ 00,00 clear
   @ 00,00 SAY QQWW
   @ 01,00 SAY "IMPRIMIR PRESUPUESTO DE GASTOS FIJOS"
   @ 02,00 say "PRESUPUESTO:"
   @ 03,00 SAY "DESCRIPCION:"
   @ 04,00 SAY "+------------------------------------------+-----------+-----------+-----------+"
   @ 05,00 SAY "|DESCRIPCION                               |     DIURNO|      MIXTO|   NOCTURNO|"
   @ 06,00 SAY "+------------------------------------------+-----------+-----------+-----------+"
   @ 07,00 SAY "|DIAS/H NORMALES DE TRABAJO                |           |           |           |"
   @ 08,00 SAY "|HORAS/H DE SOBRETIEMPO                    |           |           |           |"
   @ 09,00 SAY "|DIAS/H DESCANSO TRABAJADO (NO DOMINGO)    |           |           |           |"
   @ 10,00 SAY "|DIAS/H DESCANSO TRABAJADO DOMINGO-FERIADO |           |           |           |"
   @ 11,00 SAY "+------------------------------------------+-----------+-----------+-----------+"
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
      STORE DESCRI   TO WPRESUDES
      STORE DNT1     TO WDNT1
      STORE HST1     TO WHST1
      STORE DND1     TO WDND1
      STORE DSD1     TO WDSD1
      STORE DNT2     TO WDNT2
      STORE HST2     TO WHST2
      STORE DND2     TO WDND2
      STORE DSD2     TO WDSD2
      STORE DNT3     TO WDNT3
      STORE HST3     TO WHST3
      STORE DND3     TO WDND3
      STORE DSD3     TO WDSD3
      STORE CEST     TO WCEST
      STORE CUDNT1   TO WCUDNT1
      STORE CUDNT2   TO WCUDNT2
      STORE CUDNT3   TO WCUDNT3
      STORE CUHST1   TO WCUHST1
      STORE CUHST2   TO WCUHST2
      STORE CUHST3   TO WCUHST3
      STORE CUDTND1  TO WCUDTND1
      STORE CUDTND2  TO WCUDTND2
      STORE CUDTND3  TO WCUDTND3
      STORE CUDTD1   TO WCUDTD1
      STORE CUDTD2   TO WCUDTD2
      STORE CUDTD3   TO WCUDTD3
      STORE CUCESTA  TO WCUCESTA
      @ 03,12 SAY WPRESUDES
      @ 07,45 SAY WDNT1 PICTURE "#######.##"
      @ 08,45 SAY WHST1 PICTURE "#######.##"
      @ 09,45 SAY WDND1 PICTURE "#######.##"
      @ 10,45 SAY WDSD1 PICTURE "#######.##"
      @ 07,57 SAY WDNT2 PICTURE "#######.##"
      @ 08,57 SAY WHST2 PICTURE "#######.##"
      @ 09,57 SAY WDND2 PICTURE "#######.##"
      @ 10,57 SAY WDSD2 PICTURE "#######.##"
      @ 07,69 SAY WDNT3 PICTURE "#######.##"
      @ 08,69 SAY WHST3 PICTURE "#######.##"
      @ 09,69 SAY WDND3 PICTURE "#######.##"
      @ 10,69 SAY WDSD3 PICTURE "#######.##"
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
      ***
      STORE  CANTIDAD     TO  WCANTIDAD
      STORE  CODCAR       TO  WCODCAR
      STORE  FACHORTV     TO  WFACHORTV
      STORE  FACIMPEMP    TO  WFACIMPEMP
      STORE  FACADMEMP    TO  WFACADMEMP
      STORE  FACUTIEMP    TO  WFACUTIEMP
      STORE  FACDESNOR    TO  WFACDESNOR
      STORE  FACSTG       TO  WFACSTG
      STORE  FACBASICO    TO  WSALBAS1
      STORE  FACBASICO    TO  WSALBAS2
      STORE  FACBASICO    TO  WSALBAS3
      STORE  FACBONOCO    TO  WBONOCO1
      STORE  FACBONOCO    TO  WBONOCO2
      STORE  FACBONOCO    TO  WBONOCO3
      STORE  FACAYU       TO  WAYUDA1
      STORE  FACAYU       TO  WAYUDA2
      STORE  FACAYU       TO  WAYUDA3
      STORE  BSTMPVIA1    TO  WTMPVIA1
      STORE  BSTMPVIA2    TO  WTMPVIA2
      STORE  BSTMPVIA3    TO  WTMPVIA3
      STORE  BSBONONOC1   TO  WBONONOCT1
      STORE  BSBONONOC2   TO  WBONONOCT2
      STORE  BSBONONOC3   TO  WBONONOCT3
      STORE  BSREPCOM1    TO  WREPCOM1
      STORE  BSREPCOM2    TO  WREPCOM2
      STORE  BSREPCOM3    TO  WREPCOM3
      STORE  BSSTG1       TO  WSTG1
      STORE  BSSTG2       TO  WSTG2
      STORE  BSSTG3       TO  WSTG3
      STORE  BSTOTBON1    TO  WTOTBON1
      STORE  BSTOTBON2    TO  WTOTBON2
      STORE  BSTOTBON3    TO  WTOTBON3
      STORE  BSBONOVAC1   TO  WBONOVAC1
      STORE  BSBONOVAC2   TO  WBONOVAC2
      STORE  BSBONOVAC3   TO  WBONOVAC3
      STORE  BSUTIPER1    TO  WUTIPER1
      STORE  BSUTIPER2    TO  WUTIPER2
      STORE  BSUTIPER3    TO  WUTIPER3
      STORE  BSLIQUI1     TO  WLIQUI1
      STORE  BSLIQUI2     TO  WLIQUI2
      STORE  BSLIQUI3     TO  WLIQUI3
      STORE  BSPREAVI1    TO  WPREAVI1
      STORE  BSPREAVI2    TO  WPREAVI2
      STORE  BSPREAVI3    TO  WPREAVI3
      STORE  BSVACA1      TO  WVACA1
      STORE  BSVACA2      TO  WVACA2
      STORE  BSVACA3      TO  WVACA3
      STORE  BSIMPREVI1   TO  WIMPREVI1
      STORE  BSIMPREVI2   TO  WIMPREVI2
      STORE  BSIMPREVI3   TO  WIMPREVI3
      STORE  BSSSO        TO  WSSO1
      STORE  BSSSO        TO  WSSO2
      STORE  BSSSO        TO  WSSO3
      STORE  BSSPF        TO  WSPF1
      STORE  BSSPF        TO  WSPF2
      STORE  BSSPF        TO  WSPF3
      STORE  BSINCE1      TO  WINCE1
      STORE  BSINCE2      TO  WINCE2
      STORE  BSINCE3      TO  WINCE3
      STORE  BSLAH        TO  WLAH1
      STORE  BSLAH        TO  WLAH2
      STORE  BSLAH        TO  WLAH3
      STORE  BSBONOTRA    TO  WBONOTRAN1
      STORE  BSBONOTRA    TO  WBONOTRAN2
      STORE  BSBONOTRA    TO  WBONOTRAN3
      STORE  BSBONOALI    TO  WBONOALIM1
      STORE  BSBONOALI    TO  WBONOALIM2
      STORE  BSBONOALI    TO  WBONOALIM3
      STORE  BSEQUIPO     TO  WEQUIPO1
      STORE  BSEQUIPO     TO  WEQUIPO2
      STORE  BSEQUIPO     TO  WEQUIPO3
      STORE  BSTOTGAST1   TO  WTOTGAST1
      STORE  BSTOTGAST2   TO  WTOTGAST2
      STORE  BSTOTGAST3   TO  WTOTGAST3
      STORE  BSGASTADM1   TO  WGASTADM1
      STORE  BSGASTADM2   TO  WGASTADM2
      STORE  BSGASTADM3   TO  WGASTADM3
      STORE  BSSUBTOT11   TO  WSUBTOT11
      STORE  BSSUBTOT12   TO  WSUBTOT12
      STORE  BSSUBTOT13   TO  WSUBTOT13
      STORE  BSUTIEMP1    TO  WUTIEMP1
      STORE  BSUTIEMP2    TO  WUTIEMP2
      STORE  BSUTIEMP3    TO  WUTIEMP3
      STORE  BSSUBTOT21   TO  WSUBTOT21
      STORE  BSSUBTOT22   TO  WSUBTOT22
      STORE  BSSUBTOT23   TO  WSUBTOT23
      STORE  BSDESNOR1    TO  WDESNOR1
      STORE  BSDESNOR2    TO  WDESNOR2
      STORE  BSDESNOR3    TO  WDESNOR3
      STORE  BSCOSTO1     TO  WCOSTO1
      STORE  BSCOSTO2     TO  WCOSTO2
      STORE  BSCOSTO3     TO  WCOSTO3
      STORE  BSST1        TO  WHORST1
      STORE  BSST2        TO  WHORST2
      STORE  BSST3        TO  WHORST3
      STORE  BSDTND1      TO  WDTND1
      STORE  BSDTND2      TO  WDTND2
      STORE  BSDTND3      TO  WDTND3
      STORE  BSDTD1       TO  WDTD1
      STORE  BSDTD2       TO  WDTD2
      STORE  BSDTD3       TO  WDTD3
      STORE  BSCESTA      TO  WCESTA1
      STORE  BSCESTA      TO  WCESTA2
      STORE  BSCESTA      TO  WCESTA3

      @ 00,00 say chr(18)
      @ 00,00 say chr(14)+qqww
      @ 01,00 say "PRESUPUESTO DE SUMINISTRO DE PERSONAL POR GASTOS FIJOS"
      @ 02,00 say RTRIM(WCODPRE)+" "+WPRESUDES
      @ 03,00 say "CARGO:"+RTRIM(WCODCAR)+" "+WCARGODES
      @ 03,55 say "CANTIDAD:"+STR(WCANTIDAD,10,2)
      @ 04,00 SAY "+----------------------------------+------------+------------+-----------+"
      @ 05,00 SAY "|                                  |   DIURNO   |   MIXTO    | NOCTURNO  |"
      @ 06,00 SAY "+----------------------------------+------------+------------+-----------+"

      @ 07,0 SAY "|SALARIO BASICO                    |            |            |           |"
      @ 07,36 SAY STR(WSALBAS1,12,2)
      @ 07,49 SAY STR(WSALBAS2,12,2)
      @ 07,61 SAY STR(WSALBAS3,12,2)

      @ 08,0 SAY "|BONO COMPENSATORIO                |            |            |           |"
      @ 08,36 SAY STR(WBONOCO1,12,2)
      @ 08,49 SAY STR(WBONOCO2,12,2)
      @ 08,61 SAY STR(WBONOCO3,12,2)

      @ 09,0 SAY "|AYUDA UNICA Y ESPECIAL            |            |            |           |"
      @ 09,36 SAY STR(WAYUDA1,12,2)
      @ 09,49 SAY STR(WAYUDA2,12,2)
      @ 09,61 SAY STR(WAYUDA3,12,2)

      @ 10,0 SAY "|TIEMPO DE VIAJE ("+STR(WFACHORTV,5,2)+") Hrs.      |            |            |           |"
      @ 10,36 SAY STR(WTMPVIA1,12,2)
      @ 10,49 SAY STR(WTMPVIA2,12,2)
      @ 10,61 SAY STR(WTMPVIA3,12,2)

      @ 11,0 SAY "|BONO NOCTURNO                     |            |            |           |"
      @ 11,36 SAY STR(WBONONOCT1,12,2)
      @ 11,49 SAY STR(WBONONOCT2,12,2)
      @ 11,61 SAY STR(WBONONOCT3,12,2)

      @ 12,0 SAY "|REPOSO Y COMIDA                   |            |            |           |"
      @ 12,36 SAY STR(WREPCOM1,12,2)
      @ 12,49 SAY STR(WREPCOM2,12,2)
      @ 12,61 SAY STR(WREPCOM3,12,2)

      @ 13,0 SAY "|SOBRE TIEMPO DE GUARDIA           |            |            |           |"
      @ 13,36 SAY STR(WSTG1,12,2)
      @ 13,49 SAY STR(WSTG2,12,2)
      @ 13,61 SAY STR(WSTG3,12,2)

      @ 14,0 SAY "|                                  |            |            |           |"
      @ 14,0 SAY "         SUB-TOTAL BONIFICABLE"
      @ 14,0 SAY "         SUB-TOTAL BONIFICABLE"
      @ 14,36 SAY STR(WTOTBON1,12,2)
      @ 14,49 SAY STR(WTOTBON2,12,2)
      @ 14,61 SAY STR(WTOTBON3,12,2)

      @ 15,0 SAY "|BONO VACACIONAL                   |            |            |           |"
      @ 15,36 SAY STR(WBONOVAC1,12,2)
      @ 15,49 SAY STR(WBONOVAC2,12,2)
      @ 15,61 SAY STR(WBONOVAC3,12,2)

      @ 16,0 SAY "|UTILIDADES                        |            |            |           |"
      @ 16,36 SAY STR(WUTIPER1,12,2)
      @ 16,49 SAY STR(WUTIPER2,12,2)
      @ 16,61 SAY STR(WUTIPER3,12,2)

      @ 17,0 SAY "|LIQUIDACION o INDEMNIZACION MINIMA|            |            |           |"
      @ 17,36 SAY STR(WLIQUI1,12,2)
      @ 17,49 SAY STR(WLIQUI2,12,2)
      @ 17,61 SAY STR(WLIQUI3,12,2)

      @ 18,0 SAY "|PREAVISO                          |            |            |           |"
      @ 18,36 SAY STR(WPREAVI1,12,2)
      @ 18,49 SAY STR(WPREAVI2,12,2)
      @ 18,61 SAY STR(WPREAVI3,12,2)

      @ 19,0 SAY "|VACACIONES                        |            |            |           |"
      @ 19,36 SAY STR(WVACA1,12,2)
      @ 19,49 SAY STR(WVACA2,12,2)
      @ 19,61 SAY STR(WVACA3,12,2)

      @ 20,0 SAY "|                                  |            |            |           |"
      @ 20,0 SAY "         IMPREVISTOS"
      @ 20,0 SAY "         IMPREVISTOS"
      @ 20,27 SAY str(Wfacimpemp,6,2)+"%"
      @ 20,36 SAY STR(WIMPREVI1,12,2)
      @ 20,49 SAY STR(WIMPREVI2,12,2)
      @ 20,61 SAY STR(WIMPREVI3,12,2)

      @ 21,0 SAY "|SEGURO SOCIAL                     |            |            |           |"
      @ 21,36 SAY STR(WSSO1    ,12,2)
      @ 21,49 SAY STR(WSSO2    ,12,2)
      @ 21,61 SAY STR(WSSO3    ,12,2)

      @ 22,0 SAY "|SEGURO DE PARO FORZOSO            |            |            |           |"
      @ 22,36 SAY STR(WSPF1    ,12,2)
      @ 22,49 SAY STR(WSPF2    ,12,2)
      @ 22,61 SAY STR(WSPF3    ,12,2)

      @ 23,0 SAY "|I.N.C.E.                          |            |            |           |"
      @ 23,36 SAY STR(WINCE1   ,12,2)
      @ 23,49 SAY STR(WINCE2   ,12,2)
      @ 23,61 SAY STR(WINCE3   ,12,2)

      @ 24,0 SAY "|LEY DE POLITICA HABITACIONAL      |            |            |           |"
      @ 24,36 SAY STR(WLAH1    ,12,2)
      @ 24,49 SAY STR(WLAH2    ,12,2)
      @ 24,61 SAY STR(WLAH3    ,12,2)

      @ 25,0 SAY "|BONO DE TRANSPORTE                |            |            |           |"
      @ 25,36 SAY STR(WBONOTRAN1,12,2)
      @ 25,49 SAY STR(WBONOTRAN2,12,2)
      @ 25,61 SAY STR(WBONOTRAN3,12,2)

      @ 26,0 SAY "|BONO ALIMENTICIO                  |            |            |           |"
      @ 26,36 SAY STR(WBONOALIM1,12,2)
      @ 26,49 SAY STR(WBONOALIM2,12,2)
      @ 26,61 SAY STR(WBONOALIM3,12,2)

      @ 27,0 SAY "|EQUIPOS DE SEGURIDAD              |            |            |           |"
      @ 27,36 SAY STR(WEQUIPO1,12,2)
      @ 27,49 SAY STR(WEQUIPO2,12,2)
      @ 27,61 SAY STR(WEQUIPO3,12,2)

      @ 28,0 SAY "|                                  |            |            |           |"
      @ 28,0 SAY "         TOTAL GASTOS"
      @ 28,0 SAY "         TOTAL GASTOS"
      @ 28,36 SAY STR(WTOTGAST1,12,2)
      @ 28,49 SAY STR(WTOTGAST2,12,2)
      @ 28,61 SAY STR(WTOTGAST3,12,2)

      @ 29,0 SAY "|GASTOS DE ADMINISTACION           |            |            |           |"
      @ 29,27 SAY str(Wfacadmemp,6,2)+"%"
      @ 29,36 SAY STR(WGASTADM1,12,2)
      @ 29,49 SAY STR(WGASTADM2,12,2)
      @ 29,61 SAY STR(WGASTADM3,12,2)

      @ 30,0 SAY "|                                  |            |            |           |"
      @ 30,0 SAY "         SUB-TOTAL"
      @ 30,0 SAY "         SUB-TOTAL"
      @ 30,36 SAY STR(WSUBTOT11,12,2)
      @ 30,49 SAY STR(WSUBTOT12,12,2)
      @ 30,61 SAY STR(WSUBTOT13,12,2)

      @ 31,0 SAY "|UTILIDADES                        |            |            |           |"
      @ 31,27 SAY str(Wfacutiemp,6,2)+"%"
      @ 31,36 SAY STR(WUTIEMP1,12,2)
      @ 31,49 SAY STR(WUTIEMP2,12,2)
      @ 31,61 SAY STR(WUTIEMP3,12,2)

      @ 32,0 SAY "|                                  |            |            |           |"
      @ 32,0 SAY "         SUB-TOTAL"
      @ 32,0 SAY "         SUB-TOTAL"
      @ 32,36 SAY STR(WSUBTOT21,12,2)
      @ 32,49 SAY STR(WSUBTOT22,12,2)
      @ 32,61 SAY STR(WSUBTOT23,12,2)

      @ 33,00 SAY "|FACTOR DESCANSO NORMAL            |            |            |           |"
      @ 33,27 SAY str(Wfacdesnor,6,2)+"%"
      @ 33,36 SAY STR(WDESNOR1,12,2)
      @ 33,49 SAY STR(WDESNOR2,12,2)
      @ 33,61 SAY STR(WDESNOR3,12,2)

      @ 34,0 SAY "|                                  |            |            |           |"
      @ 34,0 SAY "         COSTO POR DIA LABORABLE"
      @ 34,0 SAY "         COSTO POR DIA LABORABLE"
      @ 34,36 SAY STR(WCOSTO1 ,12,2)
      @ 34,49 SAY STR(WCOSTO2 ,12,2)
      @ 34,61 SAY STR(WCOSTO3 ,12,2)

      @ 35,0 SAY "+----------------------------------+------------+------------+-----------+"
      @ 36,0 SAY "|                                  |            |            |           |"
      @ 37,0 SAY "|                                  |            |            |           |"
      @ 38,0 SAY "|HORAS EXTRAS AL                   |            |            |           |"
      @ 38,18 SAY str(Wfacstg,6,2)+"%"
      @ 38,36 SAY STR(WHORST1,12,2)
      @ 38,49 SAY STR(WHORST2,12,2)
      @ 38,61 SAY STR(WHORST3,12,2)

      @ 39,0 SAY "+----------------------------------+------------+------------+-----------+"
      @ 40,0 SAY "|DIAS DESC. TRAB. QUE NO ES DOMINGO|            |            |           |"
      @ 40,36 SAY STR(WDTND1,12,2)
      @ 40,49 SAY STR(WDTND2,12,2)
      @ 40,61 SAY STR(WDTND3,12,2)

      @ 41,0 SAY "+----------------------------------+------------+------------+-----------+"
      @ 42,0 SAY "|DIAS DESC. TRAB. DOMINGO O FERIADO|            |            |           |"
      @ 42,36 SAY STR(WDTD1,12,2)
      @ 42,49 SAY STR(WDTD2,12,2)
      @ 42,61 SAY STR(WDTD3,12,2)

      @ 43,0 SAY "+----------------------------------+------------+------------+-----------+"
      @ 44,0 SAY "|CESTA BASICA/H                    |            |            |           |"
      @ 44,36 SAY STR(WCESTA1,12,2)
      @ 44,49 SAY STR(WCESTA2,12,2)
      @ 44,61 SAY STR(WCESTA3,12,2)
      @ 45,0 SAY "+----------------------------------+------------+------------+-----------+"

      ********
      SELECT 4
      SKIP
   ENDDO
   EJECT

   *** CALCULO DE TOTAL POR RENGLON DEL PRESUPUESTO
   STORE WDNT1*WCUDNT1 TO WCTDNT1
   STORE WDNT2*WCUDNT2 TO WCTDNT2
   STORE WDNT3*WCUDNT3 TO WCTDNT3

   STORE WHST1*WCUHST1 TO WCTHST1
   STORE WHST2*WCUHST2 TO WCTHST2
   STORE WHST3*WCUHST3 TO WCTHST3

   STORE WDND1*WCUDTND1 TO WCTDTND1
   STORE WDND2*WCUDTND2 TO WCTDTND2
   STORE WDND3*WCUDTND3 TO WCTDTND3

   STORE WDSD1*WCUDTD1 TO WCTDTD1
   STORE WDSD2*WCUDTD2 TO WCTDTD2
   STORE WDSD3*WCUDTD3 TO WCTDTD3

   STORE WCEST*WCUCESTA TO WCTCESTA

   *** CALCULO DEL TOTAL GENERAL DEL PRESUPUESTO
   STORE WCTDNT1+WCTDNT2+WCTDNT3+WCTHST1+WCTHST2+WCTHST3+WCTDTND1+WCTDTND2+WCTDTND3+;
         WCTDTD1+WCTDTD2+WCTDTD3+WCTCESTA TO WTOTPRESU

   @ 00,00 SAY CHR(14)+QQWW
   @ 01,00 say "PRESUPUESTO DE SUMINISTRO DE PERSONAL POR GASTOS FIJOS"
   @ 03,00 SAY WCODPRE+" "+WPRESUDES
   @ 04,00 SAY "+----------------------------------------+----------+-----------+--------------+"
   @ 05,00 SAY "|                                        |CANTIDAD A|   COSTO   |     COSTO    |"
   @ 06,00 SAY "|       D E S C R I P C I O N            |CONTRATAR |  UNITARIO |     TOTAL    |"
   @ 07,00 SAY "+----------------------------------------+----------+-----------+--------------+"
   @ 08,00 SAY "|1. 1er.TURNO (DIURNO) 7:00 AM - 3:00 PM |          |           |              |"
   @ 08,00 SAY "|1. 1er.TURNO (DIURNO) 7:00 AM - 3:00 PM |          |           |              |"
   @ 09,00 SAY "|                                        |          |           |              |"
   @ 10,00 SAY "|1.1. DIAS/H NORMALES DE TRABAJO         |          |           |              |"
   @ 10,42 SAY   WDNT1     PICTURE "#######.##"
   @ 10,52 SAY   WCUDNT1   PICTURE "#,###,###.##"
   @ 10,66 SAY   WCTDNT1   PICTURE "##,###,###.##"
   @ 11,00 SAY "|                                        |          |           |              |"
   @ 12,00 SAY "|1.2. HORAS/H DE SOBRETIEMPO             |          |           |              |"
   @ 12,42 SAY   WHST1     PICTURE "#######.##"
   @ 12,52 SAY   WCUHST1   PICTURE "#,###,###.##"
   @ 12,66 SAY   WCTHST1   PICTURE "##,###,###.##"
   @ 13,00 SAY "|                                        |          |           |              |"
   @ 14,00 SAY "|1.3. DIAS/H DESCANSO TRABAJADO          |          |           |              |"
   @ 14,42 SAY   WDND1     PICTURE "#######.##"
   @ 14,52 SAY   WCUDTND1  PICTURE "#,###,###.##"
   @ 14,66 SAY   WCTDTND1  PICTURE "##,###,###.##"
   @ 15,00 SAY "|     (NO DOMINGO)                       |          |           |              |"
   @ 16,00 SAY "|                                        |          |           |              |"
   @ 17,00 SAY "|1.4. DIAS/H DESCANSO TRABAJADO          |          |           |              |"
   @ 17,42 SAY   WDSD1     PICTURE "#######.##"
   @ 17,52 SAY   WCUDTD1   PICTURE "#,###,###.##"
   @ 17,66 SAY   WCTDTD1   PICTURE "##,###,###.##"
   @ 18,00 SAY "|     (DOMINGO o FERIADO)                |          |           |              |"
   @ 19,00 SAY "|                                        |          |           |              |"

   @ 20,00 SAY "|2. 2do.TURNO (MIXTO) 3:00 PM - 11:00 PM |          |           |              |"
   @ 20,00 SAY "|2. 2do.TURNO (MIXTO) 3:00 PM - 11:00 PM |          |           |              |"
   @ 21,00 SAY "|                                        |          |           |              |"
   @ 22,00 SAY "|2.1. DIAS/H NORMALES DE TRABAJO         |          |           |              |"
   @ 22,42 SAY   WDNT2     PICTURE "#######.##"
   @ 22,52 SAY   WCUDNT2   PICTURE "#,###,###.##"
   @ 22,66 SAY   WCTDNT2   PICTURE "##,###,###.##"
   @ 23,00 SAY "|                                        |          |           |              |"
   @ 24,00 SAY "|2.2. HORAS/H DE SOBRETIEMPO             |          |           |              |"
   @ 24,42 SAY   WHST2     PICTURE "#######.##"
   @ 24,52 SAY   WCUHST2   PICTURE "#,###,###.##"
   @ 24,66 SAY   WCTHST2   PICTURE "##,###,###.##"
   @ 25,00 SAY "|                                        |          |           |              |"
   @ 26,00 SAY "|2.3. DIAS/H DESCANSO TRABAJADO          |          |           |              |"
   @ 26,42 SAY   WDND2     PICTURE "#######.##"
   @ 26,52 SAY   WCUDTND2  PICTURE "#,###,###.##"
   @ 26,66 SAY   WCTDTND2  PICTURE "##,###,###.##"
   @ 27,00 SAY "|     (NO DOMINGO)                       |          |           |              |"
   @ 28,00 SAY "|                                        |          |           |              |"
   @ 29,00 SAY "|2.4. DIAS/H DESCANSO TRABAJADO          |          |           |              |"
   @ 29,42 SAY   WDSD2     PICTURE "#######.##"
   @ 29,52 SAY   WCUDTD2   PICTURE "#,###,###.##"
   @ 29,66 SAY   WCTDTD2   PICTURE "##,###,###.##"
   @ 30,00 SAY "|     (DOMINGO o FERIADO)                |          |           |              |"
   @ 31,00 SAY "|                                        |          |           |              |"

   @ 32,00 SAY "|3. 3er.TURNO (NOCT.) 11:00 PM - 7:00 AM |          |           |              |"
   @ 32,00 SAY "|3. 3er.TURNO (NOCT.) 11:00 PM - 7:00 AM |          |           |              |"
   @ 33,00 SAY "|                                        |          |           |              |"
   @ 34,00 SAY "|3.1. DIAS/H NORMALES DE TRABAJO         |          |           |              |"
   @ 34,42 SAY   WDNT3     PICTURE "#######.##"
   @ 34,52 SAY   WCUDNT3   PICTURE "#,###,###.##"
   @ 34,66 SAY   WCTDNT3   PICTURE "##,###,###.##"
   @ 35,00 SAY "|                                        |          |           |              |"
   @ 36,00 SAY "|3.2. HORAS/H DE SOBRETIEMPO             |          |           |              |"
   @ 36,42 SAY   WHST3     PICTURE "#######.##"
   @ 36,52 SAY   WCUHST3   PICTURE "#,###,###.##"
   @ 36,66 SAY   WCTHST3   PICTURE "##,###,###.##"
   @ 37,00 SAY "|                                        |          |           |              |"
   @ 38,00 SAY "|3.3. DIAS/H DESCANSO TRABAJADO          |          |           |              |"
   @ 38,42 SAY   WDND3     PICTURE "#######.##"
   @ 38,52 SAY   WCUDTND3  PICTURE "#,###,###.##"
   @ 38,66 SAY   WCTDTND3  PICTURE "##,###,###.##"
   @ 39,00 SAY "|     (NO DOMINGO)                       |          |           |              |"
   @ 40,00 SAY "|                                        |          |           |              |"
   @ 41,00 SAY "|3.4. DIAS/H DESCANSO TRABAJADO          |          |           |              |"
   @ 41,42 SAY   WDSD3     PICTURE "#######.##"
   @ 41,52 SAY   WCUDTD3   PICTURE "#,###,###.##"
   @ 41,66 SAY   WCTDTD3   PICTURE "##,###,###.##"
   @ 42,00 SAY "|     (DOMINGO o FERIADO)                |          |           |              |"
   @ 43,00 SAY "|                                        |          |           |              |"

   @ 44,00 SAY "|4. PAGO DE CESTA BASICA                 |          |           |              |"
   @ 44,00 SAY "|4. PAGO DE CESTA BASICA                 |          |           |              |"
   @ 44,42 SAY   WCEST     PICTURE "#######.##"
   @ 44,52 SAY   WCUCESTA  PICTURE "#,###,###.##"
   @ 44,66 SAY   WCTCESTA  PICTURE "##,###,###.##"
   @ 45,00 SAY "|----------------------------------------+----------+-----------+--------------|"
   @ 46,00 SAY "|  T O T A L    C O N T R A T O   Bs.                                          |"
   @ 46,00 SAY "|  T O T A L    C O N T R A T O   Bs.                                          |"
   @ 46,65 SAY WTOTPRESU PICTURE "###,###,###.##"
   @ 46,65 SAY WTOTPRESU PICTURE "###,###,###.##"
   @ 47,00 SAY "+------------------------------------------------------------------------------|"
   EJECT
   SET DEVI TO SCRE
ENDDO

