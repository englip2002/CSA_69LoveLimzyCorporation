; Assignment Option 1
; Author: Thong So Xue
; Description:
;   Loop through all the products and display their product name, description, price and quantity in stock

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
    opt1Title DB "( Option 1 ) Display Item Information", 13, 10, 10, "$" 
    newline DB 13, 10, "$"
    anyKeyToContinue DB "< Press any key to continue >$"
    opt1PrefixID    DB "Product ID       : $"
    opt1PrefixName  DB "Product Name     : $"
    opt1PrefixDesc  DB "Description      : $"
    opt1PrefixPrice DB "Price            : RM $"
    opt1PrefixQty   DB "Quantity In Stock: $"

    currProdIndex DB 0
    currProdNameIndex DB 0
    currProdDescIndex DB 0

    displayStack DW 5 DUP (0)
    tenW DW 10
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV AH, 09H
    LEA DX, opt1Title
    INT 21H

    
    MOV currProdIndex, 0
    Opt1ProductLoop:
        ; Display Product ID
        LEA DX, opt1PrefixID
        INT 21H
        MOV AH, 0
        MOV AL, currProdIndex
        INC AL
        CALL DisplayNum
        MOV AH, 09H
        LEA DX, newline
        INT 21H

        ; Display Product Name
        MOV AH, 09H
        LEA DX, opt1PrefixName
        INT 21H
        Opt1NameLoop: ;Loop 12 (prodNameLength) times to display all characters in a product name
            MOV BH, 0
            MOV BL, currProdNameIndex
            MOV AH, 02H
            MOV DL, prodNames[BX]
            INT 21H

            INC currProdNameIndex
            MOV AH, 0
            MOV AL, currProdNameIndex
            DIV prodNameLength
            CMP AH, 0
            JNE Opt1NameLoop

        ; Display Product Description
        MOV AH, 09H
        LEA DX, newline
        INT 21H
        LEA DX, opt1PrefixDesc
        INT 21H

        MOV AH, 0
        MOV AL, currProdIndex
        DIV prodDescDivLen
        CMP AH, 0
        JNE Opt1DescLoopStart
        MOV currProdDescIndex, 0
        Opt1DescLoopStart: ;Loop 50 (prodDescLength) times to display all characters in a product description
            MOV BH, 0
            MOV BL, currProdDescIndex
            MOV AH, 02H
            MOV CL, currProdIndex
            CMP CL, 4
            JB Opt1Desc1
            CMP CL, 8
            JB Opt1Desc2
            JMP Opt1Desc3

        Opt1Desc1:
            MOV DL, prodDescs1[BX]
            JMP Opt1DescLoopEnd
        Opt1Desc2:
            MOV DL, prodDescs2[BX]
            JMP Opt1DescLoopEnd
        Opt1Desc3:
            MOV DL, prodDescs3[BX]
            JMP Opt1DescLoopEnd

        Opt1DescLoopEnd:
            INT 21H
            INC currProdDescIndex
            MOV AH, 0
            MOV AL, currProdDescIndex
            DIV prodDescLength
            CMP AH, 0
            JE Opt1Price
            JMP Opt1DescLoopStart

        ; Display Product Price
        Opt1Price:
            MOV AH, 09H
            LEA DX, newline
            INT 21H
            LEA DX, opt1PrefixPrice
            INT 21H

        MOV AL, currProdIndex
        MOV BH, 2       ; Multiply index by 2 because prodPrices array is a word array
        MUL BH
        MOV BX, AX
        MOV AX, prodPrices[BX]
        CALL DisplayNum

        MOV AH, 02H
        MOV DL, '.'
        INT 21H
        MOV DL, '0'
        INT 21H
        INT 21H

        ; Display Product Quantity
        MOV AH, 09H
        LEA DX, newline
        INT 21H
        LEA DX, opt1PrefixQty
        INT 21H
        MOV BH, 0
        MOV BL, currProdIndex
        MOV AH, 0
        MOV AL, prodQuantities[BX]
        CALL DisplayNum

        ; Display <Press any key to continue>
        MOV AH, 09H
        LEA DX, newline
        INT 21H
        LEA DX, anyKeyToContinue
        INT 21H
        MOV AH, 01H
        INT 21H

        MOV AH, 09H
        LEA DX, newline
        CMP AL, 13
        JE Opt1SpaceBetweenProd
        INT 21H
        Opt1SpaceBetweenProd:
        INT 21H

        INC currProdIndex
        MOV BL, currProdIndex
        CMP BL, totalProducts
        JE EndOpt1
        JMP Opt1ProductLoop

    EndOpt1:
        MOV AX, 4C00H
        INT 21H
MAIN ENDP

; Display AX in numeric form (max 65535 / 1 word / 2 byte)
DisplayNum PROC
    MOV DI, 0
    displayIntLoop:
        MOV DX, 0
        DIV tenW
        MOV displayStack[DI], DX
        INC DI
        CMP AX, 0
        JNE displayIntLoop

    doneLoop:
        DEC DI
        MOV DX, displayStack[DI]
        MOV AH, 02H
        ADD DL, 30H
        INT 21H
        MOV displayStack[DI], 0
        CMP DI, 0
        JNE doneLoop
    RET
DisplayNum ENDP

END MAIN
