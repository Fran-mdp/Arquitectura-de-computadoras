.data
n1: .double 9.13
n2: .double 6.58
res1: .double 0.0
res2: .double 0.0

.code
l.d f1, n1(r0)     ; carga en registro f1 el valor de n1
l.d f2, n2(r0)     ; carga en registro f2 el valor de n1


NOP
add.d f3, f2, f1   ; almacena en f3 el la suma de f1 y f2
mul.d f1, f2, f1   ; PARA EJERCICIO d)
mul.d f4, f2, f1   ; almacena en f3 la multip de f1 y f2
s.d f3, res1(r0)   ; almacena en memoria
s.d f4, res2(r0)
halt

; a) Con forwarfing --> 16 ciclos, 7 instrucciones, 
; 2.286 CPI.

;b) Se generan 4 RAW. 
; add.d f3, f2, f1 --> el dato en conflicto es f2 porque se 
; lo quiere utilizar como operando cuando aun no fue escrito 
; en el registro

; s.d f3, res1(r0) --> el dato en conflicto es f3 porque se 
; lo quiere almacenar en memoria y aun no se le guardo el 
; resultado de la operación 
; s.d f4, res2(r0) --> idem anterior


; c) Dos o más instrucciones necesitan utilizar el mismo 
; recurso hardware en el mismo ciclo:

; s.d f3, res1(r0)--> aparece en la etapa X (ejecución) 
; porque la instrucción add.d f3, f2, f1 se encuentra en la 
; etapa M y ambos quieren acceder a memoria. --------> NO ME 
; QUEDA CLARO ESTO porque el resultado de la instruc add se 
; almacena en un registro NO en la memoria, pero creo que si 
; o si tiene que pasar por esa etapa <--------


; s.d f4, res2(r0) --> aparece en la etapa X porque la 
; instruccion mul.d quiere acceder a memoria al mismo tiempo



; d) Aparece un atasco tipo WAR porque la instrucción 
; agregada quiere leer f1 que en la instrucción anterior fue 
; escrita con un nuevo valor  

; e) Explicar por qué colocando un NOP antes de la suma, se 
;soluciona el RAW de la instrucción ADD y como 
;consecuencia se elimina el WAR.
; Se soluciona el RAW porque la instrucción NOP atrasa un 
; ciclo de reloj todas las etapas de las siguientes instruc. 
; Por lo tanto el valor de n2 ya va a estar escrito en el 
; registro r2 cuando la instrucción add lo solicite.

; no se
