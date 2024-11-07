//**************************************************************
// Archivo:    Programa15.s
// Proyecto:   15.Invertir una cadena
// Autor:      [Kevin Omar Alvarez Hernandez]
// Fecha:      [07/11/2024]
// Descripción:
//             [Invertir una cadena]
// 
// Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
// * Todos los derechos reservados.
// * 
// 
// **************************************************************//

// Programa en ARM64 Assembly para invertir una cadena de caracteres
// Asumimos que la dirección de la cadena se pasa como argumento en el registro X0

.section .text
.global _start

_start:
    // Pasar la dirección de la cadena como argumento en x0
    ldr x0, =cadena

    bl reverse_string

    // Salir del programa
    mov x0, x0 // Retornar la dirección de la cadena invertida
    mov x8, #93 // Syscall de salida
    svc #0

reverse_string:
    // Inicializar punteros al inicio y final de la cadena
    mov x1, x0 // Inicio
    mov x2, x0 // Final

    // Encontrar el final de la cadena
loop:
    ldrb w3, [x2]
    cmp w3, #0
    beq end
    add x2, x2, #1
    b loop

end:
    sub x2, x2, #1 // Retroceder un carácter para apuntar al último carácter

    // Intercambiar caracteres mientras los punteros no se crucen
swap:
    ldrb w3, [x1]
    ldrb w4, [x2]
    strb w4, [x1]
    strb w3, [x2]
    add x1, x1, #1
    sub x2, x2, #1
    cmp x1, x2
    blt swap

    // Retornar la dirección de la cadena invertida
    mov x0, x0
    ret