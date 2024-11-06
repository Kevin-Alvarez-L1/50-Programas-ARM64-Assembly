/**************************************************************
 * Archivo:    Programa9.as
 * Proyecto:   Suma de elementos en un arreglo
 * Autor:      [Kevin Omar Alvarez Hernandez]
 * Fecha:      [05/11/2024]
 * Descripción:
 *             [Suma de elementos en un arreglo]
 * 

 * 
 * Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
 * Todos los derechos reservados.
 * 

 **************************************************************/

     .data
arr:            .word 10, 20, 30, 40, 50     // Arreglo con 5 elementos
arr_len:        .word 5                       // Longitud del arreglo (5 elementos)
resultMsg:      .asciz "La suma de los elementos es: "
buffer:         .space 20                      // Espacio para almacenar el resultado de la suma (en formato ASCII)

    .text
    .global _start

_start:
    // Mostrar el mensaje de solicitud
    ldr x0, =1                          // STDOUT (descriptor de archivo 1)
    ldr x1, =resultMsg                  // Cargar la dirección del mensaje
    mov x2, #30                         // Longitud del mensaje (30 caracteres)
    mov x8, #64                         // Syscall para 'write' (64)
    svc #0                              // Llamada al sistema

    // Inicializar variables para la suma
    mov x0, #0                          // Acumulador de la suma (inicializado a 0)
    ldr x1, =arr                        // Dirección del arreglo
    ldr x2, =arr_len                    // Dirección de la longitud del arreglo
    ldr w2, [x2]                        // Cargar la longitud del arreglo (número de elementos)
    mov x3, #0                          // Contador de índice (inicializado a 0)

sum_loop:
    cmp x3, w2                          // Comparar el índice con la longitud del arreglo
    bge end_sum                         // Si el índice es mayor o igual a la longitud, salir del ciclo

    ldr w4, [x1, x3, LSL #2]            // Cargar el valor del elemento en el arreglo (x3 * 4)
    add x0, x0, x4                      // Sumar el valor al acumulador (x0)
    add x3, x3, #1                      // Incrementar el índice
    b sum_loop                          // Repetir el ciclo

end_sum:
    // Mostrar la suma en formato ASCII
    mov x1, x0                          // Mover la suma al registro x1
    bl print_number                     // Llamar a la función que imprime el número en formato ASCII

    // Terminar el programa
    mov x8, #93                         // Syscall para 'exit' (93)
    svc #0                               // Llamada al sistema

// Función para imprimir un número en formato ASCII
print_number:
    mov x2, x1                          // Copiar el número a x2
    mov x3, #10                         // Establecer el divisor (base 10)
    mov x4, #0                          // Inicializar el índice del buffer

print_number_loop:
    udiv x5, x2, x3                     // x5 = x2 / 10 (cociente)
    msub x6, x5, x3, x2                 // x6 = x2 - x5 * 10 (resto, último dígito)
    add x6, x6, #'0'                    // Convertir el dígito a su valor ASCII
    strb w6, [x1, x4]                   // Almacenar el dígito en el buffer
    add x4, x4, #1                      // Incrementar el índice del buffer
    mov x2, x5                          // Actualizar x2 con el cociente
    cmp x2, #0                          // Comprobar si el cociente es cero
    bne print_number_loop               // Si no es cero, continuar con el siguiente dígito

    // Agregar el carácter de terminación de cadena (nulo)
    mov w6, #0
    strb w6, [x1, x4]

    // Imprimir el número en el buffer
    ldr x0, =1                          // STDOUT (descriptor de archivo 1)
    ldr x1, =buffer                     // Dirección del buffer con la longitud en ASCII
    mov x2, x4                          // Longitud del número en ASCII
    mov x8, #64                         // Syscall para 'write' (64)
    svc #0                               // Llamada al sistema

    ret