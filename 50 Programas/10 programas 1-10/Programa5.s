//**************************************************************
// * Archivo:    Programa5.as
// * Proyecto:   División de dos números
// * Autor:      [Kevin Omar Alvarez Hernandez]
// * Fecha:      [05/11/2024]
// * Descripción:
// *             [División de dos números]
// * 
// * 
// * Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
// * Todos los derechos reservados.
// * 
// **************************************************************/

// 5. Division of Two Numbers
// Filename: divide.s
.text
.global _start
_start:
    mov     x19, #100       // Dividend
    mov     x20, #5         // Divisor
    
    udiv    x0, x19, x20    // Unsigned division
    
    // Exit with quotient
    mov     x8, #93
    svc     #0