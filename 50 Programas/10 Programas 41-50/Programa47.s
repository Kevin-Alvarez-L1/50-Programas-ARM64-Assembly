//**************************************************************
// Archivo:    Programa47.s
// Proyecto:   47.Búsqueda binaria
// Autor:      [Kevin Omar Alvarez Hernandez]
// Fecha:      [09/11/2024]
// Descripción:
//             [Búsqueda binaria]
// 
// Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
// * Todos los derechos reservados.
// * 
// 
// **************************************************************//

.data
    array:      .word 1, 3, 5, 7, 9, 11, 13, 15, 17, 19  // Arreglo ordenado
    size:       .word 10                                // Tamaño del arreglo
    target_msg: .asciz "Ingrese el número a buscar: "
    found_msg:  .asciz "Número encontrado en la posición: "
    not_found:  .asciz "Número no encontrado."
    buffer:     .space 10                               // Para almacenar la entrada del usuario

.text
    .global _start

_start:
    // Mostrar mensaje "Ingrese el número a buscar: "
    ldr x0, =1
    ldr x1, =target_msg
    mov x2, #24
    mov x8, #64
    svc #0

    // Leer el número a buscar
    ldr x0, =0
    ldr x1, =buffer
    mov x2, #10
    mov x8, #63
    svc #0

    // Convertir la entrada de ASCII a número
    ldr x0, =buffer
    bl atoi               // Función para convertir ASCII a entero, el número queda en x0 (target)

    // Llamar a la función de búsqueda binaria
    bl binary_search

    // Si se encontró el número
    cmp x0, #-1           // x0 contendrá el índice o -1 si no se encuentra
    b.eq not_found_label

    // Mostrar "Número encontrado en la posición"
    ldr x0, =1
    ldr x1, =found_msg
    mov x2, #32
    mov x8, #64
    svc #0

    // Mostrar el índice donde se encontró
    bl itoa               // Convertir el índice a ASCII
    ldr x0, =1
    ldr x1, =buffer
    mov x2, #10
    mov x8, #64
    svc #0

    // Terminar
    b exit

not_found_label:
    // Mostrar "Número no encontrado"
    ldr x0, =1
    ldr x1, =not_found
    mov x2, #19
    mov x8, #64
    svc #0

exit:
    mov x8, #93
    svc #0

binary_search:
    // Implementación de búsqueda binaria
    // Se espera que el target esté en x0, y el índice retornado en x0
    // Regresa -1 si no se encuentra
    // El arreglo está en 'array' y el tamaño en 'size'
