store .t. to lds
do while lds
  store 0 to qwerty
  @ 12,76 get qwerty picture "#"
  read
  if qwerty < 0 .or. qwerty > 2
     store 0 to qwerty
  else
     store .f. to lds
  endif
enddo
DO CASE
   CASE QWERTY=0
      RETURN
   CASE QWERTY=1
      DO IPN0302A
   CASE QWERTY=2
      DO IPN0302B
ENDCASE
RETURN

