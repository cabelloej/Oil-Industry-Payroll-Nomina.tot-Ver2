*****************************************************************
*     PROGRAMA PARA IMPRIMIR EL ARC GENERAL                     *
*****************************************************************
store .t. to arc
do while arc
   store space(35) to QQWW
   do INFORMA with QQWW
   select 1
   use ipnperso index ipnperso alias personal
   select 2
   use ipnhisto alias historico
   store space(10) to wcedula
   store 0 to wyear
   store "AR-C" to heading
    store "Ingrese el a¤o a procesar" to mes
   set color to w/n
   @ 6,1 clear to 12,50
   @ 5,0 to 13,51 double
   @ 5,20 say heading
   @ 10,5 say "A¥O   : "
   do mensaje with mes
   @ 10,12 get wyear picture "####"
   read
   if wyear = 0
      CLOSE DATA
      CLOSE INDEX
      RETURN
   endif
   store "01-01-"+str(wyear,4) to per1
   store ctod(per1) to per11
   store "31-12-"+str(wyear,4) to per2
   store ctod(per2) to per22
   STORE WYEAR TO ANO
   STORE STR(ANO,4) TO ANO1
   store SUBSTR(ANO1,3,2) to ano2
   select 1
   SET DEVI TO PRINT
   @ prow(),1 say chr(27)+chr(67)+chr(51)
   GO TOP
   DO WHILE .NOT. EOF()
      STORE CEDULA TO WCEDULA
      @ 7,88 say "01  01 "+ANO2
      @ 7,101 say "31  12 "+ANO2
      if nacion = "V"
         @ 10,88 say "X"
      else
         @ 11,88 say "X"
      endif
      @ 11,07 say rtrim(nombre)+" "+apellido
      @ 11,90 say wcedula
      @ 16,07 say QQWW
      @ 16,69 say QQWWRIF
      select 2
      use ipnhisto
      copy stru to ipnarc
      select 2
      use ipnarc
      index on dtoc(fecha) to ipnarc
      append from ipnhisto for cedula = wcedula .and. year(fecha) = wyear
      GO TOP
      LOCATE FOR CEDULA = WCEDULA .AND. YEAR(FECHA)=WYEAR
      STORE 0 TO WSSO
      DO WHILE .NOT. EOF()
         STORE WSSO + BSSSO TO WSSO
         CONTINUE
      ENDDO
      @ 23,8 SAY QQWWDIR1
      @ 23,102 SAY WSSO PICTURE "######.##"
      @ 25,36 SAY QQWWDIR2+"   "+QQWWTEL
      STORE 1 TO MESSS
      STORE 0 TO MONTOBON
      STORE 0 TO MONTOISLR
      STORE 32 TO LINE
      DO WHILE MESSS < 13
         SELECT ipnarc
         GO TOP
         LOCATE FOR CEDULA = WCEDULA .AND. MONTH(FECHA) = MESSS .AND. YEAR(FECHA) = WYEAR
         STORE 0 TO WTOTALBON
         STORE 0 TO WTOTALISLR
         DO WHILE .NOT. EOF()
            STORE WTOTALBON+BSTOTBON+BSTOTNBON TO WTOTALBON
            STORE WTOTALISLR+BSISLR TO WTOTALISLR
            CONTINUE
         ENDDO
         STORE LINE+1 TO LINE
         IF WTOTALISLR > 0 .AND. WTOTALBON > 0
            STORE (WTOTALISLR*100)/WTOTALBON TO WPORC
         ELSE
            STORE 0 TO WPORC
         ENDIF
         STORE MONTOBON+WTOTALBON TO MONTOBON
         STORE MONTOISLR+WTOTALISLR TO MONTOISLR
         @ LINE,12 SAY WTOTALBON PICTURE "#######.##"
         @ LINE,23 SAY WPORC PICTURE "##.##"
         @ LINE,30 SAY WTOTALISLR  PICTURE "######.##"
         @ LINE,39 SAY MONTOBON
         @ LINE,51 SAY MONTOISLR
         STORE MESSS+1 TO MESSS
      ENDDO
      select 1
      skip
   enddo
   SET DEVI TO SCREE
   EJECT
   @ prow(),1 say chr(27)+chr(67)+chr(65)
ENDDO

