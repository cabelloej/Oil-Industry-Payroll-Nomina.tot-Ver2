SELECT 1
USE IPNPERSO INDEX IPNPERSO
STORE .T. TO WER
DO WHILE WER
   STORE SPACE(10) TO WCEDULA
   SET COLOR TO W+/B
   @ 5,0 CLEAR TO 20,79
   @ 5,0 TO 20,79
   @ 5,30 SAY "CONCEPTOS FIJOS ADICIONALES"
   @ 7,1 SAY   "CEDULA :" GET WCEDULA
   @ 10,1 SAY  "SOBRETPO. DIURNO 3 Hrs. :"
   @ 11,1 SAY  "SOBREMPO. MIXTO  3 Hrs. :"
   @ 12,1 SAY  "SOBREMPO. NOCT.  3 Hrs. :"
   @ 14,1 SAY  "TMPO.VIAJE DIURNO DE 1.5:"
   @ 15,1 SAY  "TMPO.VIAJE MIXTO  DE 1.5:"
   @ 16,1 SAY  "TMPO.VIAJE NOCT.  DE 1.5:"
   @ 18,1 SAY  "MONTO PRESTAMO PERSONAL :"
   @ 19,1 SAY  "CUOTA PRESTAMO PERSONAL :"
   @ 10,40 SAY "CODIGO Y MONTO BONIFIC.:"
   @ 11,40 SAY "CODIGO Y MONTO NO BON. :"
   @ 12,40 SAY "CODIGO Y MONTO DEDUC.  :"
   @ 14,40 SAY "COMIDAS POR DIA        :"
   @ 16,40 SAY "DIFERENCIA DE RETROACT.:"
   @ 17,40 SAY "SUJETO A UTILIDAD ACUM.:"
   @ 18,40 SAY "MOSTRAR ACUM. EN SOBRE :" 
   READ
   IF WCEDULA = SPACE(10)
      SET COLOR TO
      CLOSE DATA
      CLOSE INDEX
      RETURN
   ENDIF
   FIND &WCEDULA
   IF EOF()
      STORE "CEDULA NO REGISTRADA, REINTENTE" TO MES
      DO AVISO WITH MES
      LOOP
   ENDIF
   @ 5,30 SAY "CONCEPTOS FIJOS ADICIONALES"
   @ 10,27  GET ST1
   @ 11,27  GET ST2
   @ 12,27  GET ST3
   @ 14,27  GET TV1
   @ 15,27  GET TV2
   @ 16,27  GET TV3
   @ 18,27  GET MP
   @ 19,27  GET CP
   @ 10,65 GET CB
   @ 10,69 GET MB PICTURE "###,###.##"
   @ 11,65 GET CNB
   @ 11,69 GET MNB PICTURE "###,###.##"
   @ 12,65 GET CD
   @ 12,69 GET MD PICTURE "###,###.##"
   @ 14,69 GET COMIDAS PICTURE "##"
   @ 16,65 GET DIFERENCIA PICTURE "####.##"
   @ 17,65 GET UTILACUM   PICTURE "##,###,###.##"
   @ 18,65 GET SHOWACUM PICTURE "!"
   READ
ENDDO
