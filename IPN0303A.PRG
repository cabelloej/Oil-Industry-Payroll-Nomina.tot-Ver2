*********************************************************
*    PROGRAMA PRINCIPAL DE LIQUIDACION DE PERSONAL      *
*********************************************************
STORE .T. TO LIQ
SELECT 1
USE IPNPERSO INDEX IPNPERSO
SELECT 2
USE IPNHISTO INDEX IPNHISTO, IPNHIST2
STORE "LIQUIDACION DE PERSONAL" TO HEADING
DO WHILE LIQ
   SET COLOR TO W+/B
   @ 5,1 CLEAR TO 18,70
   @ 5,1 TO 18,70 DOUBLE
   @ 5,10 SAY HEADING
   @ 7,3 SAY "CEDULA:"
   STORE SPACE(10) TO WCEDULA
   STORE "NUMERO DE CEDULA A LIQUIDAR" to mes
   DO MENSAJE WITH MES
   @ 7,11 get WCEDULA
   READ
   IF WCEDULA = SPACE(10)
      CLOSE DATA
      CLOSE INDEX
      RETURN
   ENDIF
   SELECT 1
   SEEK WCEDULA
   IF .NOT. FOUND()
      STORE "CEDULA NO REGISTRADA" to mes
      do aviso with mes
      loop
   endif
   @ 07,30 say rtrim(nombre)+" "+apellido
    
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
   @ 09,3 SAY "FECHA DE INICIO     :" GET FECHAINI
   READ
   
   STORE WFECACT TO FECHALIQ
   @ 11,3 SAY "FECHA DE LIQUIDACION:" GET FECHALIQ
   READ

   @ 13,3 SAY "MOTIVO DE LA LIQUIDACION:"
   STORE "MOTIVO DE LA LIQUIDACION: (T)ERMINACION DE CONTRATO, (D)ESPIDO, (R)ENUNCIA" to mes
   store "T" to p1
   store "D" to p2
   store "R" to p3
   store " " to resp
   do pide3 with p1,p2,p3,mes,resp

   STORE RESP TO WTIPOLIQ
   if resp = "T"
      store "TERMINACION" TO WMOTIVO
   ENDIF
   if resp = "D"
      store "DESPIDO" TO WMOTIVO
      @ 15,3 SAY "TIPO DE DESPIDO :"
      STORE "TIPO DE DESPIDO: (J)USTIFICADO, (I)NJUSTIFICADO" to mes
      store "J" to p1
      store "I" to p2
      store " " to resp
      do pide2 with p1,p2,mes,resp
      STORE RESP TO WTIPODESPI
   ENDIF
   if resp = "R"
      store "RENUNCIA" TO WMOTIVO
   ENDIF
   @ 13,3 SAY "MOTIVO DE LA LIQUIDACION:"+WMOTIVO
      
   STORE CONTRATO TO WCONTRAEJC

   *** MESES EN GENERAL
   ***
   STORE (FECHALIQ-FECHAINI) + 1 TO WTOTDIAS
   store int(wtotdias/30.4166667) to wmes
   store wtotdias/30 to xmes
   store wtotdias-(wmes*30) to wdias
   IF WDIAS >= 25
      store wmes+1 to wmes2
      store "Desea convertir los "+str(wmes,3)+" meses y "+str(wdias,2)+" dias en "+str(wmes2,3)+ " meses ?" to mes
      store "S" to p1
      store "N" to p2
      store " " to resp
      do pide2 with p1,p2,mes,resp
      if resp = "S"
         STORE WMES+1 TO WMES
         STORE WMES TO XMES
         STORE 0 TO WDIAS
      endif
   ENDIF
   STORE INT(WMES*30)+WDIAS TO WTOTDIAS

   *** VACACION
   ***
   STORE ipnperso->vacacion TO FIVAC
   IF FIVAC = CTOD("  -  -    ")
      STORE IPNPERSO->INGRESO TO FIVAC
   ENDIF
   STORE (FECHALIQ-FIVAC) + 1 TO WTDVAC
   IF WTDVAC < 0
      STORE 0 TO WTDVAC
   ENDIF
   store int(wtDVAC/30.4166667) to wmesVAC
   store wtDVAC-(wmesVAC*30) to wdiasVAC
   IF WMESVAC < 0
      STORE 0 TO WMESVAC
   ENDIF
   IF WDIASVAC < 0
      STORE 0 TO WDIASVAC
   ENDIF
   IF WDIASVAC >= 25
      store wmesVAC+1 to wmesVAC2
      store "Desea convertir los "+str(wmesVAC,4)+" meses de vacacion y "+str(wdiasVAC,4)+" dias en "+str(wmesVAC2,4)+ " meses ?" to mes
      store "S" to p1
      store "N" to p2
      store " " to resp
      do pide2 with p1,p2,mes,resp
      if resp = "S"
         STORE WMESVAC2 TO WMESVAC
         STORE 0 TO WDIASVAC
      endif
   ENDIF
   STORE INT(WMESVAC*30)+WDIASVAC TO WTDVAC

   *** ANTIGUEDAD
   ***
   STORE ipnperso->ANTIGUE TO FIANT
   IF FIANT = CTOD("  -  -    ")
      STORE IPNPERSO->INGRESO TO FIANT
   ENDIF
   STORE (FECHALIQ-FIANT) + 1 TO WTDANT
   IF WTDANT < 0
      STORE 0 TO WTDANT
   ENDIF
   store int(wtDANT/30.4166667) to wmesANT
   store wtDANT-(wmesANT*30) to wdiasANT
   IF WMESANT < 0
      STORE 0 TO WMESANT
   ENDIF
   IF WDIASANT < 0
      STORE 0 TO WDIASANT
   ENDIF
   IF WDIASANT >= 25
      store wmesANT+1 to wmesANT2
      store "Desea convertir los "+str(wmesANT,4)+" meses de antiguedad y "+str(wdiasant,4)+" dias en "+str(wmesant2,4)+ " meses ?" to mes
      store "S" to p1
      store "N" to p2
      store " " to resp
      do pide2 with p1,p2,mes,resp
      if resp = "S"
         STORE WMESANT2 TO WMESANT
         STORE 0 TO WDIASANT
      endif
   ENDIF
   STORE INT(WMESANT*30)+WDIASANT TO WTDANT


   IF WCONTRAEJC = "PETROLERO"
      if wmes > 12 .and. wmes < 20
         store wmes - 12 to wliqejc
         STORE WMES TO WLASTWMES
         STORE 12 TO WMES
      else
         store 0 to wliqejc
         STORE WMES TO WLASTWMES
      endif
   ENDIF

   STORE NOMINA    TO WNOMINA
   STORE NOMBRE    TO WNOMBRE
   STORE APELLIDO  TO WAPELLIDO
   STORE INGRESO   TO WINGRESO
   STORE CONTRATO  TO WCONTRATO
   STORE SUELDO    TO WSUELDO
   STORE BONOCO    TO WBONOCO
   STORE TIPO      TO WTIPO

   store "OPCIONES: (C)ONTINUAR, (S)ALIR" to mes
   store "C" to p1
   store "S" to p2
   store " " to resp
   do pide2 with p1,p2,mes,resp
   if resp = "S"
      loop
   endif
   STORE 0 TO BSPREAVISO
   STORE 0 TO BSPREAVISO2
   STORE 0 TO BSANTIGUE
   STORE 0 TO BSANTIGUE2
   STORE 0 TO BSCESANTIA
   STORE 0 TO BSVACACION
   STORE 0 TO BSINDCOM
   STORE 0 TO BASICODIA
   STORE 0 TO BSBONOVAC
   STORE 0 TO BSEXAMEN
   STORE 0 TO BSMINIMO

   IF WCONTRATO = "PETROLERO"
      STORE .T. TO WFLAGAS
      DO IPNLIQA
   ENDIF
   IF WCONTRATO = "LDT"
      STORE .T. TO WFLAGAS
      DO IPNLIQB
   ENDIF
   IF WCONTRATO = "CONSTRUCCION"
      STORE .T. TO WFLAGAS
      DO IPNLIQC
   ENDIF
   IF WCONTRATO = "PEQUIVEN"
      STORE .T. TO WFLAGAS
      DO IPNLIQD
   ENDIF
   select 1
   replace retiro    with fechaliq
   replace exnomina  with nomina
   replace exingreso with ingreso
   replace nomina    with space(5)
   
   *replace ingreso   with ctod("  -  -    ")
   *replace utilidad  with ctod("  -  -    ")
   *replace lastutil  with ctod("  -  -    ")
   *REPLACE SALPRO    WITH 0
   *REPLACE UTILACUM  WITH 0
   *replace VACACION  with ctod("  -  -    ")
   *replace LASTVACA  with ctod("  -  -    ")
   SELECT 2
ENDDO

