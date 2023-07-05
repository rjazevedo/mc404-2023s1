# Atividade 2

Nessa atividade, você vai fazer um codificador de instruções do processador RISC-V

!!! tip "Regras gerais"
    * Essa atividade é individual e você não pode olhar nem compartilhar código com outros colegas
    * Você pode conversar com outros colegas sobre a atividade, mas não pode compartilhar código
    * Seu código deve ser desenvolvido individualmente
    * Entregue no Google Classrom e você deve entregar apenas um arquivo de código
    * Coloque um comentário no início do seu código contendo seu RA e nome completo.

## Todas as instruções do RISC-V têm uma codificação em binário

Conforme visto na aula sobre [Codificação de Instruções](../slides/assembly05.pdf), cada instrução tem sua forma de ser codificada para que o processador saiba identifica-las unicamente. Sua tarefa nessa atividade é fazer um codificador de instruções onde o usuário poderá digitar uma instrução em assembly e você deverá imprimir o código em hexadecimal correspondente à instrução codificada.

Você pode utilizar uma linguagem de sua preferência entre Python ou C que vocês já aprenderam em disciplinas anteriores e deve entregar seu código em um único arquivo que será compilado ou executado conforme o caso.

Seu programa deve ler uma instrução em assembly e imprimir o código hexadecimal correspondente. Por exemplo, se o usuário digitar o código `addi t0, zero, 4`, você deve imprimir o código `0x00400293`. Note que o número tem 32 bits e, por isso, 8 dígitos hexadecimais (incluindo os zeros necessários à esquerda). Todas as letras em hexadecimal devem estar em maiúsculas. Repita o processo de leitura de instrução e escrita do assembly até que uma linha em branco seja digitada.

Como guia de codificação, utilize os [slides da aula](../slides/assembly05.pdf) e a [Especificação das Instruções](https://github.com/riscv/riscv-isa-manual/releases/download/Ratified-IMAFDQC/riscv-spec-20191213.pdf) (em epsecial o capítulo 24) que está na bibliografia da disciplina.

Como referência para as instruções de salto, suponha que a instrução que está sendo convertida esteja na posição 1000 de memória sempre. Assim, você pode calcular o deslocamento de salto como sendo a diferença entre o endereço da instrução de destino e 1000. Por exemplo, se a instrução de salto for para o endereço 1024, o deslocamento será 24.

Você pode aceitar apenas instruções escritas em letras minúsculas e a forma mais legível do nome dos registradores (s, t, a, zero, ... ao invés de x0, x1, ...). Utilize a sintaxe do simulador atual e dos exemplos de código recente em caso de dúvidas.

Você pode considerar que todos os imediatos para toda e qualquer instrução estão em decimal.

Você deve emitir uma mensagem de erro caso não seja uma das instruções suportadas ou se a sintaxe estiver incorreta.

## Instruções a codificar

Seu programa deve ser capaz de codificar, ao menos, as instruções/pseudoinstruções abaixo:

* addi
* slli
* xor
* call
* ret
* beq
* lw
* sw
* mul
* lui

Sua nota será dada pela quantidade de instruções corretas que você for capaz de fazer dentre as indicadas acima.

## Bônus

Se você implementar a pseudoinstrução `li` com suporte a imediato de até 32 bits podendo gerar uma ou duas instruções em hexadecimal, você ganhará um bônus de 2 pontos extras nessa atividade (isso mesmo, a atividade pode valer até 12 pontos no total!).

??? tip "Dicas"
    * Ambos os simuladores que trabalhamos até agora tem a opção de mostrar a instrução codificada. Para o simulador atual, basta escolher a opção **Views** > **Assembly**.
    * Não deixe de conferir o código hexadecimal gerado pelo simulador para comparar com o seu. 
