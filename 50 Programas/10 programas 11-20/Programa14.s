//**************************************************************
// Archivo:    Programa14.s
// Proyecto:   14.Verificar si un número es primo
// Autor:      [Kevin Omar Alvarez Hernandez]
// Fecha:      [07/11/2024]
// Descripción:
//             [Verificar si un número es primo]
// 
// Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
// * Todos los derechos reservados.
// * 
// 
// **************************************************************//

// Programa en ARM64 Assembly para verificar si un número es primo
// Asumimos que el número se pasa como argumento en el registro X0

.section .text
.global _start

_start:
    // Llamar a la función is_prime con el argumento en x0
    mov x0, #7 // Ejemplo: verificar si 7 es primo
    bl is_prime

    // Salir del programa
    mov x0, x0 // Retornar el resultado
    mov x8, #93 // Syscall de salida
    svc #0

is_prime:
    // Condición de parada: si el argumento es 0, 1 o 2, retornar 0 (no es primo)
    cmp x0, #0
    beq end
    cmp x0, #1
    beq end
    cmp x0, #2
    beq is_prime_end

    // Inicializar el divisor en 2
    mov x1, #2

loop:
    // Comparar el divisor con el número
    cmp x1, x0
    bge is_prime_end // Si el divisor es mayor o igual al número, es primo

    // Calcular el módulo del número con el divisor
    udiv x2, x0, x1
    msub x2, x2, x1, x0

    // Si el módulo es 0, no es primo
    cmp x2, #0
    beq end

    // Incrementar el divisor
    add x1, x1, #1
    b loop

is_prime_end:
    mov x0, #1 // Retornar 1 (es primo)
    b end

end:
    mov x0, x0 // Retornar 0 (no es primo)
    ret