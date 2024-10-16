.data
x: .word 2
y: .word 3
a: .word 2

.code
ld r1, x(r0)
ld r2, y(r0)
ld r3, a(r0)

loop: beqz r3, FIN  ; si a es 0 termina
dadd r5, r0, r0   ; pongo r5 en 0
slt r5, r3, r0    ; r5 = 1 si r3 < r0, a < 0
bne r5, r0, FIN   ; si r5 != 0 => r5 = 1 => a < 0 => fin
dadd r1, r1, r2   ; x = x + y
daddi r3, r3, -1  ; a = a - 1
j loop

FIN: sd r1, x(r0)
sd r3, a(r0)
nop
halt