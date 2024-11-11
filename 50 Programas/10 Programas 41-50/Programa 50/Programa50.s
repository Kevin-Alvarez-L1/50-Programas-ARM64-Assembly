//**************************************************************
// Archivo:    Programa50.s
// Proyecto:   50.Implementar una pila usando un arreglo
// Autor:      [Kevin Omar Alvarez Hernandez]
// Fecha:      [09/11/2024]
// Descripción:
//             [Implementar una pila usando un arreglo]
// 
// Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
// * Todos los derechos reservados.
// * 
// 
// **************************************************************//

.data
    stack:    .space 40          // Espacio para una pila de 10 enteros
    top:      .word -1           // Índice del elemento superior de la pila (-1 indica que está vacía)
    push_msg: .asciz "Ingrese el número a apilar: "
    pop_msg:  .asciz "Número desapilado: "
    buffer:   .space 10          // Para leer la entrada

.text
    .global _start

_start:
    // Push
    ldr x0, =1
    ldr x1, =push_msg
    mov x2, #24
    mov x8, #64
    svc #0

    // Leer el número a apilar
    ldr x0, =0
    ldr x1, =buffer
    mov x2, #10
    mov x8, #63
    svc #0

    // Convertir de ASCII a número y apilar
    ldr x0, =buffer
    bl atoi
    bl push

    // Pop
    bl pop
    bl itoa

    // Mostrar el número desapilado
    ldr x0, =1
    ldr x1, =pop_msg
    mov x2, #18
    mov x8, #64
    svc #0

    // Terminar
    mov x8, #93
    svc #0

push:
    // Implementación de push
    // Verificar si la pila está llena antes de apilar
