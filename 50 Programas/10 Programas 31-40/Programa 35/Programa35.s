//**************************************************************
// Archivo:    Programa35.s
// Proyecto:   35.Rotación de un arreglo (izquierda/derecha)
// Autor:      [Kevin Omar Alvarez Hernandez]
// Fecha:      [09/11/2024]
// Descripción:
//             [Rotación de un arreglo (izquierda/derecha)]
// 
// Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
// * Todos los derechos reservados.
// * 
// 
// **************************************************************//

// Programa para encontrar el Segundo Elemento más Grande en ARM64 Assembly
.data
    msg1:    .asciz "Ingrese el tamaño del arreglo: "
    msg2:    .asciz "Ingrese elemento "
    msg3:    .asciz ": "
    msg4:    .asciz "El segundo elemento más grande es: "
    newline: .asciz "\n"
    buffer:  .space 12
    array:   .space 400    // Espacio para 100 números (4 bytes cada uno)
    size:    .quad 0
    largest: .quad 0
    second:  .quad 0
    
.text
    .global _start

_start:
    // Mostrar mensaje para tamaño
    mov x0, #1
    ldr x1, =msg1
    mov x2, #29
    mov x8, #64
    svc #0
    
    // Leer tamaño
    mov x0, #0
    ldr x1, =buffer
    mov x2, #12
    mov x8, #63
    svc #0
    
    // Convertir string a número
    ldr x0, =buffer
    bl atoi
    ldr x1, =size
    str x0, [x1]        // Guardar tamaño
    
    // Inicializar contador y puntero al array
    mov x19, #0         // Contador
    ldr x20, =array     // Puntero al array
    
input_loop:
    // Comprobar si terminamos
    ldr x0, =size
    ldr x0, [x0]
    cmp x19, x0
    beq find_second
    
    // Mostrar "Ingrese elemento "
    mov x0, #1
    ldr x1, =msg2
    mov x2, #17
    mov x8, #64
    svc #0
    
    // Mostrar número de elemento
    mov x0, x19
    add x0, x0, #1
    ldr x1, =buffer
    bl itoa
    
    mov x0, #1
    ldr x1, =buffer
    mov x2, #12
    mov x8, #64
    svc #0
    
    // Mostrar ": "
    mov x0, #1
    ldr x1, =msg3
    mov x2, #2
    mov x8, #64
    svc #0
    
    // Leer elemento
    mov x0, #0
    ldr x1, =buffer
    mov x2, #12
    mov x8, #63
    svc #0
    
    // Convertir string a número y guardar en array
    ldr x0, =buffer
    bl atoi
    str w0, [x20, x19, lsl #2]
    
    add x19, x19, #1
    b input_loop
    
find_second:
    // Inicializar largest y second con primer elemento
    ldr w21, [x20]      // largest
    str w21, [=largest]
    mov w22, #-1        // second (inicializado con -1)
    str w22, [=second]
    
    // Comenzar desde el segundo elemento
    mov x19, #1
    
find_loop:
    ldr x0, =size
    ldr x0, [x0]
    cmp x19, x0
    beq show_result
    
    ldr w23, [x20, x19, lsl #2]  // Elemento actual
    ldr w21, [=largest]          // Cargar largest actual
    
    // Si el elemento actual es mayor que largest
    cmp w23, w21
    ble check_second
    
    // Actualizar second y largest
    str w21, [=second]   // El antiguo largest se vuelve second
    str w23, [=largest]  // El nuevo elemento se vuelve largest
    b continue
    
check_second:
    ldr w22, [=second]   // Cargar second actual
    // Si el elemento es menor que largest pero mayor que second
    cmp w23, w22
    ble continue
    str w23, [=second]   // Actualizar second
    
continue:
    add x19, x19, #1
    b find_loop
    
show_result:
    // Mostrar mensaje de resultado
    mov x0, #1
    ldr x1, =msg4
    mov x2, #33
    mov x8, #64
    svc #0
    
    // Convertir second a string y mostrar
    ldr w0, [=second]
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

// Funciones auxiliares atoi e itoa
atoi:
    mov x2, #0
    mov x3, #10
atoi_loop:
    ldrb w4, [x0], #1
    cmp w4, #0x0A
    beq atoi_end
    cmp w4, #0
    beq atoi_end
    sub w4, w4, #0x30
    mul x2, x2, x3
    add x2, x2, x4
    b atoi_loop
atoi_end:
    mov x0, x2
    ret

itoa:
    mov x2, #0
    mov x3, #10
itoa_loop:
    udiv x4, x0, x3
    msub x5, x4, x3, x0
    add x5, x5, #0x30
    strb w5, [x1, x2]
    add x2, x2, #1
    mov x0, x4
    cmp x0, #0
    bne itoa_loop
    mov w4, #0
    strb w4, [x1, x2]
    ret