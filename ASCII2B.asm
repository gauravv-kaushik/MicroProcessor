; ASCII TO BINARY

.MODEL SMALL
.DATA
TEMP DW ?
MES1 DB 13,10,10,"ENTER A NUMBER : $"
MES2 DB 13,10,10,"THE NUMBER ENTERED IS : $"

.CODE
.STARTUP
MOV DX,OFFSET MES1
MOV AH,9
INT 21H

XOR AX,AX
CALL READN
MOV TEMP, AX
MOV AH,9
MOV DX, OFFSET MES2
INT 21H
MOV AX, TEMP
CALL DISPX
.EXIT

READN PROC NEAR
    PUSH BX
    PUSH CX
    MOV CX,10
    MOV BX, 0
    READN1:
        MOV AH,1
        INT 21H
        CMP AL,30H
        JB READN2
        CMP AL, 39H
        JA READN2
        SUB AL,30H
        PUSH AX
        MOV AX,BX
        MUL CX
        MOV BX,AX
        POP AX
        MOV AH,0
        ADD BX,AX
        JMP READN1
        READN2:
            MOV AX,BX
            POP CX
            POP BX
            RET
    READN ENDP

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

