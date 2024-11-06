/**************************************************************
 * Archivo:    Programa10.as
 * Proyecto:   Leer entrada desde el teclado
 * Autor:      [Kevin Omar Alvarez Hernandez]
 * Fecha:      [05/11/2024]
 * Descripción:
 *             [Leer entrada desde el teclado]
 * 

 * 
 * Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
 * Todos los derechos reservados.
 * 

 **************************************************************/

     .data
promptMsg:      .asciz "Ingrese una cadena de texto: "  // Mensaje para solicitar entrada
buffer:         .space 100                              // Espacio para almacenar la entrada (máximo 100 caracteres)
echoMsg:        .asciz "La entrada que ingresó es: "

    .text
    .global _start

_start:
    // Mostrar el mensaje de solicitud
    ldr x0, =1                          // STDOUT (descriptor de archivo 1)
    ldr x1, =promptMsg                  // Cargar la dirección del mensaje
    mov x2, #29                         // Longitud del mensaje (29 caracteres)
    mov x8, #64                         // Syscall para 'write' (64)
    svc #0                              // Llamada al sistema

    // Leer la entrada desde el teclado
    ldr x0, =0                          // STDIN (descriptor de archivo 0)
    ldr x1, =buffer                     // Cargar la dirección del buffer donde se almacenará la entrada
    mov x2, #100                        // Leer hasta 100 caracteres
    mov x8, #63                         // Syscall para 'read' (63)
    svc #0                              // Llamada al sistema

    // Mostrar la entrada ingresada
    ldr x0, =1                          // STDOUT (descriptor de archivo 1)
    ldr x1, =echoMsg                    // Cargar la dirección del mensaje de salida
    mov x2, #27                         // Longitud del mensaje (27 caracteres)
    mov x8, #64                         // Syscall para 'write' (64)
    svc #0                              // Llamada al sistema

    // Mostrar la entrada del usuario
    ldr x0, =1                          // STDOUT (descriptor de archivo 1)
    ldr x1, =buffer                     // Cargar la dirección del buffer que contiene la entrada
    mov x2, #100                        // Mostrar hasta 100 caracteres
    mov x8, #64                         // Syscall para 'write' (64)
    svc #0                              // Llamada al sistema

    // Terminar el programa
    mov x8, #93                         // Syscall para 'exit' (93)
    svc #0                              // Llamada al sistema