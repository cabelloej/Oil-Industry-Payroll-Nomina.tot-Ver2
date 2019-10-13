*********************************************************
*    PROGRAMA PRINCIPAL DE CALCULO DE FEDEICOMISO LDT   *
*********************************************************
   
   @ 11,03 SAY "DESDE             :"
   @ 13,03 SAY "HASTA             :"
   STORE CTOD("01-01-"+STR(YEAR(DATE()-1),4)) TO WFECINI
   IF WINGRESO>WFECINI
      STORE WINGRESO TO WFECINI
   ENDIF
   @ 11,23 GET WFECINI
   READ
   IF LASTKEY()=27.OR.WFECINI=CTOD("  -  -    ")
      RETURN
   ENDIF
   STORE CTOD("31-12-"+STR(YEAR(DATE()-1),4)) TO WFECFIN
   @ 13,23 GET WFECFIN
   READ
   IF LASTKEY()=27.OR.WFECFIN=CTOD("  -  -    ").OR.WFECINI>WFECFIN
      RETURN
   ENDIF
   IF INT(((WFECFIN-WFECINI)/30)) > 12
      STORE "CALCULOS APLICAN PARA PERIODOS DE UN A¥O" TO MES
      DO AVISO WITH MES
      RETURN
   ENDIF
   store "OPCIONES: (C)ONTINUAR, (S)ALIR" to mes
   store "C" to p1
   store "S" to p2
   store " " to resp
   do pide2 with p1,p2,mes,resp
   if resp = "S"
      RETURN
   endif
   STORE .T. TO WFLAGACT
   DO IPNFIDLP
RETURN

