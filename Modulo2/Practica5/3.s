.data
base: .double 5.85
altura: .double 13.47
superficie: .double 0.0

.code
l.d f1, base(r0)    ; base
l.d f2, altura(r0)  ; altura
daddi r1, r0, 2     ; cargo 2 para dividir

mtc1 r1, f3         ; copia r1 en registro flotante f3
cvt.d.l f3, f3      ; convierte lo que hay en f3 en flotante

mul.d f4, f1, f2    ; f4 = f1 * f2, (b * a)
div.d f5, f4, f3    ; f5 = f4 / f3, ((b * a)/ 2)

s.d f5, superficie(r0)  ; almaceno el resultado de f5 en superficie
; funciona
