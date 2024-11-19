//**************************************************************
// Archivo:    Programa12.s
// Proyecto:   12.Factorial de un número
// Autor:      [Kevin Omar Alvarez Hernandez]
// Fecha:      [07/11/2024]
// Descripción:
//             [Factorial de un número]
// 
// Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
// * Todos los derechos reservados.
// * 
// 
// **************************************************************//

// Programa en ARM64 Assembly para calcular el factorial de un número
// Asumimos que el número se pasa como argumento en el registro X0

.section .text
.global _start

_start:
    // Llamar a la función factorial con el argumento en x0
    mov x0, #5 // Ejemplo: calcular el factorial de 5
    bl factorial

    // Salir del programa
    mov x0, x0 // Retornar el resultado
    mov x8, #93 // Syscall de salida
    svc #0

factorial:
    // Condición de parada: si el argumento es 0 o 1, retornar 1
    cmp x0, #0
    beq end
    cmp x0, #1
    beq end

    // Caso recursivo: factorial(n) = n * factorial(n-1)
    mov x1, x0 // Guardar el argumento original
    sub x0, x0, #1 // Decrementar el argumento
    bl factorial // Llamada recursiva
    mul x0, x1, x0 // Multiplicar el resultado por el argumento original

end:
    ret