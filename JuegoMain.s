/*UNIVERSIDAD DEL VALLE DE GUATEMALA*/
/*BRYANN EDUARDO ALFARO HERNANDEZ 19372*/
/*DIEGO DE JESUS ARREDONDO TURCIOS 19422*/
/*Proyecto 3 Realizacion de un juego*/
/*REFERENCIA GENERAL: CLASE VIRTUAL Y ARCHIVOS DE CLASE*/
/*ORGANIZACION DE COMPUTADORAS Y ASSEMBLER*/

/*----------------------SECCION DE DATOS-------------------*/
.data
.align 4

primeraParte: .asciz "              ____  _  _  ____  ____" 
primeraParte1: .asciz "     (__  )___(_  _)( \/ )(  _ \(  __)"
primeraParte2: .asciz "    / _/(___) )(   )  /  ) __/ ) _)" 
primeraParte3: .asciz "   (____)    (__) (__/  (__)  (____)"

f1: .asciz "_______________________________________________________________________________ "
f2: .asciz "|                                                                              |"
f3: .asciz "|  Debes Destruir las palabras completándolas.                                 |"  
f4: .asciz "|  Selecciona el orden de la palabra seguido de sus caracteres faltantes: 1e  |" 
f5: .asciz "|  Listo para jugar?(Y/N)                                                      |"
f6: .asciz "_______________________________________________________________________________|"

ingresoOpcion: .asciz "%c"
opcionElegida: .asciz " "
errorMessage: .asciz "Error caracter invalido"
juegoI: .asciz "Entraste al juego"
correctoM: .asciz  "CORRECTO"
incorrectoM: .asciz  "INCORRECTO"
perder: .asciz  "HAS PERDIDO"
ganar: .asciz  "HAS GANADO"

bancoCorrecto: .asciz "o", "a", "e", "i", "u" @caracteres correctos
formato: .asciz "1-%s\n"

eleccion: .asciz "%s"
eleccion2: .asciz "%s\t"
formatoChar: .asciz "%c\n"
opcion: .asciz "  "
numero: .word 0
mult: .asciz "%d\n"
mult2: .asciz "%d-"
espacio: .asciz "\n"
espacioVacio: .asciz "      "
puntos: .word 0
bancoPalabras: .asciz "pel?ta", "c?rros", "tomat?", "?guana", "p?erta" @palabras del juego

/*---------------------------------------------------------*/
.text
.align 4
.global main
.type main,%function


main:

	stmfd sp!, {lr}	/* SP = R13 link register */
	/* valor1 */

inicio:
	mov r10, #1
	mov r11, #0
	mov r9, #4
	mov r12, #0
	mov r4, #1
/*-----CARGGA DEL ASCII DIBUJO--------------*/
	ldr r0, =primeraParte
	bl puts
	ldr r0, =primeraParte1
	bl puts
	ldr r0, =primeraParte2
	bl puts
	ldr r0, =primeraParte3
	bl puts
	
/*------CARGA DEL CUADRO INICIAL DEL JUEGO-----*/
	ldr r0, =f1
	bl puts
	ldr r0, =f2
	bl puts
	ldr r0, =f3
	bl puts
	ldr r0, =f4
	bl puts
	ldr r0, =f5
	bl puts
	ldr r0, =f6
	bl puts
/*-------------------------------------------------*/

	ldr r0, =ingresoOpcion
	ldr r1, =opcionElegida
	bl scanf

	ldr r1,=opcionElegida
	ldrb r1,[r1]

	cmp r1, #'Y'
	beq juego
	cmp r1, #'N'
	beq salida
	b error
	
error:
	ldr r0, =errorMessage
	bl puts
	b inicio
	
juego:
	mov r2, #0

	ldr r0, =juegoI
	bl puts
	
	@Mostrar palabra inicial
	ldr r5, =bancoPalabras
	ldr r0, =formato
	mov r1, r5
	bl printf
	
	b juego2
	
juego2: 
	@Pedir al usuario su eleccion
	ldr r0, =eleccion
	ldr r1, =opcion
	bl scanf
	
	@Prueba de desgloce de ingreso de usuario numero
	ldr r0, =formatoChar
	ldr r1, =opcion
	ldrb r1, [r1]
	sub r1, r1, #48 @entero
	sub r2, r1, #1 @copiar para no perder referencia
	mov r8, r2
	
	ldr r0, =formatoChar @letra ingresada
	ldr r3, =opcion
	ldrb r1, [r3, #1]
	mov r7, #2
	mul r2, r2, r7
	
	ldr r6, =bancoCorrecto
	ldrb r6, [r6, r2] @Colocando en la letra de acuerdo al numero ingresado
	
	cmp r6, r1
	
	beq correcto
	bne incorrecto
	
correcto:
	ldr r0, =correctoM
	bl puts
	bl limpiezaArreglo
	@ldr r5, =puntos
	@ldr r5, [r5]
	@add r5, r5, #1
	@cmp r1, #5
	@beq salidaGano
	@mov r12, r5
	@str r12, [r5]
	ldr r5, =bancoPalabras
	bl operar
	bl impresionPalabraC
	ldr r0, =espacio
	bl puts
	mov r11, #0
	mov r4, #1
	b juego2

incorrecto:
	
	ldr r0, =incorrectoM
	bl puts
	add r4, #1
	cmp r4, #5 @Comprobacion para prevenir loop infinito
	bgt salidaPerdio
	ldr r5, =bancoPalabras
	bl operar
	bl impresionPalabraI
	ldr r0, =espacio
	bl puts
	mov r11, #0
	b juego2
 
impresionPalabraC:
	push {lr}
	
	sub r12, r10, r11
	cmp r12, #1
	blt juego2

	ldr r1, [r5]
	add r5, r5, #7
	ldr r12, =espacioVacio
	ldr r12, [r12]
	add r11, r11, #1 @bandera del turno
	add r10, #1
	add r4, #1
	cmp r1, r12
	beq impresionPalabraC
	sub r11, r11, #1
	sub r10, r10, #1
	sub r4, #1
	add r11, r11, #1 @bandera del turno
	sub r5, r5, #7

	ldr r0, =mult2 @carga formato
	mov r1, r11
	bl printf
		
	mov r1, r5   @moverse dentro del arreglo
	add r5, r5, #7
	ldr r0, =eleccion2
	
	bl printf
	cmp r4, r11 
	bne impresionPalabraC
	pop {lr}
	mov pc, lr

impresionPalabraI:
	push {lr}
	
	add r11, r11, #1 @bandera del turno
	ldr r0, =mult2 @carga formato
	mov r1, r11
	bl printf
		
	mov r1, r5   @moverse dentro del arreglo
	add r5, r5, #7
	ldr r0, =eleccion2
	
	bl printf
	sub r12, r10, r11
	cmp r12, #1
	bge impresionPalabraI
	pop {lr}
	mov pc, lr

operar:
	push {lr}
	mov r10, r4
	pop {lr}
	mov pc, lr

limpiezaArreglo:
	push {lr}
	mov r9, #7
	mul r8, r8, r9
	ldr r9, =bancoPalabras
	add r9, r8
	mov r8, #6
	mov r12, #' '
ciclo:
	mov r0, #0
	strb r12, [r9], #1
	sub r8, r8, #1
	cmp r8, r0
	bne ciclo
	pop {lr}
	mov pc, lr

salidaPerdio:
	ldr r0, =perder
	bl puts
	/* salida correcta */
	b salida

salidaGano:
	ldr r0, =ganar
	bl puts
	/* salida correcta */
	b salida
	
salida:
	/* salida correcta */
	mov r0, #0
	mov r3, #0
	ldmfd sp!, {lr}	/* R13 = SP */
	bx lr
	
	