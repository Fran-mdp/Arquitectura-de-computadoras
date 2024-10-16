; 1) 
; IF | ID | EXE | MEM   | WB  |  ;LD
;      IF | ID  | EXE.d | EXE.d | EXE.d | EXE.d | MEM | WB  ;ADD.D, 
;         | IF  | ID    | EXE   | MEM   | WB  ;S.D
;               | IF    | ID    | EXE   | MEM   | WB  ;halt

; 9 ciclos / 4 instrucciones = 9/4 cpi
; .data 
; numero: .double 2
; .code 
; l.d f1, numero($0)
; add.d f2, f2, f2
; s.d f4, numero($0)
; halt 

; 2)
; ;Inicio de pila
; daddi $sp, $0, 0x400
; ;Carga del dato
; daddi $sp, $sp, -8
; sd $t6, 0($sp) 

; 3)
; 2 Atascos de salto en el incio de branch taken
; 2 Atascos de misprediction al final
; .code
; daddi $t7, $0, 5
; daddi $t7, $t7, 40
; siguiente: daddi $t7, $t7, -1
; bnez $t7, siguiente
; halt

; 4)
; .data 
; Valor: .double 4.64
; CONTROL: .word32 0x10000
; DATA: .word32 0x10008
; texto_resultado: .asciiz "El resultado es: "

; .text
; ld $s0, CONTROL($0)
; ld $s1, DATA($0)

; daddi $t0, $0, 8
; sd $t0, 0($s0)

; l.d f1, 0($s1)
; l.d f2, Valor($0)

; c.le.d f1, f2

; bc1t menor_igual
; ;(X - valor) * X
; sub.d f2, f1, f2
; mul.d f1, f2, f1
; j mostrar
; menor_igual: sub.d f2, f2, f1
; div.d f1, f2, f1

; mostrar: daddi $t0, $0, texto_resultado
; sd $t0, 0($s1)
; daddi $t0, $0, 4
; sd $t0, 0($s0)

; s.d f1, 0($s1)
; daddi $t0, $0, 3
; sd $t0, 0($s0)

; halt


; 5)
.data 
CONTROL: .word32 0x10000
DATA: .word32 0x10008
rojo: .word32 255, 0, 0, 0
tabla_1: .word32 14, 12, 5, 16, 8, 12, 10, 11, 4, 13
tabla_2: .word32 1, 2, 3, 4, 5, 6, 7, 8, 9, 10

.code
ld $s0, CONTROL($0)
ld $s1, DATA($0)

daddi $a0, $0, tabla_1
daddi $a1, $0, 10
jal MIN_MAX

dadd $s2, $0, $v0 ;S2 = max
dadd $s3, $0, $v1 ;S3 = min


daddi $a0, $0, tabla_2
daddi $a1, $0, 10
jal MIN_MAX

;Limpiar pantalla
daddi $t0, $0, 7
sd $t0, 0($s0)

;Pantalla Grafica
lwu $t0, rojo($0)
sw $t0, 0($s1)

sw $s3, 5($s1) ;X = MINIMO tabla_1
sw $v0, 4($s1) ;X = maximo tabla_2
daddi $t0, $0, 5
sd $t0, 0($s0);CONTROL = 5, para imprimir

sw $v1, 5($s1) ;X = MINIMO tabla_2
sw $s2, 4($s1) ;X = maximo tabla_1
daddi $t0, $0, 5
sd $t0, 0($s0);CONTROL = 5, para imprimir
halt

;a0 = Direccion de comienzo, a1 = Cantidad de elementos
;v0 = MAX, V1 = MIN
MIN_MAX: daddi $t2, $0, 1 ;Para comparar luego de SLT 
daddi $v1, $0, 0x400 ;Maximo valor inmediato??
daddi $v0, $0, 0
loop: daddi $a1, $a1, -1
lw $t0, 0($a0) ;$t0 = A[i]
slt $t1, $t0, $v1 ;(A[i] < MIN) t1 = 1
bne $t1, $t2, sig
;MIN
dadd $v1, $0, $t0
sig: slt $t1, $v0, $t0 ;(MAX < A[i]) t1 = 1
bne $t1, $t2, prox
;MAX
dadd $v0, $0, $t0
prox: daddi $a0, $a0, 4 ;Avanzo de a words
bnez $a1, loop

fin: jr $ra





