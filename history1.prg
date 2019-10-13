IF SUBSTR(VERS(),4,3) = "Pro"
   SET COMPATIBLE FOXPLUS
   *SET EXCLUSIVE OFF
   SET EXCLUSIVE ON
ENDIF
SET FIXED ON
SET DECIMAL TO 4
SET TALK OFF
SET ECHO OFF
SET HELP OFF
SET SCOREBOARD OFF
SET ESCAPE OFF
SET DELIMITER OFF
SET BELL OFF
SET STATUS OFF
SET SAFETY OFF
SET DELETED ON
SET CONFIRM ON
SET EXACT OFF
SET DATE ITALIAN
SET PROCEDURE TO IPNPROC
SET CENTURY ON

select 1
use ipnperso index ipnperso

select 2
use ipnhisto

do while .t.
@ 0,0 clear
@ 0,0 say "Recalculo de retenciones en historico"
store space(10) to wcodced
store date()   to wdesde
store date()   to whasta
store 0        to wfactsso
store 0        to wfactspf
store 0        to wfactah

@ 05,5 say "Cedula  :"
@ 07,5 say "Desde   :"
@ 09,5 say "Hasta   :"
@ 11,5 say "% sso   :"
@ 13,5 say "% spf   :"
@ 15,5 say "% ah.hab:"


@ 05,15 get wcodced
read
if wcodced=space(10).or. lastkey()=27
   close data
   close index
   quit
endif
select ipnperso
seek wcodced
if .not. found()
   store "Persona no registrada, reintente" to mes
   do aviso with mes
   close data
   close index
   quit
else
   @ 05,30 say rtrim(apellido)+", "+nombre
endif
@ 07,15 get wdesde
read
@ 09,15 get whasta
read
if wdesde>whasta
   store "Error en fechas, reintente" to mes
   do aviso with mes
   close data
   close index
   quit
endif
@ 11,15 get wfactsso picture "99.99"
read
@ 13,15 get wfactspf picture "99.99"
read
@ 15,15 get wfactah  picture "99.99"
read

store "(C)ontinuar, (A)bandonar" to mes
store "C" to p1
store "A" to p2
store " " to resp
do pide2 with p1,p2,mes,resp
if resp="A"
   close data
   close index
   quit
endif

select ipnhisto
go top
do while .not. eof()
   if cedula<>wcodced
      skip
      loop
   endif
   if fecha>=wdesde.and.fecha<=whasta
      * no problem
   else
      skip
      loop
   endif
   if ipnperso.tipo="E "
      store 15 to wfaccal
   else
      store 7  to wfaccal
   endif
  * replace lastsso  with bssso
    replace bssso    with (basico*wfaccal*wfactsso)/100
  * replace lastspf  with bsspf
   replace bsspf    with (basico*wfaccal*wfactspf)/100
  * replace lastah   with bsahrhab
   replace bsahrhab with (basico*wfaccal*wfactah)/100
   skip
enddo
enddo
close data
close index
quit




