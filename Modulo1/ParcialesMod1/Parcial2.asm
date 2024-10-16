EOI EQU 20H
IMR EQU 21H
INT0 EQU 24H
PB EQU 31H
CB EQU 33H
N_F10 EQU 10

ORG 40
IP_F10 DW RUT_F10

ORG 1000H
TABLA DB 0,1, 3, 7, 15, 31, 63, 127, 255

ORG 3000H
RUT_F10:INC DL
CMP DL, 2
JNZ TERMINO
MOV AL, [BX]
OUT PB, AL
CMP BYTE PTR [BX], 255
JNZ SEGUIR
MOV BX, OFFSET TABLA -1
SEGUIR: MOV DL, 0
INC BX
TERMINO: MOV AL, 20H
OUT EOI, AL
IRET

ORG 2000H
CLI
MOV AL, 11111110B
OUT IMR, AL
MOV AL, N_F10
OUT INT0, AL
MOV AL, 00000000B
OUT CB, AL
MOV DL, 0
MOV BX, OFFSET TABLA
STI

LOOP: JMP LOOP
INT 0
END