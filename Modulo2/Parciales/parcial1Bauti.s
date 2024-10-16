
; ; 1)
; ; r3 = 4 -> 3 -> 2 -> 1 -> 0
; ; r5 = 10
; ; r7 = 0 -> 10 -> 20 -> 30 -> 40

; ; x = 40

; 2) 
; ld r3, A(r0)
; ld r5, B(r0)
; lazo: dadd r7, r0, r0
; daddi r3, r3, -1
; bnez r3, lazo
; sd r7, X(r0)
; halt

; Cambiaria daddi por dadd.

; 3)5 instrucciones fuera del lazo = 5
; 4 * 3 instrucciones del lazo =     12
; Total                              17

; 21 ciclos / 17 instrucciones 

; 4) Bajamos el dadd r7, r7, r5 debajo de bnez

; 5) WAR, debido a que ADD esta intentando escribir en f1 antes de que mul termine de usar el f1 original

; 6) $s6 = control $s7 DATA
; daddi $t0, $0, TITULO
; sd $t0, 0($s7)
; daddi $t0, $0, 4
; sd $t0, 0($s6)

; 7)daddi $a0, $0, cadena
; l.d f0, NUM($0)

;EJERCICIO 9 (Programa)
.data 
CONTROL: .word 0x10000
DATA: .word 0x10008
coorX: .byte 5
coorY: .byte 5
verde: .word32 0, 255, 0, 0

.text 
daddi $t0, $0, verde
ld $s0, CONTROL($0)
ld $s1, DATA($0)

;Limpio Pantalla
daddi $t0, $0, 7
sd $t0, 0($s0)

;Solicito DATOS
daddi $t0, $0, 8
;Base
sd $t0, 0($s0)
ld $a0, 0($s1)
;Altura
sd $t0, 0($s0)
ld $a1, 0($s1)

;COLOR = VERDE
lwu $t0, verde($0)
sw $t0, 0($s1) 

;Coordenadas de inicio
lbu $a2, coorX($0)
lbu $a3, coorY($0)

daddi $t0, $0, 7
sd $t0, 0($s0)

;Llamo a subrutina con $a0 = base, $a1 = altura, $a2 = coorX, $a3 = coorY, DATA = VERDE, ?, ?
jal rectangulo



halt

rectangulo: daddi $t3, $0, 5 ;CONTROL = 5 -> Pintar pixel
dadd $t1, $a2, $a0 ;$t1 = Limite de las bases
daddi $t0, $0, 2

loop_bases: nop

base: nop ;Imprimo pixel actual
sb $a3, 4($s1)
sb $a2, 5($s1)
sb $t3, 0($s0)

;Me muevo hacia la derecha (Inc x)
daddi $a2, $a2, 1
bne $t1, $a2, base

;Mando (x,y) al lado superior
dsub $a2, $a2, $a0
dadd $a3, $a3, $a1
daddi $t0, $t0, -1
bnez $t0, loop_bases

;Resetear valores de coordenadas
dsub $a2, $a2, $a0
dsub $a3, $a3, $a1

dadd $t1, $a3, $a1 ;$t1 = Limite de las alturas
daddi $t0, $0, 2
loop_alturas: nop

altura: nop ;Imprimo pixel actual
sb $a3, 4($s1)
sb $a2, 5($s1)
sb $t3, 0($s0)

;Me muevo hacia arriba (Inc y)
daddi $a3, $a3, 1
bne $t1, $a3, altura

;Mando (x,y) al lado derecho
dsub $a3, $a3, $a1
dadd $a2, $a2, $a0
daddi $t0, $t0, -1
bnez $t0, loop_alturas

jr $ra



