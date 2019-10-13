PUSH KEY CLEAR
ON KEY LABEL F1 DO IPN0104R

SAVE SCRE TO WSCR4
STORE .T. TO WPIDIENDO
DO WHILE WPIDIENDO
   RESTORE SCRE FROM WSCR4
   store .t. to lds
   do while lds
      store 0 to qwerty
      @ 13,77 get qwerty picture "#"
      read
     if qwerty < 0 .or. qwerty > 4
        store 0 to qwerty
     else
        store .f. to lds
     endif
   enddo
   DO CASE
      CASE QWERTY=0
         POP KEY
         RETURN
      CASE QWERTY=1
         DO IPN0104A
      CASE QWERTY=2
         DO IPN0104B
      CASE QWERTY=3
         DO IPN0104C
      CASE QWERTY=4
         DO IPN0104D
   ENDCASE
ENDDO
RETURN

