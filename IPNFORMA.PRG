**************************************
DO CASE
   CASE LN = 1
@ PROW(),PCOL() SAY CHR(18)
@ 0,5   SAY CHR(14)+QQWW
@ 1,5   SAY CHR(18)+"OBRA EN EJECUCION :"
@ 1,95  SAY CHR(15)+"здддбддддддддддддддддддбдддбддддддддддддддддбдддбддддддддддддддд©"+CHR(18)
@ 2,5   SAY CHR(18)+WCODNOM+" "+NOMINA->DESNOM
@ 2,95  SAY CHR(15)+"ЁCODЁBONIFICABLES      ЁCODЁNO BONIFICABLE  ЁCODЁ DEDUCCIONES   Ё"+CHR(18)
@ 3,94  SAY CHR(15)+"цдддеддддддддддддддддддедддеддддддддддддддддедддеддддддддддддддд╢"+CHR(18)
@ 4,5   SAY CHR(18)+"CONTRATO U ORDEN DE SERVICIO:"
@ 4,95  SAY CHR(15)+"Ё6toЁPAGO SEXTO DIA    ЁANIЁACC. NO INDUST. ЁSV ЁSEGURO DE VIDA Ё"+CHR(18)
@ 5,5   SAY CHR(18)+NOMINA->CONTRATO
@ 5,95  SAY CHR(15)+"ЁM  ЁMANUTENCION       ЁENPЁENFER. NO PROF. ЁCCOЁCTAS.x C. OTROSЁ"+CHR(18)
@ 6,94  SAY CHR(15)+"ЁMTPЁMEZCLA TETRAPLOMO ЁEMPЁEXA.MED.PRE EMP.ЁI  ЁINAVI          Ё"+CHR(18)
@ 7,5   SAY CHR(18)+"PERIODO"
@ 7,95  SAY CHR(15)+"ЁPA ЁPRIMA DE ALTURA   ЁBVPЁBONO VAC.PRORAT.Ё   Ё               Ё"+CHR(18)
IF WFROM = 1
   @ 8,5   SAY CHR(18)+"DEL "+DTOC(nomina->APERT1)+" AL "+DTOC(nomina->APERT2)
   @ 8,95  SAY CHR(15)+"Ё   Ё                  Ё   Ё                Ё   Ё               Ё"+CHR(18)
   @ 9,94  SAY CHR(15)+"Ё   Ё                  Ё   Ё                Ё   Ё               Ё"+CHR(18)
   @ 10,5  SAY CHR(18)+"FECHA DE ELABORACION:"+DTOC(WFECACT)
ELSE
   IF WFROM = 2
      @ 8,5   SAY CHR(18)+"DEL "+DTOC(FEC1)+" AL "+DTOC(FEC2)
      @ 8,95  SAY CHR(15)+"Ё   Ё                  Ё   Ё                Ё   Ё               Ё"+CHR(18)
      @ 9,94  SAY CHR(15)+"Ё   Ё                  Ё   Ё                Ё   Ё               Ё"+CHR(18)
   ENDIF
ENDIF
@ 10,95  SAY CHR(15)+"Ё   Ё                  Ё   Ё                Ё   Ё               Ё"+CHR(18)
@ 11,94  SAY CHR(15)+"юдддаддддддддддддддддддадддаддддддддддддддддадддаддддддддддддддды"+CHR(18)


STORE "N O M I N A    D E    P A G O" TO TITULO

@ 12,50-(LEN(TITULO)/2) SAY CHR(18)+CHR(14)+TITULO+CHR(18)
@ PROW(),PCOL() SAY CHR(15)
@ 13,0 SAY   "здддбдддддддддддддддддддддддддддбддддддддддбддддбддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддбдддддддддбддддддддддддддддддддддддддддддбддддддддддддддддддддддддддддбддддддддбддддддддд©"
@ 14,0 SAY   "Ё   Ё      F I R M A            Ё CEDULA   ЁD   Ё                        R  E  M  U  N  E  R  A  C  I  O  N  E  S                              Ё  TOTAL  ЁCONCEPTOS    NO   BONIFICABLESЁ   D E D U C C I O N E S    Ё TOTAL  Ё         Ё"
@ 15,0 SAY   "Ё   цдддддддддддддддддддддддддддадддддддддд╢I   цддддддддддддддбдддддддддддддбддддддддддддбдддддддддддбддддддддддддбддддддддддддбдддддддддддддд╢ BONIFIC.цддддддддбдддддддддддбдддддддддеддддддддбдддддддбддддддддддд╢ DEDUC .ЁP A G O  Ё"
@ 16,0 SAY   "ЁNo.Ё      NOMBRES Y APELLIDOS             ЁA   Ё T.O. DIURNO  ЁS.T. DIURNO  ЁTV. DIURNO  ЁDES.NORMAL ЁAYUDA CIUDADЁB.NOCT.TRAB.Ё    OTROS     Ё         ЁB.TR/AL.ЁUTILIDAD   Ё  TOTAL  ЁI.S.L.R.ЁSINDIC.Ё   OTRAS   Ё        Ё         Ё"
@ 17,0 SAY   "Ё   цддддддддддддддддддддддддддддбддддддддд╢S   Ё T.O. MIXTO   ЁS.T. MIXTO   ЁTV. MIXTO   ЁDES.CON.TR.ЁCOMIDAS     ЁB.NOCT.VIAJEЁ  CONCEPTOS   Ё         ЁB.SUBS. ЁINDEMNIZAC.Ё   NO    ЁS.S.O.  ЁPREST. ЁDEDUCCIONESЁ        ЁN E T O  Ё"
@ 18,0 SAY   "Ё   Ё      CLASIFICACION         ЁBASICO   Ё    Ё T.O. NOCTURNOЁS.T. NOCTURNOЁTV. NOCTURNOЁDES.LEG.TR.ЁREPOSO/COMIDЁPRIM.DOM/FERЁ BONIFICABLES Ё         ЁCESTA B.ЁOTROS      Ё BONIFIC.ЁS.P.F.  ЁCAJA A.Ё           Ё        Ё         Ё"
@ 19,0 SAY   "Ё   цддддддддддддддддддддддддддддеддддддддд╢    Ё              ЁS.T. GUARDIA Ё            ЁDES.COMPEN.ЁFERIADOS    ЁB.COMPENSAT.Ё              Ё         ЁVIVIENDAЁOTROS      Ё         ЁAHO.HAB.Ё       Ё           Ё        Ё         Ё"
@ 20,0 SAY   "Ё   Ё                            ЁNORMAL   Ё    Ё Hr Ё  Bs.    ЁHr  Ё  Bs.   Ё Hr Ё   Bs. ЁHrЁ  Bs    ЁHr Ё  Bs    ЁHr Ё  Bs    ЁCDЁHrЁ  Bs    Ё   Bs    Ё   Bs   ЁCDЁ  Bs    Ё   Bs    Ё   Bs   Ё  Bs   ЁCDЁ  Bs    Ё   Bs   Ё   Bs    Ё"

   CASE LN = 2
@ LINE,0 SAY "Ё   Ё                           Ё          Ё    Ё    Ё         Ё    Ё        Ё    Ё       Ё  Ё        Ё   Ё        Ё   Ё        Ё  Ё  Ё        Ё         Ё        Ё  Ё        Ё         Ё        Ё       Ё  Ё        Ё        Ё         Ё"

   CASE LN = 3
@ LINE,0 SAY "Ё   цдддддддддддддддддддддддддддаддддддддддеддддеддддедддддддддеддддеддддддддеддддедддддддеддеддддддддедддеддддддддедддеддддддддеддеддеддддддддедддддддддеддддддддеддеддддддддедддддддддеддддддддедддддддеддеддддддддеддддддддеддддддддд╢"

   CASE LN = 4
@ LINE,0 SAY "Ё   Ё                                      Ё    Ё    Ё         Ё    Ё        Ё    Ё       Ё  Ё        Ё   Ё        Ё   Ё        Ё  Ё  Ё        Ё         Ё        Ё  Ё        Ё         Ё        Ё       Ё  Ё        Ё        Ё         Ё"

   CASE LN = 5
@ LINE,0 SAY "Ё   цддддддддддддддддддддддддддддбдддддддддеддддеддддедддддддддеддддеддддддддеддддедддддддеддеддддддддедддеддддддддедддеддддддддеддеддеддддддддедддддддддеддддддддеддеддддддддедддддддддеддддддддедддддддеддеддддддддеддддддддеддддддддд╢"

   CASE LN = 6
@ LINE,0 SAY "Ё   Ё                            Ё         Ё    Ё    Ё         Ё    Ё        Ё    Ё       Ё  Ё        Ё   Ё        Ё   Ё        Ё  Ё  Ё        Ё         Ё        Ё  Ё        Ё         Ё        Ё       Ё  Ё        Ё        Ё         Ё"

   CASE LN = 6.5
@ LINE,0 SAY "Ё   цддддддддддддддддддддддддддддедддддддддеддддеддддедддддддддеддддеддддддддеддддедддддддеддеддддддддедддеддддддддедддеддддддддеддеддеддддддддедддддддддеддддддддеддеддддддддедддддддддеддддддддедддддддеддеддддддддеддддддддеддддддддд╢"

   CASE LN = 7
@ LINE,0 SAY "цдддедддддддддддддддддддддддддддбадддддддддеддддеддддедддддддддеддддеддддддддеддддедддддддеддеддддддддедддеддддддддедддеддддддддеддеддеддддддддедддддддддеддддддддеддеддддддддедддддддддеддддддддедддддддеддеддддддддеддддддддеддддддддд╢"

   CASE LN = 8
@ LINE,0 SAY "юдддаддддддддддддддддддддддддддддадддддддддаддддаддддадддддддддаддддаддддддддаддддадддддддаддаддддддддадддаддддддддадддаддддддддаддаддаддддддддадддддддддаддддддддаддаддддддддадддддддддаддддддддадддддддаддаддддддддаддддддддаддддддддды"

ENDCASE
RETURN
************************************
