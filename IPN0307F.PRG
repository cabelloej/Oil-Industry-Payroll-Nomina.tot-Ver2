*********************************************
*          informe de deposito habitacional *
*********************************************
select 1
use ipnperso index ipnperso ALIAS PERSONAL
select 2
use ipndesinc
STORE "Desea limpiar lista de desincorporaciones ? (S/N)" to mes
store "S" to p1
store "N" to p2
store " " to resp
do pide2 with p1,p2,mes,resp
if resp = "S"
   select 2
   zap
endif
@ 5,0 clear to 21,79
@ 5,15  say "DESINCORPORACIONES MANUALES DEL A.HABIT."
store .t. to lista
do while lista
   select 1
   store space(10) to wced
   @ 8,10 say "Cedula: " get wced
   read
   if wced = space(10)
      store .f. to lista
      loop
   endif
   find &wced
   if eof()
      store "cedula no registrada" to mes
      do aviso with mes
      loop
   else
      STORE  RTRIM(NOMBRE)+" "+RTRIM(APELLIDO)+" ? (S/N)" TO MES
      STORE "S" TO P1
      STORE "N" TO P2
      store " " to resp
      do pide2 with p1,p2,mes,resp
      if resp = "S"
         select 2
         LOCATE FOR CEDULA = WCED
         IF .NOT. FOUND()
            append blank
         ENDIF
         replace cedula with wced
         replace nombre with PERSONAL->nombre
         replace apellido with PERSONAL->apellido
         replace cta with PERSONAL->cta
      endif
   ENDIF
enddo

STORE "Opciones :  (C)ontinuar, (R)echazar" to mes
store "C" to p1
store "R" to p2
store " " to resp
do pide2 with p1,p2,mes,resp
if resp = "R"
   close data
   close index
   return
endif
store "Procesando informacion, favor esperar" to mes
do mensaje with mes
SET DEVI TO PRINT
STORE 0 TO TOTAL1
STORE 0 TO TOTAL2
STORE 0 TO PAGINA
store 100 to line
SELECT 2
GO TOP
DO WHILE .NOT. EOF()
   IF LINE > 50
      @ 0,0  SAY CHR(18)
      @ 0,0  SAY CHR(14)+QQWW
      @ 1,0  SAY QQWWDIR1
      @ 2,50 SAY QQWWDIR2+", "+dtoc(wfecact)
      @ 5,0  say "Se¤ores:                                  +----------+------+---------------+"
      @ 6,0  say "ORIENTE ENTIDAD DE AHORRO Y PRESTAMO      |Telefono  |Codigo|  No. R.I.F.   |"
      @ 7,0  SAY "Ciudad                                    +----------+------+---------------+"
      @ 8,0  SAY "                                          |"+QQWWTEL+"|"+QQWWCODAH+"|"+QQWWRIF+"|"
      @ 9,0  SAY "                                          +----------+------+---------------+"
      @ 12,0 SAY "Estimados se¤ores:"
      @ 15,0 say "     Por la presente relacionamos a ustedes, los trabajadores que han sido"
      @ 16,0 say "desincorporados de esta empresa y que por aplicacion de la ley de politica"
      @ 17,0 say "habitacional, poseen en esa entidad las siguientes cuentas de ahorro.     "
      @ 19,0 say "APELLIDOS Y NOMBRES              CEDULA DE IDENTIDAD     No. DE CUENTA    "
      @ 20,0 SAY "-------------------------------- -------------------     -----------------"
      STORE 21 TO LINE
   ENDIF
   @ LINE,0 SAY RTRIM(APELLIDO)+" "+NOMBRE
   @ LINE,43 SAY CEDULA
   @ LINE,57 SAY CTA
   STORE LINE+1 TO LINE
   SKIP
ENDDO
STORE LINE + 2 TO LINE
@ LINE+1,0 SAY "      En consecuencia, les autorizamos para eliminar  la relacion de dependen-"
@ LINE+2,0 say "cia que han tenido con nosotros dentro del mencionado sistema.                      "
@ LINE+3,0 say "      Sin otro particular, les saludamos muy atentamente."
set devi to scre
eject
CLOSE DATA
CLOSE INDEX
RETURN

