//**************************************************************
// Archivo:    Programa49.s
// Proyecto:   49.Multiplicación de matrices
// Autor:      [Kevin Omar Alvarez Hernandez]
// Fecha:      [09/11/2024]
// Descripción:
//             [Multiplicación de matrices]
// 
// Derechos de autor © [2024] [Kevin Omar Alvarez Hernandez]. 
// * Todos los derechos reservados.
// * 
// 
// **************************************************************//


.data
    matrix1:   .word 1, 2, 3, 4  // Primera matriz 2x2
    matrix2:   .word 5, 6, 7, 8  // Segunda matriz 2x2
    result:    .space 16         // Espacio para almacenar la matriz resultante

.text
    .global _start

_start:
    // Llamar a la función de multiplicación de matrices
    bl matrix_multiply

    // Mostrar el resultado (puedes agregar código para imprimir la matriz)
    // Aquí deberías convertir los valores a ASCII y mostrarlos

    // Terminar
    mov x8, #93
    svc #0

matrix_multiply:
    // Cargar valores de las matrices en registros y realizar multiplicación
    ldr w0, [matrix1]    // Cargar matrix1[0,0]
    ldr w1, [matrix1, 4] // Cargar matrix1[0,1]
    ldr w2, [matrix2]    // Cargar matrix2[0,0]
    ldr w3, [matrix2, 4] // Cargar matrix2[0,1]
    // Continuar con la multiplicación de las matrices
