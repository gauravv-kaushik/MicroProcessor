.MODEL SMALL
.DATA
ARR DB 9 DUP(?)
MES1 DB 13,10,10,"ENTER THE ARRAY ELEMENTS:$"
MES2 DB 13,10,10,"THE SORTED ARRAY:$"

.CODE
.STARTUP

MOV AH,9
MOV DX,OFFSET MES1
INT 21H
MOV SI,0
MOV CX,9
L1:
    MOV AH,1
    INT 21H
    SUB AL,30H
    MOV ARR[SI],AL
    INC SI
    LOOP L1
    
MOV CX,9
DEC CX

L2:
    MOV DI,CX
    MOV SI,0
    L3:
        MOV AL,ARR[SI]
        CMP AL,ARR[SI+1]
        JL CONTINUE
        XCHG AL,ARR[SI+1]
        MOV ARR[SI],AL
        CONTINUE:
            INC SI
            LOOP L3
            MOV CX,DI
            LOOP L2
      
MOV AH,9
MOV DX,OFFSET MES2
INT 21H

MOV SI,0
MOV CX,9
L4:
    MOV DL,ARR[SI]
    ADD DL,30H
    MOV AH,2
    INC SI
    INT 21H
    LOOP L4
.EXIT
END
