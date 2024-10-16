.data
X: .byte 5
Y: .byte 5
VERDE: .byte 0,255,0,0
CONTROL: .word 0x10000
DATA: .word 0x10008

.text
;cargo control y data
ld $s0, CONTROL($0)
ld $s1, DATA($0)

;limpio pantalla
daddi $t0, $0, 6
sd $t0, 0($s0)

;cargo base y altura
daddi $t0, $0, 8
sd $t0, 0($s0)
ld $a0, 0($s1)  ;$a0 = base
sd $t0, 0($s0)
ld $a1, 0($s1)  ;$a1 = altura

jal dibujo
halt

dibujo: 
        lwu $t0, VERDE($0)
        sw $t0, 0($s1)
        ld $t1, X($0)
        ld $t2, Y($0)
        dadd $t1, $t1, $a0
        dadd $t2, $t2, $a1
        daddi $t3, $0, 5

        lazo: 
            sb $t1, 5($s1)
            sb $t2, 4($s1)
            sd $t3, 0($s0)
            daddi $t1, $t1, -1
            slti $t4, $t1, 5
            beqz $t4, lazo
            daddi $t2, $t2, -1
            slti $t4, $t2, 5
            bnez $t4, retornar
            daddi $t1, $a0, 5
            j lazo
retornar: jr $ra


