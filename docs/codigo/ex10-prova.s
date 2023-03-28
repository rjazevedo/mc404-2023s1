.section .data
NUMEROS:
  .word 9 
  .word 4 
  .word 15 
  .word 6
  .word 3 
.section .text

elefante:
  lui  t0, %hi(NUMEROS)
  addi t0, t0, %lo(NUMEROS)

  addi t1, zero, 5
  addi t2, zero, 0
abacate:
  lw   t3, 0(t0)
  andi t4, t3, 1
  beq  t4, zero, uva
  add  t2, t2, t3
uva:
  addi t0, t0, 4
  addi t1, t1, -1
  bne  t1, zero, abacate

  add a0, zero, t2
  ret
  
