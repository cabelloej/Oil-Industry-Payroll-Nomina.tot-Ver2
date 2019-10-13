select 1
use ipnperso index ipnperso
select 2
use ipncargo index ipncargo
store .t. to wsi
do while wsi
   @ 05,00 clear to 15,60
   @ 05,00       to 15,60
   @ 4,00 say "CONSTANCIAS DE TRABAJO"
   @ 07,05 SAY "CEDULA    :"
   @ 09,05 SAY "NOMBRE    :"
   @ 11,05 SAY "INGRESO   :"
   @ 13,05 SAY "EGRESO    :"
   STORE SPACE(10) TO WCEDULA
   @ 07,17 GET WCEDULA
   READ
   IF WCEDULA = SPACE(10)
      EXIT
   ENDIF
   SELECT 1
   FIND &WCEDULA
   IF EOF()
      STORE "ERROR, CEDULA NO REGISTRADA" TO MES
      DO AVISO WITH MES
      LOOP
   ELSE
      @ 09,17 SAY RTRIM(APELLIDO)+", "+RTRIM(NOMBRE)
      @ 11,17 SAY INGRESO
      @ 13,17 SAY RETIRO
   ENDIF
   store cargo to wcargo
   if wcargo <> space(10)
      select 2
      find &wcargo
      if eof()
         store "NO REGISTRADO EN SISTEMA" to wcargodes
      else
         store descri                     to wcargodes
      endif
   else
      store "NO DEFINIDO"                 to wcargodes
   endif
   select 1
   STORE "OPCIONES: (C)ONTINUAR, (S)ALIR" TO MES
   STORE "C" TO P1
   STORE "S" TO P2
   STORE " " TO RESP
   DO PIDE2 WITH P1,P2,MES,RESP
   IF RESP = "S"
      LOOP
   ENDIF
   SET DEVI TO PRINT
   @ 12,00 SAY "              A    Q U I E N   P U E D A   I N T E R E S A R"
   @ 12,00 SAY "              A    Q U I E N   P U E D A   I N T E R E S A R"

   @ 22,04 SAY "          Yo,    JOSE ALBERTO ACEVEDO,   Venezolano,  mayor de edad,"
   @ 22,04 SAY "                 JOSE ALBERTO ACEVEDO                               "

   @ 24,04 SAY "casado, comerciante,  de este domicilio  y portador de la cedula de "

   @ 26,04 SAY "identidad No.  3.199.529,  en mi caracter de GERENTE ADMINISTRATIVO "
   @ 26,04 SAY "               3.199.529                     GERENTE ADMINISTRATIVO "

   @ 28,04 SAY "de CONSTRUCCIONES VALAC, C.A.,   hago  constar   que  el  ciudadano "
   @ 28,04 SAY "   CONSTRUCCIONES VALAC, C.A.                                       "

   @ 30,04 SAY RTRIM(ipnperso->apellido)+", "+ipnperso->nombre+" titular de la cedula de identidad No."
   @ 30,04 SAY RTRIM(ipnperso->apellido)+", "+ipnperso->nombre+"                                      "
   if ipnperso->retiro<>ctod("  -  -    ").and.ipnperso->retiro>ipnperso->ingreso.and.ipnperso->nomina=space(5)
      store "trabajo"                 to wtex1
      store " hasta el "+dtoc(RETIRO) to wtex2
      store exingreso                 to wingreso
   else
      store "trabaja"                 to wtex1
      store " "                       to wtex2
      store ingreso                   to wingreso
   endif
   store (ipnperso->sueldo+ipnperso->bonoco)*30 to wsueldo
   @ 32,04 say "V-"+ipnperso->cedula+" "+wtex1+"  en  esta  empresa desempe"+chr(164)+"ando  el  cargo  de"
   @ 32,04 say "V-"+ipnperso->cedula
   @ 34,04 say wcargodes+" desde el "+dtoc(wingreso)+wtex2
   @ 34,04 say wcargodes
   @ 36,04 say "con un sueldo basico mensual de bolivares "+str(wsueldo,10,2)

   @ 40,04 say "         peticion que se hace de parte interesada en la ciudad de"
   @ 42,04 say "Puerto La Cruz el "+dtoc(wfecact)
   eject
   set devi to scre
ENDDO
close data
close index
return

