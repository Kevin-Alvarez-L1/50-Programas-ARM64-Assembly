//**************************************************************
// Archivo:    Programa48.s
// Proyecto:   48.Medir el tiempo de ejecución de una función
// Autor:      [Kevin Omar Alvarez Hernandez]
// Fecha:      [09/11/2024]
// Descripción:
//             [Medir el tiempo de ejecución de una función]
// 
// Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
// * Todos los derechos reservados.
// * 
// 
// **************************************************************//

.data
    start_time: .space 16        // Espacio para almacenar el tiempo inicial
    end_time:   .space 16        // Espacio para almacenar el tiempo final
    result_msg: .asciz "Tiempo de ejecución (nanosegundos): "
    buffer:     .space 10

.text
    .global _start

_start:
    // Obtener el tiempo de inicio
    mov x0, #0                   // CLOCK_REALTIME
    ldr x1, =start_time
    mov x8, #403                 // clock_gettime syscall
    svc #0

    // Llamar a la función cuyo tiempo quieres medir
    bl function_to_measure

    // Obtener el tiempo de fin
    mov x0, #0
    ldr x1, =end_time
