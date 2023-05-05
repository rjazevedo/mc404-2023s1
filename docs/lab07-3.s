.data
vetor: .word 5, 10, 20, 40, 80
s: .string "Hello World!"

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
    li   a0, 4
    la   a1, s
    ecall
    # Encerra a execução do programa
    addi a0, zero, 10
    ecall

MultiplicaVetor:
for:
    beq a0, zero, fim
    lw  t1, 0(a1)
    mul t1, t1, a2
    sw  t1, 0(a1)
    addi a1, a1, 4
    addi a0, a0, -1
    j   for

fim:
    ret
