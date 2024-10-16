PA EQU 30H
PB EQU 31H
CA EQU 32H
CB EQU 33H
      ORG 1000H
MSJ   DB "CONCEPTOS DE "
      DB "ARQUITECTURA DE "
      DB "COMPUTADORAS"
FIN   DB ?
      ORG 2000H
      MOV AL, 0FDH ; INICIALIZACION PIO PARA IMPRESORA 11111101B ;Strobe salida Busy entrada
      OUT CA, AL ;CA
      MOV AL, 0
      OUT CB, AL ;CB
      IN AL, PA ;mando strobe en 0
      AND AL, 0FDH
      OUT PA, AL ; FIN INICIALIZACION
      MOV BX, OFFSET MSJ
      MOV CL, OFFSET FIN-OFFSET MSJ
POLL: IN AL, PA
      AND AL, 1
      JNZ POLL ;MIENTRAS NO ESTE LIBRE SIGO CONSULTANDO
      MOV AL, [BX]
      OUT PB, AL
      IN AL, PA ; PULSO 'STROBE'
      OR AL, 02H
      OUT PA, AL
      IN AL, PA
      AND AL, 0FDH
      OUT PA, AL ; FIN PULSO
      INC BX
      DEC CL
      JNZ POLL
      INT 0
      END

;chequear el bit de busy 
;enviar el caracter a pb
;generar el pulso de impresion strobe