STORE "OPCIONES: (G)ENERAL, (I)NDIVIDUAL, (S)ALIR" to mes
store "G" to p1
store "I" to p2
store "S" to p3
store " " to resp
do pide3 with p1,p2,p3,mes,resp
store resp to gnis
if gnis = "S"
   close data
   Close index
   return
endif
if gnis = "G"
   do ipn0308A
endif
if gnis = "I"
   do ipn0308B
endif
RETURN
