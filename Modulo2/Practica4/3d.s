; Modificar el programa para que almacene en un arreglo en memoria de datos los 
;contenidos parciales del registro r1 ¿Qué 
;significado tienen los elementos de la tabla que se genera?

.data
A: .word 1
B: .word 6
arreglo: .word 0


.code
ld r1, A(r0)
ld r2, B(r0)
dadd r3, r3, r3        ; pongo en 0 para ir avanzando en la tabla
 

loop: dsll r1, r1, 1   ; rota 1 a la izquierda
sd r1, arreglo(r3)     ; r1 lo guardo en memoria
daddi r3, r3, 8        ; avanzo en el arreglo
daddi r2, r2, -1       ; disminuyo dimL
bnez r2, loop
halt