*********************************************
*          informe de deposito habitacional *
*********************************************
select 1
use ipnperso index ipnperso ALIAS PERSONAL
store ctod("  -  -    ") to fec1
store ctod("  -  -    ") to fec2
set color to w/n
@ 5,1 clear to 10,50
@ 5,1 to 10,50 double
@ 5,2  say "DESINCORPORACIONES DEL A.HABIT."
@ 7,3 SAY "FECHA INICIAL  :" GET FEC1
@ 8,3 SAY "FECHA FINAL    :" GET FEC2
READ
IF FEC1 >= FEC2
   CLOSE DATA
   CLOSE INDEX
   RETURN
ENDIF

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
GO TOP
LOCATE FOR MONTH(RETIRO) = (MONTH(FEC2)-1) .and. year(retiro) = year(fec2)
DO WHILE .NOT. EOF()
   IF LINE > 50
      @ 0,0  SAY CHR(18)
      @ 0,0  SAY CHR(14)+QQWW
      @ 1,0  SAY QQWWDIR1
      @ 2,50 SAY QQWWDIR2+" "+dtoc(wfecact)
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
   CONTINUE
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