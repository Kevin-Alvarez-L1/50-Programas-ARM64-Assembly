//**************************************************************
// Archivo:    Programa42.s
// Proyecto:   42.Generación de números aleatorios (con semilla)
// Autor:      [Kevin Omar Alvarez Hernandez]
// Fecha:      [09/11/2024]
// Descripción:
//             [Generación de números aleatorios (con semilla)]
// 
// Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
// * Todos los derechos reservados.
// * 
// 
// **************************************************************//

// Generación de números aleatorios con semilla
.data
    prompt:    .asciz "Ingrese una semilla para generar un numero aleatorio: "
    result_msg: .asciz "El numero aleatorio generado es: "
    newline:   .asciz "\n"
    buffer:    .space 100

.text
.global _start

_start:
    // Pedir semilla
    ldr x0, =1                 // STDOUT
    ldr x1, =prompt            // Mensaje
    mov x2, #39                // Longitud del mensaje
    mov x8, #64                // Syscall 'write'
    svc #0                     // Llamar al sistema

    // Leer la semilla
    ldr x0, =0                 // STDIN
    ldr x1, =buffer            // Buffer
    mov x2, #100               // Leer hasta 100 caracteres
    mov x8, #63                // Syscall 'read'
    svc #0                     // Llamar al sistema

    // Convertir la entrada a número (esto requiere conversión de cadena a entero)

    // Generación del número aleatorio (por ejemplo, utilizando un LCG: Xn+1 = (a * Xn + c) % m)
    // La semilla es el valor inicial

    // Mostrar el resultado
    ldr x0, =1                 // STDOUT
    ldr x1, =result_msg        // Mensaje de resultado
    mov x2, #29                // Longitud del mensaje
    mov x8, #64                // Syscall 'write'
    svc #0                     // Llamar al sistema

    // Terminar el programa
    mov x8, #93                // Syscall 'exit'
    svc #0                     // Llamar al sistema
