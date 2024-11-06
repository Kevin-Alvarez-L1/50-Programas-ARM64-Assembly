/**************************************************************
 * Archivo:    Programa7.as
 * Proyecto:   Conversión de entero a ASCII
 * Autor:      [Kevin Omar Alvarez Hernandez]
 * Fecha:      [05/11/2024]
 * Descripción:
 *             [Conversión de entero a ASCII]
 * 

 * 
 * Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
 * Todos los derechos reservados.
 * 

 **************************************************************/

    .data
promptMsg:      .asciz "Ingrese un numero entero: "
buffer:         .space 20              // Espacio para almacenar el número en formato ASCII
resultMsg:      .asciz "El numero en ASCII es: "

    .text
    .global _start

_start:
    // Solicitar el número entero
    ldr x0, =1                       // STDOUT (descriptor de archivo 1)
    ldr x1, =promptMsg               // Cargar la dirección del mensaje
    mov x2, #25                      // Longitud del mensaje (25 caracteres)
    mov x8, #64                      // Syscall para 'write' (64)
    svc #0                           // Llamada al sistema

    // Leer el número entero (en formato ASCII)
    ldr x0, =0                       // STDIN (descriptor de archivo 0)
    ldr x1, =buffer                  // Cargar la dirección del buffer
    mov x2, #20                      // Leer hasta 20 caracteres
    mov x8, #63                      // Syscall para 'read' (63)
    svc #0                           // Llamada al sistema

    // Convertir el número de ASCII a entero
    bl convert_str_to_int            // Llamada a la función de conversión de ASCII a entero

    // Convertir el número entero a ASCII
    bl convert_int_to_ascii          // Llamada a la función para convertir el entero a ASCII

    // Mostrar el mensaje con el número convertido
    ldr x0, =1                       // STDOUT (descriptor de archivo 1)
    ldr x1, =resultMsg               // Cargar la dirección del mensaje
    mov x2, #24                      // Longitud del mensaje (24 caracteres)
    mov x8, #64                      // Syscall para 'write' (64)
    svc #0                           // Llamada al sistema

    // Mostrar el número convertido en ASCII
    ldr x0, =1                       // STDOUT (descriptor de archivo 1)
    ldr x1, =buffer                  // Mostrar el contenido del buffer
    mov x2, #20                      // Longitud del número en ASCII (máximo 20 caracteres)
    mov x8, #64                      // Syscall para 'write' (64)
    svc #0                           // Llamada al sistema

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

// Función para convertir un número entero a ASCII
convert_int_to_ascii:
    mov x2, #0                       // Inicializar el índice de la cadena (buffer)
    mov x3, x0                       // Copiar el número entero a x3 para procesarlo
    mov x4, #10                      // Divisor (base 10)

convert_int_loop:
    udiv x5, x3, x4                  // x5 = x3 / 10 (cociente)
    msub x6, x5, x4, x3              // x6 = x3 - x5 * 10 (resto, último dígito)
    add x6, x6, #'0'                 // Convertir el dígito a su valor ASCII
    strb w6, [x1, x2]                // Almacenar el dígito en el buffer
    add x2, x2, #1                   // Incrementar el índice
    mov x3, x5                       // Actualizar x3 con el cociente
    cmp x3, #0                       // Comprobar si el cociente es cero
    bne convert_int_loop             // Si no es cero, continuar con el siguiente dígito

    // Agregar el carácter de terminación de cadena (nulo)
    mov w6, #0
    strb w6, [x1, x2]

    ret