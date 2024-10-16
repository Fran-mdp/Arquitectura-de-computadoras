PIO     EQU 30H
PIC EQU 20H
INT0 EQU 24H
N_F10 EQU 10

ORG 40
IP_F10 DW RUT_F10
        ORG 1000H

CAR     DB ?
;Subrutina de inicialización impresora
        ORG 3000H
RUT_F10: PUSH AX
PUSH BX
MOV DL, 0FFH
MOV AL, PIC
OUT PIC, AL
POP BX
POP AX
INI_IMP:MOV AL,     0FDH
        OUT PIO+2,  AL
        MOV AL,     0
        OUT PIO+3,  AL
        IN  AL,     PIO
        AND AL,     0FDH
        OUT PIO,    AL
        RET
;SUBRUTINA DE GENERACIÓN DE PULSO "STROBE"
PULSO:  IN  AL,     PIO
        OR  AL,     02H
        OUT PIO,    AL
        IN  AL,     PIO
        AND AL,     0FDH
        OUT PIO,    AL
        RET

; PROGRAMA PRINCIPAL
        ORG 2000H
        CLI
        MOV AL, 11111110B
        OUT PIC+1, AL
        MOV AL, N_F10
        OUT INT0, AL
        MOV DL, 00H
        STI
        PUSH AX
        CALL INI_IMP
        POP AX
        MOV BX, OFFSET CAR
        MOV CL, 0
LAZO:   CMP DL, 0FFH
JZ IMPRIMIR
INT 6
INC BX
INC CL
JMP LAZO
IMPRIMIR: MOV BX, OFFSET CAR
POLL:   IN AL, PIO
        AND AL, 1
        JNZ POLL
        MOV AL, [BX]
        OUT PIO+1, AL
        PUSH AX
        CALL PULSO
        POP AX
        INC BX
        DEC CL
        JNZ POLL
        INT 0
END