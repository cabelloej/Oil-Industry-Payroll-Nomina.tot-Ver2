         IF WFLAGACT
            STORE WLINE+1 TO WLINE
            IF WLINE>55
               DO FIDSALTO
            ENDIF
            @ WLINE,1  SAY WFECINI
            @ WLINE,14 SAY WMESNO      PICTURE "###"
            @ WLINE,23 SAY WSUELDO     PICTURE "######.##"
            @ WLINE,34 SAY WTOTPRES    PICTURE "#########.##"
            @ WLINE,48 SAY WINTERESES  PICTURE "##.##"
            @ WLINE,59 SAY WINTMES     PICTURE "##.##"
            @ WLINE,70 SAY WTOTMES     PICTURE "#########.##"
         ENDIF
         *** SUBTOTAL ANUAL
         IF WFLAGACT
            IF ((WMESNO/12)-INT(WMESNO/12)=0) .AND. WMESNO <> 12
               STORE WLINE+1 TO WLINE
               @ WLINE,0 SAY REPLICATE("-",80)
               STORE WLINE+1 TO WLINE
               @ WLINE,48 SAY "SALDO AL MES "+STR(WMESNO,3)+"  Bs.:"
               @ WLINE,70 SAY WSUBTOT     PICTURE "#########.##"
               STORE 0 TO WSUBTOT
            ENDIF
         ENDIF
