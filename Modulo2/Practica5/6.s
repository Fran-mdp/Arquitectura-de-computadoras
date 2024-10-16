.data
valor1: .word 16
valor2: .word 4
result: .word 0

.text
ld $a0, valor1($0)
ld $a1, valor2($0)

jal a_la_potencia        ; llama a subrutina
sd $v0, result($0)       ; 
halt


;SUBRUTINA
a_la_potencia: daddi $v0, $0, 1    ; pone en v0 1

lazo: slt $t1, $a1, $0             ; si a1 < 0 t1 = 1
bnez $t1, terminar                 ; si t1 = 0 termina
daddi $a1, $a1, -1		     ; decrementa a1
dmul $v0, $v0, $a0                 ; multiplica v0 con a0
j lazo				     	
terminar: jr $ra			     ; ret


; a) el programa llama a una subrutina que multiplica un num x si 
;mismo 

; b) instrucción jal --> llama a la subrutina
; instrucción jr --> vuelve de la subrutina al prog principal

; c) En $ra se almacena la dirección de retorno de la subrutina al 
; prog principal
; $a0 y $a1 son los encargados de pasar los parámetros a la 
; subrutina.
; $v0 devuelve el resultado al programa principal

; d) Deberia "pushear" antes de llamar la otra subrutina y luego 
; "popear" 

; porque text y no code????????????