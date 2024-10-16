ORG 1000H
MSJ DB "INGRESE UN NUMERO:"
FIN DB ?

ORG 1500H
NUM1 db ?
NUM2 db ?
RES db 30h
GUION db 2DH

ORG 2000H
MOV BX, OFFSET MSJ ;muevo a bx la direccion del mensaje a imprimir
MOV AL, OFFSET FIN-OFFSET MSJ ;muevo a al la cantidad de caracteres que se imprimen
INT 7 ;muestro en pantalla
MOV BX, OFFSET NUM1 ;le muevo a bx la direccion del numero a ingresar
int 6

sub byte ptr [BX],30h ;guardo la cantidad de espacios que me tendria que mover por el numero 1
mov AH,[BX] 

mov BX, OFFSET NUM2
int 6

sub byte ptr [BX],30h
mov CL,[BX]; guardo la cantidad de espacios que me tendria que mover por el numero 2

CMP AH,CL ;comparo el numero 1 con el 2
JNS mostrar_pos; si me dio postivo, el primero es mas grande por lo salto a la otra etiqueta
SUB CL,AH; por el contrario, si es mas chico, tengo que mostrar el guion
mov BX, OFFSET GUION
mov AL,1
int 7

MOV BX,OFFSET RES; luego al numero mas grande(el 2), restarle el numero 1 e imprimirlo
ADD [BX],CL
MOV AL,1
INT 7
JMP fin

mostrar_pos: SUB AH,CL; si es mas grande, el 1, simplemente le resto esa cantidad de espacios al numero 1 e imprimo
mov BX,OFFSET RES
add [BX],AH
MOV AL,1
int 7



fin:INT 0
END