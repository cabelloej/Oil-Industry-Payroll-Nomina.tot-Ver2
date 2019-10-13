
STORE .T. TO WMMM
DO WHILE WMMM
   @ 09,54  PROMPT " Elaborar Presupuesto    "
   @ 10,54  PROMPT " Imprimir Presupuesto    "
   @ 11,54  PROMPT " Elaborar Valuacion      "
   @ 12,54  PROMPT " Imprimir Valuacion      "
   MENU TO WOPPRE
   IF WOPPRE = 1
      DO IPN0402A
   ENDIF
   IF WOPPRE = 2
      DO IPN0402B
   ENDIF
   IF WOPPRE = 3
      DO IPN0402C
   ENDIF
   IF WOPPRE = 4
      DO IPN0402D
   ENDIF
   IF WOPPRE = 0
      EXIT
   ENDIF
ENDDO
