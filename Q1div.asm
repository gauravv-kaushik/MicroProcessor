.MODEL SMALL
.DATA
    ; Split the two 32-bit integers into four 16-bit variables
    dividend_low DW 5678h
    dividend_high DW 1234h
    divisor_low DW 2222h
    divisor_high DW 1111h
    quotient_low DW ?
    quotient_high DW ?
    remainder_low DW ?
    remainder_high DW ?
    temp DW ?
    temp2 DW ?
    temp3 DW ?

.CODE
.STARTUP
    ; Initialize variables
    MOV quotient_low, 0
    MOV quotient_high, 0
    MOV remainder_low, 0
    MOV remainder_high, 0

    ; Perform 32-bit division
    XOR DX, DX  ; Clear DX (DX:AX will hold dividend)
    MOV AX, dividend_low
    MOV BX, divisor_low
    DIV BX  ; Perform division of low parts

    ; Store quotient_low and remainder_low
    MOV quotient_low, AX
    MOV remainder_low, DX

    ; Calculate quotient_high and remainder_high
    XOR DX, DX  ; Clear DX again
    MOV AX, dividend_high
    DIV BX  ; Perform division using divisor_low
    MOV quotient_high, AX
    MOV remainder_high, DX

    CALL disp
    MOV AH, 4Ch
    INT 21h

disp PROC NEAR
    ; Display quotient_high
    MOV AX, quotient_high
    CALL display_digit

    ; Display quotient_low
    MOV AX, quotient_low
    CALL display_digit

    ; Display remainder_high
    MOV AX, remainder_high
    CALL display_digit

    ; Display remainder_low
    MOV AX, remainder_low
    CALL display_digit

    RET

display_digit:
    PUSH CX
    MOV CX, 4  ; Display 4 digits

up:
    ; Load and display the least significant digit
    MOV DL, '0'
    ADD DL, AL
    MOV AH, 02h
    INT 21h

    ; Shift to the next digit
    ROL AX, 4

    ; Decrement the counter and continue
    DEC CX
    JNZ up

    POP CX
    RET

disp ENDP

MOV AX, 4C00h
INT 21h

END
