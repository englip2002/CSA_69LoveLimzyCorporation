;-------Login & Menu
; Default id       : user123
; Default password : psw1234


.MODEL SMALL
.STACK 100
.DATA      
	newline            DB 0DH,0AH,"$"
	
	;---Program Title
	progTitleLine1     DB "//***********************************************************\\$"
	progTitleLine2     DB "\\***********************************************************//$"
	progTitle          DB "| 69 LOVE LIMZY CORPORATION SDN BHD ||$"
	
	progTitle1         DB "[   __ __               _                     __      __      ]$"
	progTitle2         DB "[  /_ (__)  /      _   / )  _     _ __/'     (  _/   / _)/ _/ ]$"
	progTitle3         DB "[ (__)__/  (__()\/(-  (__()/ /)()/ (///()/) __)(//) /(_)/)(/  ]$"
	progTitle4         DB "[                           /                                 ]$"

	
	;---Login
	loginTitle         DB " LOGIN$"
	loginLine          DB "---------------------------------------$"
	promptId           DB "   Enter ID       > $"
	promptPassword 	   DB "   Enter Password > $"
	invalidLoginMsg    DB "   Invalid ID or Password!!$"
	loginSuccessMsg    DB "Welcome!!!$"
	validId            DB "user123"
	validPassword      DB "psw1234"
	idEntered          DB 7 DUP(?)
	passwordEntered    DB 7 DUP(?)
	
	;---Menu
	menuTitle          DB "              MAIN MENU$"
	menuLine           DB "=======================================$"
	menu1              DB " |  [1] Display Product Information  |$"
	menu2              DB " |  [2] Purchase                     |$"
	menu3              DB " |  [3] Sales Summary                |$"
	menu4              DB " |  [4] Product Maintenance          |$"
	menu5              DB " |  [5] Exit Program                 |$"
	promptMenuOpt      DB "Enter your option (1-5) > $"
	invalidMenuOptMsg  DB "Invalid Option!!$"
	Op1                DB "Display Product Information$"
	Op2                DB "Purchase$"
	Op3                DB "Sales Summary$"
	Op4                DB "Product Maintenance$"
	Op5                DB "Bye...$"
	
.CODE
MAIN PROC
	MOV AX,@DATA
	MOV DS,AX
	
	;------Program Title
	MOV AH,09H
	LEA DX,progTitleLine1
	INT 21H
	
	MOV AH,09H
	LEA DX,newline
	INT 21H
	
	MOV AH,09H
	LEA DX,progTitle1
	INT 21H
	
	MOV AH,09H
	LEA DX,newline
	INT 21H
	
	MOV AH,09H
	LEA DX,progTitle2
	INT 21H
	
	MOV AH,09H
	LEA DX,newline
	INT 21H
	
	MOV AH,09H
	LEA DX,progTitle3
	INT 21H
	
	MOV AH,09H
	LEA DX,newline
	INT 21H
	
	MOV AH,09H
	LEA DX,progTitle4
	INT 21H
	
	MOV AH,09H
	LEA DX,newline
	INT 21H
	
	MOV AH,09H
	LEA DX,progTitleLine2
	INT 21H
	
	MOV AH,09H
	LEA DX,newline
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
		
	MOV AH,09H
	LEA DX,loginLine
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
	
	
	;------Menu
	Menu:	
		MOV AH,09H
		LEA DX,newline
		INT 21H
	
		MOV AH,09H
		LEA DX,menuTitle
		INT 21H
		
		MOV AH,09H
		LEA DX,newline
		INT 21H
		
		MOV AH,09H
		LEA DX,menuLine
		INT 21H
		
		MOV AH,09H
		LEA DX,newline
		INT 21H
		
		MOV AH,09H
		LEA DX,menu1
		INT 21H
		
		MOV AH,09H
		LEA DX,newline
		INT 21H
		
		MOV AH,09H
		LEA DX,menu2
		INT 21H
		
		MOV AH,09H
		LEA DX,newline
		INT 21H
		
		MOV AH,09H
		LEA DX,menu3
		INT 21H
		
		MOV AH,09H
		LEA DX,newline
		INT 21H
		
		MOV AH,09H
		LEA DX,menu4
		INT 21H
		
		MOV AH,09H
		LEA DX,newline
		INT 21H
		
		MOV AH,09H
		LEA DX,menu5
		INT 21H
		
		MOV AH,09H
		LEA DX,newline
		INT 21H
		
		MOV AH,09H
		LEA DX,menuLine
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
			JE Opt1
			CMP AL,2
			JE Opt2
			CMP AL,3
			JE Opt3
			CMP AL,4
			JE Opt4
			CMP AL,5
			JNE InvalidOption
			JMP Opt5
	
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
	
	Opt1:
		MOV AH,09H
		LEA DX,newline
		INT 21H
	
		MOV AH,09H
		LEA DX,Op1
		INT 21H
		
		MOV AH,09H
		LEA DX,newline
		INT 21H
		
		JMP Menu
		
	Opt2:
		MOV AH,09H
		LEA DX,newline
		INT 21H

		MOV AH,09H
		LEA DX,Op2
		INT 21H	
		
		MOV AH,09H
		LEA DX,newline
		INT 21H
		
		JMP Menu
		
	Opt3:
		MOV AH,09H
		LEA DX,newline
		INT 21H

		MOV AH,09H
		LEA DX,Op3
		INT 21H	
		
		MOV AH,09H
		LEA DX,newline
		INT 21H		
		
		JMP Menu
		
	Opt4:
		MOV AH,09H
		LEA DX,newline
		INT 21H
	
		MOV AH,09H
		LEA DX,Op4
		INT 21H	

		MOV AH,09H
		LEA DX,newline
		INT 21H
		
		JMP Menu
		
	Opt5:
		MOV AH,09H
		LEA DX,newline
		INT 21H

		MOV AH,09H
		LEA DX,Op5
		INT 21H
	
		MOV AX,4C00H
		INT 21H
MAIN ENDP
END MAIN