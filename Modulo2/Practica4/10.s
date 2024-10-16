.data
cadena: .asciiz "adbdcdedfdgdhdid"  ; cadena a analizar
car: .asciiz "d"                    ; caracter buscado
cant: .word 0                       ; cantidad de veces que se repite el caracter car en cadena.

.code 
lbu r2, car(r0)         ; letra que busco en r2
daddi r3, r0, 16        ; cantidad letras de cadena en r3
dadd r4, r0, r0         ; cuento cant en r4 
dadd r1, r0, r0         ; pos donde estoy

loop: beqz r3, fin      ; si llegue al final termino
lbu r5, cadena(r1)      ; pongo en r5 letra(pos)
bne r5, r2, sigo        ; si letra(pos) != car => sigo
daddi r4, r4, 1         ; si es aumento contador
sigo: daddi r1, r1, 1  ; aumeneto pos
daddi r3, r3, -1        ; disminuyo cant letras cadena
j loop                  ; continuo con el loop

fin: sd r4, cant(r0)    ; pongo lo que hay en el contador de r4 en cant
nop                     ; nunca entendi que hace
halt