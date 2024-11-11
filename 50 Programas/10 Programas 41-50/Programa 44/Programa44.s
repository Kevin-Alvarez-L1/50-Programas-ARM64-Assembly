//**************************************************************
// Archivo:    Programa44.s
// Proyecto:   44.Encontrar prefijo común más largo en cadenas
// Autor:      [Kevin Omar Alvarez Hernandez]
// Fecha:      [09/11/2024]
// Descripción:
//             [Encontrar prefijo común más largo en cadenas]
// 
// Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
// * Todos los derechos reservados.
// * 
// 
// **************************************************************//

// Encontrar el prefijo común más largo
.data
    prompt:    .asciz "Ingrese dos cadenas (separadas por espacio): "
    result_msg: .asciz "El prefijo comun es: "
    newline:   .asciz "\n"
    buffer1:   .space 100
    buffer2:   .space 100

.text
.global _start

_start:
    // Leer las cadenas
    ldr x0, =1                 // STDOUT
    ldr x1, =prompt            // Mensaje
    mov x2, #39                // Longitud del mensaje
    mov x8, #64                // Syscall 'write'
    svc #0                     // Llamar al sistema

    // Leer primera cadena
    ldr x0, =0                 // STDIN
    ldr x1, =buffer1           // Buffer
    mov x2, #100               // Leer hasta 100 caracteres
    mov x8, #63                // Syscall 'read'
    svc #0                     // Llamar al sistema

    // Leer segunda cadena
    ldr x0, =0                 // STDIN
    ldr x1, =buffer2           // Buffer
    mov x2, #100               // Leer hasta 100 caracteres
    mov x8, #63                // Syscall 'read'
    svc #0                     // Llamar al sistema

    // Comparar las cadenas y encontrar el prefijo común
    // Aquí se debe comparar caracter por caracter

    // Mostrar el prefijo común
    ldr x0, =1                 // STDOUT
    ldr x1, =result_msg        // Mensaje de resultado
    mov x2, #23                // Longitud del mensaje
    mov x8, #64                // Syscall 'write'
    svc #0                     // Llamar al sistema

    // Terminar el programa
    mov x8, #93                // Syscall 'exit'
    svc #0                     // Llamar al sistema
