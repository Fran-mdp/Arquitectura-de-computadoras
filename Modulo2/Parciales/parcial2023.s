.data
a: .double 1.1, 2.2, 3.3
b: .double 4.4, 5.5, 6.6
c: .double 7.7, 8.8, 9.9
res: .word 0
.code
daddi r1, r0, a
daddi r2, r0, b
daddi r3, r0, c
daddi r4, r0, res
jal subrutina
halt

subrutina: daddi r6, r0, 10
loop: l.d f1, 0(r1)
l.d f2, 0(r2)
l.d f3, 0(r3)
mul.d f5, f1, f1
mul.d f6, f2, f2
add.d f4, f5, f6
div.d f4, f4, f3
s.d f4, 0(r4)
daddi r1, r1, 8
daddi r2, r2, 8
daddi r3, r3, 8
daddi r6, r6, -1
bnez r6, loop
jr $ra
