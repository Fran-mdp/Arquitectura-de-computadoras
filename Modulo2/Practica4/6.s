.data
A: .word 1
B: .word 2
C: .word 3
D: .word 0

.code
ld r1, A(r0)
ld r2, B(r0)
ld r3, C(r0)
dadd r4, r0, r0

beq r1, r2, iguales12
beq r1, r3, iguales13
beq r2, r3, iguales23
j fin

iguales12: beq r1, r3, todosIguales
daddi r4, r4, 2
j fin

iguales13: daddi r4, r4, 2
j fin

iguales23: daddi r4, r4, 2
j fin

todosIguales: daddi r4, r4, 3

fin: sd r4, D(r0)
halt
