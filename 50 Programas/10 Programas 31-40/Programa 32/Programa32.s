//**************************************************************
// Archivo:    Programa32.s
// Proyecto:   32.Potencia (x^n)
// Autor:      [Kevin Omar Alvarez Hernandez]
// Fecha:      [09/11/2024]
// Descripción:
//             [Potencia (x^n)]
// 
// Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
// * Todos los derechos reservados.
// * 
// 
// **************************************************************//

// Programa Potencia en ARM64 Assembly
.data
    msg1:    .asciz "Ingrese la base (x): "
    msg2:    .asciz "Ingrese el exponente (n): "
    result:  .asciz "El resultado de x^n es: "
    newline: .asciz "\n"
    buffer:  .space 12
    
.text
    .global _start

_start:
    // Mostrar mensaje para base
    mov x0, #1
    ldr x1, =msg1
    mov x2, #19
    mov x8, #64
    svc #0
    
    // Leer base
    mov x0, #0
    ldr x1, =buffer
    mov x2, #12
    mov x8, #63
    svc #0
    
    // Convertir string a número
    ldr x0, =buffer
    bl atoi
    mov x19, x0        // Guardar base en x19
    
    // Mostrar mensaje para exponente
    mov x0, #1
    ldr x1, =msg2
    mov x2, #24
    mov x8, #64
    svc #0
    
    // Leer exponente
    mov x0, #0
    ldr x1, =buffer
    mov x2, #12
    mov x8, #63
    svc #0
    
    // Convertir string a número
    ldr x0, =buffer
    bl atoi
    mov x20, x0        // Guardar exponente en x20
    
    // Calcular potencia
    mov x0, #1         // Resultado inicial = 1
    mov x1, x19        // Base
    mov x2, x20        // Exponente
    
power_loop:
    cmp x2, #0
    beq power_end
    mul x0, x0, x1     // Resultado *= base
    sub x2, x2, #1     // exponente--
    b power_loop
    
power_end:
    // Guardar resultado
    mov x21, x0
    
    // Mostrar mensaje de resultado
    mov x0, #1
    ldr x1, =result
    mov x2, #23
    mov x8, #64
    svc #0
    
    // Convertir resultado a string y mostrar
    mov x0, x21
    ldr x1, =buffer
    bl itoa
    
    mov x0, #1
    ldr x1, =buffer
    mov x2, #12
    mov x8, #64
    svc #0
    
    // Mostrar nueva línea
    mov x0, #1
    ldr x1, =newline
    mov x2, #1
    mov x8, #64
    svc #0
    
    // Salir
    mov x8, #93
    svc #0

// Función auxiliar para convertir ASCII a entero (atoi)
atoi:
    mov x2, #0          // Resultado
    mov x3, #10         // Base 10
atoi_loop:
    ldrb w4, [x0], #1   // Cargar siguiente byte
    cmp w4, #0x0A       // Comprobar si es newline
    beq atoi_end
    cmp w4, #0          // Comprobar si es fin de string
    beq atoi_end
    sub w4, w4, #0x30   // Convertir ASCII a número
    mul x2, x2, x3      // Multiplicar resultado por 10
    add x2, x2, x4      // Añadir nuevo dígito
    b atoi_loop
atoi_end:
    mov x0, x2
    ret

// Función auxiliar para convertir entero a ASCII (itoa)
itoa:
    mov x2, #0          // Contador de dígitos
    mov x3, #10         // Base 10
itoa_loop:
    udiv x4, x0, x3     // Dividir por 10
    msub x5, x4, x3, x0 // Obtener residuo
    add x5, x5, #0x30   // Convertir a ASCII
    strb w5, [x1, x2]   // Almacenar dígito
    add x2, x2, #1      // Incrementar contador
    mov x0, x4          // Actualizar número
    cmp x0, #0          // Comprobar si terminamos
    bne itoa_loop
    // Añadir null terminator
    mov w4, #0
    strb w4, [x1, x2]
    ret