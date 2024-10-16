.data
TABLA_1: .word 1,2,3,4,5,6
TABLA_2: .word 0
LONG: .word 6
SUMA: .word 0
CONTROL: .word32 0x10000
DATA: .word32 0x10008

.code
lwu $s0, CONTROL($0)
lwu $s1, DATA($0)
daddi $a0, $0, TABLA_1
daddi $a1, $0, TABLA_2
ld $a2, LONG($0)

jal rutina
sd $v0, SUMA($0)
sd $v0, 0($s1)
daddi $t0, $0, 1
sd $t0, 0($s0)
halt

rutina: daddi $t0, $0, 0    ;act
daddi $v0, $0, 0    ;suma
daddi $t3, $0, 0    ;index
loop: ld $t0, 0($a0)
dadd $t0, $t0, $t0
dadd $v0, $v0, $t0
sd $t0, 0($a1)
daddi $a1, $a1, 8
daddi $a0, $a0, 8
daddi $a2, $a2, -1
bnez $a2, loop
jr $ra


