**************************************
DO CASE
   CASE LN = 1
@ PROW(),PCOL() SAY CHR(18)
@ 0,5   SAY CHR(14)+QQWW
@ 1,5   SAY CHR(18)+"OBRA EN EJECUCION :"
@ 1,95  SAY CHR(15)+"���������������������������������������������������������������Ŀ"+CHR(18)
@ 2,5   SAY CHR(18)+WCODNOM+" "+NOMINA->DESNOM
@ 2,95  SAY CHR(15)+"�COD�BONIFICABLES      �COD�NO BONIFICABLE  �COD� DEDUCCIONES   �"+CHR(18)
@ 3,94  SAY CHR(15)+"���������������������������������������������������������������Ĵ"+CHR(18)
@ 4,5   SAY CHR(18)+"CONTRATO U ORDEN DE SERVICIO:"
@ 4,95  SAY CHR(15)+"�6to�PAGO SEXTO DIA    �ANI�ACC. NO INDUST. �SV �SEGURO DE VIDA �"+CHR(18)
@ 5,5   SAY CHR(18)+NOMINA->CONTRATO
@ 5,95  SAY CHR(15)+"�M  �MANUTENCION       �ENP�ENFER. NO PROF. �CCO�CTAS.x C. OTROS�"+CHR(18)
@ 6,94  SAY CHR(15)+"�MTP�MEZCLA TETRAPLOMO �EMP�EXA.MED.PRE EMP.�I  �INAVI          �"+CHR(18)
@ 7,5   SAY CHR(18)+"PERIODO"
@ 7,95  SAY CHR(15)+"�PA �PRIMA DE ALTURA   �BVP�BONO VAC.PRORAT.�   �               �"+CHR(18)
IF WFROM = 1
   @ 8,5   SAY CHR(18)+"DEL "+DTOC(nomina->APERT1)+" AL "+DTOC(nomina->APERT2)
   @ 8,95  SAY CHR(15)+"�   �                  �   �                �   �               �"+CHR(18)
   @ 9,94  SAY CHR(15)+"�   �                  �   �                �   �               �"+CHR(18)
   @ 10,5  SAY CHR(18)+"FECHA DE ELABORACION:"+DTOC(WFECACT)
ELSE
   IF WFROM = 2
      @ 8,5   SAY CHR(18)+"DEL "+DTOC(FEC1)+" AL "+DTOC(FEC2)
      @ 8,95  SAY CHR(15)+"�   �                  �   �                �   �               �"+CHR(18)
      @ 9,94  SAY CHR(15)+"�   �                  �   �                �   �               �"+CHR(18)
   ENDIF
ENDIF
@ 10,95  SAY CHR(15)+"�   �                  �   �                �   �               �"+CHR(18)
@ 11,94  SAY CHR(15)+"�����������������������������������������������������������������"+CHR(18)


STORE "N O M I N A    D E    P A G O" TO TITULO

@ 12,50-(LEN(TITULO)/2) SAY CHR(18)+CHR(14)+TITULO+CHR(18)
@ PROW(),PCOL() SAY CHR(15)
@ 13,0 SAY   "���������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������Ŀ"
@ 14,0 SAY   "�   �      F I R M A            � CEDULA   �D   �                        R  E  M  U  N  E  R  A  C  I  O  N  E  S                              �  TOTAL  �CONCEPTOS    NO   BONIFICABLES�   D E D U C C I O N E S    � TOTAL  �         �"
@ 15,0 SAY   "�   ��������������������������������������ĴI   ����������������������������������������������������������������������������������������������Ĵ BONIFIC.�����������������������������������������������������������Ĵ DEDUC .�P A G O  �"
@ 16,0 SAY   "�No.�      NOMBRES Y APELLIDOS             �A   � T.O. DIURNO  �S.T. DIURNO  �TV. DIURNO  �DES.NORMAL �AYUDA CIUDAD�B.NOCT.TRAB.�    OTROS     �         �B.TR/AL.�UTILIDAD   �  TOTAL  �I.S.L.R.�SINDIC.�   OTRAS   �        �         �"
@ 17,0 SAY   "�   ��������������������������������������ĴS   � T.O. MIXTO   �S.T. MIXTO   �TV. MIXTO   �DES.CON.TR.�COMIDAS     �B.NOCT.VIAJE�  CONCEPTOS   �         �B.SUBS. �INDEMNIZAC.�   NO    �S.S.O.  �PREST. �DEDUCCIONES�        �N E T O  �"
@ 18,0 SAY   "�   �      CLASIFICACION         �BASICO   �    � T.O. NOCTURNO�S.T. NOCTURNO�TV. NOCTURNO�DES.LEG.TR.�REPOSO/COMID�PRIM.DOM/FER� BONIFICABLES �         �CESTA B.�OTROS      � BONIFIC.�S.P.F.  �CAJA A.�           �        �         �"
@ 19,0 SAY   "�   ��������������������������������������Ĵ    �              �S.T. GUARDIA �            �DES.COMPEN.�FERIADOS    �B.COMPENSAT.�              �         �VIVIENDA�OTROS      �         �AHO.HAB.�       �           �        �         �"
@ 20,0 SAY   "�   �                            �NORMAL   �    � Hr �  Bs.    �Hr  �  Bs.   � Hr �   Bs. �Hr�  Bs    �Hr �  Bs    �Hr �  Bs    �CD�Hr�  Bs    �   Bs    �   Bs   �CD�  Bs    �   Bs    �   Bs   �  Bs   �CD�  Bs    �   Bs   �   Bs    �"

   CASE LN = 2
@ LINE,0 SAY "�   �                           �          �    �    �         �    �        �    �       �  �        �   �        �   �        �  �  �        �         �        �  �        �         �        �       �  �        �        �         �"

   CASE LN = 3
@ LINE,0 SAY "�   �����������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������Ĵ"

   CASE LN = 4
@ LINE,0 SAY "�   �                                      �    �    �         �    �        �    �       �  �        �   �        �   �        �  �  �        �         �        �  �        �         �        �       �  �        �        �         �"

   CASE LN = 5
@ LINE,0 SAY "�   �����������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������Ĵ"

   CASE LN = 6
@ LINE,0 SAY "�   �                            �         �    �    �         �    �        �    �       �  �        �   �        �   �        �  �  �        �         �        �  �        �         �        �       �  �        �        �         �"

   CASE LN = 6.5
@ LINE,0 SAY "�   �����������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������Ĵ"

   CASE LN = 7
@ LINE,0 SAY "���������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������Ĵ"

   CASE LN = 8
@ LINE,0 SAY "�����������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������"

ENDCASE
RETURN
************************************
