      STORE WLINE + 1 TO WLINE
      IF WLINE>55
         DO FIDSALTO
      ENDIF
      @ WLINE, 1 SAY "T O T A L   F I D E I C O M I S O   Bs.:"
      @ WLINE,70 SAY WTOTFIDE     PICTURE "#########.##"
      STORE "------------------------------------" TO WX1
      STORE RTRIM(WAPELLIDO)+" "+WNOMBRE TO WX2
      STORE WCEDULA  TO WX3
      @ 54,40-(LEN(WX1)/2) SAY WX1
      @ 55,40-(LEN(WX2)/2) SAY WX2
      @ 56,40-(LEN(WX3)/2) SAY WX3
      SELECT 1
      REPLACE MESFIDE WITH WMESFIN
      EJECT
