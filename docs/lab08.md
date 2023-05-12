# Laboratório 8

Revisitando strings

!!! tip "Dicas"
    * Você não precisa entregar nenhum código como resposta. Procure entender os conceitos e explorar as variações.
    * Você vai utilizar um novo simulador, chamado Venus, que pode ser executado online ou como plugin dentro do Visual Studio Code. Vamos utilizar preferencialmente a versão do VSCode pois tem mais componentes para praticarmos.
    * Não deixe de colocar comentários nos seus códigos. Procure organizar o código de forma que ele fique mais fácil de entender.
    * As dicas desse laboratório estão colapsadas. Para expandi-las, clique na pequena seta do lado direito da caixa de texto.

## Recapitulando strings

Strings são sequências de caracteres representadas em memória e codificadas de alguma forma padronizada. Até o momento, você sempre trabalhou com strings codificadas em ASCII, que é uma codificação de 8 bits (1 byte) para cada caractere. Por exemplo, a string "abc" é representada em memória como: 0x61, 0x62, 0x63. A string "abc" tem 3 caracteres, então ocupa 3 bytes de memória. É necessário ter uma forma para indicar o final da string. No simulador anterior, ao ler uma string do teclado, você indicava o tamanho máximo de caracteres que queria ler e a sua string voltava com o valor digitado seguido da quantidade necessária de espaços até completar o tamanho indicado. O novo simulador trabalha com o caracter de código ASCII 0 como finalizador de strings.

Você pode alocar memória para strings de múltiplas formas, sendo as mais comuns exemplificadas abaixo:

```mips-asm
.data
  str1: .string "abc"
  str2: .byte 0x61, 0x62, 0x63, 0x00
  str3: .word 0 0 0 0 0
  str4: .space 5
```

!!! tip "Dica"
    * A diretiva `.string` aloca memória para uma string e já preenche com os caracteres indicados. O último caracter é sempre o 0.
    * A diretiva `.byte` aloca memória para um byte e já preenche com o valor indicado. Você deve colocar o 0x00 ao final
    * A diretiva `.word` aloca memória para uma palavra (4 bytes) e já preenche com os valores indicados.
    * A diretiva `.space` aloca memória para a quantidade de bytes indicada. O valor inicial é indefinido.

É sempre importante relembrar que temos apenas sequências de bytes na memória, o uso desses bytes é dado sempre pelo seu programa.

!!! note "Atividade 1"
    O que o programa abaixo faz? Copie e cole o programa e rode no simulador novo. Você deve ver o resultado na janela de saída. Atente para as chamadas de sistema de impressão de strings. Elas estão imprimindo exatamente o que você desejaria?

```mips-asm
.data

  str1: .string "Teste de string"
  str2: .space 20
  str3: .string "Hello World"

.text
main:
  li a0, 4
  la a1, str1
  ecall          # Imprime string str1

  li a0, 11
  li a1, 13
  ecall          # Imprime caracter de nova linha (\n)

  la s0, str2
  li s1, 20
  li s3, 65
loop:
  sb s3, 0(s0)
  addi s0, s0, 1
  addi s1, s1, -1
  bne  s1, zero, loop

  li a0, 4      
  la a1, str2
  ecall          # Imprime string str2: O que vai ser impresso?

  li a0, 11
  li a1, 13
  ecall          # Imprime caracter de nova linha (\n)

  li a0, 4
  la a1, str2
  sb zero, 19(a1)
  ecall          # Imprime string str2: O que vai ser impresso?

  li a0, 11
  li a1, 13
  ecall          # Imprime caracter de nova linha (\n)

  li a0, 4
  la a1, str3
  ecall          # Imprime string str3

  li a0, 11
  li a1, 13
  ecall          # Imprime caracter de nova linha (\n)

  li a0, 10
  ecall          # Encerra o programa
  ret
```

## Acesso aos caracteres da string

As strings estão sempre em memória e você precisa utilizar instruções de leitura (load) e escrita (store) na memória para acessá-las. A forma convencional de ler caracteres de uma string é utilizando a instrução `lbu` (*load byte unsigned*) e para escrever você usa `sb` (*store byte*).

??? tip "Dica"
    * A instrução `lbu` lê um byte da memória e coloca no registrador destino. O byte lido é sempre interpretado como um valor sem sinal, não realizando a extensão de sinal que acontece se você utilizar `lb`.

!!! note "Atividade 2"
    Implemente a função `char * strcpy(char *s1, char *s2)` que copia o conteúdo da string `s2` para `s1`. Faça um programa que declare duas strings e utilize essa função para copiar. Após a cópia, você deve imprimir as duas strings para verificar se a cópia foi feita corretamente.

??? tip "Dica"
    Se você está cansado de incluir uma outra chamada de sistema para imprimir o caracter de nova linha, você pode incluir o \n ao final da string já na declaração.

## Agora vamos ler strings do teclado

Ao contrário do simulador anterior, agora você precisa ler strings caracter por caracter, usando mais de uma chamada de sistema. O simulador Venus trabalha com o mecanismo de *polling*, o que significa que você deve ficar perguntando ao simulador sobre a disponibilidade de caracteres até que receba um (ou vários). Para isso, passo a passo, você precisa:

1. Executar a chamada de sistema `0x130` para indicar que tem intenção de ler algo do teclado.
1. Executar, dentro de um laço, a chamada de sistema `0x131` para verificar se tem algum caracter disponível até não encontrar mais caracteres. A chamada 0x131 pode retornar os seguintes valores:

| Valor de a0 | Significado |
|:----:|-------------|
| 0x00 | Todos os caracteres já foram lidos |
| 0x01 | Ainda não tem caracter disponível |
| 0x02 | Tem caracter disponível e foi lido, o código dele está em a1 |

Então, se você quiser ler uma string, você precisa fazer um laço que verifica se tem caracter disponível e, se tiver, lê o caracter e armazena em algum lugar. Você pode armazenar em um vetor de caracteres ou em uma string já alocada. Se você armazenar em um vetor, você precisa ter um contador para saber quantos caracteres já foram lidos. Não se esqueça de colocar um caracter \0 ao final da string.

!!! note "Atividade 3"
    Implemente a função `char * gets(char *s)` que lê uma string do teclado e a armazena em `s`.

## Ler strings pode ser perigoso!

Qual o tamanho máximo que a string do programa anterior pode ter? Seu programa declarou uma string na memória mas sua rotina (`gets`) não sabe o tamanho dela. Se o usuário digitar uma string maior que o espaço alocado, o que acontece? Você pode testar isso no simulador.

É por esse motivo que é mais comum termos uma versão da função que recebe um tamanho máximo também. Você pode atualizar sua função para receber um segundo parâmetro (`N`) e ler, no máximo, N caracteres? (sua string tem que ter N+1 para conseguir armazenar o \0 também.).

!!! note "Atividade 4"
    Implemente a função `char * fgets(char *s, int N)` que lê uma string do teclado e a armazena em `s`. A função deve ler, no máximo, `N` caracteres.

## Mais funções sobre strings

Agora que você já sabe ler strings, você pode implementar outras funções sobre strings. Você pode implementar as seguintes funções:

* `int strlen(char *s)` que retorna o tamanho da string `s`.
* `int strcmp(char *s1, char *s2)` que compara as strings `s1` e `s2` e retorna 0 se elas forem iguais, um valor negativo se `s1` for menor que `s2` e um valor positivo se `s1` for maior que `s2`.
* `char * strcat(char *s1, char *s2)` que concatena as strings `s1` e `s2` e retorna o resultado em `s1`.

!!! note "Atividade 5"
    Implemente as funções `strlen`, `strcmp` e `strcat`.

## Desafio final

Agora que você já sabe ler e escrever strings, você pode implementar um programa que lê uma string do teclado e imprime ela invertida. Por exemplo, se o usuário digitar `abcd`, seu programa deve imprimir `dcba`. Você pode implementar uma função `void strrev(char *s)` que recebe uma string e a inverte.

!!! note "Atividade 6"
    Implemente a função `void strrev(char *s)` que recebe uma string e a inverte. Implemente um programa que lê uma string do teclado e imprime ela invertida.

## Conclusões

Você praticou mais sobre operações com strings nesse laboratório.

!!! success "Resumo"
    Você sabe que strings são conjuntos de bytes na memória que precisam ser manipulados como tal. Para isso, você deve utilizar instruções `lbu` e `sb` para acesso à memória. Você também sabe que strings são terminadas com o caracter `\0` e que você pode utilizar essa informação para implementar funções sobre strings.