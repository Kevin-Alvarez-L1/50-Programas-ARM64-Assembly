//**************************************************************
// Archivo:    Programa31.s
// Proyecto:   31.Mínimo Común Múltiplo (MCM)
// Autor:      [Kevin Omar Alvarez Hernandez]
// Fecha:      [09/11/2024]
// Descripción:
//             [Mínimo Común Múltiplo (MCM)]
// 
// Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
// * Todos los derechos reservados.
// * 
// 
// **************************************************************//

// Programa MCM en ARM64 Assembly
.data
    msg1:    .asciz "Ingrese primer número: "
    msg2:    .asciz "Ingrese segundo número: "
    result:  .asciz "El MCM es: "
    newline: .asciz "\n"
    buffer:  .space 12
    num1:    .quad 0
    num2:    .quad 0
    
.text
    .global _start

// Función para calcular MCD (necesario para MCM)
mcd:
    // Preservar registros
    stp x29, x30, [sp, #-16]!
    
    // x0 y x1 contienen los números
mcd_loop:
    cmp x1, #0
    beq mcd_end
    
    // t = b
    mov x2, x1
    // b = a % b
    udiv x3, x0, x1
    msub x1, x3, x1, x0
    // a = t
    mov x0, x2
    b mcd_loop
    
mcd_end:
    ldp x29, x30, [sp], #16
    ret

_start:
    // Mostrar primer mensaje
    mov x0, #1
    ldr x1, =msg1
    mov x2, #21
    mov x8, #64
    svc #0
    
    // Leer primer número
    mov x0, #0
    ldr x1, =buffer
    mov x2, #12
    mov x8, #63
    svc #0
    
    // Convertir string a número
    ldr x0, =buffer
    bl atoi
    ldr x1, =num1
    str x0, [x1]
    
    // Mostrar segundo mensaje
    mov x0, #1
    ldr x1, =msg2
    mov x2, #22
    mov x8, #64
    svc #0
    
    // Leer segundo número
    mov x0, #0
    ldr x1, =buffer
    mov x2, #12
    mov x8, #63
    svc #0
    
    // Convertir string a número
    ldr x0, =buffer
    bl atoi
    ldr x1, =num2
    str x0, [x1]
    
    // Calcular MCM = (a * b) / MCD(a,b)
    ldr x0, =num1
    ldr x0, [x0]
    ldr x1, =num2
    ldr x1, [x1]
    
    // Guardar a y b
    mov x19, x0
    mov x20, x1
    
    // Calcular MCD
    bl mcd
    mov x21, x0  // Guardar MCD
    
    // Calcular MCM
    mul x0, x19, x20  // a * b
    udiv x0, x0, x21  // / MCD
    
    // Mostrar mensaje de resultado
    mov x0, #1
    ldr x1, =result
    mov x2, #11
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