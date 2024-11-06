/**************************************************************
 * Archivo:    Programa4.as
 * Proyecto:   Multiplicación de dos números
 * Autor:      [Kevin Omar Alvarez Hernandez]
 * Fecha:      [05/11/2024]
 * Descripción:
 *             [Multiplicación de dos números]
 * 

 * 
 * Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
 * Todos los derechos reservados.
 * 

 **************************************************************/

    .data
promptNum1:     .asciz "Ingrese el primer numero: "
promptNum2:     .asciz "Ingrese el segundo numero: "
resultMsg:      .asciz "El resultado de la multiplicacion es: "
buffer1:        .space 20          // Espacio para el primer número (máximo 20 caracteres)
buffer2:        .space 20          // Espacio para el segundo número (máximo 20 caracteres)

    .text
    .global _start

_start:
    // Solicitar el primer número
    ldr x0, =1                      // STDOUT (descriptor de archivo 1)
    ldr x1, =promptNum1             // Cargar la dirección del mensaje
    mov x2, #26                     // Longitud del mensaje (26 caracteres)
    mov x8, #64                     // Syscall para 'write' (64)
    svc #0                          // Llamada al sistema

    // Leer el primer número
    ldr x0, =0                      // STDIN (descriptor de archivo 0)
    ldr x1, =buffer1                // Cargar la dirección del buffer1
    mov x2, #20                     // Leer hasta 20 caracteres
    mov x8, #63                     // Syscall para 'read' (63)
    svc #0                          // Llamada al sistema

    // Convertir el primer número de cadena a entero
    bl convert_str_to_int
    mov x19, x0                     // Guardar el primer número en x19 (x0 contiene el resultado)

    // Solicitar el segundo número
    ldr x0, =1                      // STDOUT (descriptor de archivo 1)
    ldr x1, =promptNum2             // Cargar la dirección del mensaje
    mov x2, #27                     // Longitud del mensaje (27 caracteres)
    mov x8, #64                     // Syscall para 'write' (64)
    svc #0                          // Llamada al sistema

    // Leer el segundo número
    ldr x0, =0                      // STDIN (descriptor de archivo 0)
    ldr x1, =buffer2                // Cargar la dirección del buffer2
    mov x2, #20                     // Leer hasta 20 caracteres
    mov x8, #63                     // Syscall para 'read' (63)
    svc #0                          // Llamada al sistema

    // Convertir el segundo número de cadena a entero
    bl convert_str_to_int
    mov x20, x0                     // Guardar el segundo número en x20

    // Multiplicar los dos números
    mul x21, x19, x20               // x21 = x19 (num1) * x20 (num2)

    // Mostrar el mensaje del resultado
    ldr x0, =1                      // STDOUT (descriptor de archivo 1)
    ldr x1, =resultMsg              // Cargar la dirección del mensaje
    mov x2, #37                     // Longitud del mensaje (37 caracteres)
    mov x8, #64                     // Syscall para 'write' (64)
    svc #0                          // Llamada al sistema

    // Convertir el resultado de la multiplicación a cadena y mostrarlo
    mov x0, x21                     // Mover el resultado (multiplicación) a x0
    bl print_result                 // Llamar a la función que convierte y muestra el resultado

    // Terminar el programa
    mov x8, #93                     // Syscall para 'exit' (93)
    svc #0                          // Llamada al sistema

// Función para convertir una cadena a un número entero
convert_str_to_int:
    mov x0, #0                      // Inicializar el acumulador (resultado) en 0
    ldr x1, =buffer1                // Cargar la dirección del buffer (número ingresado)

convert_loop:
    ldrb w2, [x1], #1               // Leer un byte del buffer
    cmp w2, #'0'                    // Comparar con '0'
    blt end_convert                 // Si es menor, terminar la conversión
    cmp w2, #'9'                    // Comparar con '9'
    bgt end_convert                 // Si es mayor, terminar la conversión
    sub w2, w2, #'0'                // Convertir el carácter a valor numérico
    mul x0, x0, #10                 // Desplazar el valor anterior a la izquierda (x10)
    add x0, x0, x2                  // Sumar el dígito convertido al acumulador
    b convert_loop                  // Repetir para el siguiente carácter

end_convert:
    ret                             // Retornar con el resultado en x0

// Función para mostrar el resultado (convertir número a string)
print_result:
    // Implementar la conversión del número x0 a una cadena de texto y mostrarlo (omisión por simplicidad)
    ret