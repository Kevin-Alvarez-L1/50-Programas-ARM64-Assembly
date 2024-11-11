//**************************************************************
// Archivo:    Programa21.s
// Proyecto:   21.Ordenamiento por selección
// Autor:      [Kevin Omar Alvarez Hernandez]
// Fecha:      [09/11/2024]
// Descripción:
//             [Ordenamiento por selección]
// 
// Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
// * Todos los derechos reservados.
// * 
// 
// **************************************************************//

// Programa de Ordenamiento por Selección en ARM64
.data
    array:     .word   64, 34, 25, 12, 22, 11, 90   // Array de ejemplo
    size:      .word   7                             // Tamaño del array
    msg1:      .asciz  "Array original: "
    msg2:      .asciz  "\nArray ordenado: "
    space:     .asciz  " "
    newline:   .asciz  "\n"

.text
.global _start

// Función para imprimir un número
print_num:
    // Guardar registros
    stp x29, x30, [sp, #-16]!
    stp x19, x20, [sp, #-16]!
    
    mov x19, x0                     // Guardar número a imprimir
    
    // Convertir a ASCII y almacenar en stack
    mov x20, sp                     // Guardar puntero original del stack
    sub sp, sp, #16                 // Reservar espacio en stack
    
    mov x0, #0                      // Contador de dígitos
    mov x1, #10                     // Divisor
    
convert_loop:
    udiv x2, x19, x1               // x2 = x19 / 10
    msub x3, x2, x1, x19           // x3 = x19 - (x2 * 10) [resto]
    add x3, x3, #'0'               // Convertir a ASCII
    sub sp, sp, #1                 // Mover stack pointer
    strb w3, [sp]                  // Almacenar dígito
    add x0, x0, #1                 // Incrementar contador
    mov x19, x2                    // Actualizar número
    cbnz x19, convert_loop         // Si no es cero, continuar
    
    // Imprimir número
    mov x2, x0                     // Longitud a imprimir
    mov x1, sp                     // Puntero a string
    mov x0, #1                     // STDOUT
    mov x8, #64                    // syscall write
    svc #0
    
    // Restaurar stack y registros
    mov sp, x20                    // Restaurar stack pointer
    ldp x19, x20, [sp], #16
    ldp x29, x30, [sp], #16
    ret

_start:
    // Imprimir mensaje inicial
    ldr x0, =msg1
    bl print_string

    // Imprimir array original
    ldr x19, =array               // Dirección base del array
    ldr x20, =size               
    ldr x20, [x20]               // Tamaño del array
    mov x21, #0                  // Índice actual

print_original:
    ldr x0, [x19, x21, lsl #2]   // Cargar elemento
    bl print_num
    
    ldr x0, =space               // Imprimir espacio
    bl print_string
    
    add x21, x21, #1             // Incrementar índice
    cmp x21, x20                 // Comparar con tamaño
    b.lt print_original          // Si no hemos terminado, continuar

    // Algoritmo de ordenamiento por selección
    mov x21, #0                  // i = 0

outer_loop:
    mov x22, x21                 // min_idx = i
    add x23, x21, #1            // j = i + 1

inner_loop:
    ldr x0, [x19, x22, lsl #2]  // arr[min_idx]
    ldr x1, [x19, x23, lsl #2]  // arr[j]
    cmp x1, x0                  // Comparar elementos
    b.ge skip_update            // Si arr[j] >= arr[min_idx], saltar
    mov x22, x23               // min_idx = j

skip_update:
    add x23, x23, #1           // j++
    cmp x23, x20              // Comparar j con size
    b.lt inner_loop           // Si j < size, continuar

    // Intercambiar elementos si es necesario
    cmp x22, x21              // Comparar min_idx con i
    b.eq no_swap             // Si son iguales, no intercambiar
    
    ldr x0, [x19, x21, lsl #2]  // temp = arr[i]
    ldr x1, [x19, x22, lsl #2]  // arr[min_idx]
    str x1, [x19, x21, lsl #2]  // arr[i] = arr[min_idx]
    str x0, [x19, x22, lsl #2]  // arr[min_idx] = temp

no_swap:
    add x21, x21, #1           // i++
    cmp x21, x20              // Comparar i con size-1
    b.lt outer_loop           // Si i < size-1, continuar

    // Imprimir mensaje de array ordenado
    ldr x0, =msg2
    bl print_string

    // Imprimir array ordenado
    mov x21, #0               // Resetear índice

print_sorted:
    ldr x0, [x19, x21, lsl #2]  // Cargar elemento
    bl print_num
    
    ldr x0, =space              // Imprimir espacio
    bl print_string
    
    add x21, x21, #1           // Incrementar índice
    cmp x21, x20               // Comparar con tamaño
    b.lt print_sorted          // Si no hemos terminado, continuar

    // Salir del programa
    mov x0, #0
    mov x8, #93                // syscall exit
    svc #0

print_string:
    // Rutina auxiliar para imprimir strings
    mov x2, #0                  // Contador de longitud
count_loop:
    ldrb w1, [x0, x2]          // Cargar byte
    cbz w1, print_now          // Si es 0, terminar conteo
    add x2, x2, #1             // Incrementar contador
    b count_loop
print_now:
    mov x1, x0                  // String a imprimir
    mov x0, #1                  // STDOUT
    mov x8, #64                 // syscall write
    svc #0
    ret