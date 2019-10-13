SAVE SCRE TO WSCR4
STORE .T. TO WPIDIENDO
DO WHILE WPIDIENDO
   RESTORE SCRE FROM WSCR4
   store .t. to lds
   do while lds
     store 0 to qwerty
     @ 11,77 get qwerty picture "#"
     read
     if qwerty < 0 .or. qwerty > 2
        store 0 to qwerty
     else
        store .f. to lds
      endif
   Enddo
   DO CASE
      CASE QWERTY=0
         RETURN
      CASE QWERTY=1
         DO IPN0105A
      CASE QWERTY=2
         DO IPN0105B
   ENDCASE
ENDDO
RETURN

