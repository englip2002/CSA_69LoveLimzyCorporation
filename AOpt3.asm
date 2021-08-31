.MODEL SMALL
.STACK 100
.DATA
    totalProducts DB 12
    prodNameLength DB 12
    prodDescLength DB 50
    prodDescDivLen DB 4
    prodNames DB "Athena      Baby Blooms Cammy       Lipstick    Mini Red    Olivia      Simply WhiteSirius      Be With Me  Merci       Eleanor     Prom Queen  $"
    prodDescs1 DB "Sunflower (1 stalk), Baby's breath                Roses (9 stalks), Baby's breath                   Chamomile flowers                                 Red roses (7 stalks), Baby's breath               $"
    prodDescs2 DB "Red roses (3 stalks), Eucalyptus baby blue        Red carnations, Roses, Eustomas (Total 7 stalks)  White roses (9 stalks), Eucalyptus baby blues     Sunflower, Roses, Ping Pong (Total 5 stalks)      $"
    prodDescs3 DB "Red roses (18 stalks)                             Hydrangea (3 stalks)                              Pink tulips (20 stalks)                           Mix of Roses, Spray roses, Eustomas, and Ping Pong$"
    prodPrices DW 50, 198, 98, 128, 48, 108, 128, 118, 208, 98, 298, 298
    prodQuantities DB 50, 20, 25, 30, 35, 20, 25, 15, 15, 20, 15, 10
    prodSold DB 12 DUP (0)

    currProdIndex DB 0
    currProdNameIndex DB 0
    currProdDescIndex DB 0
    newline DB 13, 10, '$'

    opt3Title DB "( Option 3 ) Display Item Purchase Summary", 13, 10, 10, "$" 
    opt3Header DB       '| Product/Service | Price (RM) | Sold Quantity | Total Sales (RM) |  Sales %  |', 13, 10, '$'
    opt3HeaderLine DB   '+-----------------+------------+---------------+------------------+-----------+', 13, 10, '$'
    opt3FooterLine DB   '+----------------------------------------------+------------------+-----------+', 13, 10, '$'
    opt3FooterPre DB    '|                                  Grand Total | RM $'
    opt3FooterPercent DB '100.000 %$'
    opt3TableRowStart DB "| $"
    opt3TableRowEnd DB " |", 13, 10, "$"
    opt3TableCellBar DB " | $"
    opt3GrandTotal DW 0, 0   ; First = Upper 16-bits, Second = Lower 16-bits 
    opt3HundredP DB "100.000$"
    anyKeyToContinue DB "< Press any key to continue >$"

    ; Variables for Display32BitNum Function
    higher16 DW ?
    lower16 DW ?
    arrQ DW 5 DUP (0)
    arrR DB 5 DUP (0)
    q2LookupArr DW 0, 6553, 13107, 19660, 26214, 32768, 39321, 45875, 52428, 58982
    r2LookupArr DB 0, 6, 2, 8, 4, 0, 6, 2, 8, 4
    prevCarry DB 0

    ; Variables for DisplayPercentage Function
    div32Dividend DW 0, 0
    div32Divisor DW 0, 0
    div32Result DB 5 DUP (0)
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Test data
    MOV prodSold[0], 10
    MOV prodSold[3], 15
    MOV prodSold[5], 32
    MOV prodSold[6], 17
    MOV prodSold[10], 2

    MOV AH, 09H
    LEA DX, opt3HeaderLine
    INT 21H
    LEA DX, opt3Header
    INT 21H
    LEA DX, opt3HeaderLine
    INT 21H

    ; Calculate Grand Total
    MOV opt3GrandTotal[0], 0
    MOV opt3GrandTotal[2], 0
    XOR CX, CX
    MOV CL, totalProducts
    MOV SI, 0
    CalcGrandTotal:
        MOV AX, SI
        MOV BL, 2
        MUL BL
        MOV BX, AX
        MOV AX, prodPrices[BX]
        XOR BX, BX
        MOV BL, prodSold[SI]
        MUL BX
        ADD opt3GrandTotal[2], AX 
        ADD opt3GrandTotal[0], DX
        INC SI
    LOOP CalcGrandTotal

    MOV currProdIndex, 0
    MOV currProdNameIndex, 0
    Opt3DisplayRow:
        MOV AH, 09H
        LEA DX, opt3TableRowStart
        INT 21H

        Opt3DisplayName:
            XOR BX, BX
            MOV BL, currProdNameIndex
            MOV AH, 02H
            MOV DL, prodNames[BX]
            INT 21H

        INC currProdNameIndex
        XOR AX, AX
        XOR DX, DX
        MOV AL, currProdNameIndex
        DIV prodNameLength
        CMP AH, 0
        JE Opt3DisplayPrice
        JMP Opt3DisplayName

        Opt3DisplayPrice:
            MOV AH, 02H
            MOV DL, ' '
            INT 21H
            INT 21H
            INT 21H
            MOV AH, 09H
            LEA DX, opt3TableCellBar
            INT 21H
            MOV AH, 02H
            MOV DL, 'R'
            INT 21H
            MOV DL, 'M'
            INT 21H

            MOV AL, currProdIndex
            MOV BL, 2
            MUL BL
            MOV BX, AX
            MOV AX, prodPrices[BX]
            XOR DX, DX
            MOV BX, 10
            DIV BX
            CMP AX, 0
            JE Opt3DisplayPrice1Digit
            XOR DX, DX
            DIV BX
            CMP AX, 0
            JE Opt3DisplayPrice2Digit
            XOR DX, DX
            DIV BX
            CMP AX, 0
            JE Opt3DisplayPrice3Digit
            XOR DX, DX
            DIV BX
            CMP AX, 0
            JE Opt3DisplayPrice4Digit
            JMP Opt3DisplayPrice5Digit

            Opt3DisplayPrice1Digit:
                MOV AH, 02H
                MOV DL, ' '
                INT 21H
            Opt3DisplayPrice2Digit:
                MOV AH, 02H
                MOV DL, ' '
                INT 21H
            Opt3DisplayPrice3Digit:
                MOV AH, 02H
                MOV DL, ' '
                INT 21H
            Opt3DisplayPrice4Digit:
                MOV AH, 02H
                MOV DL, ' '
                INT 21H
            Opt3DisplayPrice5Digit:

            XOR AX, AX
            MOV AL, currProdIndex
            MOV BL, 2
            MUL BL
            MOV BX, AX
            MOV AX, prodPrices[BX]
            CALL DisplayNum

            Opt3DisplayPriceEnd:
                MOV AH, 02H
                MOV DL, '.'
                INT 21H
                MOV DL, '0'
                INT 21H
                INT 21H
                MOV AH, 09H
                LEA DX, opt3TableCellBar
                INT 21H

        Opt3DisplaySoldQty:
            MOV CX, 10
            MOV AH, 02H
            MOV DL, ' '
            Opt3DisplaySoldQtyPre:
                INT 21H
            LOOP Opt3DisplaySoldQtyPre

            XOR BX, BX
            MOV BL, currProdIndex
            XOR AX, AX
            MOV AL, prodSold[BX]
            MOV BL, 10
            DIV BL
            CMP AL, 0
            JE Opt3DisplaySoldQty1Digit
            XOR AH, AH
            DIV BL
            CMP AL, 0
            JE Opt3DisplaySoldQty2Digit
            JMP Opt3DisplaySoldQty3Digit
            
            Opt3DisplaySoldQty1Digit:
                MOV AH, 02H
                MOV DL, ' '
                INT 21H
            Opt3DisplaySoldQty2Digit:
                MOV AH, 02H
                MOV DL, ' '
                INT 21H
            Opt3DisplaySoldQty3Digit:
                XOR BX, BX
                MOV BL, currProdIndex
                XOR AX, AX
                MOV AL, prodSold[BX]
                CALL DisplayNum
            
            MOV AH, 09H
            LEA DX, opt3TableCellBar
            INT 21H
        
        Opt3DisplayTotalSales:
            MOV AH, 02H
            MOV DL, 'R'
            INT 21H
            MOV DL, 'M'
            INT 21H
            MOV DL, ' '
            INT 21H
            XOR AX, AX
            MOV AL, currProdIndex
            MOV BL, 2
            MUL BL
            MOV BX, AX
            MOV AX, prodPrices[BX]
            XOR BX, BX
            MOV BL, currProdIndex
            XOR DX, DX
            MOV DL, prodSold[BX]
            MUL DX
            PUSH DX
            PUSH AX
            CALL Display32BitNum
            MOV AH, 02H
            MOV DL, '.'
            INT 21H
            MOV DL, '0'
            INT 21H
            INT 21H

            MOV AH, 09H
            LEA DX, opt3TableCellBar
            INT 21H

        Opt3DisplayPercentage:
            POP AX
            POP DX
            MOV BX, opt3GrandTotal[0]
            MOV CX, opt3GrandTotal[2]
            CALL DisplayPercentage
            MOV AH, 02H
            MOV DL, ' '
            INT 21H
            MOV DL, '%'
            INT 21H


        MOV AH, 09H
        LEA DX, opt3TableRowEnd
        INT 21H
        
    INC currProdIndex
    CMP currProdIndex, 12
    JE Opt3Footer
    JMP Opt3DisplayRow

    Opt3Footer:
        MOV AH, 09H
        LEA DX, opt3HeaderLine
        INT 21H
        LEA DX, opt3FooterPre
        INT 21H
        MOV DX, opt3GrandTotal[0]
        MOV AX, opt3GrandTotal[2]
        CALL Display32BitNum
        MOV AH, 02H
        MOV DL, '.'
        INT 21H
        MOV DL, '0'
        INT 21H
        INT 21H
        MOV AH, 09H
        LEA DX, opt3TableCellBar
        INT 21H
        LEA DX, opt3FooterPercent
        INT 21H
        LEA DX, opt3TableRowEnd
        INT 21H
        LEA DX, opt3FooterLine
        INT 21H
        LEA DX, newline
        INT 21H
        LEA DX, anyKeyToContinue
        INT 21H
        MOV AH, 01H
        INT 21H

    MOV AX, 4C00H
    INT 21H
MAIN ENDP

DisplayNum PROC
    MOV CX, 0
    displayIntLoop:
        XOR DX, DX
        MOV BX, 10
        DIV BX
        PUSH DX
        INC CX
        CMP AX, 0
        JNE displayIntLoop

    MOV AH, 02H
    doneLoop:
        POP DX
        ADD DL, 30H
        INT 21H
    LOOP doneLoop
    RET
DisplayNum ENDP

Display32BitNum PROC
    MOV higher16, DX
    MOV lower16, AX
    MOV prevCarry, 0

    MOV CX, 5
    MOV SI, 0
    clearStackArr:
        MOV arrR[SI], 0
        MOV AX, SI
        MOV BL, 2
        MUL BL
        MOV BX, AX
        MOV arrQ[BX], 0
        INC SI
    LOOP clearStackArr

    MOV SI, 0
    calc32bitNumStack:
        CMP SI, 5
        JAE divideLower16
        
        MOV AX, higher16
        XOR DX, DX
        MOV BX, 10
        DIV BX
        MOV higher16, AX    ; new higher16 = higher16 // 10

        MOV BX, DX              ; DX = old higher16 % 10
        MOV DL, r2LookupArr[BX] ; Lookup to get the corresponding quotient and remainder of (higher16 % 10 * 2^16) / 10
        MOV arrR[SI], DL
        
        MOV AX, BX
        MOV BL, 2
        MUL BL
        MOV BX, AX
        MOV DX, q2LookupArr[BX] 
        MOV AX, SI
        MOV BL, 2
        MUL BL
        MOV BX, AX
        MOV arrQ[BX], DX

        divideLower16:          ; new lower16 = lower16 // 10
            MOV AX, lower16
            XOR DX, DX
            MOV BX, 10
            DIV BX
            MOV lower16, AX
            MOV AX, DX
        
        ADD AL, prevCarry      ; Add previous's carry number
        MOV CX, 5
        MOV DI, 0

        r2AddupLoop:
            ADD AL, arrR[DI]    ; Add each remainder in array
            INC DI
        LOOP r2AddupLoop
        
        XOR DX, DX
        MOV BX, 10
        DIV BX
        MOV prevCarry, AL      ; Save the carry to be added in next loop
        PUSH DX

        MOV CX, 5
        MOV DI, 0
        divideArrQRLoop:        ; Divide quotient array by 10, then reassign to both quotient and remainder array
            MOV AX, arrQ[DI]
            XOR DX, DX
            MOV BX, 10
            DIV BX
            MOV arrQ[DI], AX
            MOV AX, DI
            MOV BL, 2
            DIV BL
            XOR BX, BX
            MOV BL, AL
            MOV arrR[BX], DL
            ADD DI, 2
        LOOP divideArrQRLoop

    INC SI
    CMP SI, 10
    JE print32BitNum
    JMP calc32BitNumStack

    print32BitNum:
        MOV CX, 10
        MOV AH, 02H
        MOV BX, 1   ; BX = 1: has leading zeros, 0: no more leading zeros
        print32BitNumLoop:
            POP DX
            CMP CX, 1
            JE print32BitNumPrint
            CMP DX, 0
            JE print32BitNumIsZero
            JMP print32BitNumPrint

        print32BitNumIsZero:
            CMP BX, 0
            JE print32BitNumPrint
            MOV DL, ' '
            INT 21H
            JMP print32BitNumLoopEnd

        print32BitNumPrint:
            XOR BX, BX
            ADD DL, 30H
            INT 21H
        print32BitNumLoopEnd:
        LOOP print32BitNumLoop
    RET
Display32BitNum ENDP

DisplayPercentage PROC
; DX:AX Dividend, BX:CX, Divisor
; Let x = Dividend, y = Divisor
; This function outputs x / y * 100% in 3 decimal places
    MOV div32Dividend[0], DX
    MOV div32Dividend[2], AX
    MOV div32Divisor[0], BX
    MOV div32Divisor[2], CX
    
    ; Display 100% dividend equals divisor
    CMP DX, BX
    JNE div32Start
    CMP AX, CX
    JNE div32Start
    MOV AH, 09H
    LEA DX, opt3HundredP
    INT 21H
    JMP DisplayPercentageEnd

    div32Start:
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
        MOV DL, ' '
        INT 21H
    DisplayPercentagePrint:
        
        CMP SI, 2
        JNE DisplayPercentagePrintPostDot
        MOV DL, '.'
        INT 21H
    DisplayPercentagePrintPostDot:
        MOV DL, div32Result[SI]
        CMP SI, 0
        JE DisplayPercentagePrintFirst
        ADD DL, 30H
        INT 21H
        JMP DisplayPercentagePrintEnd

    DisplayPercentagePrintFirst:
        CMP DL, 0
        JE DisplayPercentagePrintFirstZero
        ADD DL, 30H
        INT 21H
        JMP DisplayPercentagePrintEnd

    DisplayPercentagePrintFirstZero:
        MOV DL, ' '
        INT 21H

    DisplayPercentagePrintEnd:
    INC SI
    CMP SI, 5
    JE DisplayPercentageEnd
    JMP DisplayPercentagePrint

    DisplayPercentageEnd:
    RET
DisplayPercentage ENDP

END MAIN