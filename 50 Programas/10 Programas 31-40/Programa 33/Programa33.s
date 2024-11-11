//**************************************************************
// Archivo:    Programa33.s
// Proyecto:   33.Implementar una cola usando un arreglo
// Autor:      [Kevin Omar Alvarez Hernandez]
// Fecha:      [09/11/2024]
// Descripción:
//             [Implementar una cola usando un arreglo]
// 
// Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
// * Todos los derechos reservados.
// * 
// 
// **************************************************************//

.data
    queue:    .space 40           // Espacio para una cola de 10 enteros
    front:    .word 0             // Índice del frente de la cola
    rear:     .word 0             // Índice del final de la cola
    enqueue_msg: .asciz "Ingrese el número a encolar: "
    dequeue_msg: .asciz "Número desencolado: "
    buffer:   .space 10           // Para leer la entrada

.text
    .global _start

_start:
    // Enqueue
    ldr x0, =1
    ldr x1, =enqueue_msg
    mov x2, #24
    mov x8, #64
    svc #0

    // Leer el número a encolar
    ldr x0, =0
    ldr x1, =buffer
    mov x2, #10
    mov x8, #63
    svc #0

    // Convertir de ASCII a número y encolar
    ldr x0, =buffer
    bl atoi
    bl enqueue

    // Dequeue
    bl dequeue
    bl itoa

    // Mostrar el número desencolado
    ldr x0, =1
    ldr x1, =dequeue_msg
    mov x2, #18
    mov x8, #64
    svc #0

    // Terminar
    mov x8, #93
    svc #0

enqueue:
    // Implementación de enqueue
    // Verificar si la cola está llena antes de insertar

dequeue:
    // Implementación de dequeue
    // Verificar si la cola está vacía antes de desencolar
