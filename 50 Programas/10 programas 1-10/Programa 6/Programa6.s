//**************************************************************
// * Archivo:    Programa6.as
// * Proyecto:   Conversión de ASCII a entero
// * Autor:      [Kevin Omar Alvarez Hernandez]
// * Fecha:      [05/11/2024]
// * Descripción:
// *             [Conversión de ASCII a entero]
// * 
// * 
// * Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
// * Todos los derechos reservados.
// * 
// **************************************************************/

// 6. ASCII to Integer Conversion
// Filename: ascii_to_int.s
.data
    ascii_num: .string "123"   // ASCII string to convert

.text
.global _start
_start:
    ldr     x0, =ascii_num  // Load address of string
    mov     x19, #0         // Initialize result
    
convert_loop:
    ldrb    w20, [x0], #1   // Load byte and increment pointer
    cbz     w20, done       // If null terminator, exit loop
    
    sub     w20, w20, #48   // Convert ASCII to number (subtract '0')
    
    // result = result * 10 + digit
    mov     x21, #10
    mul     x19, x19, x21
    add     x19, x19, x20
    b       convert_loop
    
done:
    mov     x0, x19         // Move result to x0 for exit
    mov     x8, #93
    svc     #0
