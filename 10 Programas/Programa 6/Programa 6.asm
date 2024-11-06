/**************************************************************
 * Archivo:    Programa6.as
 * Proyecto:   Conversión de ASCII a entero
 * Autor:      [Kevin Omar Alvarez Hernandez]
 * Fecha:      [05/11/2024]
 * Descripción:
 *             [Conversión de ASCII a entero]
 * 

 * 
 * Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
 * Todos los derechos reservados.
 * 

 **************************************************************/
    .data
promptMsg:      .asciz "Ingrese un numero en formato ASCII: "
buffer:         .space 20             // Espacio para el número ASCII ingresado (máximo 20 caracteres)
resultMsg:      .asciz "El numero entero es: "

    .text
    .global _start

_start:
    // Mostrar el mensaje de solicitud
    ldr x0, =1                       // STDOUT (descriptor de archivo 1)
    ldr x1, =promptMsg               // Cargar la dirección del mensaje
    mov x2, #36                      // Longitud del mensaje (36 caracteres)
    mov x8, #64                      // Syscall para 'write' (64)
    svc #0                           // Llamada al sistema

    // Leer el número en formato ASCII
    ldr x0, =0                       // STDIN (descriptor de archivo 0)
    ldr x1, =buffer                  // Cargar la dirección del buffer
    mov x2, #20                      // Leer hasta 20 caracteres
    mov x8, #63                      // Syscall para 'read' (63)
    svc #0                           // Llamada al sistema

    // Convertir la cadena ASCII a un número entero
    bl convert_str_to_int            // Llamada a la función de conversión

    // Mostrar el mensaje con el resultado
    ldr x0, =1                       // STDOUT (descriptor de archivo 1)
    ldr x1, =resultMsg               // Cargar la dirección del mensaje
    mov x2, #24                      // Longitud del mensaje (24 caracteres)
    mov x8, #64                      // Syscall para 'write' (64)
    svc #0                           // Llamada al sistema

    // Mostrar el número entero convertido
    bl print_result                  // Llamada a la función para mostrar el número convertido

    // Terminar el programa
    mov x8, #93                      // Syscall para 'exit' (93)
    svc #0                           // Llamada al sistema

// Función para convertir una cadena de ASCII a entero
convert_str_to_int:
    mov x0, #0                       // Inicializar el acumulador (resultado) en 0
    ldr x1, =buffer                  // Cargar la dirección del buffer (número ingresado en formato ASCII)

convert_loop:
    ldrb w2, [x1], #1                // Leer un byte del buffer (un carácter)
    cmp w2, #'0'                     // Comparar con el carácter '0'
    blt end_convert                  // Si es menor, terminar la conversión
    cmp w2, #'9'                     // Comparar con el carácter '9'
    bgt end_convert                  // Si es mayor, terminar la conversión
    sub w2, w2, #'0'                 // Convertir el carácter a valor numérico (restar el valor ASCII de '0')
    mul x0, x0, #10                  // Desplazar el valor anterior a la izquierda multiplicando por 10
    add x0, x0, x2                   // Sumar el dígito convertido al acumulador
    b convert_loop                   // Repetir para el siguiente carácter

end_convert:
    ret                              // Retornar con el resultado en x0

// Función para mostrar el número convertido (entero)
print_result:
    // Convertir el número en x0 a cadena de texto y mostrarlo (a implementar)
    // Aquí debe ir la lógica para convertir el entero a su representación ASCII
    ret