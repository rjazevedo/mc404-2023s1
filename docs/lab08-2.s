.data
  mensagem: .string "Digite varios caracteres (vou ler ate a letra A): "
  str1: .space 20

.text
main:
  li a0, 4
  la a1, mensagem
  ecall

  li a0, 0x130
  ecall

  li s0, 65
  li s2, 1

loop:
  li a0, 0x131
  ecall

  beq a0, s2, loop

  mv s1, a1

  mv a1, a0
  li a0, 1
  ecall

  li a0, 11
  li a1, 32
  ecall

  mv a1, s1
  li a0, 1
  ecall

  li a0, 11
  li a1, 13
  ecall

  bne s1, s0, loop

  li a0, 10
  ecall
  ret

