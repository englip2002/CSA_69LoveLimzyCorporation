; Assignment Option 1
; Done: 
;   - Display name
;   - Display desc
; Not done:
;   - Display Price (i have no idea how to store this)
;       (If we use like 5000 as RM 50.00, mean 2 bytes can store max 65535 / RM 655.35 only)
;       (Trying LDS and LES to store double word, but this shit just doesn't work)
;   - Display quantity (easy, but haven't do)

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
    prodPrices DW 50000, 19800, 9800, 12800, 4800, 10800, 12800, 11800, 20800, 9800, 29800, 29800
    prodQuantities DB 50, 20, 25, 30, 35, 20, 25, 15, 15, 20, 15, 10
    opt1Title DB "( Option 1 ) Display Item Information", 13, 10, 10, "$" 
    newline DB 13, 10, "$"
    anyKeyToContinue DB "< Press any key to continue >$"
    prefixName DB "Product Name: $"
    prefixDesc DB "Description : $"
    prefixPrice DB "Price       : RM$"
    prefixQty DB "Quantity    : $"

    currProdIndex DB 0
    currProdNameIndex DB 0
    currProdDescIndex DB 0
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV AH, 09H
    LEA DX, opt1Title
    INT 21H

    Opt1ProductLoop:
        MOV AH, 09H
        LEA DX, prefixName
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

        MOV AH, 09H
        LEA DX, newline
        INT 21H
        LEA DX, prefixDesc
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
            JNE Opt1DescLoopStart

        Opt1PriceLoop:
            

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
        JE EndProgram
        JMP Opt1ProductLoop
    

    EndProgram:
        MOV AX, 4C00H
        INT 21H
MAIN ENDP
END MAIN
