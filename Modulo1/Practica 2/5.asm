ORG 1000H
MSJ DB "INGRESE UN NUMERO:"
FIN_MSJ DB ?
ERROR DB "CARACTER NO VALIDO"
FIN_ERROR DB ?
ORG 1500H 
      NUM DB ?

ORG 3000H
ES_NUM: MOV CL, [BX]
CMP CL, 30H
JS FIN_NO
CMP CL, 3AH
JNS FIN_NO
MOV DL, 0FFH
RET


FIN_NO: MOV DL, 00H
MOV BX, OFFSET ERROR
MOV AL, OFFSET FIN_ERROR - OFFSET ERROR
INT 7
RET

ORG 2000H
      MOV BX, OFFSET MSJ
      MOV AL, OFFSET FIN_MSJ - OFFSET MSJ
      INT 7
      MOV BX, OFFSET NUM
      INT 6
      CALL ES_NUM
      INT 0
END