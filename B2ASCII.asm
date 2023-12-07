; BINARY TO ASCII

.MODEL SMALL
.CODE
.STARTUP
MOV AX,1234
CALL DISPX
.EXIT

DISPX PROC NEAR
    PUSH DX
    PUSH CX
    PUSH BX
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
   POP BX
   POP CX
   POP DX
   RET
DISPX ENDP
END
 
