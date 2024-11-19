//**************************************************************
// Archivo:    Programa37.s
// Proyecto:   37.Convertir decimal a binario
// Autor:      [Kevin Omar Alvarez Hernandez]
// Fecha:      [09/11/2024]
// Descripción:
//             [Convertir decimal a binario]
// 
// Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
// * Todos los derechos reservados.
// * 
// 
// **************************************************************//

// 37. Convertir decimal a binario
.data
    prompt_dec:  .asciz  "Ingrese un número decimal: "
    bin_msg:     .asciz  "En binario es: "
    bin_result:  .space  33                  // 32 bits + null terminator
    
.text
decimal_to_binary:
    // Guardar registros
    stp x29, x30, [sp, #-16]!
    
    // Mostrar prompt
    mov x0, #1
    ldr x1, =prompt_dec
    mov x2, #24
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
    
    // Preparar buffer para binario
    ldr x20, =bin_result
    mov x21, #32         // Contador de bits
    
convert_loop:
    cmp x21, #0
    beq print_binary
    sub x21, x21, #1
    
    // Obtener bit actual
    mov x22, x19
    lsr x22, x22, x21
    and x22, x22, #1
    
    // Convertir bit a char y guardar
    add x22, x22, #48
    strb w22, [x20], #1
    
    b convert_loop
    
print_binary:
    // Imprimir resultado
    mov x0, #1
    ldr x1, =bin_msg
    mov x2, #14
    mov x8, #64
    svc #0
    
    mov x0, #1
    ldr x1, =bin_result
    mov x2, #32
    mov x8, #64
    svc #0
    
    // Restaurar registros y retornar
    ldp x29, x30, [sp], #16
    ret
