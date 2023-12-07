; BCD SUBTRACTION 32 BIT

.MODEL SMALL
.DATA

NUM1 DB 28,34,56,78
NUM2 DB 26,32,12,21

NUM3 DB 4 DUP(?)

.CODE
.STARTUP

MOV CX,4
MOV SI,0

L1:
   MOV AL,NUM1[SI]
   SUB AL,NUM2[SI]
   MOV NUM3[SI],AL
   INC SI
   LOOP L1
   
   MOV SI,0
   MOV CX,4
   
   L2:
      MOV AL,NUM3[SI]
      AAM
      ADD AX,3030H
      MOV BX,AX
      
      MOV AH,2
      MOV DL,BH
      INT 21H
      
      MOV AH,2
      MOV DL,BL
      INT 21H
      INC SI
      LOOP L2
      
      
.EXIT

END
