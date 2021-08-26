; Assignment Option 4
; Author: Thong So Xue
; Description: 
;   1) Enter product ID
;   2) Display current product info
;   3) Choose which field to alter
;   4) Enter new changes
;   5) Display new changes

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
    newline DB 13, 10, "$"
    displayPrefixID    DB "Product ID       : $"
    displayPrefixName  DB "Product Name     : $"
    displayPrefixDesc  DB "Description      : $"
    displayPrefixPrice DB "Price            : RM $"
    displayPrefixQty   DB "Quantity In Stock: $"

    opt4Title DB "( Option 4 ) Update Item Information", 13, 10, 10, "$" 
    opt4GetProdID DB "Enter the product's ID to update (01-12): $"
    opt4InvalidID DB "Invalid product ID! Please re-enter. $"
    opt4ProdID DB ?

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
    LEA DX, opt4Title
    INT 21H

    ; Input product ID
    Opt4InputIDLoop:
        MOV AH, 09H
        LEA DX, opt4GetProdID
        INT 21H
        MOV AH, 01H
        INT 21H
        SUB AL, 30H
        MOV BL, AL
        INT 21H
        SUB AL, 30H
        MOV BH, AL
        MOV AL, BL
        MOV CL, 10
        MUL CL
        ADD AL, BH
        CMP AL, 0
        JB Opt4InvalidInputID
        CMP AL, 12
        JA Opt4InvalidInputID
        JMP Opt4DisplayInfoPre
    
    Opt4InvalidInputID:
        MOV AH, 09H
        LEA DX, newline
        INT 21H
        LEA DX, opt4InvalidID
        INT 21H
        LEA DX, newline
        INT 21H
        JMP Opt4InputIDLoop

    Opt4DisplayInfoPre:
        DEC AL
        MOV currProdIndex, AL

    Opt4DisplayInfo:
        MOV AH, 09H
        LEA DX, newline
        INT 21H
        INT 21H

        ; Display product info: Product ID
        LEA DX, displayPrefixID
        INT 21H
        MOV AH, 0
        MOV AL, currProdIndex
        INC AL
        MOV BL, 10
        DIV BL

        MOV BX, AX
        MOV AH, 02H
        MOV DL, BL
        ADD DL, 30H
        INT 21H
        MOV DL, BH
        ADD DL, 30H
        INT 21H

        ; Display product info: Product name
        MOV AH, 09H
        LEA DX, newline
        INT 21H
        LEA DX, displayPrefixName
        INT 21H
        MOV AL, currProdIndex
        MUL prodNameLength
        MOV currProdNameIndex, AL

        Opt4DisplayInfoName: ;Loop 12 (prodNameLength) times to display all characters in a product name
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
            JNE Opt4DisplayInfoName
        
        ; Display product info: Product Description
        MOV AH, 09H
        LEA DX, newline
        INT 21H
        LEA DX, displayPrefixDesc
        INT 21H
        MOV AH, 0
        MOV AL, currProdIndex
        MOV BL, 4
        DIV BL
        MOV AL, AH
        MOV AH, 0
        MUL prodDescLength
        MOV BX, AX
        CMP currProdIndex, 4
        JB Opt4DisplayInfoDesc1
        CMP currProdIndex, 8
        JB Opt4DisplayInfoDesc2
        JMP Opt4DisplayInfoDesc3

        Opt4DisplayInfoDesc1:
            MOV AH, 02H
            MOV DL, prodDescs1[BX]
            INT 21H
            INC BX
            MOV AX, BX
            DIV prodDescLength
            CMP AH, 0
            JNE Opt4DisplayInfoDesc1
            JMP Opt4DisplayInfoPrice

        Opt4DisplayInfoDesc2:
            MOV AH, 02H
            MOV DL, prodDescs2[BX]
            INT 21H
            INC BX
            MOV AX, BX
            DIV prodDescLength
            CMP AH, 0
            JNE Opt4DisplayInfoDesc2
            JMP Opt4DisplayInfoPrice

        Opt4DisplayInfoDesc3:
            MOV AH, 02H
            MOV DL, prodDescs3[BX]
            INT 21H
            INC BX
            MOV AX, BX
            DIV prodDescLength
            CMP AH, 0
            JNE Opt4DisplayInfoDesc3
            JMP Opt4DisplayInfoPrice

        ; Display product info: Product Price
        Opt4DisplayInfoPrice: 
            MOV AH, 09H
            LEA DX, newline
            INT 21H
            LEA DX, displayPrefixPrice
            INT 21H
            MOV AL, currProdIndex
            MOV BL, 2
            MUL BL
            MOV BL, AL
            MOV BH, 0
            MOV AX, prodPrices[BX]
            CALL DisplayNum
            MOV AH, 02H
            MOV DL, '.'
            INT 21H
            MOV DL, '0'
            INT 21H
            INT 21H
        
        ; Display product info: Product Quantity
        MOV AH, 09H
        LEA DX, newline
        INT 21H
        LEA DX, displayPrefixQty
        INT 21H
        MOV BH, 0
        MOV BL, currProdIndex
        MOV AH, 0
        MOV AL, prodQuantities[BX]
        CALL DisplayNum
        MOV AH, 09H
        LEA DX, newline
        INT 21H

    ; Choose Which field to modify

    ; Modify field

    ; Loop back to top

    EndOpt4:
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
