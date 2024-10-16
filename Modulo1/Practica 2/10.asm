PIC EQU 20H 
EOI EQU 20H 
N_F10 EQU 10    
ORG 40 
IP_F10 DW  RUT_F10    
    ORG 2000H  
    CLI  
    MOV AL, 0FEH  
    OUT PIC+1, AL ; PIC: registro IMR  
    MOV AL, N_F10  
    OUT PIC+4, AL ; PIC: registro INT0  
    MOV DX, 0  
    STI
LAZO:   JMP LAZO    
        ORG 3000H 
RUT_F10:PUSH AX  
        INC DX  
        MOV AL, EOI  
        OUT EOI, AL  ; PIC: registro EOI  
        POP AX  
        IRET    
        END 
/*
a) La función de los registros del PIC: ISR, IRR, IMR, INT0-INT7, EOI. Indicar la dirección de cada uno.
-ISR: Se marca en 1 el bit correspondiente a una interrupcion ejecutandose (23H)
-IRR: Se marca en 1 el bit correspondiente a una interrupcion solicitada (22H)
-IMR: Se merca en 0 el bit correspondiente a una interrupcion habilitada (21H)
-EOI: Registro de comandos del controlador. Al cargarle 20H para indicar fin de la rutina de servicio de una interrupcion (20H)
-INT0 - INT7: Direcciones de comienzo de rutinas de manejo de interrupciones (24H - 31H)

b) Cuáles de estos registros son programables y cómo trabaja la instrucción OUT.
Son programables:
    -IMR: Para indicar que interrupciones habilitar
    -EOI: Para indicar el fin de una rutina de manejo de interrupcion
    -INT0-INT7: Para cargar las direcciones de los comienzos de las rutinas de manejo de interrupciones
La instruccion OUT funciona como un MOV con la diferencia que el primer operando siempre es un modulo de entrada/salida. Ej: PIC,TIMER, etc.

c) Qué hacen y para qué se usan las instrucciones CLI y STI.
    -CLI: Deshabilita las interrupciones enmascarables.
    -STI: Habilita las interrupciones enmascarables.
Son muy utiles para cuando se esta seteando el comportamiento de una interrupcion. Evitan que en dicho proceso, se interrumpa el 
funcionamiento normal del procesador.
*/