# Atividade 1

Nessa atividade, você terá que utilizar a tela do robô do simulador para mostrar informações.

!!! tip "Regras gerais"
    * Essa atividade é individual e você não pode olhar nem compartilhar código com outros colegas
    * Você pode conversar com outros colegas sobre a atividade, mas não pode compartilhar código
    * Seu código deve ser desenvolvido individualmente
    * Entregue no Google Classrom o arquivo `a1.s` com seu código. 
    * Coloque um comentário no início do seu código contendo seu RA e nome completo.

## Utilize a tela do robô para mostrar informações

Você pode ligar a visualização do robô de forma similar ao que fez para ligar o display de pontos. A tela do robô é uma matriz de 12 linhas por 16 colunas e só tem uma cor (verde). Você pode ligar e desligar linhas completas da tela através da ecall 0x110. Essa ecall recebe 3 parâmetros:

* `a0`: 0x110 (índice da ecall da tela do robô)
* `a1`: número da linha (0 a 11)
* `a2`: número binário de com os bits 15-0 indicando se cada led deve ser aceso ou não (o bit 15 representa o led mais à esquerda). Ex.: 0x3 acende os dois leds à direita

Veja mais informações e exemplo no manual do simulador.

## Faça um programa que mostre seu RA na tela do robô, um dígito por vez

Seu programa deve mostrar o seu RA na tela do robô, um dígito de cada vez, do mais à esquerda ao mais à direita. Você tem duas formas de fazer o trabalho e deve escolher uma delas:

1. Mostre um dígito por vez, aguarde uma pausa e mostre o próximo dígito e assim sucessivamente até o último. (vale até 7 pontos)
1. Mostre os dígitos deslocando da direita para a esquerda, como se fosse um painel animado. Nesse caso, uma pequena pausa deve ser feita entre cada movimento. (vale até 10 pontos)

Em ambos os casos, implemente uma função chamada `Pausa` que faz uma pequena pausa através de um laço contando até um valor que você escolher. Essa função deve receber um parâmetro que indica quantas vezes o laço deve ser executado. Por exemplo, se você chamar `Pausa(1000)`, o laço deve ser executado 1000 vezes. Escolha um valor que faça a pausa ser perceptível, mas não muito longa.

??? tip "Dicas"
    * Declare vetores com os padrões de bits de cada dígito, para ficar mais fácil desenha-los na tela.
    * Faça funções para mostrar um dígito ou um dígito se deslocando conforme sua escolha.
    * Você pode escrever números binários utilizando o prefixo 0b. Ex.: 0b1010 é o número 10 em binário.
