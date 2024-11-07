//**************************************************************
// * Archivo:    Programa7.as
// * Proyecto:   Conversión de entero a ASCII
// * Autor:      [Kevin Omar Alvarez Hernandez]
// * Fecha:      [05/11/2024]
// * Descripción:
// *             [Conversión de entero a ASCII]
// * 
// * 
// * Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
// * Todos los derechos reservados.
// * 
// **************************************************************/

// 7. Integer to ASCII Conversion
// Filename: int_to_ascii.s
.data
    buffer: .skip 12        // Buffer for ASCII result
    
.text
.global _start
_start:
    mov     x19, #12345     // Number to convert
    ldr     x0, =buffer     // Load buffer address
    add     x0, x0, #11     // Start from end of buffer
    mov     w1, #0          // Null terminator
    strb    w1, [x0]        // Store null terminator
    mov     x21, #10        // Divisor
    
convert_loop2:
    sub     x0, x0, #1      // Move pointer back
    udiv    x22, x19, x21   // Divide by 10
    msub    x23, x22, x21, x19  // Get remainder
    add     w23, w23, #48   // Convert to ASCII
    strb    w23, [x0]       // Store ASCII char
    mov     x19, x22        // Update number
    cbnz    x19, convert_loop2   // Continue if number isn't 0
    
    // Exit
    mov     x0, #0
    mov     x8, #93
    svc     #0