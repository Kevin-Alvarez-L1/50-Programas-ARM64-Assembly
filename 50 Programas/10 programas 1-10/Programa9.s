//**************************************************************
// * Archivo:    Programa9.as
// * Proyecto:   Suma de elementos en un arreglo
// * Autor:      [Kevin Omar Alvarez Hernandez]
// * Fecha:      [05/11/2024]
// * Descripción:
// *             [Suma de elementos en un arreglo]
// * 
// * 
// * Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
// * Todos los derechos reservados.
// * 
// **************************************************************/

// 9. Sum of Array Elements
// Filename: array_sum.s
.data
    array:  .quad   1, 2, 3, 4, 5, 6, 7, 8, 9, 10
    length: .quad   10

.text
.global _start
_start:
    ldr     x0, =array      // Load array address
    ldr     x1, =length     // Load length address
    ldr     x1, [x1]        // Load actual length value
    mov     x19, #0         // Initialize sum
    
sum_loop:
    ldr     x20, [x0], #8   // Load element and increment pointer
    add     x19, x19, x20   // Add to sum
    subs    x1, x1, #1      // Decrement counter
    b.ne    sum_loop        // Continue if not zero
    
    mov     x0, x19         // Move sum to x0 for exit
    mov     x8, #93
    svc     #0