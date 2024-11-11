//**************************************************************
// Archivo:    Programa28.s
// Proyecto:   28.Establecer, borrar y alternar bits
// Autor:      [Kevin Omar Alvarez Hernandez]
// Fecha:      [09/11/2024]
// Descripción:
//             [Establecer, borrar y alternar bits]
// 
// Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
// * Todos los derechos reservados.
// * 
// 
// **************************************************************//

// Programa para manipular bits individuales en ARM64
.data
    number:     .quad   0b10101010       // Número inicial
    msg1:       .asciz  "Número original: "
    msg2:       .asciz  "\nEstablecer bit 3: "
    msg3:       .asciz  "\nBorrar bit 4: "
    msg4:       .asciz  "\nAlternar bit 5: "
    newline:    .asciz  "\n"

.text
.global _start

_start:
    // Cargar número original
    ldr x19, =number
    ldr x19, [x19]
    
    // Mostrar número original
    ldr x0, =msg1
    bl print_string
    mov x0, x19
    bl print_binary
    
    // Establecer bit 3 (OR con máscara)
    mov x20, x19
    mov x21, #1
    lsl x21, x21, #3         // Crear máscara 0...01000
    orr x20, x20, x21        // OR para establecer el bit
    
    ldr x0, =msg2
    bl print_string
    mov x0, x20
    bl print_binary
    
    // Borrar bit 4 (AND con máscara invertida)
    mov x20, x19
    mov x21, #1
    lsl x21, x21, #4         // Crear máscara 0...010000
    mvn x21, x21             // Invertir máscara
    and x20, x20, x21        // AND para borrar el bit
    
    ldr x0, =msg3
    bl print_string
    mov x0, x20
    bl print_binary
    
    // Alternar bit 5 (XOR con máscara)
    mov x20, x19
    mov x21, #1
    lsl x21, x21, #5         // Crear máscara 0...0100000
    eor x20, x20, x21        // XOR para alternar el bit
    
    ldr x0, =msg4
    bl print_string
    mov x0, x20
    bl print_binary
    
    // Salir
    mov x8, #93
    mov x0, #0
    svc #0

// Las funciones print_binary y print_string son las mismas que en programas anteriores