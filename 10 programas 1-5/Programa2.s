//**************************************************************
// * Archivo:    Programa2.as
// * Proyecto:   Suma de dos números
// * Autor:      [Kevin Omar Alvarez Hernandez]
// * Fecha:      [05/11/2024]
// * Descripción:
// *             [Suma de dos númeroso]
// * 
// * 
// * Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
// * Todos los derechos reservados.
// * 
// * 
// **************************************************************/

// 2. Sum of Two Numbers
// Filename: sum.s
.text
.global _start
_start:
    mov     x19, #15        // First number
    mov     x20, #27        // Second number
    
    add     x0, x19, x20    // Add numbers
    
    // Exit with sum
    mov     x8, #93
    svc     #0



// 4. Multiplication of Two Numbers
// Filename: multiply.s
.text
.global _start
_start:
    mov     x19, #12        // First number
    mov     x20, #5         // Second number
    
    mul     x0, x19, x20    // Multiply numbers
    
    // Exit with product
    mov     x8, #93
    svc     #0