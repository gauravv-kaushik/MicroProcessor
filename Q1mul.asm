.MODEL SMALL
.DATA
    ; Split the two 32-bit integers into four 16-bit variables
    n1_low DW 5678h
    n1_high DW 1234h
    n2_low DW 2222h
    n2_high DW 1111h
    result_low DW ?
    result_mid DW ?
    result_high DW ?
    carry1 DW 0
    carry2 DW 0

.CODE
.STARTUP
    ; Initialize the result variables
    MOV result_low, 0
    MOV result_mid, 0
    MOV result_high, 0

    ; Perform the 16-bit multiplication for the low parts
    MOV AX, n1_low
    MUL n2_low
    ADD result_low, AX  ; Add the low part of the result

    ; Calculate carry for the middle part
    MOV AX, 0
    ADC AX, 0  ; Check if the low part caused a carry
    ADD result_mid, AX

    ; Perform the 16-bit multiplication for the cross parts
    MOV AX, n1_low
    MUL n2_high
    ADD result_mid, AX

    MOV AX, n1_high
    MUL n2_low
    ADD result_mid, AX

    ; Calculate carry for the high part
    MOV AX, 0
    ADC AX, 0  ; Check if the cross parts caused a carry
    ADD result_high, AX

    ; Perform the 16-bit multiplication for the high parts
    MOV AX, n1_high
    MUL n2_high
    ADD result_high, AX

    CALL disp
    MOV AH, 4Ch
    INT 21h

disp PROC NEAR
    MOV CX, 16  ; Display 16 digits

up:
    ; Load digits from result_high, result_mid, and result_low
    MOV AX, result_high
    ROL AX, 4
    MOV result_high, AX

    MOV AX, result_mid
    ROL AX, 4
    MOV result_mid, AX

    MOV AX, result_low
    ROL AX, 4
    MOV result_low, AX

    ; Extract and display the least significant digit
    MOV AX, result_low  ; Use AX for AND operation
    AND AX, 0Fh
    CMP AL, 0Ah
    JAE dl
    ADD AL, 7

dl:
    ADD AL, 30h
    MOV DL, AL
    MOV AH, 02h
    INT 21h

    ; Decrement the counter and continue
    DEC CX
    JNZ up
    RET

disp ENDP

MOV AX, 4C00h
INT 21h

END
