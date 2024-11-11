//**************************************************************
// Archivo:    Programa45.s
// Proyecto:   45.Detección de desbordamiento en sumas
// Autor:      [Kevin Omar Alvarez Hernandez]
// Fecha:      [09/11/2024]
// Descripción:
//             [Detección de desbordamiento en sumas]
// 
// Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
// * Todos los derechos reservados.
// * 
// 
// **************************************************************//

// Detección de desbordamiento en suma
.data
    prompt:    .asciz "Ingrese dos numeros para sumar: "
    result_msg: .asciz "La suma no ha causado desbordamiento"
    error_msg: .asciz "Desbordamiento detectado"
    newline:   .asciz "\n"
    buffer:    .space 100

.text
.global _start

_start:
    // Leer dos números y verificar el desbordamiento

    // Realizar la suma
    // Verificar si el resultado desborda el tamaño del registro

    // Mostrar el resultado
    ldr x0, =1                 // STDOUT
    ldr x1, =result_msg        // Mensaje si no hay desbordamiento
    mov x2, #34                // Longitud del mensaje
    mov x8, #64                // Syscall 'write'
    svc #0                     // Llamar al sistema

    // Terminar el programa
    mov x8, #93                // Syscall 'exit'
    svc #0                     // Llamar al sistema
