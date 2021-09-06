.MODEL SMALL
.STACK 100
.DATA
    div32Dividend DW 0, 0
    div32Divisor DW 0, 0
    div32Result DB 5 DUP (0)
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV DX, 2
    MOV AX, 35325
    MOV BX, 6
    MOV CX, 62472

    MOV DX, 1
    MOV AX, 47064
    MOV BX, 8
    MOV CX, 64254
    CALL DisplayPercentage

    MOV AX, 4C00H
    INT 21H
MAIN ENDP

DisplayPercentage PROC
; DX:AX Dividend, BX:CX, Divisor
; Let x = Dividend, y = Divisor
; This function outputs x / y * 100% in 3 decimal places
    MOV div32Dividend[0], DX
    MOV div32Dividend[2], AX
    MOV div32Divisor[0], BX
    MOV div32Divisor[2], CX

    MOV SI, 0
    MOV CX, 5
    div32ClearResult:
        MOV div32Result[SI], 0
        INC SI
    LOOP div32ClearResult

    MOV SI, 0
    div32DecLoop:
        ; x = x * 10
        MOV AX, div32Dividend[2]
        MOV BX, 10
        MUL BX
        MOV div32Dividend[2], AX
        MOV CX, DX
        MOV AX, div32Dividend[0]
        MOV BX, 10
        MUL BX
        ADD AX, CX
        MOV div32Dividend[0], AX

        ; Calculate x // y and x % y
        MOV DI, 0   ; DI = Quotient
        div32DivLoop:
            ; If x >= y, quotient++ and x = x-y; else, break loop
            MOV AX, div32Dividend[0]
            CMP AX, div32Divisor[0]
            JB div32Lower
            JA div32Higher
            MOV AX, div32Dividend[2]
            CMP AX, div32Divisor[2]
            JB div32Lower

            div32Higher:
                INC DI
                MOV AX, div32Dividend[2]
                SUB AX, div32Divisor[2]
                JNC div32SubNoCarry
            
            DEC div32Dividend[0]
            div32SubNoCarry:
                MOV div32Dividend[2], AX

            MOV AX, div32Dividend[0]
            SUB AX, div32Divisor[0]
            MOV div32Dividend[0], AX
        JMP div32DivLoop
        
        div32Lower:
            MOV BX, DI
            MOV div32Result[SI], BL
    INC SI
    CMP SI, 5
    JE DisplayPercentagePrintPre
    JMP div32DecLoop

    DisplayPercentagePrintPre:
        MOV SI, 0
        MOV AH, 02H
    DisplayPercentagePrint:
        CMP SI, 2
        JNE DisplayPercentagePrintPostDot
        MOV DL, '.'
        INT 21H
    DisplayPercentagePrintPostDot:
        MOV DL, div32Result[SI]
        ADD DL, 30H
        INT 21H

    INC SI
    CMP SI, 5
    JE DisplayPercentageEnd
    JMP DisplayPercentagePrint

    DisplayPercentageEnd:
    RET
DisplayPercentage ENDP

END MAIN