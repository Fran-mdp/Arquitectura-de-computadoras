# Conversión de Hexadecimal a Punto Flotante de Doble Precisión

Este programa Python realiza la conversión de un número hexadecimal a un número de punto flotante de doble precisión mediante el módulo `struct`.

## Descripción

El programa define un número hexadecimal como una cadena de texto. Luego, se usa `struct.unpack('!d', bytes.fromhex(hex_num))[0]` para convertir el número hexadecimal a un número de punto flotante de doble precisión.

- `bytes.fromhex(hex_num)` convierte la cadena hexadecimal en bytes.
- `struct.unpack('!d', ...)` desempaqueta los bytes en un número de punto flotante de doble precisión. El `!d` es un formato de conversión que indica un número de punto flotante de doble precisión en el orden de bytes de la red.

Finalmente, el programa imprime el número de punto flotante resultante.

## Uso

Simplemente ejecute el script Python y este imprimirá el número de punto flotante de doble precisión correspondiente al número hexadecimal definido.
