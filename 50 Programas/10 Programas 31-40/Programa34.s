//**************************************************************
// Archivo:    Programa34.s
// Proyecto:   34.Invertir los elementos de un arreglo
// Autor:      [Kevin Omar Alvarez Hernandez]
// Fecha:      [09/11/2024]
// Descripción:
//             [Invertir los elementos de un arreglo]
// 
// Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
// * Todos los derechos reservados.
// * 
// 
// **************************************************************//

// Programa para Rotar Arreglo en ARM64 Assembly
.data
    msg1:    .asciz "Ingrese el tamaño del arreglo: "
    msg2:    .asciz "Ingrese elemento "
    msg3:    .asciz ": "
    msg4:    .asciz "Ingrese posiciones a rotar: "
    msg5:    .asciz "Rotar a la (1)izquierda o (2)derecha?: "
    msg6:    .asciz "Arreglo rotado: "
    space:   .asciz " "
    newline: .asciz "\n"
    buffer:  .space 12
    array:   .space 400    // Espacio para 100 números
    temp:    .space 400    // Array temporal para rotación
    size:    .quad 0
    rot:     .quad 0
    
.text
    .global _start

_start:
    // Pedir y leer tamaño del array
    mov x0, #1
    ldr x1, =msg1
    mov x2, #29
    mov x8, #64
    svc #0
    
    mov x0, #0
    ldr x1, =buffer
    mov x2, #12
    mov x8, #63
    svc #0
    
    ldr x0, =buffer
    bl atoi
    ldr x1, =size
    str x0, [x1]
    
    // Leer elementos
    mov x19, #0
    ldr x20, =array
    
input_loop:
    ldr x0, =size
    ldr x0, [x0]
    cmp x19, x0
    beq get_rotation
    
    // Pedir elemento
    mov x0, #1
    ldr x1, =msg2
    mov x2, #17
    mov x8, #64
    svc #0
    
    mov x0, x19
    add x0, x0, #1
    ldr x1, =buffer
    bl itoa
    
    mov x0, #1
    ldr x1, =buffer
    mov x2, #12
    mov x8, #64
    svc #0
    
    mov x0, #1
    ldr x1, =msg3
    mov x2, #2
    mov x8, #64
    svc #0
    
    mov x0, #0
    ldr x1, =buffer
    mov x2, #12
    mov x8, #63
    svc #0
    
    ldr x0, =buffer
    bl atoi
    str w0, [x20, x19, lsl #2]
    
    add x19, x19, #1
    b input_loop
    
get_rotation:
    // Pedir cantidad de posiciones a rotar
    mov x0, #1
    ldr x1, =msg4
    mov x2, #27
    mov x8, #64
    svc #0
    
    mov x0, #0
    ldr x1, =buffer
    mov x2, #12
    mov x8, #63
    svc #0
    
    ldr x0, =buffer
    bl atoi
    ldr x1, =rot
    str x0, [x1]
    
    // Preguntar dirección de rotación
    mov x0, #1
    ldr x1, =msg5
    mov x2, #36
    mov x8, #64
    svc #0
    
    mov x0, #0
    ldr x1, =buffer
    mov x2, #12
    mov x8, #63
    svc #0
    
    ldr x0, =buffer
    bl atoi
    cmp x0, #1
    beq rotate_left
    b rotate_right
    
rotate_left:
    // Rotar a la izquierda
    ldr x21, =rot
    ldr x21, [x21]      // Posiciones a rotar
    ldr x22, =size
    ldr x22, [x22]      // Tamaño del array
    mov x19, #0         // Contador
    
rotate_left_loop:
    cmp x19, x22
    beq show_result
    
    add x23, x19, x21   // Nueva posición = i + rot
    udiv x24, x23, x22
    msub x23, x24, x22, x23  // Nueva posición % size
    
    ldr w24, [x20, x19, lsl #2]
    ldr x25, =temp
    str w24, [x25, x23, lsl #2]
    
    add x19, x19, #1
    b rotate_left_loop
    
rotate_right:
    // Rotar a la derecha
    ldr x21, =rot
    ldr x21, [x21]      // Posiciones a rotar
    ldr x22, =size
    ldr x22, [x22]      // Tamaño del array
    mov x19, #0         // Contador
    
rotate_right_loop:
    cmp x19, x22
    beq show_result
    
    sub x23, x22, x21   // Nueva posición = size - rot + i
    add x23, x23, x19
    udiv x24, x23, x22
    msub x23, x24, x22, x23  // Nueva posición % size
    
    ldr w24, [x20, x19, lsl #2]
    ldr x25, =temp
    str w24, [x25, x23, lsl #2]
    
    add x19, x19, #1
    b rotate_right_loop
    
show_result:
    // Copiar array temporal al original
    mov x19, #0
    ldr x25, =temp
    
copy_loop:
    ldr x0, =size
    ldr x0, [x0]
    cmp x19, x0
    beq print_result
    
    ldr w24, [x25, x19, lsl #2]
    str w24, [x20, x19, lsl #2]
    
    add x19, x19, #1
    b copy_loop
    
print_result:
    // Mostrar resultado
    mov x0, #1
    ldr x1, =msg6
    mov x2, #15
    mov x8, #64
    svc #0
    
    mov x19, #0
    
print_loop:
    ldr x0, =size
    ldr x0, [x0]
    cmp x19, x0
    beq exit_program
    
    ldr w0, [x20, x19, lsl #2]
    ldr x1, =buffer
    bl itoa
    
    mov x0, #1
    ldr x1, =buffer
    mov x2, #12
    mov x8, #64
    svc #0
    
    mov x0, #1
    ldr x1, =space
    mov x2, #1
    mov x8, #64
    svc #0
    
    add x19, x19, #1
    b print_loop
    
exit_program:
    mov x0, #1
    ldr x1, =newline
    mov x2, #1
    mov x8, #64
    svc #0
    
    mov x8, #93
    svc #0

// Funciones auxiliares atoi e itoa (mismas que antes)
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