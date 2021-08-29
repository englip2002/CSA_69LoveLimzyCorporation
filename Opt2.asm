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
    prodPrices DW 500, 198, 98, 128, 48, 108, 128, 118, 208, 98, 298, 298
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

    ;--Order
    ;--constant value
    HUNDRED DW 100
    TWO DB 2
    ServicePercentage DW 10
    SSTPercentage DW 6
    DeliveryFee DW 20
    ;--messages
    PurchaseIndexMsg DB "Enter your choice (01-12): $"
    PurchaseQuantityMsg DB "Enter purchase quantity (01-99): $"
    InvalidPurchaseIndexMsg DB "Invalid Choice! Pls Re-enter.$"
    InsufficientStockMsg DB "Stock Insufficient! Pls Re-enter$"
    InvalidQuantityMsg DB "Invalid Quantity! Pls Re-enter$"
    ContinueMsg DB "Continue purchase? (Y to continue) $"
    DeliveryMsg DB "Do you want to have delivary service ? (Y to choose) $"
    DeliveryChoose DB ?

    ;--indexing
    PurchaseCount DB 0
    CalculateSubtotalIndex DW 0

    ;--storing data
    PurchasingItem DB 20 DUP (?)
    PurchaseQuantity DB 20 DUP (?)
    Subtotal DW 0
    SST_QUOTIENT DW 0
    SST_REMAINDER DW 0
    SERVICE_QUOTIENT DW 0
    SERVICE_REMAINDER DW 0
    TOTAL_QUOTIENT DW 0
    TOTAL_REMAINDER DW 0

    ;--display
    tenB DB 10
    tenW DW 10
    displayStack DW 5 DUP (0)
    displayStackIndex DW 0

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    DISPLAY_PRODUCT_LIST:
        MOV CH,0
        MOV CL,prodNameLength

            ;--DISPLAY INDEX NUMBERS
            MOV AH,0
            MOV AL,currProdIndex
            ADD AL,1
            DIV tenB
            MOV BX,AX

            MOV AH,02H
            MOV DL,BL
            ADD DL,30H
            INT 21H

            MOV AH,02H
            MOV DL,BH
            ADD DL,30H
            INT 21H

            MOV AH,02H
            MOV DL,")"
            INT 21H
        DISPLAY_PRODUCT_NAME:
            ;--DISPLAY NAME
            MOV BH,0
            MOV BL,currProdNameIndex
            MOV AH,02H
            MOV DL, prodNames[BX]
            INT 21H
            INC currProdNameIndex

            LOOP DISPLAY_PRODUCT_NAME
            JMP DISPLAY_CURRENT_STOCK
        DISPLAY_PROD_MIDDLE:
            JMP DISPLAY_PRODUCT_LIST

        DISPLAY_CURRENT_STOCK:
            ;--DISPLAY STOCK
            MOV BH,0
            MOV BL,currProdIndex

            MOV AH,02H
            MOV DL," "
            INT 21H

            MOV AH,02H
            MOV DL,"("
            INT 21H

            MOV AH,0
            MOV AL,prodQuantities[BX]
            DIV tenB
            MOV BX,AX

            MOV AH,02H
            MOV DL,BL
            ADD DL,30H
            INT 21H

            MOV AH,02H
            MOV DL,BH
            ADD DL,30H
            INT 21H

            MOV AH,02H
            MOV DL,")"
            INT 21H

            ;--NEXTLINE
            MOV AH,09H
            LEA DX, newline
            INT 21H

            ;--INCREASE PRODUCT INDEX
            INC currProdIndex
            MOV BL, currProdIndex
            CMP BL, totalProducts
            JNE DISPLAY_PROD_MIDDLE 
    
    ;--new line
    MOV AH,09H
    LEA DX,newline
    INT 21H

    InputPurchase:
    ;--OUTPUT MESSAGE
    MOV AH,09H
    LEA DX,PurchaseIndexMsg
    INT 21H

    ;--INPUT DATA(2 DIGIT)
    MOV AH,01H
    INT 21H
    SUB AL,30H
    MUL tenB        ;--IF INPUT 1 THEN BECOME 10

    MOV BH,0
    MOV BL,PurchaseCount ;--MOVE THE PurchaseCount(index) TO REGISTER
    MOV PurchasingItem[BX], AL ;--SAVE TO PurchasingItem[PurchaseCount]
    
    MOV AH,01H
    INT 21H
    SUB AL,30H
    ADD PurchasingItem[BX],AL ;--IF INPUT 2, ADD B4 ONE BECOME 12
    SUB PurchasingItem[BX],1 ;--TO DECREASE 1 SINCE USER CHOICE START FROM 1

    MOV AH,09H
    LEA DX,newline
    INT 21H

    MOV DL,PurchasingItem[BX]    ;--COMPARE IF GREATER THAN 12 OR LOWER THAN 1 JMP InvalidItem
    CMP DL,11
    JA InvalidItem
    CMP DL,0
    JB InputPurchase
    JMP InputPurchaseQuantity    ;--ELSE JMP InputPurchseQuantity

InvalidItem:
    MOV AH,09H
    LEA DX,InvalidPurchaseIndexMsg
    INT 21H

    MOV AH,09H
    LEA DX,newline
    INT 21H

    MOV AH,09H
    LEA DX,newline
    INT 21H
    JMP InputPurchase

InputPurchaseQuantity:
    ;--INPUT PURCHASE QUANTITY
    MOV AH,09H
    LEA DX,newline
    INT 21H

    MOV AH,09H
    LEA DX,PurchaseQuantityMsg
    INT 21H

    MOV AH,01H
    INT 21H
    SUB AL,30H
    MUL tenB       ;--IF INPUT 1 THEN BECOME 10

    MOV BH,0
    MOV BL,PurchaseCount       ;--MOVE THE PurchaseCount(index) TO REGISTER
    MOV PurchaseQuantity[BX], AL   ;--SAVE TO PurchaseQuantity[PurchaseCount]

    MOV AH,01H
    INT 21H
    SUB AL,30H
    ADD PurchaseQuantity[BX],AL   ;--ADD SECOND DIGIT TO PurchaseQuantity

    CMP PurchaseQuantity[BX],1   ;--CHECK IF NUMBER IS LESS THAN 1
    JL PrintInvalidQuantityMessage

    JMP CheckQuantity

PrintInvalidQuantityMessage:
    MOV AH,09H
    LEA DX,newline
    INT 21H

    MOV AH,09H
    LEA DX,InvalidQuantityMsg
    INT 21H

    MOV AH,09H
    LEA DX,newline
    INT 21H

    JMP InputPurchaseQuantity
CheckQuantity:
    ;--CHECKING QUANTITY 
    MOV DL,PurchaseQuantity[BX]    ;--GET THE PurchaseQuantity 
    MOV BH,0                       ;--CHANGE BX TO INDEX OF Purchasing Item's Index 
    MOV BL,PurchasingItem[BX]
    CMP DL,prodQuantities[BX]      ;--COMPARE THE QUANTITY(IF PurchaseQuantity > ProdQuantity : do following)
    JB  SubQuantity

    MOV AH,09H
    LEA DX,newline
    INT 21H

    MOV AH,09H
    LEA DX,InsufficientStockMsg
    INT 21H
    
    MOV AH,09H
    LEA DX,newline
    INT 21H
    JMP InputPurchaseQuantity

MIDDLEPOINT:
    JMP InputPurchase

SubQuantity:
    ;--TO SUBSTARCT THE NUMBER OF STOCK WITH ITEM
    MOV BH,0
    MOV BL,PurchaseCount           ;--CHANGE THE INDEX BACK TO PurchaseCount (Current Purchase)
    MOV DL,PurchaseQuantity[BX]    ;--MOVE PurchaseQuantity[PurchaseCount] TO DL

    MOV BH,0
    MOV BL,PurchasingItem[BX]      ;--CHANGE BX TO INDEX OF Purchasing Item's index 
    SUB prodQuantities[BX],DL      ;--SUBSTARCT THE prodQuantities[Index of item] THAT IN POSITION WITH PurchaseQuantity


    INC PurchaseCount ;--INCREASE INDEX 

    ;--INPUT WEATHER CONTINUE OR NOT
    MOV AH,09H
    LEA DX,newline
    INT 21H

    MOV AH,09H
    LEA DX, ContinueMsg
    INT 21H

    MOV AH,01H
    INT 21H

    MOV AH,09H
    LEA DX,newline
    INT 21H

    CMP AL,'Y'       ;--IF CONTINUE == Y || y, JUMP TO BEGINING
    JE MIDDLEPOINT
    CMP AL,'y' 
    JE MIDDLEPOINT

    MOV AH,09H
    LEA DX,newline
    INT 21H

    ;--DELIVARY ?
    MOV AH,09H
    LEA DX, DeliveryMsg
    INT 21H

    MOV AH,01H
    INT 21H
    MOV DeliveryChoose, AL
    CMP DeliveryChoose,'Y'
    JE AddDelivery

    CMP DeliveryChoose,'y'
    JE AddDelivery
    JMP CalculateSubtotal

AddDelivery:
    MOV AX,DeliveryFee
    ADD Subtotal,AX     ;--ADD DELIVERY FEE(FIXED)

CalculateSubtotal:
    MOV AH,09H
    LEA DX,newline
    INT 21H
MOV CH,0
MOV CL,PurchaseCount
CalculateSub: 
    MOV BX,CalculateSubtotalIndex
    MOV AH,0
    MOV DH,0                    ;--AL=mul result, BX=real index, CX=loop, DX=purchaseQuantity
    MOV DL,PurchaseQuantity[BX] ;--get purchase quantity and save to DL(need to get first because index changed after this)
    MOV AL,PurchasingItem[BX] ;--get purchasing item [index] then multiply 2 to get real index
    MUL TWO
    MOV BL,AL   ;--real index is store into BX

    MOV AL,DL            ;--pass the quantity of purchase to AL
    MUL prodPrices[BX]   ;--Multiply quantity with prodPrices[PurchasingItemIndex]
    ADD Subtotal,AX      ;--add to subtotal
    INC CalculateSubtotalIndex
LOOP CalculateSub

    ;CALCULATE SERVICE CHARGE AND SST
    MOV AX,Subtotal
    MUL SSTPercentage
    DIV HUNDRED
    MOV SST_REMAINDER,DX     ;MUL DX,AX
    MOV SST_QUOTIENT,AX    ;DIV DX,AX(R,Q)

    MOV AX,Subtotal
    MUL ServicePercentage
    DIV HUNDRED
    MOV SERVICE_REMAINDER,DX     
    MOV SERVICE_QUOTIENT,AX   

    ;--ADD SERVICE CHARGE AND SST
    MOV BX,Subtotal
    MOV TOTAL_QUOTIENT,BX   ;--move amount of subtotal to total_quotient
    MOV AX,SST_QUOTIENT     ;--add total_quotient with SST and service charge
    ADD TOTAL_QUOTIENT,AX   
    MOV AX,SERVICE_QUOTIENT
    ADD TOTAL_QUOTIENT,AX

    MOV AX,SST_REMAINDER      
    ADD TOTAL_REMAINDER,AX
    MOV AX,SERVICE_REMAINDER
    ADD TOTAL_REMAINDER,AX
    CMP TOTAL_REMAINDER,100
    JB Display1
    
    ADD TOTAL_QUOTIENT,1
    SUB TOTAL_REMAINDER,100
    
Display1:
    MOV AX,TOTAL_QUOTIENT
    CALL DisplayNum

    MOV AH,02H
    MOV DL,'.'
    INT 21H

    MOV AX,TOTAL_REMAINDER
    CALL DisplayNum

    EndProgram:
    MOV AX, 4C00H
    INT 21H
MAIN ENDP

DisplayNum PROC
    MOV displayStackIndex, 0
    displayIntLoop:
        MOV DX, 0
        DIV tenW
        MOV BX, displayStackIndex
        MOV displayStack[BX], DX
        INC displayStackIndex
        CMP AX, 0
        JNE displayIntLoop

    doneLoop:
        DEC displayStackIndex
        DisplayDecimal:
        MOV BX, displayStackIndex
        MOV DX, displayStack[BX]
        MOV AH, 02H
        ADD DL, 30H
        INT 21H
        CMP displayStackIndex, 0
        JNE doneLoop
    RET
DisplayNum ENDP
END MAIN