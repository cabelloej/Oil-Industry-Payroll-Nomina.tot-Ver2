store "Reorganizando indices, favor esperar..." to mes
@ 12,5 say mes
use ipnfacto index ipnfacto EXCLUSIVE
reindex
use ipnomina index ipnomina EXCLUSIVE
reindex
use ipnperso index ipnperso EXCLUSIVE
reindex
use ipnproco index ipnproco EXCLUSIVE
reindex
use ipnotcon index ipnotcon
reindex
use ipnhisto index ipnhisto, IPNHIST2 EXCLUSIVE
reindex
use ipncargos index ipncargos EXCLUSIVE
reindex
use ipnpref  index ipnpref EXCLUSIVE
reindex
use ipnparf  index ipnparf EXCLUSIVE
reindex
use ipnvalf  index ipnvalf EXCLUSIVE
reindex
use ipnprer  index ipnprer EXCLUSIVE
reindex
use ipnparr  index ipnparr EXCLUSIVE
reindex
close data
close index
clear
STORE "El Sistema se reiniciara, Oprima (Enter) para continuar" to mes
do aviso with mes
quit

