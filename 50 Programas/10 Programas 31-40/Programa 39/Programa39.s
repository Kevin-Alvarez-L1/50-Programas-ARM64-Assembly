//**************************************************************
// Archivo:    Programa39.s
// Proyecto:   39.Conversión de decimal a hexadecimal
// Autor:      [Kevin Omar Alvarez Hernandez]
// Fecha:      [09/11/2024]
// Descripción:
//             [Conversión de decimal a hexadecimal]
// 
// Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
// * Todos los derechos reservados.
// * 
// 
// **************************************************************//

// 39. Conversión de decimal a hexadecimal
.data
    prompt_dec_hex: .asciz "Ingrese un número decimal para convertir a hex: "
    hex_msg:        .asciz "En hexadecimal es: 0x"
    hex_chars:      .asciz "0123456789ABCDEF"
    hex_result:     .space 17                      // 16 dígitos + null terminator
    
.text
decimal_to_hex:
    // Guardar registros
    stp x29, x30, [sp, #-16]!
    
    // Mostrar prompt
    mov x0, #1
    ldr x1, =prompt_dec_hex
    mov x2, #44
    mov x8, #64
    svc #0
    
    // Leer número decimal
    mov x0, #0
    ldr x1, =result
    mov x2, #12
    mov x8, #63
    svc #0
    
    // Convertir string a número
    bl string_to_int
    mov x19, x0          // Guardar número en x19
    
    // Preparar conversión a hex
    ldr x20, =hex_result
    mov x21, #15         // Índice para 16 dígitos (0-15)
    ldr x23, =hex_chars
    
convert_hex_loop:
    cmp x21, #0
    blt print_hex
    
    // Obtener dígito hex actual
    mov x22, x19
    and x22, x22, #0xF
    
    // Obtener carácter correspondiente
    ldrb w24, [x23, x22]
    
    // Guardar carácter
    strb w24, [x20, x21]
    
    // Preparar siguiente iteración
    lsr x19, x19, #4
    sub x21, x21, #1
    b convert_hex_loop
    
print_hex:
    // Imprimir mensaje
    mov x0, #1
    ldr x1, =hex_msg
    mov x2, #19
    mov x8, #64
    svc #0
    
    // Imprimir resultado
    mov x0, #1
    ldr x1, =hex_result
    mov x2, #16
    mov x8, #64
    svc #0
    
    // Restaurar registros y retornar
    ldp x29, x30, [sp], #16
    ret

// Funciones auxiliares
int_to_string:
    // Implementación de conversión de entero a string
    // ... (código de la función)
    ret

string_to_int:
    // Implementación de conversión de string a entero
    // ... (código de la función)
    ret