.data
    prompt_cantidad: .asciiz "Ingrese la cantidad de números a comparar (mínimo 3, máximo 5): "
    prompt_num: .asciiz "Ingrese un número: "
    resultado: .asciiz "El número menor es: "
    salto: .asciiz "\n"
    numbers_space: .space 20  # Espacio para almacenar hasta 5 números (4 bytes c/u)

.text
    .globl main

main:
    # Solicitar cantidad de números a comparar
    li $v0, 4
    la $a0, prompt_cantidad
    syscall

    # Leer la cantidad de números
    li $v0, 5
    syscall
    move $t0, $v0  # Guardar cantidad de números en $t0

    # Validar que la cantidad esté en el rango permitido (3 a 5)
    li $t1, 3
    blt $t0, $t1, main  # Si es menor a 3, repetir
    li $t1, 5
    bgt $t0, $t1, main  # Si es mayor a 5, repetir

    # Inicializar el menor número como el primer número ingresado
    li $v0, 4
    la $a0, prompt_num
    syscall

    li $v0, 5
    syscall
    move $t2, $v0  # Guardar primer número en $t2 (menor actual)

    li $t3, 1  # Contador de números ingresados

loop:
    beq $t3, $t0, fin  # Si se han ingresado todos los números, salir

    # Pedir el siguiente número
    li $v0, 4
    la $a0, prompt_num
    syscall

    li $v0, 5
    syscall
    move $t1, $v0  # Guardar número actual en $t1

    # Comparar con el número menor actual
    bge $t1, $t2, continuar  # Si no es menor, continuar
    move $t2, $t1  # Actualizar el menor número

continuar:
    addi $t3, $t3, 1  # Incrementar contador
    j loop

fin:
    # Mostrar resultado
    li $v0, 4
    la $a0, resultado
    syscall

    li $v0, 1
    move $a0, $t2
    syscall

    li $v0, 4
    la $a0, salto
    syscall

    # Salir del programa
    li $v0, 10
    syscall
