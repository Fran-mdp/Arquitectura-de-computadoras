; 1)

; .data
; tabla1: .word 15, 11, 24
; tabla2: .word 0, 0, 0   
; .code
; daddi r1, r0, 0
; daddi r2, r0, 3
; loop: ld r3, tabla1(r1)
;     daddi r3, r3, 1
;     sd r3, tabla2(r1)
;     daddi r1, r1, 8
;     daddi r2, r2, -1
; bnez r2, loop
; halt

; RAW: 
; Lineas 4, 5, 6: 2 RAW -> 3 ITERACIONES * 2 RAW = 6 RAWS
; IF | ID | EX | ME | WB
;    | IF | ID | RAW | EX | ME | WB
;         | IF | ID  | RAW| EX | ME | WB

; BTS:
; 2 BTS ya que en la 3era iteracion es correcto ejecutar el halt

; CPI: 
; Instrucciones = 3 Instrucciones (fuera del loop) + 3 * 6 instrucciones (dentro del loop) = 21 Instrucciones
; Ciclos = 21(Inst) + 4 + 8(stalls) = 33 Ciclos
; CPI = 33 Ciclos/ 21 Instrucciones

; 2)La cantidad de RAWS va a ser la misma ya que no BTB no afecta a los Atascos
; de dependencia de datos sino que a los de Atascos de control.
; RAW = 6 RAWS.

; Como el BUFFER inicia en (no saltes) van a ocurrir 2 Bts, uno generado por el error
; y el otro generado por la actualizacion del buffer.

; Luego en la ultima iteracion se van a generar 2 Branch misprediction, uno generado por
; Saltar cuando debe ejecutar el halt y el otro por actualizar el buffer a no saltes.
; BTS = 2
; BMIS = 2

; 3)Es mayor ya que hay dos atascos Bmisprediction que antes no estaban. En este caso
; donde se itera pocas veces no es conveniente activar BTB.

; 4)daddi r1, r1, 8 debajo del bnez

;5) cvt.l.d f9, f9
; mfc1  r5, f9

; 6)
; s.d f2, 0($s7)
; daddi $t0, $0, 3
; sd $t0, 0($s6)

; 7)
; 1. L.D f2, MAX($0)
; 2. L.D F3, TABLA1($t3)
; 3. daddi $t5, $t5, 1

; 8)
.data 
CONTROL: .word32 0x10000
DATA: .word32 0x10008
TABLA: .word 3, 2, 14, 25, 33, 44, 1
LONG: .word 7
.code
ld $s0, CONTROL($0)
ld $s1, DATA($0)
daddi $a0, $0, TABLA
ld $a1, LONG($0)
jal SUM_ALL

sw $v0, 0($s1)
daddi $t0, $0, 1
sd $t0, 0($s0)
halt


;$a0 = Direccion de inicio, $a1 = CANT ELEMENTOS, $v0 = Resultado
SUM_ALL: daddi $v0, $0, 0
recorrer: ld $t0, 0($a0)
dadd $v0, $v0, $t0
daddi $a1, $a1, -1
daddi $a0, $a0, 8
bnez $a1, recorrer
jr $ra


