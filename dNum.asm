; Function to display number (up to dw, dd still struggling)

.MODEL SMALL
.STACK 100
.DATA
    n1 DD 1
    n2 DW 120
    tenB DB 10
    tenW DW 10
    displayStack DW 5 DUP (0)
    displayStackIndex DW 0
    newline DB 13, 10, "$"
    words DW 500, 600, 1500, 1600
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; How to use:
    ; Move the number to AX
    ; Call DisplayNum
    MOV AX, words[5]
    CALL DisplayNum

    MOV AX, 4C00H
    INT 21H
MAIN ENDP

; Max display: 65535 (1 word)
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