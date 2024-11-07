//**************************************************************
// * Archivo:    Programa10.as
// * Proyecto:   Leer entrada desde el teclado
// * Autor:      [Kevin Omar Alvarez Hernandez]
// * Fecha:      [05/11/2024]
// * Descripción:
// *             [Leer entrada desde el teclado]
// * 
// * 
// * Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
// *Todos los derechos reservados.
// * 
// **************************************************************/

// 10. Read Keyboard Input
// Filename: keyboard_input.s
.data
    buffer: .skip 100       // Buffer for input
    prompt: .string "Enter text: "
    prompt_len = . - prompt

.text
.global _start
_start:
    // Print prompt
    mov     x0, #1          // stdout
    ldr     x1, =prompt     // prompt string
    mov     x2, #prompt_len // length
    mov     x8, #64         // write syscall
    svc     #0
    
    // Read input
    mov     x0, #0          // stdin
    ldr     x1, =buffer     // buffer address
    mov     x2, #100        // max length
    mov     x8, #63         // read syscall
    svc     #0
    
    // Exit
    mov     x8, #93
    svc     #0