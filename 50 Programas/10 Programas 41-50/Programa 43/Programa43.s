//**************************************************************
// Archivo:    Programa43.s
// Proyecto:   43.Verificar si un número es Armstrong
// Autor:      [Kevin Omar Alvarez Hernandez]
// Fecha:      [09/11/2024]
// Descripción:
//             [Verificar si un número es Armstrong]
// 
// Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
// * Todos los derechos reservados.
// * 
// 
// **************************************************************//

// Verificar si un número es Armstrong
.data
    prompt:    .asciz "Ingrese un numero para verificar si es Armstrong: "
    result_msg: .asciz "El numero es Armstrong"
    error_msg: .asciz "El numero no es Armstrong"
    newline:   .asciz "\n"
    buffer:    .space 100

.text
.global _start

_start:
    // Pedir número
    ldr x0, =1                 // STDOUT
    ldr x1, =prompt            // Mensaje
    mov x2, #45                // Longitud del mensaje
    mov x8, #64                // Syscall 'write'
    svc #0                     // Llamar al sistema

    // Leer el número
    ldr x0, =0                 // STDIN
    ldr x1, =buffer            // Buffer
    mov x2, #100               // Leer hasta 100 caracteres
    mov x8, #63                // Syscall 'read'
    svc #0                     // Llamar al sistema

    // Convertir la entrada a número (esto requiere conversión de cadena a entero)

    // Calcular la suma de los dígitos elevados a la potencia del número de dígitos
    // Comparar con el número original

    // Mostrar si es Armstrong o no
    ldr x0, =1                 // STDOUT
    ldr x1, =result_msg        // Mensaje de resultado si es Armstrong
    mov x2, #25                // Longitud del mensaje
    mov x8, #64                // Syscall 'write'
    svc #0                     // Llamar al sistema

    // Terminar el programa
    mov x8, #93                // Syscall 'exit'
    svc #0                     // Llamar al sistema
