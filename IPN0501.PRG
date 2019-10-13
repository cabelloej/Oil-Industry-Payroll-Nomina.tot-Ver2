**************************************
*  REPORTE DE PERSONAL POR NOMINA    *
**************************************
select 1
use ipnperso alias personal
select 2
use ipnomina index ipnomina alias nomina
store .t. to personal
STORE SPACE(35) TO QQWW
DO INFORMA WITH QQWW
IF QQWW <> t3
   STORE 1 TO POSI
   else
   STORE 0 TO POSI
ENDIF
store "INSTALACION NO AUTORIZADA" TO WARNING
do while personal
   store .t. to nomina
   do while nomina
      STORE "CODIGO DE NOMINA A REPORTAR" to mes
      do mensaje with mes
      SELECT 2
      store space(5) to wcodnom
      set color to w+/n
      @ 5,0 clear to 10,50
      set color to r+/n
      @ 5,0 to 10,50 double
      @ 5,15 say "PERSONAL POR NOMINA"
      SET COLOR TO W/N
      @ 8,2 SAY "CODIGO DE NOMINA:" GET WCODNOM
      @ 9,2 say "DESCRIPCION     :"
      READ
      if wcodnom = space(5)
         close data
         close index
         return
      endif
      STORE UPPER(WCODNOM) TO WCODNOM
      FIND &WCODNOM
      IF EOF()
         STORE "Nomina no registrada" to mes
         do aviso with mes
         loop
      endif
      @ 9,20 SAY DESNOM
      store "OPCIONES: (C)ONTINUAR, (S)ALIR" to mess
      store " " to resp
      store "C" to p1
      store "S" to p2
      do pide2 with p1,p2,mess,resp
      if resp = "S"
         loop
      endif
      store .F. to nomina
   enddo
   SET DEVI TO PRINT
   IF POSI = 1
      @ PROW(),1 SAY CHR(14)+warning+CHR(18)
      SET DEVI TO SCRE
      CLOSE DATA
      CLOSE INDEX
      QUIT
   ENDIF
   STOR 100 TO LINE
   select 1
   locate for nomina = wcodnom
   do while .not. eof()
     STORE LINE+1 TO LINE
     IF LINE > 55
        @ PROW(),0 SAY CHR(18)
        @ PROW(),0 SAY CHR(14)
        @ 1,1 SAY QQWW
        @ 2,1 SAY "PERSONAL POR NOMINA"
        @ PROW(),0 SAY CHR(18)
        @ 3,1 SAY "NOMINA:"+WCODNOM+" "+NOMINA->DESNOM
        @ 4,1 SAY "CONTRATO u ORDEN POR SERVICIO: "+NOMINA->CONTRATO
        @ PROW(),0 SAY CHR(15)
        @ 6,01  SAY "CEDULA"
        @ 6,12  SAY "APELLIDOS"
        @ 6,35  SAY "NOMBRES"
        @ 6,60  SAY "TIPO"
        @ 6,65  SAY "TURNO"
        @ 6,75  SAY "INGRESO"
        @ 6,87  SAY "NOMINA"
        @ 6,97  SAY "CONTRATO"
        @ 6,112 SAY "CARGO"
        @ 6,137 SAY "SUELDO"
        @ 6,147 SAY "BONO"
        @ 6,157 SAY "SINDICATO"
        @ 6,172 SAY "B.ALIM."
        @ 6,182 SAY "B.TRAN."
        STORE REPLICATE("-",188) TO WSTRING
        @ 7,1 SAY WSTRING
        STORE 8 TO LINE
     ENDIF
     @ LINE,01  SAY CEDULA
     @ LINE,12  SAY RTRIM(APELLIDO)
     @ LINE,35  SAY RTRIM(NOMBRE)
     @ LINE,60  SAY TIPO
     @ LINE,65  SAY TURNO
     @ LINE,75  SAY DTOC(INGRESO)
     @ LINE,87  SAY NOMINA
     @ LINE,97  SAY CONTRATO
     @ LINE,112 SAY CARGO
     @ LINE,137 SAY STR(SUELDO,8,2)
     @ LINE,147 SAY STR(BONOCO,8,2)
     @ LINE,157 SAY SINDICATO
     @ LINE,172 SAY STR(BA,6,2)
     @ LINE,182 SAY STR(BT,6,2)
      select 1
      continue
   enddo
   @ PROW(),0 SAY CHR(18)
   EJECT
   SET DEVI TO SCRE
enddo




