TIMER EQU 10H
COMP EQU 11H
IMR EQU 21H
EOI EQU 20H
INT1 EQU 25H
INT0 EQU 24H
N_F10 EQU 10
N_CLK EQU 11


ORG 40 
IP_F10 DW RUT_F10
ORG 44
IP_CLK DW RUT_CLK


ORG 1000H
SEG DB 30H
SEG_NEXT DB 30H
ESPACIO DB " "
FIN DB ?


ORG 3000H
RUT_CLK: PUSH AX
DEC SEG_NEXT
CMP SEG_NEXT, 2FH ; EL NUMERO ANTERIOR A 0 EN ASCII
JNZ RESET
MOV SEG_NEXT, 30H
DEC SEG
MOV SEG_NEXT, 39H
CMP SEG, 2FH ; EL NUMERO ANTERIOR A 0 EN ASCII
JNZ RESET
MOV SEG, 30H
RESET: CMP SEG, 30H
JNZ SEGUIR
CMP SEG_NEXT, 30H
JNZ SEGUIR
INT 7
MOV AL, 0
OUT TIMER, AL
MOV AL, EOI
OUT EOI, AL
POP AX
MOV AL, 11111110B
OUT IMR, AL
IRET
SEGUIR: INT 7
MOV AL, 0
OUT TIMER, AL
MOV AL, EOI
OUT EOI, AL
POP AX
IRET

RUT_F10:PUSH AX
MOV AL,0FEH ;deshabilito interrupciones de timer 1111 1110
OUT IMR,AL ;le indico al pic el estado
INC DL ;incremento el contador de veces que presione f10
MOV AL,EOI
OUT EOI,AL;le indico al pic que termine
CMP DL,02H; comparo si presione 2 veces
JNZ VOLVER; si no es asi, vuelvo
MOV DL,0H; de ser qu es la segunda vez que presiono, pongop en 0 el contador
MOV AL,0FCH; reanudo interrupciones del timer
OUT IMR,AL
VOLVER:POP AX
IRET


ORG 2000H
CLI
MOV AL, 0FEH ;11111110
OUT IMR, AL ; PIC: registro IMR
MOV AL, N_CLK ; el ID del registro
OUT INT1, AL ; PIC: registro INT1
MOV AL, 1
OUT COMP, AL ; TIMER: registro COMP
MOV AL, 0
OUT TIMER, AL ; TIMER: registro CONT
MOV AL, N_F10
OUT INT0, AL
MOV DL, 00H ; contador en 0
MOV BX, OFFSET SEG
INT 6
MOV BX, OFFSET SEG_NEXT
INT 6
MOV BX, OFFSET SEG
MOV AL, OFFSET FIN-OFFSET SEG