; Function to display number (up to dw, dd still struggling)

.MODEL SMALL
.STACK 100
.DATA
    tenW DW 10
    displayStack DW 5 DUP (0)
    n DW 12345
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; How to use:
    ; Move the number to AX
    ; Call DisplayNum
    MOV AX, n
    CALL DisplayNum

    MOV AX, 4C00H
    INT 21H
MAIN ENDP

; Max display: 65535 (1 word)
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