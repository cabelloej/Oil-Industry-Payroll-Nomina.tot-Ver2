SELECT 1
USE IPNPERSO INDEX IPNPERSO 
SELECT 2
USE IPNHISTO INDEX IPNHISTO, IPNHIST2

STORE "RESUMEN ESTIMADO DE LIQUIDACION" TO HEADING
DO WHILE .T.
   SET COLOR TO W+/B
   @ 5,1 CLEAR TO 18,50
   @ 5,1 TO 18,50 DOUBLE
   @ 5,10 SAY HEADING
   @ 7,3 SAY "NOMINA:"
   STORE SPACE(05) TO XNOMINA
   STORE "INGRESE LA NOMINA A ESTIMAR. ENTER=TODAS, ESC=SALIR" TO MES
   DO MENSAJE WITH MES
   @ 7,11 get XNOMINA
   READ
   IF XNOMINA=SPACE(5).OR.LASTKEY() = 27
      EXIT
   ENDIF
   STORE 100 TO WLINE
   STORE 0   TO WTOTREP
   SELECT 1
   GO TOP
   DO WHILE .NOT. EOF()
      IF XNOMINA<>SPACE(5).AND.XNOMINA<>NOMINA
         SELECT IPNPERSO
         SKIP
         LOOP
      ENDIF
      IF NOMINA=SPACE(5)
         SELECT IPNPERSO
         SKIP
         LOOP
      ENDIF
      *
      STORE CEDULA                   TO WCEDULA
      STORE CTOD("  -  -    ")       TO FECHAINI
      SELECT IPNHISTO
      SEEK WCEDULA
      DO WHILE .NOT. EOF() .AND. CEDULA=WCEDULA
         IF NOMINA="LIQUI"
            STORE FECHA              TO FECHAINI
         ENDIF
         SKIP
      ENDDO
      SELECT IPNPERSO
      IF FECHAINI=CTOD("  -  -    ")
         STORE INGRESO               TO FECHAINI
      ENDIF
      STORE NOMINA                   TO WNOMINA
      STORE WFECACT                  TO FECHALIQ
      STORE "T"                      TO WTIPOLIQ
      STORE "TERMINACION"            TO WMOTIVO
    
      STORE CONTRATO                 TO WCONTRAEJC
      STORE (FECHALIQ-FECHAINI) + 1  TO WTOTDIAS
      store int(wtotdias/30.4166667) to wmes, wmesant
      store wtotdias/30              to xmes
      store wtotdias-(wmes*30)       to wdias
      IF WDIAS >= 27
         STORE WMES+1                TO WMES, WMESANT
         STORE WMES                  TO XMES
         STORE 0                     TO WDIAS
      ENDIF
      STORE INT(WMES*30)+WDIAS       TO WTOTDIAS
      STORE ipnperso->vacacion       TO FIVAC
      IF FIVAC = CTOD("  -  -    ")
         STORE IPNPERSO->INGRESO     TO FIVAC
      ENDIF
      STORE (FECHALIQ-FIVAC) + 1     TO WTDVAC
      IF WTDVAC < 0
         STORE 0                     TO WTDVAC
      ENDIF
      store int(wtDVAC/30.4166667)   to wmesVAC
      store wtDVAC-(wmesVAC*30)      to wdiasVAC
      IF WMESVAC < 0
         STORE 0                     TO WMESVAC
      ENDIF
      IF WDIASVAC < 0
         STORE 0                     TO WDIASVAC
      ENDIF
      IF WDIASVAC >= 27
         STORE WMESVAC+1             TO WMESVAC
         STORE 0                     TO WDIASVAC
      ENDIF
      STORE INT(WMESVAC*30)+WDIASVAC TO WTDVAC
      IF WCONTRAEJC = "PETROLERO"
         if wmes > 12 .and. wmes < 20
            store wmes - 12          to wliqejc
            STORE WMES               TO WLASTWMES
            STORE 12                 TO WMES
         else
            store 0                  to wliqejc
            STORE WMES               TO WLASTWMES
         endif
      ENDIF

      STORE 0                        TO WMESAA

      STORE NOMINA                   TO WNOMINA
      STORE NOMBRE                   TO WNOMBRE
      STORE APELLIDO                 TO WAPELLIDO
      STORE INGRESO                  TO WINGRESO
      STORE CONTRATO                 TO WCONTRATO
      STORE SUELDO                   TO WSUELDO
      STORE BONOCO                   TO WBONOCO
      STORE TIPO                     TO WTIPO

      STORE 0                        TO BSPREAVISO
      STORE 0                        TO BSPREAVISO2

      STORE 0                        TO BSANTIGUE
      STORE 0                        TO BSANTIGUE2
      STORE 0                        TO BSCESANTIA

      STORE 0                        TO BSVACACION
      STORE 0                        TO BSBONOVAC

      STORE 0                        TO BSMINIMO
      STORE 0                        TO BSINDCOM

      STORE 0                        TO BASICODIA
      STORE 0                        TO BSEXAMEN

      IF WCONTRATO = "PETROLERO"
         STORE .F.                   TO WFLAGAS
         DO IPNLIQA
      ENDIF
      IF WCONTRATO = "LDT"
         STORE .F.                   TO WFLAGAS
         DO IPNLIQB
      ENDIF
      IF WCONTRATO = "CONSTRUCCION"
         STORE .F.                   TO WFLAGAS
         DO IPNLIQC
      ENDIF
      IF WCONTRATO = "PEQUIVEN"
         STORE .F.                   TO WFLAGAS
         DO IPNLIQD
      ENDIF

      SET DEVI TO PRINT
      DO IMPLIN
      SET DEVI TO SCRE

      SELECT 1
      SKIP
   ENDDO
   STORE WLINE + 2 TO WLINE
   SET DEVI TO PRINT
   @ wline,121 SAY str(WTOTREP,11,2)
   SET DEVI TO SCRE
ENDDO
CLOSE DATA
CLOSE INDEX
RETURN
***************
PROCEDURE SALTO
***************
@ 1,00 SAY CHR(18)+CHR(14)+QQWW
@ 2,00 SAY "RESUMEN DE LIQUIDACIONES AL "+DTOC(WFECACT)
@ 3,00 SAY "NOMINA "+XNOMINA
@ 3,00 SAY CHR(15)

@ 06,00  SAY "CEDULA"
@ 06,11  SAY "NOMBRE Y APELLIDO"
@ 06,35  SAY "MS.EM."
@ 06,43  SAY "MS.LQ."
@ 06,49  say "  PREAVISOS"
@ 06,61  SAY "  ANT.LEGAL"
@ 06,73  SAY "  ANT.CONT." 
@ 06,85  SAY "  ANT.ADIC."     
@ 06,97  SAY "  IND.MI/CO"
@ 06,109 SAY  "VACACIONES"
@ 06,121 SAY  "      TOTAL"
STORE 08 TO WLINE
RETURN
*****************
PROCEDURE IMPLIN
*****************
STORE WLINE+1 TO WLINE
IF WLINE>50
   DO SALTO
ENDIF
@ wline,00  SAY wcedula
@ wline,11  SAY substr((rtrim(wapellido)+", "+wnombre),1,25)
@ wline,35  SAY STR(WMESAA,4)
@ wline,43  SAY STR(WMES,4)
@ wline,49  SAY STR((BSPREAVISO+BSPREAVISO2),11,2)
@ wline,61  SAY STR(BSANTIGUE, 11,2)
@ wline,73  SAY STR(BSANTIGUE2,11,2)
@ wline,85  SAY STR(BSCESANTIA,11,2)
@ wline,97  SAY STR((BSMINIMO+BSINDCOM),11,2)
@ wline,109 SAY STR((BSVACACION+BSBONOVAC),11,2)
STORE BSPREAVISO+BSPREAVISO2+BSANTIGUE+BSANTIGUE2+BSCESANTIA+;
      BSMINIMO+BSINDCOM+BSVACACION+BSBONOVAC TO WNETO
@ wline,121 SAY str(wneto,11,2)
STORE WTOTREP + WNETO TO WTOTREP
RETURN

