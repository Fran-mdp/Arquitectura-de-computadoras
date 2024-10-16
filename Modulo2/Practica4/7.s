.data 
TABLA: .word 1, 2 ,3, 4, 5, 6, 7, 8, 9, 10
dimL: .word 10
X: .word 5
CANT: .word 0
RES: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

.code
dadd r1, r0, r0     ; pos tabla
ld r6, dimL(r0)     ; dimL tabla
dadd r2, r0, r0     ; cont > X
ld r3, X(r0)        ; elemento que comparo
daddi r7, r0, 1     ; pongo en 1 para comparar


loop: ld r4, TABLA(r1)
slt r5, r3, r4      ; r5 = 1 si r3 < r4, X < TABLA(pos)
beq r5, r7, no_es   ; si r5 = 1 (X < TABLA(pos))=> no es 
beq r3, r4, no_es   ; si X = TABLA(pos) => no es
sd r7, RES(r1)      ; si llego aca es => pongo RES(pos) en 1
daddi r2, r2, 1    ; incremento CANT
j final             ; salteo no_es
no_es: sd r0, RES(r1)   ; pongo 0 en RES(pos)
final: daddi r1, r1, 8  ; incremento pos
daddi r6, r6, -1    ; decremento dimL(para saber que ya procese)
bnez r6, loop       ; si no termine de procesar, sigo

sd r2, CANT(r0)     ; pongo el valor de r2(contador de cant) en CANT
nop                 ; no se porque
halt

