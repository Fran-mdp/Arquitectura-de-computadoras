.data
CONTROL: .word32 0x10000
DATA: .word32 0x10008
color: .byte 0,255,0,0
coorX: .byte 5
coorY: .byte 5

.code
lwu $s6, CONTROL($0)
lwu $s7, DATA($0)

daddi $t0, $0, 7
sd $t0, 0($s6)

daddi $t0, $0, 8
sd $t0, 0($s6)
ld $t1, 0($s7) ; t1 = base
sd $t0, 0($s6)
ld $t2, 0($s7) ; t2 = altura

ld $a0, coorX($0)
ld $a1, coorY($0)
dadd $a2, $0, $t1  ;a2 = base
dadd $a3, $0, $t2  ;a3 = altura

lwu $t0, color($0) ; dejo color puesto en data
sw $t0, 0($s7)

jal imprimir_rectangulo
halt

imprimir_rectangulo: daddi $t0, $0, 5
    dadd $t1, $0, $a0  ;x
    dadd $t2, $0, $a1  ;y
    dadd $t3, $0, $a2  ;base
    dadd $t4, $0, $a3  ;altura
    loop: sb $t1, 5($s7) ; x
        sb $t2, 4($s7)   ; y
        sd $t0, 0($s6)
        daddi $t3, $t3, -1
        daddi $t1, $t1, 1
        bnez $t3, loop
        dadd $t3, $0, $a2
        daddi $t2, $t2, 1
        daddi $t4, $t4, -1
        dadd $t1, $0, $a0
        bnez $t4, loop
        jr $ra



