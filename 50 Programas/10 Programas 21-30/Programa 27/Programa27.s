//**************************************************************
// Archivo:    Programa27.s
// Proyecto:   27.Desplazamientos a la izquierda y derecha
// Autor:      [Kevin Omar Alvarez Hernandez]
// Fecha:      [09/11/2024]
// Descripción:
//             [Desplazamientos a la izquierda y derecha]
// 
// Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
// * Todos los derechos reservados.
// * 
// 
// **************************************************************//

// Programa de desplazamientos de bits en ARM64
.data
    number:     .quad   0b1100           // Número inicial (12 en binario)
    msg1:       .asciz  "Número original (binario): "
    msg2:       .asciz  "\nDesplazamiento izquierdo 2 bits: "
    msg3:       .asciz  "\nDesplazamiento derecho lógico 1 bit: "
    msg4:       .asciz  "\nDesplazamiento derecho aritmético 1 bit: "
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
    
    // Desplazamiento izquierdo (LSL)
    lsl x20, x19, #2         // Desplazar 2 bits a la izquierda
    ldr x0, =msg2
    bl print_string
    mov x0, x20
    bl print_binary
    
    // Desplazamiento derecho lógico (LSR)
    lsr x20, x19, #1         // Desplazar 1 bit a la derecha
    ldr x0, =msg3
    bl print_string
    mov x0, x20
    bl print_binary
    
    // Desplazamiento derecho aritmético (ASR)
    asr x20, x19, #1         // Desplazar 1 bit a la derecha manteniendo el signo
    ldr x0, =msg4
    bl print_string
    mov x0, x20
    bl print_binary
    
    // Salir
    mov x8, #93
    mov x0, #0
    svc #0

// Las funciones print_binary y print_string son las mismas que en el programa anterior