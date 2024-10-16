TIMER EQU 10H
COMP EQU 11H
IMR EQU 21H
EOI EQU 20H
INT1 EQU 25H
N_CLK EQU 10


ORG 40
IP_CLK DW RUT_CLK


ORG 1000H
SEG DB 30H
SEG_NEXT DB 30H
FIN DB ?


ORG 3000H
RUT_CLK: PUSH AX
INC SEG_NEXT
CMP SEG_NEXT, 3AH
JNZ RESET
MOV SEG_NEXT, 30H
INC SEG
CMP SEG, 36H
JNZ RESET
MOV SEG, 30H
RESET: INT 7
MOV AL, 0
OUT TIMER, AL
MOV AL, EOI
OUT EOI, AL
POP AX
IRET


ORG 2000H
CLI
MOV AL, 0FDH ;11111101
OUT IMR, AL ; PIC: registro IMR
MOV AL, N_CLK ; el ID del registro
OUT INT1, AL ; PIC: registro INT1
MOV AL, 1
OUT COMP, AL ; TIMER: registro COMP
MOV AL, 0
OUT TIMER, AL ; TIMER: registro CONT
MOV BX, OFFSET SEG
MOV AL, OFFSET FIN-OFFSET SEG
STI
LAZO: JMP LAZO
END

/*
a) Cómo funciona el TIMER y cuándo emite una interrupción a la CPU.
El timer es un contador de eventos que realiza una cuenta ascendente de los pulsos de la señal aplicada a su entrada INT, restaurandose el valor inicial de cuenta al final de la misma.
b) La función que cumplen sus registros, la dirección de cada uno y cómo se programan.
    -COMP(11H): Registro de comparacion, que determina el modulo de la cuenta del TIMER.
    -CONT(10H): Registro contador, que muestra la cuenta de los pulsos de la senial aplicada a la entrada INT del periferico. La coincidencia de su valor con el del registro anterior provoca la activacion de la salida OUT (interrupcion)
*/