# Laboratório 9

Vamos falar sobre segurança?

!!! tip "Dicas"
    * Você não precisa entregar nenhum código como resposta. Procure entender os conceitos e explorar as variações.
    * Você vai utilizar um novo simulador, chamado Venus, que pode ser executado online ou como plugin dentro do Visual Studio Code. Vamos utilizar preferencialmente a versão do VSCode pois tem mais componentes para praticarmos.
    * Não deixe de colocar comentários nos seus códigos. Procure organizar o código de forma que ele fique mais fácil de entender.
    * As dicas desse laboratório estão colapsadas. Para expandi-las, clique na pequena seta do lado direito da caixa de texto.
    * Você pode consultar [as chamadas de sistema](https://github.com/61c-teach/venus/wiki/Environmental-Calls) online e também na documentação do simulador.

## Recapitulando pilha

A pilha é uma estrutura de dados gerenciada completamente por software (seu programa) e utilizada para guardar as informações relevantes da execução do seu programa. Dentro de cada função, você utiliza a pilha para salvar:

* Registradores `s` que você tem intenção de modificar
* Registrador `ra` se você for chamar outra função, pois a chamada a outra função irá sobrepor o valor de `ra`
* Argumentos que você precisa passar para a função que você está chamando que não couberem nos registradores `a` (como o nono, décimo, etc.)
* Variáveis locais que você precisa alocar na memória

O início de uma função tem, então a seguinte estrutura se não houver variável local:

```mips-asm
funcao: addi sp, sp, -12
        sw   s1, 8(sp)
        sw   s0, 4(sp)
        sw   ra, 0(sp)
```

Supondo a necessidade de uma variável local do tipo vetor de 10 inteiros, será necessário alocar mais 40 bytes na pilha e você pode fazer da seguinte forma:

```mips-asm
funcao: addi sp, sp, -52
        sw   s1, 48(sp)
        sw   s0, 44(sp)
        sw   ra, 40(sp)
        mv   s0, sp      # s0 aponta para o início do vetor
```

Veja que o endereço do vetor é calculado utilizando o `sp` como referência para o endereço. Não há distinção, na pilha, sobre o conteúdo que está armazenado, da mesma forma que não há na área de memória `.data`. Se fossem necessários dois vetores, um de 6 inteiros (24 bytes) e outro com 4 inteiros (16 bytes), o código deveria ser alterado para:

```mips-asm
funcao: addi sp, sp, -52
        sw   s1, 48(sp)
        sw   s0, 44(sp)
        sw   ra, 40(sp)
        mv   s0, sp      # s0 aponta para o início do vetor de 6 inteiros
        addi s1, sp, 24  # s1 aponta para o início do vetor de 4 inteiros
```

Novamente, ficou como responsabilidade do programador calcular os endereços no espaço de memória reservado ao movimentar o `sp`.

!!! tip "Dica"
    Caso seja necessário alocar alguma variável cujo tamanho não é conhecido no momento da escrita do código (desenvolvimento), você pode separar o ajuste do `sp` em duas partes, uma para a parte fixa guardando os registradores e variáveis de tamanho conhecido e outra para a parte variável, fazendo as contas necessárias no código e ajustando o `sp` de forma complementar. O mesmo deve ser feito ao final do código.

É sempre importante relembrar que temos apenas sequências de bytes na memória, o uso desses bytes é dado sempre pelo seu programa.

!!! note "Atividade 1"
    Faça uma função `int LeNumero()` que leia um número inteiro do teclado e retorne esse número. Faça um programa (main) que chame essa função e imprima o número lido.

!!! note "Atividade 2"
    Faça uma função `void LeVetor(int *v, int N)` que leia N números inteiros do teclado através da função `LeNumero` e armazene no vetor `v`. Faça um programa (main) que chame essa função e imprima os números lidos.

!!! note "Atividade 3"
    Faça uma função `int Media(int *v, int N)` que receba um vetor de inteiros e retorne a média dos valores armazenados no vetor. Faça um programa (main) que chame as funções `LeVetor` e `Media` e imprima a média dos valores lidos.

!!! note "Atividade 4"
    Faça um programa (main) que leia um número `N` e chame uma função que receba um parâmetro `N`, leia `N` números e retorne quantos deles são maiores que a média. Você também deve utilizar as funções das atividades anteriores.

## Lembra que leituras do teclado podem ser perigosas?

O código abaixo tem um bug. Apenas leia os comentários da função `main` e tente entender o que ele deveria fazer.

```mips-asm
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
```

!!! note "Atividade 5"
    Copie e cole o código no simulador, não altere nenhuma das linhas do código. Digite, como entradas, os números (um por linha): 3, 1, 2, 3, 276. Aconteceu o que você esperava?

## Desafio final

Onde está o problema do programa?

!!! note "Atividade 6"
    Corrija o programa acima para que ele siga sua expectativa baseada no que está indicado na `main`.

## Conclusões

Você praticou pilha e também aprendeu um pouco sobre o perigo que leitura de dados não dimensionados pode ocasionar.

!!! success "Resumo"
    Pilhas servem para ajudar a construir programas mais complexos, liberando os registradores para serem utilizados por outras funções. Mas deve ser utilizada com cuidado, pois temos tanto registradores quanto variáveis na pilha e isso pode causar impactos na execução do programa.
