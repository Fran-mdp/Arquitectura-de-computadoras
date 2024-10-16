.data
peso: .double 69.2
estatura: .double 1.70
IMC: .double 0.0
infrapeso: .double 18.5
normal:    .double 25.0
sobrepeso: .double 30.0
estado: .word 0

.code
l.d f1, peso(r0)        ; pesro en f1
l.d f2, estatura(r0)    ; estatura en f2

mul.d f3, f2, f2        ; f3 = altura ^ 2
div.d f4, f1, f3        ; f4 = peso / (altura^2)
s.d f4,     IMC(r0)     ; almaceno IMC en memoria

daddi r1, r0, 4         ; por defecto es un gordo obeso

l.d f5, infrapeso(r0)   ; cargo infrapeso
c.lt.d f4, f5           ; comparo IMC con infrapeso
bc1t infra              ; si es infrapeso va a infra

l.d f5, normal(r0)   ; cargo normal
c.lt.d f4, f5           ; comparo IMC con normal
bc1t normi              ; si es normal va a normi

l.d f5, sobrepeso(r0)   ; cargo sobrepeso
c.lt.d f4, f5           ; comparo IMC con sobrepeso
bc1t sobre              ; si es sobrepeso va a sobre

j final                 ; si es un gordo obeso va al final (default)

infra: daddi r1, r0, 1  ; tiene infrapeso entonces pongo 1
j final

normi: daddi r1, r0, 2  ; es normal entonces pongo 2
j final

sobre: daddi r1, r0, 3  ; tiene sobrepeso entonces pongo 3

final: sd r1, estado(r0)    ; cargo el numero que haya quedado en el estado

nop
halt

