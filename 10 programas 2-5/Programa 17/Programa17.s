//**************************************************************
// Archivo:    Programa17.s
// Proyecto:   17.Encontrar el máximo en un arreglo
// Autor:      [Kevin Omar Alvarez Hernandez]
// Fecha:      [07/11/2024]
// Descripción:
//             [Encontrar el máximo en un arreglo]
// 
// Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
// * Todos los derechos reservados.
// * 
// 
// **************************************************************//

// Programa en ARM64 Assembly para encontrar el máximo valor en un arreglo de enteros
// Asumimos que la dirección del arreglo se pasa como argumento en el registro X0
// y el tamaño del arreglo se pasa en el registro X1

.section .text
.global _start

_start:
    // Pasar la dirección del arreglo en x0 y el tamaño en x1
    ldr x0, =arr
    mov x1, #5

    bl find_max

    // Salir del programa
    mov x0, x0 // Retornar el máximo
    mov x8, #93 // Syscall de salida
    svc #0

find_max:
    // Inicializar el máximo con el primer elemento del arreglo
    ldr x2, [x0]
    mov x3, #1 // Contador

loop:
    // Comparar el máximo actual con el elemento actual del arreglo
    cmp x3, x1
    beq end_loop
    ldr x4, [x0, x3, lsl #3] // Cargar el elemento actual del arreglo
    cmp x4, x2
    ble skip
    mov x2, x4 // Actualizar el máximo

skip:
    add x3, x3, #1 // Incrementar el contador
    b loop

end_loop:
    mov x0, x2 // Retornar el máximo
    ret

.data
arr: .quad 5, 2, 9, 1, 7