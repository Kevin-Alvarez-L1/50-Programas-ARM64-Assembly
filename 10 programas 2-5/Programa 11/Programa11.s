//**************************************************************
// Archivo:    Programa11.s
// Proyecto:   11.Suma de los N primeros números naturales
// Autor:      [Kevin Omar Alvarez Hernandez]
// Fecha:      [07/11/2024]
// Descripción:
//             [Suma de los N primeros números naturales]
// 
// Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
// * Todos los derechos reservados.
// * 
// 
// **************************************************************//

.section .text
.global _start

_start:
    // Inicializar el contador y la suma
    mov x1, #0 // Contador
    mov x2, #0 // Suma

loop:
    // Incrementar el contador
    add x1, x1, #1

    // Sumar el contador a la suma
    add x2, x2, x1

    // Comparar el contador con N (argumento en x0)
    cmp x1, x0
    bne loop // Si no es igual, continuar el loop

    // Salir del programa
    mov x0, x2 // Retornar la suma
    mov x8, #93 // Syscall de salida
    svc #0
