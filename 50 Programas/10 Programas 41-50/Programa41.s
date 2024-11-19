//**************************************************************
// Archivo:    Programa41.s
// Proyecto:   41.Calculadora simple (Suma, Resta, Multiplicación, División)
// Autor:      [Kevin Omar Alvarez Hernandez]
// Fecha:      [09/11/2024]
// Descripción:
//             [Calculadora simple (Suma, Resta, Multiplicación, División)]
// 
// Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
// * Todos los derechos reservados.
// * 
// 
// **************************************************************//

// Calculadora simple (Suma, Resta, Multiplicación, División)
.data
    prompt:  .asciz "Ingrese dos numeros (espacio entre ellos): "
    prompt_op: .asciz "\nSeleccione una operacion (1: Suma, 2: Resta, 3: Multiplicacion, 4: Division): "
    buffer:  .space 100
    result_msg: .asciz "El resultado es: "
    newline: .asciz "\n"

.text
.global _start

_start:
    // Pedir primer número
    ldr x0, =1                 // STDOUT
    ldr x1, =prompt            // Mensaje
    mov x2, #30                // Longitud del mensaje
    mov x8, #64                // Syscall 'write'
    svc #0                     // Llamar al sistema

    // Leer los números
    ldr x0, =0                 // STDIN
    ldr x1, =buffer            // Buffer de entrada
    mov x2, #100               // Leer hasta 100 caracteres
    mov x8, #63                // Syscall 'read'
    svc #0                     // Llamar al sistema

    // Conversión de los números (asumimos que se usan enteros simples)
    // Aquí iría la conversión de la cadena a entero

    // Pedir la operación
    ldr x0, =1                 // STDOUT
    ldr x1, =prompt_op         // Mensaje
    mov x2, #54                // Longitud del mensaje
    mov x8, #64                // Syscall 'write'
    svc #0                     // Llamar al sistema

    // Leer la operación
    ldr x0, =0                 // STDIN
    ldr x1, =buffer            // Buffer de entrada
    mov x2, #100               // Leer hasta 100 caracteres
    mov x8, #63                // Syscall 'read'
    svc #0                     // Llamar al sistema

    // Realizar la operación según el código ingresado
    // Aquí se realizarían las operaciones de suma, resta, multiplicación y división

    // Imprimir el resultado
    ldr x0, =1                 // STDOUT
    ldr x1, =result_msg        // Mensaje de resultado
    mov x2, #18                // Longitud del mensaje
    mov x8, #64                // Syscall 'write'
    svc #0                     // Llamar al sistema

    // Terminar el programa
    mov x8, #93                // Syscall 'exit'
    svc #0                     // Llamar al sistema
