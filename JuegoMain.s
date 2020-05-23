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

bienvenida: .asciz "Bienvenido"




/*---------------------------------------------------------*/


.text
.align 2
.global main
.type main,%function


main:

	stmfd sp!, {lr}	/* SP = R13 link register */
	/* valor1 */

ldr r0, =primeraParte
bl puts
ldr r0, =primeraParte1
bl puts
ldr r0, =primeraParte2
bl puts
ldr r0, =primeraParte3
bl puts

/*aqui debe de ir otro ascii para hacer el espacio del juego */
ldr r0, =bienvenida
bl puts
 
salida:
	
	/* salida correcta */
	mov r0, #0
	mov r3, #0
	ldmfd sp!, {lr}	/* R13 = SP */
	bx lr
	
	