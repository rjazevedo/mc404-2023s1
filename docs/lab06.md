# Laboratório 6

Finalmente chegou a hora das funções!

!!! tip "Dicas"
    * Você não precisa entregar nenhum código como resposta. Procure entender os conceitos e explorar as variações.
    * Você pode utilizar o [simulador RISC-V](https://ascslab.org/research/briscv/simulator/simulator.html) para testar os códigos que você desenvolver. Para isso, veja as dicas fornecidas logo abaixo.
    * Não deixe de colocar comentários nos seus códigos. Procure organizar o código de forma que ele fique mais fácil de entender.
    * As dicas desse laboratório estão colapsadas. Para expandi-las, clique na pequena seta do lado direito da caixa de texto.

## Um pouco sobre a pilha

A pilha é uma estrutura de dados onde o próximo elemento é inserido no topo e sempre se retira elementos do topo da pilha. O seu processador não tem uma implementação de pilha, mas você deve garantir o comportamento de uma pilha para a correta execução do programa. Assim, dados que você quiser guardar temporariamente, podem ser colocados na pilha. Variáveis locais do seu programa também podem ser alocadas na pilha.

No modelo de memória do computador, a pilha sempre cresce em direção a endereços menores. Então, o registrador que aponta para o topo da pilha, o `sp`, começa com um valor alto e vai diminuindo conforme mais elementos são agregados à pilha. É sua responsabilidade fazer os ajustes necessários tanto no `sp` quando nas leituras e escritas na pilha. O `sp` aponta sempre para o último elemento que foi colocado na pilha. Veja o código abaixo da função `void MultiplicaVetor(unsigned N, unsigned *v, unsigned fator)`, que recebe o número N de elementos do vetor, o vetor e um fator como parâmetros. A função multiplica todos os elementos do vetor pelo fator utilizando a função `int Multiplica(unsigned x, unsigned y)` , que não será mostrada aqui.

```mipsasm
MultiplicaVetor:
    # Movimenta o apontador da pilha 4 posicoes para baixo (16 bytes) e guarda 4 registradores na pilha
    addi sp, sp, -16
    sw   s0, sp, 12
    sw   s1, sp, 8
    sw   s2, sp, 4
    sw   ra, sp, 0

    mv   s0, a0
    mv   s1, a1
    mv   s2, a2

for:
    beq  s0, zero, fim
    lw   a0, s1, 0
    mv   a1, s2
    call Multiplica
    sw   a0, s1, 0
    addi s1, s1, 4
    addi s0, s0, -1
    j    for

fim:
    # Movimenta o apontador da pilha 4 posicoes para cima (16 bytes) e recupera 4 registradores da pilha
    lw   ra, sp, 0
    lw   s2, sp, 4
    lw   s1, sp, 8
    lw   s0, sp, 12
    addi sp, sp, 16
    ret
```

Note que a organização da pilha é feita no início e no final da função, bastando que você saiba quais registradores precisam ser preservados. Nesse caso, como a função `Multiplica` está sendo chamada, é necessário preservar todos os registradores `a` além dos obrigatórios `s` que serão utilizados. 

??? tip "Dica"
    Você sempre deve pensar no pior caso, apesar da função `Multiplica` utilizar apenas os registradors `a0` e `a1`, você não tem certeza se ela não chama outra função que utilize o `a3` que você precisa. Portanto, todos os parâmetros precisam ser preservados para utilização no laço.

!!! note "Atividade 1"
    Implemente um programa que declare um vetor de 5 posições e chame a função acima para multiplicar todos os elementos por 10.

!!! note "Atividade 2"
    Implemente a função `unsigned Multiplica(unsigned x, unsigned y)`.

## Nem todas as funções precisam utilizar a pilha

Existe um tipo especial de função, denominada função folha, que não chama nenhuma outra função e não precisa utilizar a pilha. Essas funções costumam ser implementadas utilizando apenas os registradores `t` e `a` que não precisarão ser chamados. Nesse sentido, elas são mais eficientes pois não precisam realizar acessos à memória.

A função `int SomaVetor(unsigned N, unsigned *v)` abaixo recebe o número N de elementos do vetor e o vetor como parâmetros pode ser implementada como função folha pois não precisa chamar nenhuma outra função. Como mencionado anteriormente, ela terá que se restringir a utilizar apenas os registradores `t` e `a`.

!!! note "Atividade 3"
    Implemente a função `int SomaVetor(unsigned N, unsigned *v)` utilizando apenas os registradores `t` e `a`. Altere seu código anterior para chamar essa função no lugar da `MultiplicaVetor`.

## Variáveis locais também são armazenadas na pilha

Quando você precisa de variávies locais no seu programa, ou você coloca em registradores (se couber) ou você deve alocar na pilha. Para isso, você precisa atualizar o `sp` corretamente para reservar espaço suficiente para sua variável. Isso significa:

1. Reservar o espaço para os registradores que quiser salvar
1. Salvar os registradores nos seus lugares
1. Reservar outro espaço para as variáveis locais

O procedimento reverso deve ser utilizado no encerramento da função. Você também precisará utilizar o `sp` para calcular o endereço das suas variáveis locais corretamente.

??? tip "Dica"
    É por estarem na pilha que as variáveis locais das funções das linguagens de alto nível não pode ser retornadas por elas. Ao final da função você restaura o `sp` ao valor inicial e aquela posição de memória fica disponível para outros acessos.

!!! note "Atividade 4"
    Crie uma função `int TamanhoString()` que tenha uma string como variável local (deve ser guardada na pilha). Leia a string do teclado e retorne apenas o tamanho da string. Você deve criar e utilizar também uma função chamada `int strlen(char *s)` para calcular o tamanho da string de acordo com as convenções do simulador (igual você já fez anteriormente).

## Funções são chamadas por meio de instruções

Como visto em sala de aula, a pseudo-instrução `call` é uma implementação da instrução `jal` (especificamente, `jal ra, funcao`). Mas você também pode utilizar a instrução `jalr` que utiliza também um registrador como parâmetro. Assim, você pode passar o endereço de uma função por um registrador. Por exemplo, se você tem o endereço de uma função no registrador `s0`, você pode utilizar `jalr ra, s0, 0` para chamar a função.

Você pode agora implementar funções distintas, guardar o endereço delas em um registrador e, com isso, gerar um código que chame de acordo com a condição que for realizar. Vamos fazer uma calculadora com 2 operações: Soma e Subtração. Você pode implementar duas funções, cada uma capaz de receber 2 registradores e retornando o resultado da operação. Como próximo passo, você pode criar um vetor de 2 posições com a estrutura abaixo:

```c
typedef struct {
    char caracter;
    int (*op)(int, int);
} Operacao;
```

Você pode preencher essa estrutura com o caracter + e o endereço da função de soma e o caracter - e o endereço da função de subtração. Agora, você pode ler um caracter do teclado e chamar a função correspondente ao caracter lido. Considere que a `struct` tenha 8 bytes e deixe 4 reservados para o caracter e 4 para a operação.

??? tip "Dica"
    Para saber o endereço da função, você pode coloca-la no início do seu programa (antes do `main`) e olhar no mapa de memória o endereço onde a primeira instrução está localizada.

!!! note "Atividade 5"
    Implemente uma calculadora com 2 operações: Soma e Subtração. Você deve ler um número, um caracter e outro número do teclado e imprimir o resultado da operação correspondente ao caracter lido. Utilize a estrutura `Operacao` para armazenar as funções.

## Desafio final

Agora que você já sabe como implementar funções, você pode implementar uma função recursiva para calcular o fatorial de um número. Para isso, você deve implementar uma função que receba um número e retorne o fatorial dele. Essa função deve chamar a si mesma para calcular o fatorial do número anterior.

!!! note "Atividade 6"
    Implemente uma função recursiva que calcule o fatorial de um número. Seu programa deve ler um número de entrada e imprimir o fatorial dele após chamar a função. Utilize a função Multiplica que você já implementou anteriormente.

??? tip "Dica"
    Digite números pequenos pois a conta pode demorar um pouco.

## Conclusões

Agora você já conseguiu reconstruir o conceito de funções como trechos de código com parâmetros e variáveis locais. Você também aprendeu a utilizar a pilha para armazenar os parâmetros e variáveis locais das funções. Por fim, você notou que funções recursivas são fáceis de implementar uma vez que você entenda como a pilha funciona.

!!! success "Resumo"
    Você aprendeu a representar funções recursivas, ponteiros para funções e variáveis locais!
