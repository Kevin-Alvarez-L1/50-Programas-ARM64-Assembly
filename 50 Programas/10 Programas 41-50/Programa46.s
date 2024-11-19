//**************************************************************
// Archivo:    Programa46.s
// Proyecto:   46.Escribir en un archivo
// Autor:      [Kevin Omar Alvarez Hernandez]
// Fecha:      [09/11/2024]
// Descripción:
//             [Escribir en un archivo]
// 
// Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
// * Todos los derechos reservados.
// * 
// 
// **************************************************************//

// Escribir en un archivo
.data
    filename: .asciz "output.txt"
    msg:      .asciz "Este es un mensaje en el archivo."

.text
.global _start

_start:
    // Abrir el archivo
    // Escribir el mensaje
    // Cerrar el archivo

    // Terminar el programa
    mov x8, #93                // Syscall 'exit'
    svc #0                     // Llamar al sistema
