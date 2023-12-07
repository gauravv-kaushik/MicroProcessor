; PROGRAM TO FIND SUM OF 32 BIT NUMBERS

.MODEL SMALL
.DATA

NUM1 DW 1234
NUM2 DW 5673
NUM3 DW 1111
NUM4 DW 2222

RES DW ?

MES3 DB 13,10,10,"SUM OF 32 BIT NUMBERS: $"

.CODE
.STARTUP
     
    MOV DX,OFFSET MES3
    MOV AH,9
    INT 21H
    
    CLC
    
    MOV AX,NUM1
    ADD AX,NUM3
    CALL DISPX
    
    MOV AX,NUM2
    ADC AX,NUM4
    CALL DISPX
    
.EXIT

DISPX PROC NEAR
   MOV CX,0
   MOV BX,10
   
   DISPX1:
      MOV DX,0
      DIV BX
      PUSH DX
      INC CX
      OR AX,AX
      JNZ DISPX1
      
   DISPX2:
      POP DX
      MOV AH,2
      ADD DL,30H
      INT 21H
      LOOP DISPX2
      
   
   RET
   
DISPX ENDP
END

