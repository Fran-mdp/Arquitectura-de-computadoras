;a) ¿Qué efecto tiene habilitar la opción Delay Slot (salto retardado)?.
; Genera un período de parada luego de una instrucción de salto

;b) ¿Con qué fin se incluye la instrucción NOP? ¿Qué sucedería si no estuviera?.
; se ejecuta la instrucción halt? no se

;c) Tomar nota de la cantidad de ciclos, la cantidad de instrucciones y los CPI 
;luego de ejecutar el programa.
; CICLOS --> 60 , INSTRUCCIONES --> 52, CPI --> 1.154

.data
cant: .word 8
datos: .word 1, 2, 3, 4, 5, 6, 7, 8
res: .word 0

.code
dadd r1, r0, r0          ; pone r1 en 0
ld r2, cant(r0)          ; dimL

loop: ld r3, datos(r1)   ; en r3 carga primer elem de tabla 
daddi r2, r2, -1         ; disminuye dimL
dsll r3, r3, 1           ; rota a la izq 1 
sd r3, res(r1)           ; lo almacena en memoria 
daddi r1, r1, 8          ; avanza en la tabla
bnez r2, loop            ; si no se termina la tabla sigue
nop                      ; periodo de parada
halt


; con forwarding hay 2 Branch Taken Stalls y 2 Branch Misprediction Stalls