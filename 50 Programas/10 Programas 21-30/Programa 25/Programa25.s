//**************************************************************
// Archivo:    Programa25.s
// Proyecto:   25.Contar vocales y consonantes
// Autor:      [Kevin Omar Alvarez Hernandez]
// Fecha:      [09/11/2024]
// Descripción:
//             [Contar vocales y consonantes]
// 
// Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
// * Todos los derechos reservados.
// * 
// 
// **************************************************************//

// Programa para contar vocales y consonantes en ARM64
.data
    text:       .asciz  "Hello World!"    // Texto de ejemplo
    msg1:       .asciz  "Texto: "
    msg2:       .asciz  "\nVocales: "
    msg3:       .asciz  "\nConsonantes: "
    vowels:     .asciz  "aeiouAEIOU"
    newline:    .asciz  "\n"

.text
.global _start

_start:
    // Imprimir mensaje inicial
    ldr x0, =msg1
    bl print_string
    
    ldr x0, =text
    bl print_string
    
    // Inicializar contadores
    mov x19, #0               // Contador de vocales
    mov x20, #0               // Contador de consonantes
    ldr x21, =text           // Puntero al texto
    
scan_loop:
    ldrb w22, [x21], #1      // Cargar siguiente carácter
    cbz w22, print_results   // Si es null, terminar
    
    // Verificar si es letra
    cmp w22, #'A'
    b.lt scan_loop
    cmp w22, #'z'
    b.gt scan_loop
    cmp w22, #'Z'
    b.le check_vowel
    cmp w22, #'a'
    b.lt scan_loop
    
check_vowel:
    // Comprobar si es vocal
    ldr x23, =vowels         // Puntero a lista de vocales
    mov x24, #0              // Índice en lista de vocales
    
vowel_loop:
    ldrb w25, [x23, x24]     // Cargar vocal
    cbz w25, is_consonant    // Si llegamos al final, es consonante
    cmp w22, w25             // Comparar con carácter actual
    b.eq is_vowel
    add x24, x24, #1
    b vowel_loop
    
is_vowel:
    add x19, x19, #1         // Incrementar contador de vocales
    b scan_loop
    
is_consonant:
    add x20, x20, #1         // Incrementar contador de consonantes
    b scan_loop
    
print_results:
    // Imprimir resultado de vocales
    ldr x0, =msg2
    bl print_string
    mov x0, x19
    bl print_num
    
    // Imprimir resultado de consonantes
    ldr x0, =msg3
    bl print_string
    mov x0, x20
    bl print_num
    
    // Nueva línea
    ldr x0, =newline
    bl print_string
    
    // Salir del programa
    mov x8, #93
    mov x0, #0
    svc #0

// Las funciones print_num y print_string son las mismas que en programas anteriores