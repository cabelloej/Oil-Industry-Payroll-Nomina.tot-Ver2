********** MAIN
DO CASE
   CASE OP = 1
        STORE " Factores                 " TO Y1
        STORE " Tablas                   " TO Y2
        STORE " Nominas                  " TO Y3
        STORE " Personal                 " TO Y4
        STORE " Historicos               " TO Y5
        STORE " Fechas                   " TO Y6
        STORE "                          " TO Y7
        STORE "                          " TO Y8
        STORE "                          " TO Y9
        STORE "                          " TO Y10
        STORE "                          " TO Y11
        STORE "                          " TO Y12
        @ 9,27  SAY Y1
        @ 10,27 SAY Y2
        @ 11,27 SAY Y3
        @ 12,27 SAY Y4
        @ 13,27 SAY Y5
        @ 14,27 SAY Y6
        @ 15,27 SAY Y7
        @ 16,27 SAY Y8
        @ 17,27 SAY Y9
        @ 18,27 SAY Y10
        @ 19,27 SAY Y11
        @ 20,27 SAY Y12
        @ 9,54  SAY " Esta opcion  le permite "
        @ 10,54 SAY "configurar  la  base  de "
        @ 11,54 SAY "datos del sistema. Cual_ "
        @ 12,54 SAY "quier  error  en   estas "
        @ 13,54 SAY "operaciones puede afectar"
        @ 14,54 SAY "seriamente  el  funciona_"
        @ 15,54 SAY "miento del mismo.        "
        @ 16,54 SAY "                         "
        @ 17,54 SAY "                         "
        @ 18,54 SAY "                         "
        @ 19,54 SAY "                         "
        @ 20,54 SAY "                         "
   CASE OP = 2
        STORE " Abrir Nominas            " TO Y1
        STORE " Cargar Variaciones       " TO Y2
        STORE " Consultar Pago           " TO Y3
        STORE " Imprimir Sabana          " TO Y4
        STORE " Imprimir Sobres          " TO Y5
        STORE " Imprimir Desglose        " TO Y6
        STORE " Imprimir Resumen         " TO Y7
        STORE " Imprimir Bancaria        " TO Y8
        STORE " Cerrar Nominas           " TO Y9
        STORE "                          " TO Y10
        STORE "                          " TO Y11
        STORE "                          " TO Y12
        @ 9,27  SAY Y1
        @ 10,27 SAY Y2
        @ 11,27 SAY Y3
        @ 12,27 SAY Y4
        @ 13,27 SAY Y5
        @ 14,27 SAY Y6
        @ 15,27 SAY Y7
        @ 16,27 SAY Y8
        @ 17,27 SAY Y9
        @ 18,27 SAY Y10
        @ 19,27 SAY Y11
        @ 20,27 SAY Y12
        @ 9,54  SAY " Agrupa todas las opera- "
        @ 10,54 SAY "ciones de  nomina reque- "
        @ 11,54 SAY "ridas por la empresa.    "
        @ 12,54 SAY " El  orden de  ejecucion "
        @ 13,54 SAY "de  estas  opciones   es "
        @ 14,54 SAY "obligatorio  y no pueden "
        @ 15,54 SAY "ser alterados.           "
        @ 16,54 SAY "                         "
        @ 17,54 SAY "                         "
        @ 18,54 SAY "                         "
        @ 19,54 SAY "                         "
        @ 20,54 SAY "                         "
   CASE OP = 3
        STORE " Vacaciones anuales       " TO Y1
        STORE " Utilidades               " TO Y2
        STORE " Liquidaciones            " TO Y3
        STORE " AR-C  (I.S.L.R.)         " TO Y4
        STORE " I.N.C.E.                 " TO Y5
        STORE " Sindicatos               " TO Y6
        STORE " Ahorro Habitacional      " TO Y7
        STORE " Comprobante Contabilidad " TO Y8
        STORE " Retroactivos             " TO Y9
        STORE " Fideicomisos             " TO Y10
        STORE " Antiguedad anual LOT     " TO Y11
        STORE "                          " TO Y12
        @ 9,27  SAY Y1
        @ 10,27 SAY Y2
        @ 11,27 SAY Y3
        @ 12,27 SAY Y4
        @ 13,27 SAY Y5
        @ 14,27 SAY Y6
        @ 15,27 SAY Y7
        @ 16,27 SAY Y8
        @ 17,27 SAY Y9
        @ 18,27 SAY Y10
        @ 19,27 SAY Y11
        @ 20,27 SAY Y12
        @ 9,54  SAY "  Esta opcion lo llevara "
        @ 10,54 SAY "a  un  submenu donde  se "
        @ 11,54 SAY "encuentra  una  variedad "
        @ 12,54 SAY "de operaciones de admi-  "
        @ 13,54 SAY "nistracion de personal.  "
        @ 14,54 SAY "                         "
        @ 15,54 SAY "                         "
        @ 16,54 SAY "                         "
        @ 17,54 SAY "                         "
        @ 18,54 SAY "                         "
        @ 19,54 SAY "                         "
        @ 20,54 SAY "                         "
   CASE OP = 4
        STORE " Gastos Reembolsables     " TO Y1
        STORE " Gastos Fijos             " TO Y2
        STORE "                          " TO Y3
        STORE "                          " TO Y4
        STORE "                          " TO Y5
        STORE "                          " TO Y6
        STORE "                          " TO Y7
        STORE "                          " TO Y8
        STORE "                          " TO Y9
        STORE "                          " TO Y10
        STORE "                          " TO Y11
        STORE "                          " TO Y12
        @ 9,27  SAY Y1
        @ 10,27 SAY Y2
        @ 11,27 SAY Y3
        @ 12,27 SAY Y4
        @ 13,27 SAY Y5
        @ 14,27 SAY Y6
        @ 15,27 SAY Y7
        @ 16,27 SAY Y8
        @ 17,27 SAY Y9
        @ 18,27 SAY Y10
        @ 19,27 SAY Y11
        @ 20,27 SAY Y12
        @ 9,54  SAY "  Esta opcion lo llevara "
        @ 10,54 SAY "a  un  submenu donde  se "
        @ 11,54 SAY "encuentra  una  variedad "
        @ 12,54 SAY "de operaciones de rutina "
        @ 13,54 SAY "en   licitaciones     de "
        @ 14,54 SAY "suministro  de  personal "
        @ 15,54 SAY "contratado.              "
        @ 16,54 SAY "                         "
        @ 17,54 SAY "                         "
        @ 18,54 SAY "                         "
        @ 19,54 SAY "                         "
        @ 20,54 SAY "                         "
   CASE OP = 5
        STORE " Personal De Una Nomina   " TO Y1
        STORE " Resumen General  Nominas " TO Y2
        STORE " Historicos Tipo Nomina   " TO Y3
        STORE " Historico Ret. I.S.L.R.  " TO Y4
        STORE " Historico Ret.Ahorro Hab." TO Y5
        STORE " Historico Ret. I.V.S.S.  " TO Y6
        STORE " Historico Bonificable    " TO Y7
        STORE " Historico No Bonificable " TO Y8
        STORE " Historico Pago Utilidades" TO Y9
        STORE " Alerta Equip.De Seguridad" TO Y10
        STORE " Constancia de Trabajo    " TO Y11
        STORE "                          " TO Y12
        @ 9,27  SAY Y1
        @ 10,27 SAY Y2
        @ 11,27 SAY Y3
        @ 12,27 SAY Y4
        @ 13,27 SAY Y5
        @ 14,27 SAY Y6
        @ 15,27 SAY Y7
        @ 16,27 SAY Y8
        @ 17,27 SAY Y9
        @ 18,27 SAY Y10
        @ 19,27 SAY Y11
        @ 20,27 SAY Y12
        @ 9,54  SAY "  La opcion de  Informes "
        @ 10,54 SAY "lo  llevara a un submenu "
        @ 11,54 SAY "donde podra  seleccionar "
        @ 12,54 SAY " y consultar  los  pagos "
        @ 13,54 SAY "efectuados en el pasado. "
        @ 14,54 SAY "                         "
        @ 15,54 SAY "                         "
        @ 16,54 SAY "                         "
        @ 17,54 SAY "                         "
        @ 18,54 SAY "                         "
        @ 19,54 SAY "                         "
        @ 20,54 SAY "                         "
   CASE OP = 6
        STORE " Vaciar archivos          " TO Y1
        STORE " Importar data anterior   " TO Y2
        STORE " Reorganizar indices      " TO Y3
        STORE "                          " TO Y4
        STORE "                          " TO Y5
        STORE "                          " TO Y6
        STORE "                          " TO Y7
        STORE "                          " TO Y8
        STORE "                          " TO Y9
        STORE "                          " TO Y10
        STORE "                          " TO Y11
        STORE "                          " TO Y12
        @ 9,27  SAY Y1
        @ 10,27 SAY Y2
        @ 11,27 SAY Y3
        @ 12,27 SAY Y4
        @ 13,27 SAY Y5
        @ 14,27 SAY Y6
        @ 15,27 SAY Y7
        @ 16,27 SAY Y8
        @ 17,27 SAY Y9
        @ 18,27 SAY Y10
        @ 19,27 SAY Y11
        @ 20,27 SAY Y12
        @ 9,54  SAY "  La opcion de  Manteni- "
        @ 10,54 SAY "miento le  permite efec- "
        @ 11,54 SAY "tuar   operaciones    de "
        @ 12,54 SAY " rutina con las tablas   "
        @ 13,54 SAY "                         "
        @ 14,54 SAY "                         "
        @ 15,54 SAY "                         "
        @ 16,54 SAY "                         "
        @ 17,54 SAY "                         "
        @ 18,54 SAY "                         "
        @ 19,54 SAY "                         "
        @ 20,54 SAY "                         "
   CASE OP = 7
        @ 9,27  SAY "Oprima (Ù) Para Confirmar"
        @ 10,27 SAY "                          "
        @ 11,27 SAY "                          "
        @ 12,27 SAY "                          "
        @ 13,27 SAY "                          "
        @ 14,27 SAY "                          "
        @ 15,27 SAY "                          "
        @ 16,27 SAY "                          "
        @ 17,27 SAY "                          "
        @ 17,27 SAY "                          "
        @ 18,27 SAY "                          "
        @ 19,27 SAY "                          "
        @ 20,27 SAY "                          "

        @ 9,54  SAY "  Mediante  esta  opcion "
        @ 10,54 SAY "usted  podra  salir  del "
        @ 11,54 SAY "sistema   de   nomina  y "
        @ 12,54 SAY "regresar    al   sistema "
        @ 13,54 SAY "operativo.  Recuerde que "
        @ 14,54 SAY "esta es la unica  opcion "
        @ 15,54 SAY "valida para abandonar el "
        @ 16,54 SAY "sistema.                 "
        @ 17,54 SAY "  Si el sistema es inte_ "
        @ 18,54 SAY "rumpido, este se autoes_ "
        @ 19,54 SAY "tructurara en su proxima "
        @ 20,54 SAY "ejecucion.               "
 endcase
 RETURN
