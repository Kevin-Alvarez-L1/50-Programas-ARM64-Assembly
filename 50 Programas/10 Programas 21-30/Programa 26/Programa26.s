//**************************************************************
// Archivo:    Programa26.s
// Proyecto:   26.Operaciones AND, OR, XOR a nivel de bits
// Autor:      [Kevin Omar Alvarez Hernandez]
// Fecha:      [09/11/2024]
// Descripción:
//             [Operaciones AND, OR, XOR a nivel de bits]
// 
// Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
// * Todos los derechos reservados.
// * 
// 
// **************************************************************//

// Programa de operaciones a nivel de bits en ARM64
.data
    num1:       .quad   0b1100           // Primer número (12 en binario)
    num2:       .quad   0b1010           // Segundo número (10 en binario)
    msg1:       .asciz  "Número 1 (binario): "
    msg2:       .asciz  "\nNúmero 2 (binario): "
    msg3:       .asciz  "\nAND resultado: "
    msg4:       .asciz  "\nOR resultado: "
    msg5:       .asciz  "\nXOR resultado: "
    newline:    .asciz  "\n"

.text
.global _start

_start:
    // Cargar números
    ldr x19, =num1
    ldr x19, [x19]            // Primer número
    ldr x20, =num2
    ldr x20, [x20]            // Segundo número
    
    // Mostrar números originales
    ldr x0, =msg1
    bl print_string
    mov x0, x19
    bl print_binary
    
    ldr x0, =msg2
    bl print_string
    mov x0, x20
    bl print_binary
    
    // Realizar AND
    and x21, x19, x20
    ldr x0, =msg3
    bl print_string
    mov x0, x21
    bl print_binary
    
    // Realizar OR
    orr x21, x19, x20
    ldr x0, =msg4
    bl print_string
    mov x0, x21
    bl print_binary
    
    // Realizar XOR
    eor x21, x19, x20
    ldr x0, =msg5
    bl print_string
    mov x0, x21
    bl print_binary
    
    // Salir
    mov x8, #93
    mov x0, #0
    svc #0

print_binary:
    // Rutina para imprimir número en binario
    stp x29, x30, [sp, #-16]!
    stp x19, x20, [sp, #-16]!
    
    mov x19, x0               // Guardar número
    mov x20, #63              // Empezar desde el bit 63
    
print_bit:
    lsr x0, x19, x20         // Desplazar a la derecha
    and x0, x0, #1           // Aislar bit menos significativo
    add x0, x0, #'0'         // Convertir a ASCII
    bl print_char
    
    sub x20, x20, #1         // Siguiente bit
    cmp x20, #-1
    b.ne print_bit
    
    ldp x19, x20, [sp], #16
    ldp x29, x30, [sp], #16
    ret

print_char:
    // Rutina para imprimir un carácter
    stp x29, x30, [sp, #-16]!
    
    mov x1, sp               // Usar stack como buffer
    strb w0, [x1]           // Guardar carácter
    mov x0, #1              // STDOUT
    mov x2, #1              // Longitud 1
    mov x8, #64             // syscall write
    svc #0
    
    ldp x29, x30, [sp], #16
    ret

// Las funciones print_string son las mismas que en programas anteriores