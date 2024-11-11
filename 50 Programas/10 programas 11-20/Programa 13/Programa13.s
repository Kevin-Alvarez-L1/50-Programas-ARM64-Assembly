//**************************************************************
// Archivo:    Programa13.s
// Proyecto:   13.Serie de Fibonacci
// Autor:      [Kevin Omar Alvarez Hernandez]
// Fecha:      [07/11/2024]
// Descripción:
//             [Serie de Fibonacci]
// 
// Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
// * Todos los derechos reservados.
// * 
// 
// **************************************************************//

// Programa en ARM64 Assembly para calcular los primeros N números de la serie de Fibonacci
// Asumimos que N se pasa como argumento en el registro X0

.section .text
.global _start

_start:
    // Llamar a la función fibonacci con el argumento en x0
    mov x0, #10 // Ejemplo: calcular los primeros 10 números de Fibonacci
    bl fibonacci

    // Salir del programa
    mov x0, x0 // Retornar el resultado
    mov x8, #93 // Syscall de salida
    svc #0

fibonacci:
    // Condición de parada: si el argumento es 0 o 1, retornar el mismo argumento
    cmp x0, #0
    beq end
    cmp x0, #1
    beq end

    // Caso recursivo: fibonacci(n) = fibonacci(n-1) + fibonacci(n-2)
    mov x1, x0 // Guardar el argumento original
    sub x0, x0, #1 // Decrementar el argumento para la primera llamada recursiva
    bl fibonacci // Primera llamada recursiva
    mov x2, x0 // Guardar el resultado de la primera llamada

    mov x0, x1 // Restaurar el argumento original
    sub x0, x0, #2 // Decrementar el argumento para la segunda llamada recursiva
    bl fibonacci // Segunda llamada recursiva
    add x0, x0, x2 // Sumar los resultados de las dos llamadas recursivas

end:
    ret