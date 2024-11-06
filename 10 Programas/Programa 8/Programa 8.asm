/**************************************************************
 * Archivo:    Programa8.as
 * Proyecto:   Calcular la longitud de una cadena
 * Autor:      [Kevin Omar Alvarez Hernandez]
 * Fecha:      [05/11/2024]
 * Descripción:
 *             [Calcular la longitud de una cadena]
 * 

 * 
 * Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
 * Todos los derechos reservados.
 * 

 **************************************************************/

     .data
promptMsg:      .asciz "Ingrese una cadena de texto: "
buffer:         .space 100              // Espacio para almacenar la cadena (máximo 100 caracteres)
resultMsg:      .asciz "La longitud de la cadena es: "

    .text
    .global _start

_start:
    // Mostrar el mensaje de solicitud
    ldr x0, =1                       // STDOUT (descriptor de archivo 1)
    ldr x1, =promptMsg               // Cargar la dirección del mensaje
    mov x2, #27                      // Longitud del mensaje (27 caracteres)
    mov x8, #64                      // Syscall para 'write' (64)
    svc #0                           // Llamada al sistema

    // Leer la cadena
    ldr x0, =0                       // STDIN (descriptor de archivo 0)
    ldr x1, =buffer                  // Cargar la dirección del buffer
    mov x2, #100                     // Leer hasta 100 caracteres
    mov x8, #63                      // Syscall para 'read' (63)
    svc #0                           // Llamada al sistema

    // Calcular la longitud de la cadena
    bl calculate_string_length       // Llamada a la función que calcula la longitud de la cadena

    // Mostrar el mensaje con la longitud
    ldr x0, =1                       // STDOUT (descriptor de archivo 1)
    ldr x1, =resultMsg               // Cargar la dirección del mensaje
    mov x2, #30                      // Longitud del mensaje (30 caracteres)
    mov x8, #64                      // Syscall para 'write' (64)
    svc #0                           // Llamada al sistema

    // Mostrar la longitud de la cadena
    mov x0, x1                       // Mover la longitud calculada a x0
    bl print_number                  // Llamada a la función para mostrar el número de la longitud

    // Terminar el programa
    mov x8, #93                      // Syscall para 'exit' (93)
    svc #0                           // Llamada al sistema

// Función para calcular la longitud de una cadena
calculate_string_length:
    mov x1, #0                       // Inicializar contador de longitud a 0
    ldr x2, =buffer                  // Cargar la dirección de la cadena

calculate_loop:
    ldrb w3, [x2], #1                // Leer un byte (carácter) de la cadena
    cmp w3, #0                       // Comparar con el carácter nulo ('\0')
    beq end_calculate                // Si es '\0', terminar el bucle
    add x1, x1, #1                   // Incrementar el contador de longitud
    b calculate_loop                 // Repetir el bucle

end_calculate:
    ret                              // Retornar con la longitud en x1

// Función para mostrar un número (longitud) en la consola
print_number:
    mov x2, x0                       // Copiar el número (longitud) a x2
    mov x3, #10                      // Establecer el divisor (base 10)
    mov x4, #0                       // Inicializar el índice del buffer

print_number_loop:
    udiv x5, x2, x3                  // x5 = x2 / 10 (cociente)
    msub x6, x5, x3, x2              // x6 = x2 - x5 * 10 (resto, último dígito)
    add x6, x6, #'0'                 // Convertir el dígito a su valor ASCII
    strb w6, [x1, x4]                // Almacenar el dígito en el buffer
    add x4, x4, #1                   // Incrementar el índice del buffer
    mov x2, x5                       // Actualizar x2 con el cociente
    cmp x2, #0                       // Comprobar si el cociente es cero
    bne print_number_loop            // Si no es cero, continuar con el siguiente dígito

    // Agregar el carácter de terminación de cadena (nulo)
    mov w6, #0
    strb w6, [x1, x4]

    // Imprimir el número en el buffer
    ldr x0, =1                       // STDOUT (descriptor de archivo 1)
    ldr x1, =buffer                  // Dirección del buffer con la longitud en ASCII
    mov x2, x4                       // Longitud del número en ASCII
    mov x8, #64                      // Syscall para 'write' (64)
    svc #0                           // Llamada al sistema

    ret