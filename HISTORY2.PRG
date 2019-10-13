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
use ipnomina index ipnomina

select 2
use ipnperso index ipnperso

select 3
use ipnhisto index history

do while .t.
@ 0,0 clear
@ 0,0 say "Reporte de recalculo de retenciones en historico"
store space(10) to wcodced
store space(5)  to wcodnom
store date()    to wdesde
store date()    to whasta

      store 0      to wtotlastsso
      store 0      to wtotlastspf
      store 0      to wtotlastah
      store 0      to wtotsso
      store 0      to wtotspf
      store 0      to wtotah




@ 05,5 say "Nomina  :"
@ 07,5 say "Desde   :"
@ 09,5 say "Hasta   :"

@ 05,15 get wcodnom
read
if wcodnom=space(5).or. lastkey()=27
   close data
   close index
   quit
endif
select ipnomina
seek wcodnom
if .not. found()
   store "Nomina no registrada, reintente" to mes
   do aviso with mes
   close data
   close index
   quit
else
   @ 05,30 say rtrim(desnom)
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

store 100 to wline
store 0   to wpage
set devi  to print

select ipnhisto
seek wcodnom
store cedula to wrupced
do while .not. eof() .and. nomina=wcodnom
   if cedula<>wrupced
      do imptotper
      store cedula to wrupced
      store 0      to wtotlastsso
      store 0      to wtotlastspf
      store 0      to wtotlastah
      store 0      to wtotsso
      store 0      to wtotspf
      store 0      to wtotah
   endif
   if fecha>=wdesde.and.fecha<=whasta
      * no problem
   else
      skip
      loop
   endif
   store wline+1 to wline
   if wline>=55
      do imptitulo
   endif
   @ wline,00  say cedula
   @ wline,15  say fecha 
   @ wline,30  say lastsso           picture "99999.99"
   @ wline,40  say lastspf           picture "99999.99"
   @ wline,50  say lastah            picture "99999.99"
   @ wline,60  say bssso             picture "99999.99"
   @ wline,70  say bsspf             picture "99999.99"
   @ wline,80  say bsahrhab          picture "99999.99"
   @ wline,90  say lastsso-bssso     picture "99999.99"
   @ wline,100 say lastspf-bsspf     picture "99999.99"
   @ wline,110 say lastah-bsahrhab   picture "99999.99"
   store wtotlastsso+lastsso     to wtotlastsso
   store wtotlastspf+lastspf     to wtotlastspf
   store Wtotlastah+ lastah      to wtotlastah
   store wtotsso+    bssso       to wtotsso
   store wtotspf+    bsspf       to wtotspf
   store wtotah +    bsahrhab    to wtotah
   skip
enddo
   do imptotper
set devi to scre
eject
enddo
close data
close index
quit
***
proc imptotper
***
   store wline+1 to wline
   if wline>=55
      do imptitulo
   endif
   select ipnperso
   seek wrupced
   if found()
     store rtrim(apellido)+", "+nombre  to wnombre
   else
     store "No reg."                   to wnombre
   endif

   select ipnhisto
   @ wline,00  say wnombre
   @ wline,30  say wtotlastsso          picture "999999.99"
   @ wline,40  say wtotlastspf          picture "99999.99"
   @ wline,50  say wtotlastah           picture "99999.99"
   @ wline,60  say wtotsso              picture "999999.99"
   @ wline,70  say wtotspf              picture "99999.99"
   @ wline,80  say wtotah               picture "99999.99"
   @ wline,90  say wtotlastsso-wtotsso  picture "999999.99"
   @ wline,101 say wtotlastspf-wtotspf  picture "999999.99"
   @ wline,111 say wtotlastah-wtotah    picture "999999.99"
   @ wline,122 say (wtotlastsso-wtotsso)+(wtotlastspf-wtotspf)+(wtotlastah-wtotah)    picture "9999999.99"
   store wline+1 to wline
   return
***
proc imptitulo
***
   @ 0,0 say chr(15)
   @ 0,0       say "Delta Human Resources"
   @ 1,0       say "Reporte recalculo retenciones"
   @ 2,0       say ipnomina.desnom
   @ 2,30      say "Desde "+dtoc(wdesde)+" hasta "+dtoc(whasta)
   @ 4,0       say "Cedula"
   @ 4,15      say "Fecha"
   @ 4,30      say "sso old"
   @ 4,40      say "spf old"  
   @ 4,50      say "a.h old" 
   @ 4,60      say "sso new"
   @ 4,70      say "spf new"
   @ 4,80      say "a.h new"
   @ 4,90      say "sso dif"           
   @ 4,100     say "spf dif"           
   @ 4,110     say "a.h dif"
   @ 4,122     say "Tot.Gral"
   store 6 to wline
   return
