//**************************************************************
// * Archivo:    Programa3.as
// * Proyecto:   Resta de dos números
// * Autor:      [Kevin Omar Alvarez Hernandez]
// * Fecha:      [05/11/2024]
// * Descripción:
// *             [Resta de dos números]
// * 
// * 
// * Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
// * Todos los derechos reservados.
// * 
//**************************************************************/

// 3. Subtraction of Two Numbers
// Filename: subtract.s
.text
.global _start
_start:
    mov     x19, #50        // First number
    mov     x20, #30        // Second number
    
    sub     x0, x19, x20    // Subtract x20 from x19
    
    // Exit with difference
    mov     x8, #93
    svc     #0