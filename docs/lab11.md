# Laboratório 11

Revisão dos tópicos vistos

!!! tip "Dicas"
    * Você não precisa entregar nenhum código como resposta. Procure entender os conceitos e explorar as variações.
    * Você vai utilizar um novo simulador, chamado Venus, que pode ser executado online ou como plugin dentro do Visual Studio Code. Vamos utilizar preferencialmente a versão do VSCode pois tem mais componentes para praticarmos.
    * Não deixe de colocar comentários nos seus códigos. Procure organizar o código de forma que ele fique mais fácil de entender.
    * As dicas desse laboratório estão colapsadas. Para expandi-las, clique na pequena seta do lado direito da caixa de texto.
    * Você pode consultar [as chamadas de sistema](https://github.com/61c-teach/venus/wiki/Environmental-Calls) online e também na documentação do simulador.

## Recapitulando o que vimos até agora

Esse laboratório tem o objetivo de recapitular os assuntos vistos nos laboratórios anteriores e propor atividades para relembrar os assuntos. Você pode aproveitar os códigos passados e fazer adaptações para as atividades abaixo. Não deixe de revisar suas implementações e ver como faria diferente agora! A gestão da pilha e convenções de chamada devem ser praticadas em cada uma das atividades abaixo.

### Chamadas de sistema

No primeiro simulador, as chamadas de sistema utilizavam registradores ```a``` e ```t``` enquanto o novo simulador utiliza apenas registradores ```a```, de forma compatível com as convenções de chamadas de funções. Entretanto, o novo simulador não tem uma função para leitura de strings ou números, deixando para o programador apenas a funcionalidade de leitura de tecla. Baseada nessa chamada de sistema, você implementou uma função de leitura de string e outra para números. Revisando esse código, faça a seguinte atividade:

!!! note "Atividade 1"
    Implemente um programa que leia um número inteiro e retorne o valor lido. A função deve ser capaz de ler números negativos e positivos. Você pode utilizar a função de leitura de string para ler o número e depois converter para inteiro. Seu programa deve ler múltiplos números e parar apenas quando o número digitado for zero. Após ler o zero, seu programa deve imprimir o maior e menor números lidos (ignorando o zero).

### Estruturas de dados

Você aprendeu a calcular quanto de espaço de memória uma estrutura gasta e como armazenar um vetor e uma estrutura em memórias. Você também aprendeu a alocar a memória dinamicamente para essas estruturas. Revisando esse código, faça a seguinte atividade:

!!! note "Atividade 2"
    Baseado na estrutura de dados com um ponto no espaço (x e y), faça uma função que leia e preencha um ponteiro dessa estrutura. Faça um programa que leia primeiro um número N (<= 10) e depois leia N pontos. Restrinja os pontos aos valores que você consegue mostrar no display. Após ler os N pontos, pinte-os no display utilizando a syscall correta e a mesma cor para todos.

### Alocação dinâmica

Vocẽ não precisa saber a quantidade de elementos antecipadamente, você pode alocar memória dinamicamente. 

!!! note "Atividade 3"
    Repita o programa anterior recebendo 3 números por ponto: as coordenadas x, y e a cor. Você deve ler N pontos e pintá-los no display. Você pode utilizar a syscall correta para pintar cada ponto com sua cor. Como você não sabe o valor de N, você deve alocar o vetor dinamicamente após ler N.

### Strings

Você utilizou strings em diversos momentos dessa disciplina. Em especial, você tem utilizado strings como representadas pela linguagem C, com um caracter \0 ao final. Você também aprendeu a ler strings e a imprimir strings. Revisando esse código, faça a seguinte atividade:

!!! note "Atividade 4"
    Implemente uma função que receba uma string e retorne o tamanho da string. Você pode utilizar a função de leitura de string para ler uma string e depois imprimir o tamanho da string lida. Você pode utilizar a syscall correta para imprimir o tamanho da string.

!!! note "Atividade 5"
    Implemente um programa que leia duas strings e copie o valor das duas contatenadas para uma outra string, deixando um espaço entre as duas. Ao final, imprima a string resultante.

### Segurança

Essa atividade será na base de desafio também onde você deve criar um programa que explore o estouro de pilha como o exemplo do Laboratório 9. A sugestão é utilizar leitura de números inteiros em um vetor que deve estar na pilha. Dessa forma, ler mais números causará a sobreposição de dados na memória que serão lidos posteriormente e guardados em registradores, causando o problema visto no Laboratório 9.

!!! note "Atividade 6"
    Faça um programa que gere um estouro de pilha utilizando as técnicas vistas no Laboratório 9.

## Conclusões

Esse laboratório foi uma revisão da última parte da disciplina.

!!! success "Resumo"
    Apesar de já ter visto todo o conteúdo até aqui, você revisou e relembrou o que já tinha praticado anteriormente.