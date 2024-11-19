//**************************************************************
// * Archivo:    Programa4.as
// * Proyecto:   Multiplicación de dos números
// * Autor:      [Kevin Omar Alvarez Hernandez]
// * Fecha:      [05/11/2024]
// * Descripción:
// *             [Multiplicación de dos números]
// * 
// * 
// * Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
// * Todos los derechos reservados.
// * 
//**************************************************************/

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