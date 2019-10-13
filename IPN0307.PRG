store .t. to lds
do while lds
  store 0 to qwerty
  @ 16,76 get qwerty picture "#"
  read
  if qwerty < 0 .or. qwerty > 6
     store 0 to qwerty
  else
     store .f. to lds
  endif
enddo
DO CASE
   CASE QWERTY=0
      RETURN
   CASE QWERTY=1
      DO IPN0307A
   CASE QWERTY=2
      DO IPN0307B
   CASE QWERTY=3
      DO IPN0307C
   CASE QWERTY=4
      DO IPN0307D
   CASE QWERTY=5
      DO IPN0307E
   CASE QWERTY=6
      DO IPN0307F
ENDCASE
RETURN

