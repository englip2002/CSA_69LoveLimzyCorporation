;-------Login & Menu
; Default id       : user123
; Default password : psw1234


.MODEL SMALL
.STACK 100
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
	loginTitle         DB "LOGIN"
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
	Op1                DB "Display Product Information$"
	Op2                DB "Purchase$"
	Op3                DB "Sales Summary$"
	Op4                DB "Product Maintenance$"
	Op5                DB 13,10,"<----- Bye..See You Next Time... ----->$"
.CODE
MAIN PROC
	MOV AX,@DATA
	MOV DS,AX
	
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
	
	
		MOV AX,4C00H
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

OPT1 PROC
	MOV AH,09H
	LEA DX,newline
	INT 21H
	
	MOV AH,09H
	LEA DX,Op1
	INT 21H
	
	MOV AH,09H
	LEA DX,newline
	INT 21H
	
	RET
OPT1 ENDP

OPT2 PROC
	MOV AH,09H
	LEA DX,newline
	INT 21H

	MOV AH,09H
	LEA DX,Op2
	INT 21H	
	
	MOV AH,09H
	LEA DX,newline
	INT 21H
	
	RET
OPT2 ENDP

OPT3 PROC
	MOV AH,09H
	LEA DX,newline
	INT 21H

	MOV AH,09H
	LEA DX,Op3
	INT 21H	
	
	MOV AH,09H
	LEA DX,newline
	INT 21H		
	
	RET
OPT3 ENDP

OPT4 PROC
	MOV AH,09H
	LEA DX,newline
	INT 21H
	
	MOV AH,09H
	LEA DX,Op4
	INT 21H	

	MOV AH,09H
	LEA DX,newline
	INT 21H
	
	RET
OPT4 ENDP

OPT5 PROC
	MOV AH,09H
	LEA DX,newline
	INT 21H

	MOV AH,09H
	LEA DX,Op5
	INT 21H
	RET
OPT5 ENDP

END MAIN
