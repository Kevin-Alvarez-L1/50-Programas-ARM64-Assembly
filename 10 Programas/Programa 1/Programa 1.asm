/**************************************************************
 * Archivo:    Programa1.as
 * Proyecto:   Convertir temperatura de Celsius a Fahrenheit
 * Autor:      [Kevin Omar Alvarez Hernandez]
 * Fecha:      [05/11/2024]
 * Descripción:
 *             [Convertir temperatura de Celsius a Fahrenheit]
 * 
 * Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
 * Todos los derechos reservados.
 * 
 
 **************************************************************/

     .data
promptCelsius:   .asciz "Ingrese la temperatura en Celsius: "
resultMsg:       .asciz "La temperatura en Fahrenheit es: "
buffer:          .space 20               // Buffer para almacenar la entrada del usuario

    .text
    .global _start

_start:
    // Desplegar el mensaje para ingresar Celsius
    ldr x0, =1                           // STDOUT (descriptor de archivo 1)
    ldr x1, =promptCelsius               // Cargar dirección del mensaje para Celsius
    mov x2, #31                          // Longitud del mensaje (31 caracteres)
    mov x8, #64                          // Syscall para 'write' (64)
    svc #0                               // Llamada al sistema

    // Leer la temperatura en Celsius ingresada por el usuario
    ldr x0, =0                           // STDIN (descriptor de archivo 0)
    ldr x1, =buffer                      // Cargar dirección del buffer
    mov x2, #20                          // Leer hasta 20 caracteres
    mov x8, #63                          // Syscall para 'read' (63)
    svc #0                               // Llamada al sistema

    // Convertir el string en un número (usamos un conversor simple)
    mov x0, #0                           // Inicializar x0 en 0 para guardar el número
    ldr x1, =buffer                      // Cargar dirección del buffer

convert_str_to_int:
    ldrb w2, [x1], #1                    // Leer un byte del buffer, w2 contiene el carácter
    cmp w2, #'0'                         // Comparar con '0'
    blt finish_str_to_int                // Si es menor, termina la conversión
    cmp w2, #'9'                         // Comparar con '9'
    bgt finish_str_to_int                // Si es mayor, termina la conversión
    sub w2, w2, #'0'                     // Convertir el carácter a valor numérico
    mul x0, x0, #10                      // Multiplicar por 10 (para desplazar dígito a la izquierda)
    add x0, x0, x2                       // Sumar el dígito al número
    b convert_str_to_int                 // Repetir para el siguiente carácter

finish_str_to_int:

    // Convertir Celsius a Fahrenheit: F = C * 9/5 + 32
    mov x1, #9                           // x1 = 9
    mul x0, x0, x1                       // x0 = Celsius * 9

    mov x1, #5                           // x1 = 5
    sdiv x0, x0, x1                      // x0 = (Celsius * 9) / 5

    add x0, x0, #32                      // x0 = (Celsius * 9 / 5) + 32 (resultado en Fahrenheit)

    // Mostrar el mensaje del resultado
    ldr x0, =1                           // STDOUT (descriptor de archivo 1)
    ldr x1, =resultMsg                   // Cargar dirección del mensaje
    mov x2, #33                          // Longitud del mensaje (33 caracteres)
    mov x8, #64                          // Syscall para 'write' (64)
    svc #0                               // Llamada al sistema

    // Convertir el resultado de Fahrenheit (x0) a una cadena para mostrarlo
    bl print_fahrenheit_result

    // Terminar el programa
    mov x8, #93                          // Syscall para 'exit' (93)
    svc #0                               // Llamada al sistema

print_fahrenheit_result:
    // Aquí se implementa una función para imprimir el número en x0 (en Fahrenheit) como string
    // Se omite por simplicidad, pero se puede implementar usando divisiones sucesivas por 10
    ret