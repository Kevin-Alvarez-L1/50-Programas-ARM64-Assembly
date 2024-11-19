//**************************************************************
// Archivo:    Programa30.s
// Proyecto:   30.Máximo Común Divisor (MCD)
// Autor:      [Kevin Omar Alvarez Hernandez]
// Fecha:      [09/11/2024]
// Descripción:
//             [Máximo Común Divisor (MCD)]
// 
// Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
// * Todos los derechos reservados.
// * 
// 
// **************************************************************//

// Programa para calcular el MCD usando el algoritmo de Euclides en ARM64
.data
    num1:       .word   48              // Primer número
    num2:       .word   36              // Segundo número
    msg1:       .asciz  "Número 1: "
    msg2:       .asciz  "\nNúmero 2: "
    msg3:       .asciz  "\nMáximo Común Divisor: "
    newline:    .asciz  "\n"

.text
.global _start

_start:
    // Cargar números
    ldr x19, =num1
    ldr x19, [x19]           // Primer número en x19
    ldr x20, =num2
    ldr x20, [x20]           // Segundo número en x20
    
    // Mostrar números originales
    ldr x0, =msg1
    bl print_string
    mov x0, x19
    bl print_num
    
    ldr x0, =msg2
    bl print_string
    mov x0, x20
    bl print_num
    
    // Calcular MCD usando algoritmo de Euclides
gcd_loop:
    cbz x20, gcd_done        // Si b == 0, terminar
    
    // a = a % b
    udiv x21, x19, x20       // x21 = a / b
    msub x21, x21, x20, x19  // x21 = a - (a / b) * b (resto)
    
    // Intercambiar a y b
    mov x19, x20             // a = b
    mov x20, x21             // b = resto
    
    b gcd_loop
    
gcd_done:
    // Mostrar resultado
    ldr x0, =msg3
    bl print_string
    mov x0, x19              // MCD está en x19
    bl print_num
    
    ldr x0, =newline
    bl print_string
    
    // Salir
    mov x8, #93
    mov x0, #0
    svc #0

// Las funciones print_num y print_string son las mismas que en programas anteriores