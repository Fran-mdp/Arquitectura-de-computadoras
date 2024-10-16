.data
tabla_1: .word 21,12,5,16,8,39,10,41,4,33
tabla_2: .word 32,24,15,32,17,28,11,20,44,21
cant: .word 10
CONTROL: .word32 0x10000
DATA: .word32 0x10008
colorRojo: .byte 255,0,0,0
colorVerde: .byte 0,255,0,0

.code
lwu $s6, CONTROL($0)
lwu $s7, DATA($0)

daddi $a0, $0, tabla_1
ld $a1, cant($0)
jal MIN_MAX
dadd $t1, $0, $v0 ;t1 = minimo_tabla1
dadd $t2, $0, $v1 ;t2 = maximo_tabla1

daddi $a0, $0, tabla_2
ld $a1, cant($0)
jal MIN_MAX
dadd $t3, $0, $v0 ;t3 = minimo_tabla2
dadd $t4, $0, $v1 ;t4 = maximo_tabla2

daddi $t5, $0, 5

ld $t0, colorRojo($0)
sw $t0, 0($s7)
sb $t1, 5($s7)
sb $t4, 4($s7)
sd $t5, 0($s6)

ld $t0, colorVerde($0)
sw $t0, 0($s7)
sb $t3, 5($s7)
sb $t2, 4($s7)
sd $t5, 0($s6)

halt

MIN_MAX: daddi $v0, $0, 9999    ;min
daddi $v1, $0, 0    ;max
loop: ld $t1, 0($a0)
slt $t3, $v0, $t1
beqz $t3, nomax
daddi $v1, $0, $t1
nomax: slt $t4, 




