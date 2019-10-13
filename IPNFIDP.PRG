***********************************************************************
***      PROGRAMA PRINCIPAL DE CALCULO DE FIDEICOMISO PETROLERO     ***
***********************************************************************

   @ 11,03 SAY "ULTIMO PAGO AL MES:"
   @ 13,03 SAY "CALCULAR AL MES   :"
   IF WMESINI = 0
      STORE 12 TO WMESINI
   ENDIF
   @ 11,23 GET WMESINI PICTURE "###"
   READ
   IF LASTKEY()=27
      CLOSE DATA
      CLOSE INDEX
      SET EXACT ON
      RETURN
   ENDIF
   IF (WMESINI=0) .OR. (WMESINI/12-INT(WMESINI/12)<>0)
      STORE "MES INICIAL INVALIDO" TO MES
      DO AVISO WITH MES
      CLOSE DATA
      CLOSE INDEX
      SET EXACT ON
      RETURN
   ENDIF
   STORE WMESINI+12 TO WMESFIN
   @ 13,23 get WMESFIN PICTURE "###"
   READ
   IF (WMESFIN/12-INT(WMESFIN/12)<>0)
      STORE "MES FINAL INVALIDO" TO MES
      DO AVISO WITH MES
      CLOSE DATA
      CLOSE INDEX
      SET EXACT ON
      RETURN
   ENDIF

   if wretiro = ctod("  -  -    ")
      store wfecact to wretiro
   endif
   
   STORE 12 TO WMESNO

   store "OPCIONES: (C)ONTINUAR, (S)ALIR" to mes
   store "C" to p1
   store "S" to p2
   store " " to resp
   do pide2 with p1,p2,mes,resp
   if resp = "C"
      STORE .T. TO WFLAGACT
      DO IPNFIDPP
   ENDIF
CLOSE DATA
CLOSE INDEX
SET EXACT ON
RETURN

