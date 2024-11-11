//**************************************************************
// Archivo:    Programa16.s
// Proyecto:   16.Invertir una cadena
// Autor:      [Kevin Omar Alvarez Hernandez]
// Fecha:      [07/11/2024]
// Descripción:
//             [Verificar si una cadena es palíndromo]
// 
// Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
// * Todos los derechos reservados.
// * 
// 
// **************************************************************//

// Programa en ARM64 Assembly para verificar si una cadena de caracteres es palíndromo
// Asumimos que la dirección de la cadena se pasa como argumento en el registro X0

.section .text
.global _start

_start:
    // Pasar la dirección de la cadena como argumento en x0
    ldr x0, =cadena

    bl is_palindrome

    // Salir del programa
    mov x0, x0 // Retornar el resultado
    mov x8, #93 // Syscall de salida
    svc #0

is_palindrome:
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

    // Comparar caracteres mientras los punteros no se crucen
check:
    ldrb w3, [x1]
    ldrb w4, [x2]
    cmp w3, w4
    bne not_palindrome
    add x1, x1, #1
    sub x2, x2, #1
    cmp x1, x2
    blt check

    // Si llegamos aquí, es palíndromo
palindrome:
    mov x0, #1
    b end_func

not_palindrome:
    mov x0, #0

end_func:
    ret