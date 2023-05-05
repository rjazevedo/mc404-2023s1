.data
vetor: .word 5, 10, 20, 40, 80

.text
main:
    li   a0, 5
    la   a1, vetor
    li   a2, 10
    call MultiplicaVetor

    la   s0, vetor
    li   s1, 5
imprime:
    beq  s1, zero, fimMain
    lw   a1, 0(s0)
    addi s0, s0, 4
    addi s1, s1, -1
    li   a0, 1
    ecall
    li   a0, 11
    li   a1, 13
    ecall
    j    imprime

fimMain:
    # Encerra a execução do programa
    addi a0, zero, 10
    ecall

MultiplicaVetor:
    # Movimenta o apontador da pilha 4 posicoes para baixo (16 bytes) e guarda 4 registradores na pilha
    addi sp, sp, -16
    sw   s0, 12(sp)
    sw   s1, 8(sp)
    sw   s2, 4(sp)
    sw   ra, 0(sp)

    mv   s0, a0
    mv   s1, a1
    mv   s2, a2

for:
    beq  s0, zero, fim
    lw   a0, 0(s1)
    mv   a1, s2
    call Multiplica
    sw   a0, 0(s1)
    addi s1, s1, 4
    addi s0, s0, -1
    j    for

fim:
    # Movimenta o apontador da pilha 4 posicoes para cima (16 bytes) e recupera 4 registradores da pilha
    lw   ra, 0(sp)
    lw   s2, 4(sp)
    lw   s1, 8(sp)
    lw   s0, 12(sp)
    addi sp, sp, 16
    ret

Multiplica:
    # Multiplica a0 por a1 e guarda o resultado em a0
    # Utilizando deslocamentos para multiplicar os números bit a bit
    mv   t0, zero
loop:
    beq  a0, zero, fimMultiplica
    andi t1, a0, 1
    beq  t1, zero, nao
    add  t0, t0, a1
nao:
    slli a1, a1, 1
    srli a0, a0, 1
    j    loop
fimMultiplica:
    mv   a0, t0
    ret
