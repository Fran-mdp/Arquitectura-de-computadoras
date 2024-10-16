# Clase 5 - Segmentación del Cauce: Soluciones a los Problemas de Paradas y Atascos

## Introducción

En la clase anterior, analizamos el concepto de segmentación de cauce o pipelining, en el que separamos las etapas del procesamiento en distintos ciclos de reloj. Sin embargo, identificamos que en ciertos casos, existen obstáculos que causan paradas o atascos en el funcionamiento del cauce, llamados stalls. Estas paradas pueden ser causadas por problemas estructurales, de dependencia de datos o de control. 

## Problemas que Generan Atascos

1. **Atascos Estructurales**: Son provocados por conflictos con el uso de los recursos que dispone el hardware en la implementación de un ciclo de instrucción.

2. **Dependencia de Datos**: El problema surge cuando dos instrucciones utilizan un mismo dato, y uno de ellos requiere el dato pero el otro aún no lo ha entregado.

3. **Dependencia de Control**: Esta dependencia se produce cuando la ejecución de una instrucción depende de cómo se ejecutó otra instrucción. Esto se aplica típicamente para las ramificaciones o saltos de control de programa.

Estos problemas pueden resultar en un incremento del número de ciclos por instrucción (CPI), lo que reduce el rendimiento teórico del sistema.

## Soluciones a los Atascos

### Solución a los Atascos Estructurales

Dado que estos atascos se deben a una falta de recursos, la solución es simple: añadir más recursos. Esto se puede lograr de tres formas:

1. **Replicación de Recursos**: Esto implica duplicar unidades funcionales para realizar una misma tarea.

2. **Segmentación de Recursos**: Esto implica dividir el hardware en partes que siguen el funcionamiento secuencial por ciclos de reloj.

3. **Turnar el Acceso a las Unidades Funcionales en Conflicto**: Esto implica dar acceso a las unidades funcionales en el orden en que se solicitan.

Por ejemplo, se podrían agregar sumadores o restadores específicos para realizar determinadas tareas, o separar la memoria en dos: una para instrucciones y otra para datos. 

### Acceso al Banco de Registros

Uno de los desafíos es cuando queremos acceder al banco de registros. Una solución es hacer turno para el acceso a la unidad en conflicto. En este caso, suponemos que toda acción de escritura sobre el banco de registro se realiza en la primera mitad de los ciclos de reloj y las lecturas en la segunda mitad del ciclo. De esta manera, podemos acceder dos veces al banco de registro en un ciclo de reloj: primero para escribir y luego para leer.

Estas estrategias ayudan a disminuir el problema del acceso al banco de registro y permiten ejecutar varias etapas en un solo ciclo de reloj, en vez de tener que esperar varios ciclos.
