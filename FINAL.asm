.MODEL SMALL
.STACK 100
.386
.DATA
    newline            DB 13,10,"$"
	
    ;---Program Title
    progTitle          DB       "//***********************************************************\\"
                       DB 13,10,"[   __ __               _                     __      __      ]"
                       DB 13,10,"[  /_ (__)  /      _   / )  _     _ __/'     (  _/   / _)/ _/ ]"
                       DB 13,10,"[ (__)__/  (__()\/(-  (__()/ /)()/ (///()/) __)(//) /(_)/)(/  ]"
                       DB 13,10,"[                           /                                 ]"
                       DB 13,10,"\\***********************************************************//$"

	
    ;---Login
    loginTitle         DB       "                 LOGIN"
                       DB 13,10,"---------------------------------------$"
    promptId           DB "   Enter ID       > $"
    promptPassword 	   DB "   Enter Password > $"
    invalidLoginMsg    DB "   Invalid ID or Password!!$"
    loginSuccessMsg    DB 13,10,"<------------ Welcome!! -------------->$"
    validId            DB "user123"
    validPassword      DB "psw1234"
    idEntered          DB 7 DUP(?)
    passwordEntered    DB 7 DUP(?)
	
    ;---Menu
    menuList           DB 13,10,"              MAIN MENU"
                       DB 13,10,"======================================="
                       DB 13,10," |  [1] Display Product Information  |"
                       DB 13,10," |  [2] Purchase                     |"
                       DB 13,10," |  [3] Sales Summary                |"
                       DB 13,10," |  [4] Product Maintenance          |"
                       DB 13,10," |  [5] Exit Program                 |"
                       DB 13,10,"=======================================$"
    promptMenuOpt      DB "Enter your option (1-5) > $"
    invalidMenuOptMsg  DB "Invalid Option!!$"

    ; Product info
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

    ; Option 1 (Display Product Information) Variables
    opt1Title DB "( Option 1 ) Display Product Information", 13, 10, 10, "$" 
    anyKeyToContinue DB "< Press any key to continue >$"
    displayPrefixID    DB "Product ID       : $"
    displayPrefixName  DB "Product Name     : $"
    displayPrefixDesc  DB "Description      : $"
    displayPrefixPrice DB "Price            : RM $"
    displayPrefixQty   DB "Quantity In Stock: $"
    currProdIndex DB 0
    currProdNameIndex DB 0
    currProdDescIndex DB 0

    ; Option 2 (Purchase) Variables
    ;---Storing data
    PurchasingItem      DB 20 DUP ("?")
    PurchaseQuantity    DB 20 DUP ("?")
    PurchasePrice       DW 0
    Subtotal            DW 0
    SST_QUOTIENT        DW 0
    SST_REMAINDER       DW 0
    SERVICE_QUOTIENT    DW 0
    SERVICE_REMAINDER   DW 0
    TOTAL_QUOTIENT      DW 0
    TOTAL_REMAINDER     DW 0
    ADJUSTED_QUOTIENT   DW 0
    ADJUSTED_REMAINDER  DW 0
    CASH_QUOTIENT       DW ?
    CASH_REMAINDER      DW ?
    BALANCE_QUOTIENT    DW 0
    BALANCE_REMAINDER   DW 0
    
    ;---Order
    ;---constant value
    HUNDRED           DW 100
    TWO               DB 2
    ServicePercentage DW 12
    SSTPercentage     DW 5
    DeliveryFee       DW 20
	
    ;---Messages
    opt2Title DB "( Option 2 ) Purchase", 13, 10, 10, "$" 
    opt2MenuLeft DB " left$"
    opt2MenuPrice DB " - RM$"
    PurchaseIndexMsg        DB "Enter your choice (01-12): $"
    PurchaseQuantityMsg     DB "Enter purchase quantity (01-99): $"
    InvalidPurchaseIndexMsg DB "Invalid Choice! Pls Re-enter.$"
    InsufficientStockMsg    DB "Stock Insufficient! Pls Re-enter.$"
    InvalidQuantityMsg      DB "Invalid Quantity! Pls Re-enter$"
    ContinueMsg             DB "Continue purchase? (Y to continue) $"
    DeliveryMsg             DB "Do you want to have delivary service (RM 20) ? (Y to choose) $"
    DeliveryChoose          DB ?
	
    purchaseBill        DB       "---------------------------------------"
                        DB 13,10,"             PURCHASE BILL$"
    purchaseBillLine    DB       "---------------------------------------$"
    purchaseBillItemMsg DB "Item           Quantity    Subtotal$"
    deliveryTotalMsg    DB "Delivery                   RM   20.00$"
    subtotalLine        DB "                           ------------$"
    subtotalMsg         DB "                           RM$"
    sstMsg              DB "SST (5%)                :  RM$"
    serviceChargeMsg    DB "Service Charge (12%)    :  RM$"
    totalAmountMsg      DB "Total Amount            :  RM$"
    roundingMsg         DB "Rounding Adjustment     : $"
    adjustedAmountMsg   DB "Total Amount (Adjusted) :  RM$"
    inputCashMsg        DB "Input Cash (ie. 50.00)  :  RM $"
    notEnoughMsg        DB "Not Enough Cash!!$"
    invalidCashMsg      DB "Invalid Cash!! Input cash should include decimal points (ie.50.00).$"
    balanceMsg          DB "Balance                 :  RM$"
    thxOrderMsg         DB "      Thank you for your order!!$"
    
    ;--indexing
    continuePurchaseCount  DB 0
    CalculateSubtotalIndex DW 0
    numOfPurchased         DB 0
	
    ;---Output & Input Amounts Used
    tenB                DB 10
    tenW                DW 10
    inputStack          DB 10 DUP(" ")
    
    ;---For Calculating Rounding Adjustment
    five                DB 5
    lastDigit           DB ?
    roundingAdjustment  DB ?
    
    ;---Formatting Rounding Adjustment
    positiveRounding    DB "+RM    0.0$"
    negativeRounding    DB "-RM    0.0$"
	

    ; Option 3 (Display Sales Summary) Variables
    opt3Title DB "( Option 3 ) Display Sales Summary", 13, 10, 10, "$" 
    opt3Header DB       '| Product/Service | Price (RM) | Sold Quantity | Total Sales (RM) |  Sales %  |', 13, 10, '$'
    opt3HeaderLine DB   '+-----------------+------------+---------------+------------------+-----------+', 13, 10, '$'
    opt3FooterLine DB   '+----------------------------------------------+------------------+-----------+', 13, 10, '$'
    opt3FooterPre DB    '|                                  Grand Total | RM $'
    opt3TableRowStart DB "| $"
    opt3TableRowEnd DB " |", 13, 10, "$"
    opt3TableCellBar DB " | $"
    opt3GrandTotal DW 0, 0   ; First = Upper 16-bits, Second = Lower 16-bits 
    opt3ZeroP DB "  0.000$"
    opt3HundredP DB "100.000$"

    ; Option 4 (Product Maintenance) Variables
    opt4Title DB "( Option 4 ) Product Maintenance", 13, 10, 10, "$" 

    ; Option 5 Ending
    opt5Title          DB 13,10,"<----- Bye..See You Next Time... ----->$"
    numOfPurchasedMsg DB "Total number of purchased: $"

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

    ;------Program Title
    MOV AH,09H
    LEA DX,progTitle
    INT 21H
    
    MOV AH,09H
    LEA DX,newline
    INT 21H
    
    
    ;------Login
    MOV AH,09H
    LEA DX,loginTitle
    INT 21H
    	
    MOV AH,09H
    LEA DX,newline
    INT 21H
    	
    Login:
    	;---Get id
    	MOV AH,09H
    	LEA DX,promptId
    	INT 21H
    
    	MOV SI,OFFSET idEntered
    	MOV CX,7
    	inputID:
    		MOV AH,01H
    		INT 21H
    		MOV [SI],AL
    		INC SI
    	LOOP inputID
    	
    	MOV AH,09H
    	LEA DX,newline
    	INT 21H
    	
    	;---Get Password
    	MOV AH,09H
    	LEA DX,promptPassword
    	INT 21H
    
    	MOV SI,OFFSET passwordEntered
    	MOV CX,7
    	inputPassword:
    		MOV AH,07H
    		INT 21H
    		MOV [SI],AL
    		INC SI
    	LOOP inputPassword
    	
    	MOV AH,09H
    	LEA DX,newline
    	INT 21H
    	
    	;---Validation
    	MOV CX,7
    	MOV SI,OFFSET idEntered
    	MOV DI,OFFSET validId
    	validateID:
    		MOV BL,[SI]
    		CMP BL,[DI]
    		JNE InvalidLogin
    		INC SI
    		INC DI
    	LOOP validateID
    	
    	MOV CX,7		
    	MOV SI,OFFSET passwordEntered
    	MOV DI,OFFSET validPassword
    	validatePassword:
    		MOV BL,[SI]
    		CMP BL,[DI]
    		JNE InvalidLogin
    		INC SI
    		INC DI
    	LOOP validatePassword
    	JMP LoginSuccess
    	
    	InvalidLogin:
    		MOV AH,09H
    		LEA DX,invalidLoginMsg
    		INT 21H
    		
    		MOV AH,09H
    		LEA DX,newline
    		INT 21H
    		
    		MOV AH,09H
    		LEA DX,newline
    		INT 21H
    		
    		JMP Login
    		
    	LoginSuccess:
    		MOV AH,09H
    		LEA DX,newline
    		INT 21H
    		
    		MOV AH,09H
    		LEA DX,loginSuccessMsg
    		INT 21H
    	
    		MOV AH,09H
    		LEA DX,newline
    		INT 21H
    		
    	CALL MENU

    MOV AX, 4C00H
    INT 21H
MAIN ENDP

;---Menu
MENU PROC	
    DisplayMenu:
    	MOV AH,09H
    	LEA DX,menuList
    	INT 21H
    
    	MOV AH,09H
    	LEA DX,newline
    	INT 21H
    
    InputOpt:
    	MOV AH,09H
    	LEA DX,promptMenuOpt
    	INT 21H
    	
    	MOV AH,01H
    	INT 21H
    	SUB AL,30H
    	
    	CMP AL,1
    	JE Option1
    	CMP AL,2
    	JE Option2
    	CMP AL,3
    	JE Option3
    	CMP AL,4
    	JE Option4
    	CMP AL,5
    	JNE InvalidOption
    	JMP Option5

    InvalidOption:
    	MOV AH,09H
    	LEA DX,newline
    	INT 21H
    	
    	MOV AH,09H
    	LEA DX,invalidMenuOptMsg
    	INT 21H
    	
    	MOV AH,09H
    	LEA DX,newline
    	INT 21H
    	
    	JMP InputOpt

    MOV AH,09H
    LEA DX,newline
    INT 21H
    
    Option1: 
    	CALL OPT1
    	JMP DisplayMenu
    
    Option2: 
    	CALL OPT2
    	JMP DisplayMenu
    	
    Option3: 
    	CALL OPT3
    	JMP DisplayMenu
    	
    Option4: 
    	CALL OPT4
    	JMP DisplayMenu
    	
    Option5: 
        CALL OPT5
    
    RET
MENU ENDP

; Option 1 - Display Product Information
OPT1 PROC
	MOV AH,09H
	LEA DX,newline
	INT 21H
	
	MOV AH, 09H
    LEA DX, opt1Title
    INT 21H
    
    MOV currProdIndex, 0
    Opt1ProductLoop:
        ; Display Product ID
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
        MOV AH, 09H
        LEA DX, newline
        INT 21H

        ; Display Product Name
        MOV AH, 09H
        LEA DX, displayPrefixName
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
        LEA DX, displayPrefixDesc
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
            LEA DX, displayPrefixPrice
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
        LEA DX, displayPrefixQty
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
	RET
OPT1 ENDP

; Option 2 - Purchase
OPT2 PROC
    MOV AH,09H
    LEA DX,newline
    INT 21H
    LEA DX, opt2Title
    INT 21H

    ;--initialize index to 0 (for 2nd time loop)
    MOV PurchasePrice,0       
    MOV Subtotal,0            
    MOV SST_QUOTIENT,0        
    MOV SST_REMAINDER,0       
    MOV SERVICE_QUOTIENT,0    
    MOV SERVICE_REMAINDER,0   
    MOV TOTAL_QUOTIENT,0     
    MOV TOTAL_REMAINDER,0     
    MOV continuePurchaseCount,0
    MOV CalculateSubtotalIndex, 0
    MOV currProdIndex, 0
    MOV currProdNameIndex, 0

    MOV SI, 0
    MOV CX, 20
    clearPurchasingItem:
        MOV PurchasingItem[SI], "?"
        INC SI
    LOOP clearPurchasingItem
    
    MOV SI, 0
    MOV CX, 20
    clearPurchaseQuantity:
        MOV PurchaseQuantity[SI], "?"
        INC SI
    LOOP clearPurchaseQuantity

    MOV CX, 10
    MOV SI, 0
    clearInputStack:
        MOV inputStack[SI], " "
        INC SI
    LOOP clearInputStack

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
            MOV DL, ' '
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

            MOV AH, 09H
            LEA DX, opt2MenuLeft
            INT 21H

            MOV AH,02H
            MOV DL,")"
            INT 21H

            MOV AH, 09H
            LEA DX, opt2MenuPrice
            INT 21H

            MOV AL, currProdIndex
            MUL TWO
            MOV BX, AX
            MOV AX, prodPrices[BX]
            CALL AmountFormatting
            MOV AL, currProdIndex
            MUL TWO
            MOV BX, AX
            MOV AX, prodPrices[BX]
            CALL DisplayNum
            MOV AH, 02H
            MOV DL, '.'
            INT 21H
            MOV DL, '0'
            INT 21H
            INT 21H

            ;--NEXTLINE
            MOV AH,09H
            LEA DX, newline
            INT 21H

            ;--INCREASE PRODUCT INDEX
            INC currProdIndex
            MOV BL, currProdIndex
            CMP BL, totalProducts
            JE InputPurchaseBefore
            JMP DISPLAY_PRODUCT_LIST 
        
        InputPurchaseBefore:
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
        CMP AL,9                     ;--MEANS IS NOT DIGIT
        JA InvalidItem
		MUL tenB                     ;--IF INPUT 1 THEN BECOME 10
	
		MOV BH,0
		MOV BL,continuePurchaseCount ;--MOVE THE index of PurchaseCount TO REGISTER
		MOV PurchasingItem[BX], AL   ;--SAVE TO PurchasingItem[PurchaseCount]
		
		MOV AH,01H
		INT 21H
		SUB AL,30H
        CMP AL, 9                    ;--MEANS IS NOT DIGIT
        JA InvalidItem
		ADD PurchasingItem[BX],AL    ;--IF INPUT 2, ADD B4 ONE BECOME 12
		SUB PurchasingItem[BX],1     ;--TO DECREASE 1 SINCE USER CHOICE START FROM 1 (INDEX)
	
		MOV AH,09H
		LEA DX,newline
		INT 21H
                                     ;-- BX = continuePurchaseCount
		MOV DL,totalProducts         ;--COMPARE IF GREATER THAN 12 OR LOWER THAN 1 JMP InvalidItem(0 and 11 because -1 arld)
        SUB DL,1
		CMP PurchasingItem[BX],DL    ;--11 IS THE TOTALPRODUCT - 1
		JA InvalidItem

        MOV BL, PurchasingItem[BX]   ;--TO GET THE INDEX OF PURCHASING PRODUCT
        MOV BH, 0
        CMP prodQuantities[BX], 0    ;--TO FIND OUT THE QUANTITY IS 0 ALRD OR NOT
        JE ItemNoStock
		JMP InputPurchaseQuantity    ;--ELSE JMP InputPurchseQuantity
	
    ItemNoStock:
        MOV AH, 09H
        LEA DX, InsufficientStockMsg
        INT 21H
        LEA DX, newline
        INT 21H
        INT 21H
        JMP InputPurchase

	InvalidItem:
    	MOV AH,09H
		LEA DX,newline
		INT 21H

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
        CMP AL, 9      ;--MEANS IS NOT DIGIT
        JA PrintInvalidQuantityMessage
		MUL tenB       ;--IF INPUT 1 THEN BECOME 10
	
		MOV BH,0
		MOV BL,continuePurchaseCount   ;--MOVE THE continuePurchaseCount TO BX
		MOV PurchaseQuantity[BX], AL   ;--SAVE TO PurchaseQuantity[PurchaseCount]
	
		MOV AH,01H
		INT 21H
		SUB AL,30H
        CMP AL, 9                     ;--MEANS IS NOT DIGIT
        JA PrintInvalidQuantityMessage
		ADD PurchaseQuantity[BX],AL   ;--ADD SECOND DIGIT TO PurchaseQuantity
	
		CMP PurchaseQuantity[BX],0    ;--CHECK IF NUMBER IS LESS THAN 1
		JE PrintInvalidQuantityMessage
	
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
		;--CHECKING QUANTITY           ;--BX=continuePurchaseCount
		MOV DL,PurchaseQuantity[BX]    ;--GET THE PurchaseQuantity 
		MOV BH,0                       ;--CHANGE BX TO INDEX OF Purchasing Item's Index 
		MOV BL,PurchasingItem[BX]
		CMP DL,prodQuantities[BX]      ;--COMPARE THE QUANTITY (IF PurchaseQuantity <= ProdQuantity : continue step)
		JBE SubQuantity
	
		MOV AH,09H
		LEA DX,newline
		INT 21H
	
        JMP ItemNoStock

	SubQuantity:
		;--TO SUBSTARCT THE NUMBER OF STOCK WITH ITEM
		MOV BH,0
		MOV BL,continuePurchaseCount   ;--CHANGE THE INDEX BACK TO continuePurchaseCount (Current Purchase)
		MOV DL,PurchaseQuantity[BX]    ;--GET PurchaseQuantity OF THE CURRENT PURCHASE
                                       ;--exp: PurchaseQuantity[0]=12 (12 is quantity of purchase input just now) 
	
		MOV BH,0
		MOV BL,PurchasingItem[BX]      ;--CHANGE BX TO INDEX OF Purchasing Item's index 
                                       ;exp: PurchasingItem[0]=01 (01 is item of purchase(Athens) input just now) 
		SUB prodQuantities[BX],DL      ;--SUBSTARCT THE prodQuantities[Index of item] WITH THE RELATED PurchaseQuantity
        ADD prodSold[BX],DL            ;--RECORD THE quantity of product sold for summary purpose

		INC continuePurchaseCount      ;--INCREASE INDEX 
	
		;--INPUT WHETHER CONTINUE OR NOT
		MOV AH,09H
		LEA DX,newline
		INT 21H
	
		MOV AH,09H
		LEA DX, ContinueMsg
		INT 21H

		MOV AH,01H
		INT 21H
		
		CMP AL,'Y'       ;--IF CONTINUE == Y || y, JUMP TO BEGINING
		JE InputPurchaseJmp
		CMP AL,'y' 
		JE InputPurchaseJmp
        JMP InputPurchaseNoJmp
	
        InputPurchaseJmp:
        MOV AH, 09H
        LEA DX, newline
        INT 21H
        LEA DX, newline
        INT 21H
        JMP InputPurchase

        InputPurchaseNoJmp:
		MOV AH,09H
		LEA DX,newline
		INT 21H
        LEA DX, newline
        INT 21H

		;--DELIVERY ?
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
	    MOV CL,continuePurchaseCount
            MOV CalculateSubtotalIndex, 0
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
		MOV SST_QUOTIENT,AX      ;DIV DX,AX(R,Q)
	
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
	    MOV AH,09H
	    LEA DX,newline
	    INT 21H
		
	    MOV AH,09H
	    LEA DX,purchaseBill
	    INT 21H
		
	    MOV AH,09H
	    LEA DX,newline
	    INT 21H
		
	    MOV AH,09H
	    LEA DX,purchaseBillLine
	    INT 21H
	    
	    MOV AH,09H
	    LEA DX,newline
	    INT 21H

    ;--Display item bought
        MOV AH,09H
        LEA DX,purchaseBillItemMsg
        INT 21H

        MOV AH,09H
        LEA DX,newline
        INT 21H

        MOV SI,0
        DISPLAY_PURCHASED_ITEM:
        MOV AL,PurchasingItem[SI]
        MUL prodNameLength
        MOV BX,AX

        MOV CH,0
        MOV CL,prodNameLength
        LOOP_PURCHASED_ITEM_NAME:
            MOV AH,02H
            MOV DL,prodNames[BX]
            INT 21H
            INC BX
        LOOP LOOP_PURCHASED_ITEM_NAME

        MOV CX,3
        LOOP_SPACE1:
            MOV AH,02H
            MOV DL," "
            INT 21H
        LOOP LOOP_SPACE1

        MOV AH,0
        MOV AL,PurchaseQuantity[SI]
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

        MOV CX,10
        LOOP_SPACE2:
            MOV AH,02H
            MOV DL," "
            INT 21H
        LOOP LOOP_SPACE2

        MOV AH,02H
        MOV DL,"R"
        INT 21H
        MOV AH,02H
        MOV DL,"M"
        INT 21H

        MOV AH,0
        MOV AL,PurchasingItem[SI]
        MUL TWO                    ;--to get real index of item 
        MOV BX,AX
        
        MOV AX,prodPrices[BX]
        MUL purchaseQuantity[SI]
	MOV PurchasePrice,AX
        CALL AmountFormatting
	MOV AX,PurchasePrice
	CALL DisplayNum
		
	MOV AH,02H
        MOV DL,"."
        INT 21H
		
	MOV AH,02H
        MOV DL,"0"
        INT 21H
		
	MOV AH,02H
        MOV DL,"0"
        INT 21H
        
        MOV AH,09H
        LEA DX,newline
        INT 21H

        INC SI
        MOV DL,continuePurchaseCount
        CMP PurchasingItem[SI],DL
        JGE VALIDATE_DELIVERY
        JMP DISPLAY_PURCHASED_ITEM
		
    VALIDATE_DELIVERY:
        CMP DeliveryChoose,"y"
        JE DISPLAY_DELIVERY_MSG
        CMP DeliveryChoose,"Y"
        JE DISPLAY_DELIVERY_MSG
        JMP DISPLAY_SUBTOTAL

    DISPLAY_DELIVERY_MSG:
        MOV AH,09H
        LEA DX,deliveryTotalMsg
        INT 21H

        MOV AH,09H
        LEA DX,newline
        INT 21H

	DISPLAY_SUBTOTAL:
	    MOV AH, 09H
	    LEA DX, subtotalLine
	    INT 21H
	
	    MOV AH,09H
	    LEA DX,newline
	    INT 21H
	
	    MOV AH, 09H
	    LEA DX, subtotalMsg
	    INT 21H
	
	    MOV AX, Subtotal
	    CALL AmountFormatting
	    MOV AX, Subtotal
	    CALL DisplayNum
	
	    MOV AH,02H
	    MOV DL, '.'
	    INT 21H
	
	    MOV DL, '0'
	    INT 21H
	    INT 21H

	    MOV AH, 09H
	    LEA DX, newline
	    INT 21H
	    
	    MOV AH,09H
	    LEA DX,purchaseBillLine
	    INT 21H
	
	    MOV AH,09H
	    LEA DX,newline
	    INT 21H

    ;------Calculate Rounding Adjustment
    MOV DX,0
    MOV AX,TOTAL_REMAINDER
    MOV BH,0
    MOV BL,five
    DIV BX
    MOV lastDigit,DL
    
    CMP lastDigit,3
    JB LessThanThree
    
    ;ie RM0.53 --> RM0.55
    MOV AL,five
    SUB AL,lastDigit
    MOV roundingAdjustment,AL
    JMP CalculateAdjustedAmount
    
    LessThanThree:
    	;ie RM0.52 --> RM0.50
    	MOV AL,lastDigit   ;Convert positive value to negative
    	SUB AL,lastDigit
    	SUB AL,lastDigit
    	MOV roundingAdjustment,AL
    
    CalculateAdjustedAmount:
    	MOV AX,TOTAL_REMAINDER
    	MOV DX,0
    	ADD AL,roundingAdjustment
    	DIV HUNDRED
    	ADD AX,TOTAL_QUOTIENT
    	MOV ADJUSTED_QUOTIENT,AX
    	MOV ADJUSTED_REMAINDER,DX    
    ;---Display SST
    MOV AH,09H
    LEA DX,sstMsg
    INT 21H
	
    MOV AX, SST_QUOTIENT
    CALL AmountFormatting
    MOV AX, SST_QUOTIENT
    CALL DisplayNum
	MOV AH,02H
	MOV DL,"."
	INT 21H
	
	CMP SST_REMAINDER,0
	JE ZeroSstDecimal
	CMP SST_REMAINDER,10
	JAE DisplaySstDecimal
	
	MOV AH,02H
	MOV DL,"0"
	INT 21H
		
	DisplaySstDecimal:
	    MOV AX, SST_REMAINDER
	    CALL DisplayNum
	    JMP DoneDisplaySST
	
	ZeroSstDecimal:
	    MOV AH,02H
	    MOV DL,"0"
	    INT 21H
	    MOV AH,02H
	    MOV DL,"0"
	    INT 21H
	
	DoneDisplaySST:
	    MOV AH,02H
	    MOV DL,"0"
	    INT 21H
	    
	    MOV AH,09H
	    LEA DX,newline
	    INT 21H
	
	
    ;---Display Service Charge
    MOV AH,09H
    LEA DX,serviceChargeMsg
    INT 21H
	
    MOV AX, SERVICE_QUOTIENT
    CALL AmountFormatting
    MOV AX, SERVICE_QUOTIENT
    CALL DisplayNum
    MOV AH,02H
    MOV DL,"."
    INT 21H
    
    CMP SERVICE_REMAINDER,0
    JE ZeroServiceChargeDecimal
    CMP SERVICE_REMAINDER,10
    JAE DisplayServiceChargeDecimal
    
    MOV AH,02H
    MOV DL,"0"
    INT 21H
    	
    DisplayServiceChargeDecimal:
    	MOV AX, SERVICE_REMAINDER
    	CALL DisplayNum
    	JMP DoneDisplayServiceCharge
    
    ZeroServiceChargeDecimal:
    	MOV AH,02H
    	MOV DL,"0"
    	INT 21H
    	MOV AH,02H
    	MOV DL,"0"
    	INT 21H
    
    DoneDisplayServiceCharge:
    	MOV AH,09H
    	LEA DX,newline
    	INT 21H
    
    
    ;---Display Total Amount
    MOV AH,09H
    LEA DX,totalAmountMsg
    INT 21H
    
    MOV AX, TOTAL_QUOTIENT
    CALL AmountFormatting
    MOV AX, TOTAL_QUOTIENT
    CALL DisplayNum
    MOV AH,02H
    MOV DL,"."
    INT 21H
    
    CMP TOTAL_REMAINDER,0
    JE ZeroTotalAmountDecimal
    CMP TOTAL_REMAINDER,10
    JAE DisplayTotalAmountDecimal
    
    MOV AH,02H
    MOV DL,"0"
    INT 21H
    	
    DisplayTotalAmountDecimal:
    	MOV AX, TOTAL_REMAINDER
    	CALL DisplayNum
    	JMP DoneDisplayTotalAmount
    
    ZeroTotalAmountDecimal:
    	MOV AH,02H
    	MOV DL,"0"
    	INT 21H
    	MOV AH,02H
    	MOV DL,"0"
    	INT 21H
    
    DoneDisplayTotalAmount:
    	MOV AH,09H
    	LEA DX,newline
    	INT 21H
    
    
    ;------Display Rounding Adjustment
    MOV AH,09H
    LEA DX,roundingMsg
    INT 21H
    
    CMP roundingAdjustment,0
    JGE IsPositive;
    
    MOV AH,09H
    LEA DX,negativeRounding
    INT 21H
    
    MOV AH,02H
    MOV DL,roundingAdjustment
    NEG DL  ;Convert negative value to positive
    ADD DL,30H
    INT 21H
    
    JMP EndDisplayRounding
    
    IsPositive:
    	MOV AH,09H
    	LEA DX,positiveRounding
    	INT 21H
    	
    	MOV AH,02H
    	MOV DL,roundingAdjustment
    	ADD DL,30H
    	INT 21H
    
    EndDisplayRounding:
    	MOV AH,09H
    	LEA DX,newline
    	INT 21H
    
    
    ;---Display Adjusted Total Amount
    MOV AH,09H
    LEA DX,adjustedAmountMsg
    INT 21H
    
    MOV AX,ADJUSTED_QUOTIENT
    CALL AmountFormatting
    MOV AX,ADJUSTED_QUOTIENT
    CALL DisplayNum
    MOV AH,02H
    MOV DL,"."
    INT 21H
    
    CMP ADJUSTED_REMAINDER,0
    JE ZeroAdjustedAmountDecimal
    CMP ADJUSTED_REMAINDER,10
    JAE DisplayAdjustedAmountDecimal
    
    MOV AH,02H
    MOV DL,"0"
    INT 21H
    	
    DisplayAdjustedAmountDecimal:
    	MOV AX, ADJUSTED_REMAINDER
    	CALL DisplayNum
    	JMP DoneDisplayAdjustedAmount
    
    ZeroAdjustedAmountDecimal:
    	MOV AH,02H
    	MOV DL,"0"
    	INT 21H
    	MOV AH,02H
    	MOV DL,"0"
    	INT 21H
    
    DoneDisplayAdjustedAmount:
    	MOV AH,09H
    	LEA DX,newline
    	INT 21H
    
    
    ;---Input Cash
    InputCash:
    	MOV AH,09H
    	LEA DX,newline
    	INT 21H
    
    	MOV AH, 09H
    	LEA DX,inputCashMsg
    	INT 21H
    
    	MOV AH,0AH
    	LEA DX,inputStack
    	INT 21H
    
    ;Validate input cash that contain .00 or not
    MOV AH,0
    MOV AL,inputStack[1]   ;Get actual number
    ;Place that store "." 
    ;= Arr Size - 3(3rd last arr) + 2(first 2 arr: max size & actual size)
    ;= Arr Size - 1
    SUB AL,1               
    MOV SI,AX
    CMP inputStack[SI],"."
    JE ValidCash
    
    MOV AH,09H
    LEA DX,newline
    INT 21H
    
    MOV AH, 09H
    LEA DX,invalidCashMsg
    INT 21H
    
    MOV AH,09H
    LEA DX,newline
    INT 21H
    
    JMP InputCash
    
    ValidCash:
    	MOV CASH_QUOTIENT,0
    	MOV CASH_REMAINDER,0
    
    MOV DI,2
    MOV CH,0
    MOV CL,inputStack[1]
    ConvertCashInteger:
    	CMP inputStack[DI],"."
    	JE NextConverting
    	
    	SUB inputStack[DI],30H
    	MOV BH,0
    	MOV BL,inputStack[DI]
    	MOV AX,CASH_QUOTIENT
    	MUL tenW
    	ADD AX,BX
    	MOV CASH_QUOTIENT,AX
    	INC DI
    	LOOP ConvertCashInteger
    
    NextConverting:
    INC DI
    MOV CX,2
    ConvertCashDecimal:
    	SUB inputStack[DI],30H
    	MOV BH,0
    	MOV BL,inputStack[DI]
    	MOV AX,CASH_REMAINDER
    	MUL tenW
    	ADD AX,BX
    	MOV CASH_REMAINDER,AX
    	INC DI
    	MOV AH,0
    	MOV AL,inputStack[1]
    	LOOP ConvertCashDecimal
    
    MOV AX,CASH_QUOTIENT
    CMP AX,ADJUSTED_QUOTIENT
    JA DoneInputCash
    JB NotEnoughCash

    MOV AX, CASH_REMAINDER
    CMP AX, ADJUSTED_REMAINDER
    JAE DoneInputCash

    NotEnoughCash:
    	MOV AH,09H
    	LEA DX,newline
    	INT 21H
    
    	MOV AH,09H
    	LEA DX,notEnoughMsg
    	INT 21H
    	
    	MOV AH,09H
    	LEA DX,newline
    	INT 21H
    
    JMP InputCash
    
    DoneInputCash:
    ;---Calculate Balance
    MOV AX,CASH_REMAINDER
    CMP AX,ADJUSTED_REMAINDER
    JA Minus
    JE NoBalance
    
    ADD AX,HUNDRED
    SUB CASH_QUOTIENT,1
    
    Minus:
    	SUB AX,ADJUSTED_REMAINDER
    	MOV BALANCE_REMAINDER,AX
    
    MOV BX,CASH_QUOTIENT
    SUB BX,ADJUSTED_QUOTIENT
    MOV BALANCE_QUOTIENT,BX
    
    NoBalance:
    ;;Skip calculating balance

    
    ;---Display Balance
    MOV AH,09H
    LEA DX,balanceMsg
    INT 21H
    
    MOV AX,BALANCE_QUOTIENT
    CALL AmountFormatting
    MOV AX,BALANCE_QUOTIENT
    CALL DisplayNum
    MOV AH,02H
    MOV DL,"."
    INT 21H
    
    CMP BALANCE_REMAINDER,0
    JE ZeroBalanceDecimal
    CMP BALANCE_REMAINDER,10
    JAE DisplayBalanceDecimal
    
    MOV AH,02H
    MOV DL,"0"
    INT 21H
    	
    DisplayBalanceDecimal:
    	MOV AX, BALANCE_REMAINDER
    	CALL DisplayNum
    	JMP DoneDisplayBalance
    
    ZeroBalanceDecimal:
    	MOV AH,02H
    	MOV DL,"0"
    	INT 21H
    	MOV AH,02H
    	MOV DL,"0"
    	INT 21H
    
    DoneDisplayBalance:
    	MOV AH,09H
    	LEA DX,newline
    	INT 21H
    
    
    ;---Display thx order message
    MOV AH,09H
    LEA DX,purchaseBillLine
    INT 21H
    
    MOV AH,09H
    LEA DX,newline
    INT 21H
    
    MOV AH,09H
    LEA DX,thxOrderMsg
    INT 21H
    
    MOV AH,09H
    LEA DX,newline
    INT 21H
    
    ;--record total number of purchase 
    INC numOfPurchased
    RET
OPT2 ENDP

; Option 3 - Display Sales Summary
OPT3 PROC
    MOV AH, 09H
    LEA DX, newline
    INT 21H
    INT 21H
    LEA DX, opt3Title
    INT 21H

    LEA DX, newline
    INT 21H
    LEA DX, opt3HeaderLine
    INT 21H
    LEA DX, opt3Header
    INT 21H
    LEA DX, opt3HeaderLine
    INT 21H

    ; Calculate Grand Total (To be used in calculating percentage)
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

    ; Loop to display 12(totalProducts) rows of data
    MOV currProdIndex, 0
    MOV currProdNameIndex, 0
    Opt3DisplayRow:
        MOV AH, 09H
        LEA DX, opt3TableRowStart
        INT 21H

        ; Display product/service name
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

        ; Display product/service unit price
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

        ; Display product/service sold quantity
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
        
        ; Display product/service total sales
        ; Total sales = Unit price * Sold quantity
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

        ; Display product/service sales percentage
        ; Sales percentage = Total sales / Grand total * 100 %
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

    ; Display Grand Total (Sales) and Total Percentage (100%)
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
        
        CMP opt3GrandTotal[0], 0
        JNE Opt3FooterHundredPercent
        CMP opt3GrandTotal[2], 0
        JNE Opt3FooterHundredPercent
        LEA DX, opt3ZeroP
        INT 21H
        JMP Opt3FooterPercentEnd

    Opt3FooterHundredPercent:
        LEA DX, opt3HundredP
        INT 21H

    Opt3FooterPercentEnd:
        MOV AH, 02H
        MOV DL, ' '
        INT 21H
        MOV DL, '%'
        INT 21H

        MOV AH, 09H
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
    
	RET
OPT3 ENDP

OPT4 PROC
	MOV AH,09H
	LEA DX,newline
	INT 21H
	
	MOV AH,09H
	LEA DX,opt4Title
	INT 21H	
	
	RET
OPT4 ENDP

OPT5 PROC
	MOV AH,09H
	LEA DX,newline
	INT 21H

    MOV AH,09H
	LEA DX,newline
	INT 21H
	
	MOV AH,09H
	LEA DX,numOfPurchasedMsg
	INT 21H

    MOV AH,0
    MOV AL,numOfPurchased
    DIV tenB
    MOV BX,AX

	CMP BL,0
	JE SkipDisplayQuotient
	
    MOV AH,02H
    MOV DL,BL
    ADD DL,30H
    INT 21H

	SkipDisplayQuotient:
		MOV AH,02H
		MOV DL,BH
		ADD DL,30H
		INT 21H
	
	MOV AH,09H
	LEA DX,newline
	INT 21H
	
	MOV AH,09H
	LEA DX,opt5Title
	INT 21H

	RET
OPT5 ENDP

; Misc Functions
; Display number in %5d
AmountFormatting PROC
	MOV DI, 0
    CalculateNoOfDigits:
        MOV DX, 0
        DIV tenW
        INC DI
        CMP AX, 0
        JNE CalculateNoOfDigits
	
	MOV BX,5
	SUB BX,DI
	MOV CX,BX
	Formatting:
		MOV AH,02H
		MOV DL," "
		INT 21H
		LOOP Formatting

	RET
AmountFormatting ENDP

; Display 16-bit Number (AX) in numeric form onto screen
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

; Display 16-bit Number (DX:AX) in numeric form onto screen
Display32BitNum PROC
    MOV higher16, DX
    MOV lower16, AX
    MOV prevCarry, 0

    MOV CX, 5
    MOV SI, 0
    clearArrStack:
        MOV arrR[SI], 0
        MOV AX, SI
        MOV BL, 2
        MUL BL
        MOV BX, AX
        MOV arrQ[BX], 0
        INC SI
    LOOP clearArrStack

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

; Given the following: 
; DX:AX = x (Dividend), BX:CX = y (Divisor)
; Then display x / y * 100% in 3 decimal places
; *Both x(Dividend) and y(Divisor) are 32 bit numbers
DisplayPercentage PROC
    MOV div32Dividend[0], DX
    MOV div32Dividend[2], AX
    MOV div32Divisor[0], BX
    MOV div32Divisor[2], CX

    ; Display 0% if x == 0
    CMP DX, 0
    JNE CheckXEqualsY
    CMP AX, 0
    JNE CheckXEqualsY
    MOV AH, 09H
    LEA DX, opt3ZeroP
    INT 21H
    JMP DisplayPercentageEnd
    
    ; Display 100% if x == y (avoid unnecessary calculation)
    CheckXEqualsY:
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

    ; Loop to calculate x / y and store the result as an int array, eg: 12.345% as 1, 2, 3, 4, 5
    MOV SI, 0       ; SI = index for result array
    ; Loop for 5 times (result array's length, as the result is fixed to 3 decimal places + 2 digit integer = 5 digit to display in total)
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
        MOV BL, 0   ; BL = Quotient
        div32DivLoop:
            ; while x >= y:
            ;   Quotient += 1
            ;   x = x-y
            MOV AX, div32Dividend[0]
            CMP AX, div32Divisor[0]
            JB div32Lower
            JA div32Higher
            MOV AX, div32Dividend[2]
            CMP AX, div32Divisor[2]
            JB div32Lower

            div32Higher:
                INC BL
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
            MOV div32Result[SI], BL     ; Append Quotient to result array
    INC SI
    CMP SI, 5
    JE DisplayPercentagePrintPre
    JMP div32DecLoop

    DisplayPercentagePrintPre:
        MOV SI, 0
        MOV AH, 02H
        MOV DL, ' '
        INT 21H
    
    ; Display Percentage / Result array
    ; Note: for example if percentage is 0.50%, the result array will be 0, 0, 5, 0, 0
    ; Thus leading zeros (first 2 zeros) need to be replaced, done by the following: 
    ; If i == 0, display ' '; else display div32result[i]
    DisplayPercentagePrint:
        CMP SI, 2
        JNE DisplayPercentagePrintNumber
        MOV DL, '.'                         ; Manual append '.' at index 2
        INT 21H
    DisplayPercentagePrintNumber:
        MOV DL, div32Result[SI]
        CMP SI, 0
        JE DisplayPercentagePrintFirstIndex
        ADD DL, 30H
        INT 21H
        JMP DisplayPercentagePrintEnd
        
    DisplayPercentagePrintFirstIndex:
        CMP DL, 0
        JE DisplayPercentagePrintLeadingZero
        ADD DL, 30H
        INT 21H
        JMP DisplayPercentagePrintEnd

    DisplayPercentagePrintLeadingZero:
        MOV DL, ' '                         ; Display ' ' as replacement for leading zeros
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
