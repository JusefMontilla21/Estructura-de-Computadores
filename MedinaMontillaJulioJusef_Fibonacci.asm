.data
    prompt_n: .asciiz "Ingrese la cantidad de términos de la serie Fibonacci: "
    resultado: .asciiz "Serie Fibonacci: "
    suma_msg: .asciiz "\nSuma de la serie: "
    espacio: .asciiz " "
    salto: .asciiz "\n"

.text
    .globl main

main:
    # Solicitar la cantidad de términos
    li $v0, 4
    la $a0, prompt_n
    syscall

    # Leer la cantidad ingresada por el usuario
    li $v0, 5
    syscall
    move $t0, $v0  # Guardar cantidad en $t0

    # Verificar si la cantidad es válida (> 0)
    blez $t0, main  # Si es menor o igual a 0, volver a pedir

    # Mostrar mensaje de la serie
    li $v0, 4
    la $a0, resultado
    syscall

    # Inicializar los dos primeros términos de Fibonacci
    li $t1, 0  # Primer término (F0)
    li $t2, 1  # Segundo término (F1)
    move $t3, $t1  # Acumulador de suma
    add $t3, $t3, $t2  # Sumar el segundo término también

    # Imprimir el primer término
    li $v0, 1
    move $a0, $t1
    syscall

    # Imprimir espacio
    li $v0, 4
    la $a0, espacio
    syscall

    # Si la cantidad ingresada es 1, terminar aquí
    beq $t0, 1, fin

    # Imprimir el segundo término
    li $v0, 1
    move $a0, $t2
    syscall

    # Imprimir espacio
    li $v0, 4
    la $a0, espacio
    syscall

    # Si la cantidad ingresada es 2, terminar aquí
    beq $t0, 2, fin

    li $t4, 2  # Contador (ya imprimimos 2 términos)

fibonacci_loop:
    beq $t4, $t0, fin  # Si se han generado todos los términos, salir

    # Calcular el siguiente número en la serie
    add $t5, $t1, $t2  # F(n) = F(n-1) + F(n-2)

    # Imprimir el número calculado
    li $v0, 1
    move $a0, $t5
    syscall

    # Imprimir espacio
    li $v0, 4
    la $a0, espacio
    syscall

    # Acumular en la suma
    add $t3, $t3, $t5

    # Mover los valores para la siguiente iteración
    move $t1, $t2  # F(n-1) = F(n)
    move $t2, $t5  # F(n) = F(n+1)

    addi $t4, $t4, 1  # Incrementar contador
    j fibonacci_loop

fin:
    # Imprimir salto de línea
    li $v0, 4
    la $a0, salto
    syscall

    # Mostrar mensaje de suma
    li $v0, 4
    la $a0, suma_msg
    syscall

    # Imprimir la suma
    li $v0, 1
    move $a0, $t3
    syscall

    # Imprimir salto de línea
    li $v0, 4
    la $a0, salto
    syscall

    # Terminar programa
    li $v0, 10
    syscall
