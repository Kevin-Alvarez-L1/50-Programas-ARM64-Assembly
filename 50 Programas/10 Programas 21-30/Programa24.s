//**************************************************************
// Archivo:    Programa24.s
// Proyecto:   24.Transposición de una matriz
// Autor:      [Kevin Omar Alvarez Hernandez]
// Fecha:      [09/11/2024]
// Descripción:
//             [Transposición de una matriz]
// 
// Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
// * Todos los derechos reservados.
// * 
// 
// **************************************************************//

// Programa de Transposición de Matriz en ARM64
.data
    matrix:     .word   1, 2, 3, 4, 5, 6, 7, 8, 9    // Matriz 3x3 original
    result:     .space  36                            // Matriz resultado (9 * 4 bytes)
    size:       .word   3                             // Tamaño N de la matriz NxN
    msg1:       .asciz  "Matriz Original:\n"
    msg2:       .asciz  "\nMatriz Transpuesta:\n"
    space:      .asciz  " "
    newline:    .asciz  "\n"

.text
.global _start

_start:
    // Imprimir matriz original
    ldr x0, =msg1
    bl print_string
    
    ldr x19, =matrix           // Base de matriz original
    bl print_matrix
    
    // Realizar transposición
    ldr x0, =size
    ldr x0, [x0]              // N = tamaño de la matriz
    mov x1, #0                // i = 0
    
outer_loop:
    mov x2, #0                // j = 0
    
inner_loop:
    // Calcular índices origen y destino
    mul x3, x1, x0            // i * N
    add x3, x3, x2            // i * N + j (índice origen)
    
    mul x4, x2, x0            // j * N
    add x4, x4, x1            // j * N + i (índice destino)
    
    // Copiar elemento
    ldr x5, =matrix
    ldr x6, [x5, x3, lsl #2]  // Cargar elemento original
    ldr x7, =result
    str x6, [x7, x4, lsl #2]  // Guardar en posición transpuesta
    
    add x2, x2, #1            // j++
    cmp x2, x0                // Comparar j con N
    b.lt inner_loop
    
    add x1, x1, #1            // i++
    cmp x1, x0                // Comparar i con N
    b.lt outer_loop
    
    // Imprimir matriz transpuesta
    ldr x0, =msg2
    bl print_string
    
    ldr x19, =result          // Base de matriz resultado
    bl print_matrix
    
    // Salir del programa
    mov x8, #93               // syscall exit
    mov x0, #0
    svc #0

print_matrix:
    // Rutina para imprimir matriz
    stp x29, x30, [sp, #-16]!
    stp x19, x20, [sp, #-16]!
    
    ldr x20, =size
    ldr x20, [x20]            // N = tamaño
    mov x21, #0               // i = 0
    
print_row:
    mov x22, #0               // j = 0
    
print_col:
    mul x23, x21, x20         // i * N
    add x23, x23, x22         // (i * N) + j
    ldr x0, [x19, x23, lsl #2]
    bl print_num
    
    ldr x0, =space
    bl print_string
    
    add x22, x22, #1          // j++
    cmp x22, x20
    b.lt print_col
    
    ldr x0, =newline
    bl print_string
    
    add x21, x21, #1          // i++
    cmp x21, x20
    b.lt print_row
    
    ldp x19, x20, [sp], #16
    ldp x29, x30, [sp], #16
    ret

// Las funciones print_num y print_string son las mismas que en programas anteriores