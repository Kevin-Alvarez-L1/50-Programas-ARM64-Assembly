//**************************************************************
// Archivo:    Programa20.s
// Proyecto:   20.Ordenamiento burbuja
// Autor:      [Kevin Omar Alvarez Hernandez]
// Fecha:      [07/11/2024]
// Descripción:
//             [Ordenamiento burbujal]
// 
// Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
// * Todos los derechos reservados.
// * 
// 
// **************************************************************//

// Programa en ARM64 Assembly para realizar el ordenamiento burbuja en un arreglo de enteros
// Asumimos que la dirección del arreglo se pasa como argumento en el registro X0
// y el tamaño del arreglo se pasa en el registro X1

.section .text
.global _start

_start:
    // Pasar la dirección del arreglo en x0 y el tamaño en x1
    ldr x0, =arr
    mov x1, #5

    bl bubble_sort

    // Salir del programa
    mov x0, x0 // Retornar la dirección del arreglo ordenado
    mov x8, #93 // Syscall de salida
    svc #0

bubble_sort:
    mov x2, x1 // Guardar el tamaño del arreglo
    sub x2, x2, #1 // Tamaño del arreglo menos 1

outer_loop:
    cmp x2, #0
    beq end
    mov x3, #0 // Contador interno

inner_loop:
    cmp x3, x2
    beq outer_loop_end
    ldr x4, [x0, x3, lsl #3] // Cargar el elemento actual
    ldr x5, [x0, x3, lsl #3, add #8] // Cargar el siguiente elemento
    cmp x4, x5
    ble skip
    str x5, [x0, x3, lsl #3] // Intercambiar los elementos
    str x4, [x0, x3, lsl #3, add #8]

skip:
    add x3, x3, #1 // Incrementar el contador interno
    b inner_loop

outer_loop_end:
    sub x2, x2, #1 // Decrementar el tamaño del arreglo
    b outer_loop

end:
    mov x0, x0 // Retornar la dirección del arreglo ordenado
    ret

.data
arr: .quad 5, 2, 9, 1, 7