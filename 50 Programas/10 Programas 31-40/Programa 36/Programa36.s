//**************************************************************
// Archivo:    Programa36.s
// Proyecto:   36.Encontrar el segundo elemento más grande
// Autor:      [Kevin Omar Alvarez Hernandez]
// Fecha:      [09/11/2024]
// Descripción:
//             [Encontrar el segundo elemento más grande]
// 
// Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
// * Todos los derechos reservados.
// * 
// 
// **************************************************************//

// 36. Encontrar el segundo elemento más grande
.data
    array:      .word   15, 8, 23, 4, 42, 16, 2    // Array de números
    len:        .word   7                          // Longitud del array
    msg1:       .asciz  "El segundo número más grande es: "
    result:     .space  20
    newline:    .asciz  "\n"

.text
.global _start
_start:
    // Inicializar registros
    ldr x19, =array        // Dirección base del array
    ldr w20, len          // Longitud del array
    mov x21, #0           // Primer máximo
    mov x22, #0           // Segundo máximo

    // Encontrar el primer máximo
find_first_max:
    mov x23, #0          // Índice actual
first_loop:
    cmp x23, x20
    beq find_second_max
    ldr w24, [x19, x23, lsl #2]
    cmp w24, w21
    ble next_first
    mov w21, w24
next_first:
    add x23, x23, #1
    b first_loop

    // Encontrar el segundo máximo
find_second_max:
    mov x23, #0          // Reset índice
second_loop:
    cmp x23, x20
    beq print_result
    ldr w24, [x19, x23, lsl #2]
    cmp w24, w21
    beq next_second
    cmp w24, w22
    ble next_second
    mov w22, w24
next_second:
    add x23, x23, #1
    b second_loop

print_result:
    // Imprimir mensaje
    mov x0, #1
    ldr x1, =msg1
    mov x2, #32
    mov x8, #64
    svc #0

    // Convertir resultado a string y mostrar
    mov x0, x22
    bl int_to_string

    mov x8, #93
    mov x0, #0
    svc #0