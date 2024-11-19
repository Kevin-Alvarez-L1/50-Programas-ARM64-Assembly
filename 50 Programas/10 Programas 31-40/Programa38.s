//**************************************************************
// Archivo:    Programa38.s
// Proyecto:   38.Convertir binario a decimal
// Autor:      [Kevin Omar Alvarez Hernandez]
// Fecha:      [09/11/2024]
// Descripción:
//             [Convertir binario a decimal]
// 
// Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
// * Todos los derechos reservados.
// * 
// 
// **************************************************************//

// 38. Convertir binario a decimal
.data
    prompt_bin:  .asciz  "Ingrese un número binario: "
    dec_msg:     .asciz  "En decimal es: "
    
.text
binary_to_decimal:
    // Guardar registros
    stp x29, x30, [sp, #-16]!
    
    // Mostrar prompt
    mov x0, #1
    ldr x1, =prompt_bin
    mov x2, #25
    mov x8, #64
    svc #0
    
    // Leer número binario
    mov x0, #0
    ldr x1, =result
    mov x2, #33
    mov x8, #63
    svc #0
    
    // Convertir binario a decimal
    mov x19, #0          // Resultado decimal
    mov x20, #0          // Índice
    ldr x21, =result     // Puntero a input
    
convert_bin_loop:
    ldrb w22, [x21, x20]
    cmp w22, #0
    beq print_decimal
    
    // Multiplicar resultado por 2
    lsl x19, x19, #1
    
    // Sumar bit actual
    sub w22, w22, #48
    add x19, x19, x22
    
    add x20, x20, #1
    b convert_bin_loop
    
print_decimal:
    // Imprimir mensaje
    mov x0, #1
    ldr x1, =dec_msg
    mov x2, #14
    mov x8, #64
    svc #0
    
    // Convertir resultado a string y mostrar
    mov x0, x19
    bl int_to_string
    
    // Restaurar registros y retornar
    ldp x29, x30, [sp], #16
    ret