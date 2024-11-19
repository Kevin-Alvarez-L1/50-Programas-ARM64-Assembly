//**************************************************************
// Archivo:    Programa22.s
// Proyecto:   22.Ordenamiento por mezcla (Merge Sort)
// Autor:      [Kevin Omar Alvarez Hernandez]
// Fecha:      [09/11/2024]
// Descripción:
//             [Ordenamiento por mezcla (Merge Sort)]
// 
// Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
// * Todos los derechos reservados.
// * 
// 
// **************************************************************//

// Programa de Ordenamiento por Mezcla (Merge Sort) en ARM64
.data
    array:      .word   64, 34, 25, 12, 22, 11, 90   // Array de ejemplo
    size:       .word   7                             // Tamaño del array
    temp_array: .space  28                            // Array temporal (7 * 4 bytes)
    msg1:       .asciz  "Array original: "
    msg2:       .asciz  "\nArray ordenado: "
    space:      .asciz  " "
    newline:    .asciz  "\n"

.text
.global _start

// Función merge
merge:
    // x0 = array base, x1 = izquierda, x2 = medio, x3 = derecha
    stp x29, x30, [sp, #-16]!   // Guardar registros
    stp x19, x20, [sp, #-16]!
    stp x21, x22, [sp, #-16]!
    stp x23, x24, [sp, #-16]!
    
    mov x19, x0                  // Guardar base del array
    mov x20, x1                  // i = izquierda
    mov x21, x1                  // k = izquierda
    add x22, x2, #1             // j = medio + 1
    
    // Copiar a array temporal
copy_loop:
    cmp x20, x2                 // mientras i <= medio
    b.gt check_j               
    cmp x22, x3                 // mientras j <= derecha
    b.gt copy_remaining_left
    
    ldr x23, [x19, x20, lsl #2] // arr[i]
    ldr x24, [x19, x22, lsl #2] // arr[j]
    
    cmp x23, x24
    b.gt copy_right
    
    // Copiar de izquierda
    ldr x0, =temp_array
    str x23, [x0, x21, lsl #2]
    add x20, x20, #1
    b next_iter

copy_right:
    ldr x0, =temp_array
    str x24, [x0, x21, lsl #2]
    add x22, x22, #1
    
next_iter:
    add x21, x21, #1
    b copy_loop

copy_remaining_left:
    cmp x20, x2
    b.gt copy_remaining_right
    ldr x23, [x19, x20, lsl #2]
    ldr x0, =temp_array
    str x23, [x0, x21, lsl #2]
    add x20, x20, #1
    add x21, x21, #1
    b copy_remaining_left

copy_remaining_right:
    cmp x22, x3
    b.gt copy_back
    ldr x23, [x19, x22, lsl #2]
    ldr x0, =temp_array
    str x23, [x0, x21, lsl #2]
    add x22, x22, #1
    add x21, x21, #1
    b copy_remaining_right

check_j:
    cmp x22, x3
    b.le copy_remaining_right
    b copy_back

copy_back:
    mov x20, x1                 // k = izquierda
copy_back_loop:
    cmp x20, x3
    b.gt merge_end
    ldr x0, =temp_array
    ldr x23, [x0, x20, lsl #2]
    str x23, [x19, x20, lsl #2]
    add x20, x20, #1
    b copy_back_loop

merge_end:
    ldp x23, x24, [sp], #16
    ldp x21, x22, [sp], #16
    ldp x19, x20, [sp], #16
    ldp x29, x30, [sp], #16
    ret

// Función mergeSort
mergeSort:
    // x0 = array base, x1 = izquierda, x2 = derecha
    stp x29, x30, [sp, #-16]!
    stp x19, x20, [sp, #-16]!
    
    cmp x1, x2                  // si izquierda >= derecha, retornar
    b.ge mergeSort_end
    
    add x19, x1, x2            // medio = (izquierda + derecha) / 2
    lsr x19, x19, #1
    
    // Llamar mergeSort para mitad izquierda
    mov x20, x0                // guardar base del array
    mov x0, x20
    // x1 ya tiene izquierda
    mov x2, x19
    bl mergeSort
    
    // Llamar mergeSort para mitad derecha
    mov x0, x20
    mov x1, x19
    add x1, x1, #1
    ldr x2, [sp, #24]          // recuperar derecha original
    bl mergeSort
    
    // Hacer merge
    mov x0, x20                // array base
    ldr x1, [sp, #16]          // izquierda original
    mov x2, x19                // medio
    ldr x3, [sp, #24]          // derecha original
    bl merge

mergeSort_end:
    ldp x19, x20, [sp], #16
    ldp x29, x30, [sp], #16
    ret

_start:
    // Imprimir mensaje inicial
    ldr x0, =msg1
    bl print_string

    // Imprimir array original
    ldr x19, =array
    ldr x20, =size
    ldr x20, [x20]
    mov x21, #0

print_original:
    ldr x0, [x19, x21, lsl #2]
    bl print_num
    
    ldr x0, =space
    bl print_string
    
    add x21, x21, #1
    cmp x21, x20
    b.lt print_original

    // Llamar a mergeSort
    ldr x0, =array            // base del array
    mov x1, #0               // izquierda = 0
    ldr x2, =size
    ldr x2, [x2]
    sub x2, x2, #1          // derecha = size - 1
    bl mergeSort

    // Imprimir mensaje de array ordenado
    ldr x0, =msg2
    bl print_string

    // Imprimir array ordenado
    mov x21, #0

print_sorted:
    ldr x0, [x19, x21, lsl #2]
    bl print_num
    
    ldr x0, =space
    bl print_string
    
    add x21, x21, #1
    cmp x21, x20
    b.lt print_sorted

    // Salir del programa
    mov x0, #0
    mov x8, #93
    svc #0

// Las funciones print_num y print_string son las mismas que en el programa anterior