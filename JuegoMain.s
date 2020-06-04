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
f4: .asciz "|  Selecciona el orden de la palabra seguido de sus caracteres faltantes: 1ER  |" 
f5: .asciz "|  Listo para jugar?(Y/N)                                                      |"
f6: .asciz "_______________________________________________________________________________|"

ingresoOpcion: .asciz "%c"
opcionElegida: .asciz " "
errorMessage: .asciz "Error caracter invalido"
juegoI: .asciz "Entraste al juego"
correctoM: .asciz  "CORRECTO"
incorrectoM: .asciz  "INCORRECTO"
bancoPalabras: .asciz "pel?ta", "c?rros", "tomat?", "?guana", "p?erta" @palabras del juego
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
mult3: .word 0

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
	 
	 
	 b salida
	
	
	incorrecto:
	
	 ldr r0, =incorrectoM
	 bl puts
	 add r10, #1
	 
	 cmp r10, #5 @Comprobacion para prevenir loop infinito
	 bgt salida
	 
	 ldr r5, =bancoPalabras
	 bl impresionPalabra
	 ldr r0, =espacio
	 bl puts
	 mov r11, #0
	 b juego2


	 b salida
 
impresionPalabra:
	push {lr}
	
	add r11, r11, #1 @bandera del turno
	
	ldr r0, =mult2 @carga formato
	mov r1, r11
	bl printf
	
	
	mov r1, r5   @moverse dentro del arreglo
	add r5, r5, #7
	
	ldr r0, =eleccion2
	
	bl printf
	
	cmp r10, r11
	bne impresionPalabra
	
	pop {lr}
	mov pc, lr

limpiezaArreglo:
	push {lr}
	
	
	pop {lr}
	mov pc, lr

salida:
	
	/* salida correcta */
	mov r0, #0
	mov r3, #0
	ldmfd sp!, {lr}	/* R13 = SP */
	bx lr
	
	