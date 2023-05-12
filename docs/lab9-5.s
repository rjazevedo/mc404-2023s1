.data
  mensagem1: .string "Digite um numero\n"
  mensagem2: .string "O numero digitado foi: "
  mensagem3: .string "A soma dos numeros digitados e: "
  mensagem4: .string "A media dos numeros digitados e: "
  vetor: .space 40
  str: .space 20

.text
main:
  li a0, 4
  la a1, mensagem1
  ecall

  la   a0, str
  call LeString    # Le o N

  la   a0, str
  call ConverteNumero # Converte para número
  mv   s0, a0

  call MediaNElementos # Le N elementos e retorna a média dos N elementos

  call ImprimeMedia # Imprime a mensagem indicando a média dos N elementos

  li a0, 10       # Encerra o programa
  ecall
  ret


MediaNElementos:   # Le N elementos e retorna a media deles
    addi  sp, sp, -20
    sw    s3, 16(sp)
    sw    s2, 12(sp)
    sw    s1, 8(sp)
    sw    s0, 4(sp)
    sw    ra, 0(sp)

    mv    s0, a0
    slli  s1, s0, 2  # multiplica por 4
    sub   sp, sp, s1 # aloca espaço para o vetor

    mv    a0, sp
    mv    a1, s0
    call  LeVetor

    mv    s1, zero   # soma os elementos do vetor
    mv    s2, zero   # quantidade de elementos somados
    mv    s3, sp
l1: beq   s2, s0, fiml1
    lw    t0, 0(s3)
    add   s1, s1, t0
    addi  s3, s3, 4
    addi  s2, s2, 1
    j     l1

fiml1:
    div   a0, s1, s0 # divide a soma pelo tamanho
    slli  s1, s0, 2
    add   sp, sp, s1 # desaloca o vetor

    lw    ra, 0(sp)
    lw    s0, 4(sp)
    lw    s1, 8(sp)
    lw    s2, 12(sp)
    lw    s3, 16(sp)
    addi  sp, sp, 20
    ret


ImprimeMedia:   # Imprime a mensagem indicando a média dos N elementos
    addi  sp, sp, -8
    sw    s0, 4(sp)
    sw    ra, 0(sp)

    mv    s0, a0
    li    a0, 4
    la    a1, mensagem4
    ecall          # Imprime a mensagem inicial

    li    a0, 1
    mv    a1, s0
    ecall
    call  NovaLinha

    lw    ra, 0(sp)
    lw    s0, 4(sp)
    addi  sp, sp, 8
    ret


ImprimeSoma:   # Imprime a mensagem indicando a soma dos N elementos
    addi  sp, sp, -8
    sw    s0, 4(sp)
    sw    ra, 0(sp)

    mv    s0, a0
    li    a0, 4
    la    a1, mensagem3
    ecall          # Imprime a mensagem inicial

    li    a0, 1
    mv    a1, s0
    ecall
    call  NovaLinha

    lw    ra, 0(sp)
    lw    s0, 4(sp)
    addi  sp, sp, 8
    ret



LeVetor:   # Le um vetor de inteiros colocando no parâmetro a0 e tamanho em a1
    addi  sp, sp, -36
    sw    s2, 32(sp)
    sw    s1, 28(sp)
    sw    s0, 24(sp)
    sw    ra, 20(sp)

    mv    s0, a0
    mv    s1, a1

l2: blt   s1, zero, fiml2  
    li    a0, 4
    la    a1, mensagem1
    ecall 
    mv    a0, sp
    call  LeString
    mv    a0, sp
    call  ConverteNumero
    sw    a0, 0(s0)
    addi  s0, s0, 4
    addi  s1, s1, -1
    j     l2

fiml2:
    lw    ra, 20(sp)
    lw    s0, 24(sp)
    lw    s1, 28(sp)
    sw    s2, 32(sp)
    addi  sp, sp, 36
    ret


ImprimeVetor:  # Imprime os elementos do vetor recebidos como parâmetro a0 e tamanho em a1
    addi  sp, sp, -12
    sw    s1, 8(sp)
    sw    s0, 4(sp)
    sw    ra, 0(sp)

    mv    s0, a0
    mv    s1, a1

l3: beq   s1, zero, fiml3
    lw    a1, 0(s0)
    li    a0, 1
    ecall
    call  NovaLinha
    addi  s0, s0, 4
    addi  s1, s1, -1
    j     l3

fiml3:
    lw    ra, 0(sp)
    lw    s0, 4(sp)
    lw    s1, 8(sp)
    addi  sp, sp, 12
    ret


LeString:   # Le uma string e armazena no endereço passado
    addi  sp, sp, -8
    sw    s0, 4(sp)
    sw    ra, 0(sp)

    mv    s0, a0
    li    a0, 0x130
    ecall           # inicia a leitura do teclado
l4: li    a0, 0x131 # tenta ler um caracter
    ecall

    beq   a0, zero, fiml4 # se for zero, terminou de ler
    li    t0, 1
    beq   a0, t0, l4
    sb    a1, 0(s0)
    addi  s0, s0, 1
    j     l4

fiml4: 
    sb    zero, 0(s0) # coloca o zero no final da string
    lw    ra, 0(sp)
    lw    s0, 4(sp)
    addi  sp, sp, 8
    ret


ConverteNumero:  # Recebe uma string e converte para número
    li    t0, 0      # define valor inicial do número
l5: lbu   t1, 0(a0)
    beq   t1, zero, fiml5 # se for zero, terminou de ler
    addi  a0, a0, 1
    addi  t1, t1, -48     # converte de ASCII para decimal
    li    t2, 10
    mul   t0, t0, t2      # multiplica o número atual por 10
    add   t0, t0, t1      # soma o valor lido ao número
    j     l5

fiml5:
    mv    a0, t0
    ret


NovaLinha:    # Imprime um caractere de nova linha
  li a0, 11
  li a1, 13
  ecall

  ret