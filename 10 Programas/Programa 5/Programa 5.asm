/**************************************************************
 * Archivo:    Programa5.as
 * Proyecto:   División de dos números
 * Autor:      [Kevin Omar Alvarez Hernandez]
 * Fecha:      [05/11/2024]
 * Descripción:
 *             [División de dos números]
 * 

 * 
 * Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
 * Todos los derechos reservados.
 * 

 **************************************************************/

    .data
promptNum1:     .asciz "Ingrese el dividendo (primer numero): "
promptNum2:     .asciz "Ingrese el divisor (segundo numero): "
resultMsg:      .asciz "El resultado de la division es: "
errorMsg:       .asciz "Error: Division por cero.\n"
buffer1:        .space 20          // Espacio para el primer número (máximo 20 caracteres)
buffer2:        .space 20          // Espacio para el segundo número (máximo 20 caracteres)

    .text
    .global _start

_start:
    // Solicitar el primer número (dividendo)
    ldr x0, =1                      // STDOUT (descriptor de archivo 1)
    ldr x1, =promptNum1             // Cargar la dirección del mensaje
    mov x2, #37                     // Longitud del mensaje (37 caracteres)
    mov x8, #64                     // Syscall para 'write' (64)
    svc #0                          // Llamada al sistema

    // Leer el primer número (dividendo)
    ldr x0, =0                      // STDIN (descriptor de archivo 0)
    ldr x1, =buffer1                // Cargar la dirección del buffer1
    mov x2, #20                     // Leer hasta 20 caracteres
    mov x8, #63                     // Syscall para 'read' (63)
    svc #0                          // Llamada al sistema

    // Convertir el primer número de cadena a entero
    bl convert_str_to_int
    mov x19, x0                     // Guardar el primer número (dividendo) en x19

    // Solicitar el segundo número (divisor)
    ldr x0, =1                      // STDOUT (descriptor de archivo 1)
    ldr x1, =promptNum2             // Cargar la dirección del mensaje
    mov x2, #34                     // Longitud del mensaje (34 caracteres)
    mov x8, #64                     // Syscall para 'write' (64)
    svc #0                          // Llamada al sistema

    // Leer el segundo número (divisor)
    ldr x0, =0                      // STDIN (descriptor de archivo 0)
    ldr x1, =buffer2                // Cargar la dirección del buffer2
    mov x2, #20                     // Leer hasta 20 caracteres
    mov x8, #63                     // Syscall para 'read' (63)
    svc #0                          // Llamada al sistema

    // Convertir el segundo número de cadena a entero
    bl convert_str_to_int
    mov x20, x0                     // Guardar el segundo número (divisor) en x20

    // Verificar si el divisor es cero
    cmp x20, #0                     // Comparar el divisor con 0
    beq division_by_zero            // Si es igual a 0, ir a manejar el error

    // Dividir los dos números (dividendo / divisor)
    udiv x21, x19, x20              // x21 = x19 (dividendo) / x20 (divisor)

    // Mostrar el mensaje del resultado
    ldr x0, =1                      // STDOUT (descriptor de archivo 1)
    ldr x1, =resultMsg              // Cargar la dirección del mensaje
    mov x2, #31                     // Longitud del mensaje (31 caracteres)
    mov x8, #64                     // Syscall para 'write' (64)
    svc #0                          // Llamada al sistema

    // Convertir el resultado de la división a cadena y mostrarlo
    mov x0, x21                     // Mover el