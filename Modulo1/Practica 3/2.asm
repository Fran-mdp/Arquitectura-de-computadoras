EOI     EQU 20H 
IMR     EQU 21H 
CONT   EQU 10H
COMP   EQU 11H
PA     EQU 30H
PB     EQU 31H
CA     EQU 32H
CB     EQU 33H
INT1   EQU 25H
N_CLK   EQU 10

        ORG 40
IP_CLK  DW  RUT_CLK

        ORG 1000
INICIO  DB  0

        ORG 3000H
RUT_CLK:INC INICIO
        CMP INICIO, 0FFH
        JNZ LUCES
        MOV INICIO, 0
LUCES:  MOV AL,     INICIO
        OUT PB,  AL ;PB
        MOV AL,     0
        OUT CONT,  AL
        MOV AL,     20H
        OUT EOI,    AL
        IRET

        ORG 2000H
        CLI
        MOV AL,     0FDH
        OUT IMR,  AL
        MOV AL,     N_CLK
        OUT INT1,  AL
        MOV AL,     1
        OUT COMP,AL
        MOV AL, 0
        OUT CB,  AL ;CB
        OUT PB,  AL ;PB
        OUT CONT,  AL
        STI
LAZO:   JMP LAZO
        HLT
        END