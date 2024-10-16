.data 
NUM1: .word 10
NUM2: .word 10
RES: .word 0

.code
ld r1, NUM1(r0)     ; numero 1
ld r2, NUM2(r0)     ; numero 2
dadd r3, r0, r0     ; resultado

beqz r1, final              ; si NUM1 = 0 no hago nada (RES = 0 por defecto)
beqz r2, final              ; si NUM2 = 0 no hago nada (RES = 0 por defecto)
loop: dadd r3, r3, r1       ; RES = RES + NUM1 (trabajo con r3, no con RES)
daddi r2, r2, -1            ; decremento NUM2
bnez r2, loop               ; si no termine de mult, sigo

sd r3, RES(r0)       ; pongo en RES el valor del contador (r3)
final: nop
halt
