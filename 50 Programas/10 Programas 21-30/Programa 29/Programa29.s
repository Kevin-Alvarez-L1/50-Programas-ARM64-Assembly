//**************************************************************
// Archivo:    Programa29.s
// Proyecto:   29.Contar los bits activados en un número
// Autor:      [Kevin Omar Alvarez Hernandez]
// Fecha:      [09/11/2024]
// Descripción:
//             [Contar los bits activados en un número]
// 
// Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
// * Todos los derechos reservados.
// * 
// 
// **************************************************************//

// Programa para contar bits activados en ARM64
.data
    number:     .quad   0b11010110       // Número a analizar
    msg1:       .asciz  "Número (binario): "
    msg2:       .asciz  "\nCantidad de bits activados: "
    newline:    .asciz  "\n"

.text
.global _start

_start:
    // Cargar número
    ldr x19, =number
    ldr x19, [x19]
    
    // Mostrar número en binario
    ldr x0, =msg1
    bl print_string
    mov x0, x19
    bl print_binary
    
    // Contar bits activados
    mov x20, x19             // Copia del número
    mov x21, #0              // Contador de bits
    
count_loop:
    cbz x20, print_result    // Si el número es 0, terminar
    and x22, x20, #1         // Obtener bit menos significativo
    add x21, x21, x22        // Incrementar contador si el bit es 1
    lsr x20, x20, #1         // Desplazar a la derecha
    b count_loop
    
print_result:
    ldr x0, =msg2
    bl print_string
    mov x0, x21
    bl print_num
    
    ldr x0, =newline
    bl print_string
    
    // Salir
    mov x8, #93
    mov x0, #0
    svc #0

// Las funciones print_binary, print_num y print_string son las mismas que en programas anteriores