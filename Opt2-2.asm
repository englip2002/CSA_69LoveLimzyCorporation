;-- Opt2 (Second part)
;-- blablabla...
;-- Calculate Rounding Adjustment
;-- Display Purchase Amounts (SST, Service Charge, Total, Rounding Adjustment, Adjusted Total)
;-- Input Cash
;-- Calculate & Display Balance

.MODEL SMALL
.STACK 100
.DATA
	;---Amounts
	sst                 DW 740   ;7.40
	serviceCharge       DW 1234  ;12.34
	totalAmount         DW 31948 ;319.48
	inputCash           DW 0
	balance             DW 0
	
	;---Message
	newline             DB 0DH,0AH,"$"
	sstMsg              DB "SST (6%)                      :  RM$"
	serviceChargeMsg    DB "Service Charge (10%)          :  RM$"
	totalAmountMsg      DB "Total Amount                  :  RM$"
	roundingMsg         DB "Rounding Adjustment           : $"
	adjustedAmountMsg   DB "Total Amount (Adjusted)       :  RM$"
	inputCashMsg        DB "Input Cash (ie. 50.00)        :  RM $"
	balanceMsg          DB "Balance                       :  RM $"
	
	;---Output & Input Amount Used
	tenB                DB 10
	tenW                DW 10
	hundred             DW 100
	mantissa            DW ?
	displayStack        DW 5 DUP (0)
	inputStack          DB 10 DUP(" ")
	
	;---For Calculating Rounding Adjustment
	five                DB 5
	lastDigit           DB ?
	roundingAdjustment  DB ?
	adjustedAmount      DW ?
	
	;---Formatting Rounding Adjustment
	positiveRounding    DB "+RM    0.0$"
	negativeRounding    DB "-RM    0.0$"
	
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

	;------Calculate Rounding Adjustment
	MOV DX,0
	MOV AX,totalAmount
	MOV BH,0
	MOV BL,five
	DIV BX
	MOV lastDigit,DL
	
	CMP lastDigit,3
	JB LessThanThree
	
	MOV AL,five
	SUB AL,lastDigit
	MOV roundingAdjustment,AL
	JMP CalculateAdjustedAmount
	
	LessThanThree:
		MOV AL,lastDigit
		SUB AL,lastDigit
		SUB AL,lastDigit
		MOV roundingAdjustment,AL
	
	CalculateAdjustedAmount:
		MOV AH,0
		MOV AL,roundingAdjustment
		ADD AX,totalAmount
		MOV adjustedAmount,AX
		

	;---Display SST
	MOV AH,09H
	LEA DX,sstMsg
	INT 21H
	
    MOV AX, sst
	CALL AmountFormatting
	MOV AX, sst
    CALL DisplayAmount
	
	MOV AH,09H
	LEA DX,newline
	INT 21H
	
	
	;---Display Service Charge
	MOV AH,09H
	LEA DX,serviceChargeMsg
	INT 21H
	
    MOV AX, serviceCharge
	CALL AmountFormatting
	MOV AX, serviceCharge
    CALL DisplayAmount
	
	MOV AH,09H
	LEA DX,newline
	INT 21H
	
	
	;---Display Total Amount
	MOV AH,09H
	LEA DX,totalAmountMsg
	INT 21H
	
	MOV AX, totalAmount
	CALL AmountFormatting
	MOV AX, totalAmount
    CALL DisplayAmount
	
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
	NEG DL
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
	
	MOV AX, adjustedAmount
	CALL AmountFormatting
	MOV AX, adjustedAmount
    CALL DisplayAmount
	
	MOV AH,09H
	LEA DX,newline
	INT 21H
	
	
	;---Input Cash
	MOV AH,09H
	LEA DX,newline
	INT 21H
	
	MOV AH, 09H
	LEA DX,inputCashMsg
	INT 21H
	
	MOV AH,0AH
	LEA DX,inputStack
	INT 21H
	
	MOV DI,2
	MOV CH,0
	MOV CL,inputStack[1]
	ConvertCash:
		CMP inputStack[DI],"."
		JE NextDigit
		
		SUB inputStack[DI],30H
		MOV BH,0
		MOV BL,inputStack[DI]
		MOV AX,inputCash
		MUL tenW
		ADD AX,BX
		MOV inputCash,AX
		
		NextDigit:
			INC DI
		LOOP ConvertCash
		
	MOV AH,09H
	LEA DX,newline
	INT 21H
	
	
	;---Calculate Balance
	MOV AX,inputCash
	SUB AX,adjustedAmount
	MOV balance,AX
	
	
	;---Display Balance
	MOV AH,09H
	LEA DX,balanceMsg
	INT 21H
	
	MOV AX,balance
    CALL DisplayAmount
	
	MOV AH,09H
	LEA DX,newline
	INT 21H

    MOV AX, 4C00H
    INT 21H
MAIN ENDP


;; %7.2f
AmountFormatting PROC
	MOV DI, 0
    CalculateNoOfDigits:
        MOV DX, 0
        DIV tenW
        INC DI
        CMP AX, 0
        JNE CalculateNoOfDigits
	
	MOV BX,7
	SUB BX,DI
	MOV CX,BX
	Formatting:
		MOV AH,02H
		MOV DL," "
		INT 21H
		LOOP Formatting

	RET
AmountFormatting ENDP


;;Display amount with sen
DisplayAmount PROC
	;---Get Mantissa
	MOV DX, 0
	DIV hundred
	MOV mantissa, DX

	;---Display Integer Part
    CALL DisplayNum
	
	;---Display Decimal Point
	MOV AH, 02H
	MOV DL, "."
	INT 21H
	
	;---Display Mantissa
	MOV AX,mantissa
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
		
    RET
DisplayAmount ENDP

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