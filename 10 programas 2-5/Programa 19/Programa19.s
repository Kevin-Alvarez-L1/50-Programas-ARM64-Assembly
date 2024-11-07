//**************************************************************
// Archivo:    Programa19.s
// Proyecto:   19.Búsqueda lineal
// Autor:      [Kevin Omar Alvarez Hernandez]
// Fecha:      [07/11/2024]
// Descripción:
//             [Búsqueda lineal]
// 
// Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
// * Todos los derechos reservados.
// * 
// 
// **************************************************************//

// Programa en ARM64 Assembly para realizar una búsqueda lineal en un arreglo de enteros
// Asumimos que la dirección del arreglo se pasa como argumento en el registro X0
// el tamaño del arreglo se pasa en el registro X1
// y el valor a buscar se pasa en el registro X2

.section .text
.global _start

_start:
    // Pasar la dirección del arreglo en x0, el tamaño en x1 y el valor a buscar en x2
    ldr x0, =arr
    mov x1, #5
    mov x2, #9

    bl linear_search

    // Salir del programa
    mov x0, x0 // Retornar el índice del elemento encontrado, o -1 si no se encontró
    mov x8, #93 // Syscall de salida
    svc #0

linear_search:
    mov x3, #0 // Contador

loop:
    // Comparar el elemento actual del arreglo con el valor a buscar
    cmp x3, x1
    beq not_found
    ldr x4, [x0, x3, lsl #3] // Cargar el elemento actual del arreglo
    cmp x4, x2
    beq found
    add x3, x3, #1 // Incrementar el contador
    b loop

found:
    mov x0, x3 // Retornar el índice del elemento encontrado
    b end

not_found:
    mov x0, #-1 // Retornar -1 si no se encontró el elemento

end:
    ret

.data
arr: .quad 5, 2, 9, 1, 7