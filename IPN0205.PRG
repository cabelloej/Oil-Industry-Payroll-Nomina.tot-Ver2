store .t. to lds
do while lds
  store 0 to qwerty
  @ 13,77 get qwerty picture "#"
  read
  if qwerty < 0 .or. qwerty > 3
     store 0 to qwerty
  else
     store .f. to lds
  endif
enddo
DO CASE
   CASE QWERTY=0
      RETURN
   CASE QWERTY=1
      DO IPN0205A
   CASE QWERTY=2
      DO IPN0205B
   CASE QWERTY=3
      DO IPN0205C
ENDCASE
RETURN

