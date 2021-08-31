; Function to display number (up to dw, dd still struggling)

.MODEL SMALL
.STACK 100
.DATA

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV AX, 25570
    SUB AX, 56344
    CALL DisplayNum

    MOV AX, 4C00H
    INT 21H
MAIN ENDP

; Max display: 65535 (1 word)
DisplayNum PROC
    MOV CX, 0
    displayIntLoop:
        MOV DX, 0
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

END MAIN