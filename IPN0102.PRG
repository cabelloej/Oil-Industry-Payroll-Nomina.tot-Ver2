SAVE SCRE TO WSCR4
STORE .T. TO WPIDIENDO
DO WHILE WPIDIENDO
   RESTORE SCRE FROM WSCR4
   store .t. to lds
   do while lds
     store 0 to qwerty
     @ 16,77 get qwerty picture "#"
     read
     if qwerty < 0 .or. qwerty > 7
        store 0 to qwerty
     else
        store .f. to lds
     endif
   enddo
   DO CASE
      CASE QWERTY=0
         RETURN
      CASE QWERTY=1
         DO IPN0102A
      CASE QWERTY=2
         DO IPN0102B
      CASE QWERTY=3
         DO IPN0102C
      CASE QWERTY=4
         DO IPN0102D
      CASE QWERTY=5
         DO IPN0102E
      CASE QWERTY= 6
         DO IPN0102F
      CASE QWERTY= 7
         DO IPN0102G

   ENDCASE
ENDDO
RETURN

