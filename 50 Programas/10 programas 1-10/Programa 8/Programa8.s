//**************************************************************
// * Archivo:    Programa8.as
// * Proyecto:   Calcular la longitud de una cadena
// * Autor:      [Kevin Omar Alvarez Hernandez]
// * Fecha:      [05/11/2024]
// * Descripción:
// *             [Calcular la longitud de una cadena]
// * 
// * 
// * Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
// * Todos los derechos reservados.
// * 
// **************************************************************/

// 8. Calculate String Length
// Filename: strlen.s
.data
    test_str: .string "Hello, ARM64!"

.text
.global _start
_start:
    ldr     x0, =test_str   // Load string address
    mov     x19, #0         // Initialize counter
    
length_loop:
    ldrb    w20, [x0, x19]  // Load character
    cbz     w20, end_count  // If null, end counting
    add     x19, x19, #1    // Increment counter
    b       length_loop
    
end_count:
    mov     x0, x19         // Move length to x0 for exit
    mov     x8, #93
    svc     #0