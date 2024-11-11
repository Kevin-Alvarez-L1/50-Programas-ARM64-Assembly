//**************************************************************
// Archivo:    Programa23.s
// Proyecto:   23.Suma de matrices
// Autor:      [Kevin Omar Alvarez Hernandez]
// Fecha:      [09/11/2024]
// Descripción:
//             [Suma de matrices]
// 
// Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
// * Todos los derechos reservados.
// * 
// 
// **************************************************************//

// Programa de Suma de Matrices en ARM64
.data
    matrix1:    .word   1, 2, 3, 4, 5, 6, 7, 8, 9        // Matriz 3x3
    matrix2:    .word   9, 8, 7, 6, 5, 4, 3, 2, 1        // Matriz 3x3
    result:     .space  36                                // Espacio para resultado (9 * 4 bytes)
    size:       .word   3                                 // Tamaño N de la matriz NxN
    msg1:       .asciz  "Matriz 1:\n"
    msg2:       .asciz  "\nMatriz 2:\n"
    msg3:       .asciz  "\nMatriz Resultado:\n"
    space:      .asciz  " "
    newline:    .asciz  "\n"

.text
.global _start

_start:
    // Imprimir primera matriz
    ldr x0, =msg1
    bl print_string
    
    ldr x19, =matrix1          // Base de matriz1
    bl print_matrix
    
    // Imprimir segunda matriz
    ldr x0, =msg2
    bl print_string
    
    ldr x19, =matrix2          // Base de matriz2
    bl print_matrix
    
    // Sumar