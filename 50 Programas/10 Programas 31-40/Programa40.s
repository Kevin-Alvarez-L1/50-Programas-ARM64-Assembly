//**************************************************************
// Archivo:    Programa40.s
// Proyecto:   40.Conversión de hexadecimal a decimal
// Autor:      [Kevin Omar Alvarez Hernandez]
// Fecha:      [09/11/2024]
// Descripción:
//             [Conversión de hexadecimal a decimal]
// 
// Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
// * Todos los derechos reservados.
// * 
// 
// **************************************************************//


// ChatGTP 4o - Fecha: 2024-10-07
// Programa en ARM64 Assembly para RaspbianOS
// Conversión de un número hexadecimal a decimal

.data
    prompt:    .asciz "Ingrese un numero hexadecimal: "  // Mensaje que solicita al usuario el número hexadecimal
    buffer:    .space 100                               // Buffer para almacenar la entrada del usuario (hasta 100 caracteres)
    result_msg: .asciz "El número en decimal es: "      // Mensaje que se mostrará antes del número decimal
    newline:   .asciz "\n"                               // Nueva línea para mostrar el resultado

.text
    .global _start

_start:
    // Desplegar mensaje: "Ingrese un numero hexadecimal: "
    ldr x0, =1                      // Descriptor de archivo 1 (STDOUT)
    ldr x1, =prompt                 // Dirección del mensaje
    mov x2, #25                     // Longitud del mensaje
    mov x8, #64                     // Syscall 'write' (64)
    svc #0                          // Llamar al sistema

    // Leer la entrada del usuario (número hexadecimal)
    ldr x0, =0                      // Descriptor de archivo 0 (STDIN)
    ldr x1, =buffer                 // Dirección del buffer para almacenar la entrada
    mov x2, #100                    // Leer hasta 100 caracteres
    mov x8, #63                     // Syscall 'read' (63)
    svc #0                          // Llamar al sistema

    // Convertir la entrada hexadecimal a decimal
    ldr x1, =buffer                 // Dirección del buffer donde se guardó la entrada
    mov x2, #0                      // Inicializar el resultado (decimal) a 0
    mov x3, #16                     // Base hexadecimal (16)
    mov x4, #0                      // Inicializar el índice

convert_loop:
    ldrb w5, [x1, x4]               // Cargar un byte de la entrada (carácter)
    cmp w5, #10                      // Verificar si es un carácter 'A'-'F'
    blt is_digit                     // Si es un dígito (0-9), saltar a 'is_digit'

    // Verificar si es una letra 'A'-'F'
    cmp w5, #'A'                     
    blt invalid_input
    cmp w5, #'F'
    bgt invalid_input
    sub w5, w5, #'A'                 // Convertir 'A'-'F' a 10-15
    add w5, w5, #10                  // Agregar 10 para convertir a valor numérico

    b process_digit

is_digit:
    cmp w5, #'0'                    
    blt invalid_input
    cmp w5, #'9'
    bgt invalid_input
    sub w5, w5, #'0'                 // Convertir '0'-'9' a 0-9

process_digit:
    // Multiplicar el resultado por 16 (desplazamiento por base 16)
    mov x6, x2
    mul x2, x6, x3                  // x2 = x2 * 16 (desplazar a la izquierda por un dígito hexadecimal)
    add x2, x2, x5                  // x2 = x2 + valor del dígito hexadecimal

    // Incrementar el índice
    add x4, x4, #1
    cmp w5, #0                       // Verificar si llegamos al final de la cadena
    bne convert_loop                 // Si no hemos llegado al final, continuar el bucle

    // Mostrar el mensaje "El número en decimal es: "
    ldr x0, =1                      // Descriptor de archivo 1 (STDOUT)
    ldr x1, =result_msg             // Dirección del mensaje
    mov x2, #26                     // Longitud del mensaje
    mov x8, #64                     // Syscall 'write' (64)
    svc #0                          // Llamar al sistema

    // Mostrar el número decimal
    mov x0, x2                      // El número decimal a mostrar
    bl print_decimal                // Llamar a la subrutina para imprimir el número en decimal

    // Imprimir una nueva línea
    ldr x0, =1                      // Descriptor de archivo 1 (STDOUT)
    ldr x1, =newline                // Dirección de la nueva línea
    mov x2, #1                      // Longitud del mensaje
    mov x8, #64                     // Syscall 'write' (64)
    svc #0                          // Llamar al sistema

    // Terminar el programa
    mov x8, #93                     // Syscall 'exit' (93)
    svc #0                          // Llamar al sistema

// Subrutina para imprimir un número decimal
print_decimal:
    // Algoritmo para convertir un número en decimal a una cadena
    mov x3, x0                      // Guardar el número en x3
    mov x4, #10                     // Base 10
    mov x5, sp                      // Dirección del buffer donde se almacenará el número
    add x5, x5, #100                // Reservar espacio para 100 caracteres (en el stack)

reverse_digits:
    udiv x6, x3, x4                 // x6 = x3 / 10 (división para obtener el dígito más bajo)
    msub x7, x6, x4, x3             // x7 = x3 - x6 * 10 (obtener el dígito más bajo)
    add x7, x7, #'0'                // Convertir el dígito a su valor ASCII
    strb w7, [x5], #1               // Almacenar el dígito en el buffer y mover el puntero
    mov x3, x6                      // Actualizar x3 con el cociente

    cmp x3, #0                      // Verificar si ya no hay más dígitos
    bne reverse_digits              // Si aún hay más dígitos, continuar

    // Imprimir la cadena de números en orden inverso
    mov x1, x5                      // Cargar la dirección del buffer
    mov x2, sp                      // Calcular la longitud de la cadena
    sub x2, x2, x5                  // Longitud = puntero final - puntero inicial
    mov x0, #1                      // Descriptor de archivo 1 (STDOUT)
    mov x8, #64                     // Syscall 'write' (64)
    svc #0                          // Llamar al sistema

    ret

invalid_input:
    // Si se ingresa un carácter inválido, terminamos el programa
    ldr x0, =1                      // Descriptor de archivo 1 (STDOUT)
    ldr x1, =invalid_msg            // Mensaje de error
    mov x2, #25                     // Longitud del mensaje
    mov x8, #64                     // Syscall 'write' (64)
    svc #0                          // Llamar al sistema
    mov x8, #93                     // Syscall 'exit' (93)
    svc #0                          // Llamar al sistema
