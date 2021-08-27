;-----Display Purchase Amounts

.MODEL SMALL
.STACK 100
.DATA
	;---Display Amount Used
	tenB DB 10
	tenW DW 10
	hundred DW 100
	mantissa DW ?
	displayStack DW 5 DUP (0)
	
	;---Display	Message
	newline             DB 0DH,0AH,"$"
	sstMsg              DB "SST (6%)                      :  RM $"
	serviceChargeMsg    DB "Service Charge (10%)          :  RM $"
	totalAmountMsg      DB "Total Amount                  :  RM $"
	roundingMsg         DB "Rounding Adjustment           : $"
	adjustedAmountMsg   DB "Total Amount (Adjusted)       :  RM $"
	
	;---For Calculating Rounding Adjustment
	five                DB 5
	lastDigit           DB ?
	roundingAdjustment  DB ?
	adjustedAmount      DW ?
	
	;---Formatting Rounding Adjustment
	positiveRounding    DB "+RM 0.0$"
	negativeRounding    DB "-RM 0.0$"
	
	;---Sample Amounts
	sst                 DW 740   ;7.40
	serviceCharge       DW 1234  ;12.34
	totalAmount         DW 31948 ;319.48
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
    CALL DisplayAmount
	
	MOV AH,09H
	LEA DX,newline
	INT 21H
	
	
	;---Display Service Charge
	MOV AH,09H
	LEA DX,serviceChargeMsg
	INT 21H
	
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
		LEA DX,newLine
		INT 21H
		
	
	;---Display Adjusted Total Amount
	MOV AH,09H
	LEA DX,adjustedAmountMsg
	INT 21H
	
	MOV AX, adjustedAmount
    CALL DisplayAmount
	
	MOV AH,09H
	LEA DX,newline
	INT 21H

    MOV AX, 4C00H
    INT 21H
MAIN ENDP

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
