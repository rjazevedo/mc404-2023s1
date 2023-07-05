# Laboratório 10

Alocação de Memória Dinâmica

!!! tip "Dicas"
    * Você não precisa entregar nenhum código como resposta. Procure entender os conceitos e explorar as variações.
    * Você vai utilizar um novo simulador, chamado Venus, que pode ser executado online ou como plugin dentro do Visual Studio Code. Vamos utilizar preferencialmente a versão do VSCode pois tem mais componentes para praticarmos.
    * Não deixe de colocar comentários nos seus códigos. Procure organizar o código de forma que ele fique mais fácil de entender.
    * As dicas desse laboratório estão colapsadas. Para expandi-las, clique na pequena seta do lado direito da caixa de texto.
    * Você pode consultar [as chamadas de sistema](https://github.com/61c-teach/venus/wiki/Environmental-Calls) online e também na documentação do simulador.

## Recapitulando Organização de Memória

Conforme visto em sala de aula, a memória do programa é dividida em 4 partes:

* Uma parte de código, onde ficam as instruções do programa, também identificadas com o comando `.text` em assembly;
* Uma parte de dados pré-alocados, onde ficam as variáveis globais, também identificadas com o comando `.data` em assembly;
* Uma parte para a pilha, que está no final do espaço de endereçamento e cresce para baixo;
* Uma parte para o heap, que está no início do espaço de endereçamento, logo após os dados estáticos, e cresce para cima.

O foco do laboratório atual é a alocação de dados no heap, também chamado de alocação dinâmica de memória. Sempre que seu programa precisar de uma quantidade de memória que não é conhecida em tempo de compilação, você precisará alocar memória no heap. Isso acontece, por exemplo, quando você precisa de um vetor de tamanho variável, ou quando você precisa de uma estrutura de dados que não é conhecida em tempo de compilação. Também acontece quando uma função deseja retornar um vetor que não foi alocado globalmente (na área `.data`).

Até aqui, toda vez que vocẽ precisou de um vetor (ou string), você fez uma declaração externa, na área `.data` e passava o endereço desse vetor para as funções que precisavam dele. Isso funciona bem, mas tem algumas desvantagens:

* O vetor precisa ser declarado em tempo de compilação, o que significa que você precisa saber o tamanho do vetor antes de executar o programa;
* O vetor precisa ser declarado globalmente, o que significa que ele tem um escopo maior que o necessário;
* O vetor precisa ser declarado com um tamanho fixo, o que significa que você precisa alocar mais memória do que o necessário.

A alocação dinâmica de memória resolve esses problemas. Com ela, você pode alocar memória em tempo de execução, alocar memória localmente e alocar apenas a quantidade de memória necessária. Para você que já programou em C, isso é o que as funções `malloc` e `calloc` fazem, elas alocam memória dinamicamente.

O Sistema Operacional ou, no nosso caso, o Simulador, possui uma chamada de sistema para alocar memória, a `sbrk` (`a0 = 9`). Essa chamada de sistema recebe um parâmetro em `a1`, que é a quantidade de memória que você deseja alocar, e retorna o endereço da memória alocada em `a0`. 

!!! note "Atividade 1"
    Faça uma função `char * LeString()` que leia uma string do teclado e retorne um ponteiro para essa string. Para isso, você também precisará de um programa (main) que chame essa função e imprima a string lida. Você deve alocar a memória dinamicamente para colocar sua string mas, como você não sabe o tamanho da string de antemão, você pode declarar, globalmente, um buffer (string), leia sua string para essa posição de memória e depois aloque uma nova memória do tamanho correto (não esquecer do '\0' ao final) para copiar a string lida. Você pode utilizar a função `strcpy` para copiar a string, que você já implementou anteriormente no Laboratório 8.

??? tip "Dica"
    Você já implementou uma função para ler string nos laboratórios anteriores, traga o código para cá.

## Estruturas de dados dinâmicas ajudam a guardar uma quantidade variável de dados

Quando você aprendeu, em MC202, a utilizar listas, uma das implementações possíveis era sobre memória dinamicamente alocada. Nesse caso, a intenção sempre é utilizar apenas a quantidade necessária de memória para o número de elementos que você precisa armazenar. Suponha a seguinte estrutura de dados em C:

```c
typedef struct tpessoa {
    char nome[50];
    int idade;
    struct tpessoa *prox;
} Pessoa;
```

Essa estrutura armazena duas informações sobre uma pessoa, o nome e a idade. Quando você quiser ler os dados de uma pessoa, você precisará sempre de uma estrutura desse tipo. Se você quiser ler os dados de 10 pessoas, você precisará de 10 estruturas desse tipo. Se você quiser ler os dados de 1000 pessoas, você precisará de 1000 estruturas desse tipo. Se você quiser ler os dados de N pessoas, você precisará de N estruturas desse tipo. Como você não sabe o valor de N em tempo de compilação, você precisará alocar memória dinamicamente para armazenar essas estruturas.

!!! note "Atividade 2"
    Faça uma função `Pessoa* LePessoa()` que aloque memória para uma estrutura `Pessoa`, leia os dados de uma pessoa (nome e idade) e retorne essa estrutura. Deixe o campo `prox` com `NULL` (valor 0).

??? tip "Dica"
    Você já implementou uma função para ler string e ler números nos laboratórios anteriores, traga o código para cá.

!!! note "Atividade 3"
    Faça uma função `void ImprimePessoa(Pessoa *p)` que recebe uma estrutura do tipo `Pessoa` e imprime os dados (nome e idade) na tela.

## Mas você havia feito um código que alocava uma string de tamanho variável!

Pois é, na Atividade 1, você fez um código que lia uma string dinamicamente, então vamos ajustar sua estrutura para que ela seja dinâmica também:

```c
typedef struct tpessoa {
    char *nome;
    int idade;
    struct tpessoa *prox;
} Pessoa;
```

Nesse caso, você pode ler nomes de pessoas com qualquer tamanho e alocar memória para essa string, utilizando seu código da Atividade 1 acima.

!!! note "Atividade 4"
    Atualize o código da Atividade 2 para utilizar uma string de tamanho variável como nome, utilizando a função definida na Atividade 1. Junte com o código da Atividade 3 e imprima a estrutura como um todo.

## Agora podemos ler mais de uma pessoa

Agora que você já sabe ler os dados de uma pessoa, está na hora de ler os dados de múltiplas pessoas, para isso, basta chamar sua função de leitura mais vezes. A diferença agora é que você também deve indicar, no campo `prox` qual o endereço de memória da próxima pessoa. Então, ao chamar a função `LePessoa`, você deve utilizar o endereço retornado para atualizar o campo `prox` da pessoa anterior.

!!! note "Atividade 5"
    Faça um programa que leia múltiplas pessoas do teclado (nome e idade), construindo uma lista encadeada entre essas pessoas. Defina uma condição de parada (o que o usuário deve fazer para encerrar a entrada de dados) e implemente-a. Ao terminar a leitura, percorra a lista imprimindo os dados de todas as pessoas lidas.

## Desafio final

Você deve estar se perguntando onde está o `free` do `malloc` que acabou de utilizar? O `free` é uma forma de liberar memória dinamicamente mas ele não devolve diretamente ao Sistema Operacional sempre. Há um gerenciador de memória junto com o seu programa que pega os dados retornados pelo `free` e deixam à disposição para novos `malloc`, sempre tomando cuidado para zerar os blocos de memória que você leu. Isso é feito para evitar que você leia dados sigilosos utilizados por outras funções.

Mas como você sabe o tamanho dos dados se a syscall `sbrk` retorna apenas um ponteiro? A forma de fazer isso é criar uma estrutura auxiliar, que você utiliza para gerenciar a memória. Os programas possuem estruturas bem elaboradas para acelerar o processo de uso de memória dinâmica e nós vamos implementar um bem simples para esse mesmo uso. Tudo será baseado em uma estrutura de dados chamada `bloco`;

```c
typedef struct tbloco {
    int tamanho;
    bool ocupado;
    void *dado;
    struct tbloco *prox;
} Bloco;
```

Com essa estrutura, você pode implementar uma função `malloc` que chama a `sbrk` e aloca sempre um `Bloco` para realizar o controle das estruturas de dados ocupadas e vazias. Ao chamar `free` você simplesmente altera o campo ocupado da estrutura para falso (0). A função `malloc` deve retornar o campo `dado` da estrutura `Bloco` para que você possa utilizá-lo.

!!! note "Atividade 6"
    Implemente as funções `malloc` e `free` para seguirem a estrutura de controle dos blocos acima. Faça um programa que utilize `malloc` e `free` e que seja capaz de reutilizar um dado que foi lido anteriormente.

## Conclusões

Você aprendeu a gerenciar memória dinamicamente no seu programa e deve ter notado que, se fizer parte a parte, a complexidade pode ser melhor gerenciada!

!!! success "Resumo"
    Você aprendeu a alocar e desalocar memória dinamicamente além de fazer o gerenciamento de todo o espaço alocado. Você também aprendeu a utilizar estruturas de dados dinâmicas para armazenar uma quantidade variável de dados.