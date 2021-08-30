; Display 32-bit numeric number on screen
; DX: High 16-bit, AX: Low 16-bit

; References:
; https://www.geeksforgeeks.org/8086-program-to-print-a-16-bit-decimal-number/
; https://codereview.stackexchange.com/questions/157926/assembly-x8086-emu8086-display-32bits-number-on-screen

.MODEL SMALL
.STACK 100
.DATA
    higher16 DW ?
    lower16 DW ?
    arrQ DW 5 DUP (0)
    arrR DB 5 DUP (0)
    q2LookupArr DW 0, 6553, 13107, 19660, 26214, 32768, 39321, 45875, 52428, 58982
    r2LookupArr DB 0, 6, 2, 8, 4, 0, 6, 2, 8, 4
    prevCarry DB 0
    
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV AX, 12345
    MOV BX, 30
    MUL BX
    CALL Display32BitNum

    MOV AX, 4C00H
    INT 21H
MAIN ENDP

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
            CMP DX, 0
            JE print32BitNumIsZero
            JMP print32BitNumPrint

        print32BitNumIsZero:
            CMP BX, 1
            JE print32BitNumLoopEnd

        print32BitNumPrint:
            XOR BX, BX
            ADD DL, 30H
            INT 21H
        print32BitNumLoopEnd:
        LOOP print32BitNumLoop
        
    RET
Display32BitNum ENDP

END MAIN