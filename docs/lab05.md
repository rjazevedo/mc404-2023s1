# Laboratório 5

Agora é a vez de utilizar a memória!

!!! tip "Dicas"
    * Você não precisa entregar nenhum código como resposta. Procure entender os conceitos e explorar as variações.
    * Você pode utilizar o [simulador RISC-V](https://ascslab.org/research/briscv/simulator/simulator.html) para testar os códigos que você desenvolver. Para isso, veja as dicas fornecidas logo abaixo.
    * Não deixe de colocar comentários nos seus códigos. Procure organizar o código de forma que ele fique mais fácil de entender.
    * As dicas desse laboratório estão colapsadas. Para expandi-las, clique na pequena seta do lado direito da caixa de texto.

## Um pouco sobre a organização da memória

Como você já sabe, no simulador atual, seu programa começa a executar através do *label* `main` (em português, as vezes, *label* é traduzido como rótulo, o que faz valer a analogia que você está apenas dando um nome para uma posição de memória). Note que não estamos necessariamente falando de uma função `main`, muito embora você tenha tratado esse ponto do programa como uma função. O simulador precisa saber apenas por onde começar e ele vai seguindo o seu código. Você consegue notar que ele continua simulando seu programa até encontrar um `ret`, quando retorna para a parte cinza do código e depois fica em loop infinito.

Você pode colocar quantos *labels* quiser no seu código. Eles podem ter utilidades distintas e você sempre utilizou para marcar posições do código até agora, tanto para o início (`main`) quanto para lugares para onde seu programa deve saltar (`loop`, `else` e `fim`).

Agora você vai encontrar um novo uso para os *labels*, você vai marcar posições de memória que contém dados e vai utilizar esses dados em seu programa. Assim como os `labels` para instruções, eles também só servem para facilitar sua organização, uma vez que você também pode indicar diretamente a posição de memória que você quer utilizar, mas isso torna o código mais difícil de entender.

## Acessando a memória

Agora você vai aprender a utilizar a memória para armazenar dados e utilizar esses dados em seu programa. Para isso, você vai utilizar a instrução `lw` (load word) que carrega uma palavra (32 bits) da memória para um registrador. A instrução `sw` (store word) faz o contrário, ela armazena uma palavra de um registrador na memória.

Existem duas opções de regiões de memória que você pode utilizar, uma para armazenar dados que somente podem ser lidos (constantes) e outro para armazenar dados que podem tanto ser lidos quanto escritos (variáveis). A região de memória para dados constantes é chamada de `.rodata` e a região de memória para dados variáveis é chamada de `.data`. Existe uma terceira região de memória, chamada de `.text`, que é utilizada para armazenar o código do programa, que você já tem utilizado sem escrever no código mas, agora que precisa trocar de região, pode ser necessário utilizar.

Juntamente com esses marcadores de trechos do programa, você deve utilizar a palavra reservada `.word` para indicar que o que vem a seguir é um dado. Por exemplo, se você quiser armazenar o número 10 na memória, você pode escrever:

```mipsasm
.data
    .word 10
```

??? tip "Dica"
    Esse código pode ser reconhecido como:
    ```c
    int a = 10;
    ```

Você pode repetir quantas vezes quiser a linha `.word 10` para armazenar mais números na memória. Por exemplo, se você quiser armazenar os números 10, 20 e 30, você pode escrever:

```mipsasm
.data
    .word 10
    .word 20
    .word 30
```

??? tip "Dica"
    Esse código pode ser reconhecido como:
    ```c
    int vetor[3] = {10, 20, 30};
    ```

Você pode utilizar qualquer nome para os *labels* que você utilizar para marcar as posições de memória. Por exemplo, se você quiser armazenar os números 10, 20 e 30 na memória e quiser que a posição de memória que contém o número 10 seja marcada com o *label* `vetor`, você pode escrever:

```mipsasm
.data
vetor: 
    .word 10
    .word 20
    .word 30
.text
main:
    lui s0, %hi(vetor)
    addi s0, s0, %lo(vetor)
    lw t0, s0, 0
    ...
```

Veja que não há definição do tamanho desse vetor, você simplesmente marcou onde ele começa, o tamanho do vetor está na sua cabeça e no comportamento correto do código e nada impedirá que você acesse a quarta posição do vetor se você fizer um código errado. O código foi complementado com o `.text` para indicar que a partir daqui você está voltando a utilizar a região de memória para o código do programa (a partir de agora, é recomendado que você utilize o `.text` antes do label `main`) seguido do label `main`. Como o endereço do vetor tem 32 bits, você precisará de duas instruções para carrega-lo num registrador, a instrução `lui` carregará os bits mais significativos e o `addi` complementará o endereço com os bits menos significativos. Como o endereço nesse simulador é pequeno, daria para utilizar apenas uma instrução, mas é bom ter a prática de carregar os endereços inteiros. Outros simuladores implementam a pseudo-instrução `la` que é convertida diretamente nessas duas instruções. A instrução `lw` (load word) carrega uma palavra (32 bits) da memória para um registrador. A instrução `sw` (store word) faz o contrário, ela armazena uma palavra de um registrador na memória.


!!! note "Atividade 1"
    Complete o código acima para que ele imprima a soma dos 3 números armazenados no vetor na tela.

??? tip "Dica"
    A instrução `lw` carrega uma palavra (32 bits ou 4 bytes) da memória a partir da posição indicada pela soma do segundo registrador com o número (imediato) a seguir. É importante destacar que, ao ler uma palavra, o endereço indicado deve estar numa posição de memória múltipla de 4 (você pode utilizar endereços que não sejam múltiplos de 4, mas isso tem o potencial de fazer seu processador ficar muito mais lento nesses acessos).

!!! note "Atividade 2"
    Altere o código anterior para que ele incremente cada um dos elementos do vetor (some o valor 1 a cada elemento e guarde o resultado na mesma posição de memória) e imprima o novo vetor na tela.

!!! note "Atividade 3"
    Declare 2 vetores com 5 elementos cada um e some os elementos de mesmo índice dos vetores e guarde o resultado em um terceiro vetor. Imprima a soma de todos os elementos do terceiro vetor na tela.

??? tip "Dica"
    Embora não faça distinção no seu código, os dois vetores que serão apenas lidos devem ser declarados na região de memória para dados constantes (`.rodata`) e o vetor que será lido e escrito deve ser declarado na região de memória para dados variáveis (`.data`). **Utilize um laço for para facilitar essa atividade**.

## E as matrizes?

Você já aprendeu a utilizar vetores para armazenar dados e utilizar esses dados em seu programa. Agora você vai aprender a utilizar matrizes.

Uma matriz nada mais é que um vetor de vetores. Então, você precisa declarar a quantidade correta de dados para fazer seu acesso. Além disso, é importante que você saiba calcular corretamente onde ficarão todos os elementos da sua matriz. A forma mais convencional é considerar as posições consecutivas para endereços consecutivos, organizando a matriz por linhas. Por exemplo, veja a matriz 3x4 abaixo com os elementos organizados por linhas, onde cada célula tem o valor do indíce necessário para acessar o elemento:

|||||
|:-:|:-:|:-:|:-:|
|0|1|2|3|
|4|5|6|7|
|8|9|10|11|

Essa matriz funciona como um vetor de 12 (=3 x 4) posições e a organização real como matriz está apenas na sua mente e no seu código. Não há distinção alguma entre a matriz acima e um vetor de 12 posições! É importante lembrar que os índices de linha e coluna devem começar com 0, então, para acessar o elemento na linha 0 e coluna 2, você utiliza o índice 2. Para acessar o elemento na linha 2 e coluna 3, você utiliza o índice 11 (=2 x 4 + 3).

!!! note "Atividade 4"
    Declare uma matriz de dimensões 2x3, com valor zero em todas as posições. Faça um programa que preencha a posição i, j com o valor (i+j). 

## Strings são vetores de caracteres

Uma string é uma sequência de caracteres. Como, para o simulador, todos os caracteres estão codificados em ASCII, o tamanho necessário para uma string é exatamente a quantidade de caracteres que você quer armazenar nela. Lembre-se que, quando falamos da linguagem C, toda string é terminada com um caracter de código ASCII 0 (representado pelo '\0') mas, no nosso simulador, ao ler uma string, os caracteres não lidos serão preenchidos com espaço (caracter de código ASCII 32).

Você pode, então, declarar uma string declarando um vetor do tamanho relevante.

!!! note "Atividade 5"
    Declare uma string com capacidade para armazenar 20 caracteres e faça a leitura da string pelo teclado. Como seu usuário não precisa ter digitado exatamente 20 caracteres, você deve contar quantos caracteres ele digitou e imprimir o tamanho da string digitada na tela.

??? tip "Dica"
    * Você pode ler strings utilizando a chamada de sistema número 6 (`addi t0, zero, 6`) que precisa passar a0 como o endereço de memória onde a string será armazenada (não deixe de declarar antes) e a1 como o tamanho máximo da string que você quer ler.
    * Se você preencher a string com zeros antes de chamar a `ecall`, você pode contar todos os caracteres que não são zero do vetor para saber o tamanho da string. Atenção para o caso da string de 20 caracteres!
    * Você pode utilizar a instrução `lb` para ler um byte da memória e armazená-lo no registrador, no lugar do `lw` que você utilizou para ler uma palavra, assim você pode percorrer a string byte a byte.

## Desafio final

Agora que você conhece as estruturas lineares, você também deve estar pensando em como armazenar um `struct` da linguagem C em memória, não? Estruturas são apenas elementos de dados compostos por outros elementos de dados e você só precisa reservar posições sucessivas de memória para coloca-los. Por exemplo, se você tem uma estrutura com 3 campos, cada um com 4 bytes, você precisa reservar 12 bytes de memória para armazenar essa estrutura. Se você tem uma estrutura com 2 campos, um inteiro de 4 bytes e um vetor de 10 caracteres, você precisa reservar 14 bytes de memória para armazenar essa estrutura. É comum que os valores de memória sejam *arredondados* para múltiplos de 4 para facilitar os acessos. Considere o código abaixo em C:

```c
struct {
    int x, y;
} ponto;
```

Esse código declara a estrutura `ponto` com 2 campos, `x` e `y`. Como cada um deles armazena um inteiro de 4 bytes, você precisa declarar duas palavras (8 bytes) para armazena-los. Note que a declaração, em assembly, ficará idêntica à declaração de um vetor de 2 posições. Novamente, o que muda aqui é o conceito que está na sua cabeça. Por isso, não deixe de dar um nome sugestivo à sua estrutura, para que você possa lembrar o que ela representa, além de colocar comentários no código.

!!! note "Atividade 6"
    Declare um vetor com 5 pontos, defina os valores iniciais na declaração e, supondo que esses são pontos no espaço, implemente um programa que detecte o ponto mais à direita. Se houver empate, escolha o mais acima. Imprima as coordenadas desse ponto na tela.

??? info "Dica"
    Parece complicado? Você já sabe cada um dos passos. Experimente colocar primeiramente os comentários do seu código conforme abaixo e vá preenchendo as partes que faltam com instruções:
    ```mipsasm
    # declaração do vetor de pontos com 5 posições de 2 inteiros cada
    ...
    # função main
    ...
    # copia o primeiro ponto para os registradores de ponto superior direito
    ...
    # loop para percorrer os demais pontos do vetor
      ...
      # compara a coordenada x do ponto atual com a coordenada x do ponto superior direito
      ...
      # compara a coordenada y do ponto atual com a coordenada y do ponto superior direito
      ...
    # imprime o ponto superior direito na tela
    ```

## Conclusões

Agora você tem consciência de que tudo o que seu computador sabe é ler e escrever da memória, não? Você declarou posições de memória no seu programa e utilizou tanto como vetores, matrizes e estruturas fazendo operações diferentes em cada caso.

!!! success "Resumo"
    Você aprendeu como armazenar vetores em memória e ler e escrever nas posições de memória. Você também aprendeu a ler strings e a declarar estruturas de dados.
